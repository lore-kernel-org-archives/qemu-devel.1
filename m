Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2954C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 13:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A574B20776
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 13:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDmrC2ae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A574B20776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcr4h-0000ad-TI
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 09:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcr43-0008PK-7Q; Sun, 24 May 2020 09:53:19 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43373)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcr42-000134-JH; Sun, 24 May 2020 09:53:18 -0400
Received: by mail-wr1-x442.google.com with SMTP id i15so14751844wrx.10;
 Sun, 24 May 2020 06:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KU0L7HoiTfXHEnpKdKbEtcdMjtpbb22uEejOrgQORew=;
 b=IDmrC2aetv1moiyJpsMsv4i2i3vYYJC0yZX1/NGV3OZMcdMZLAup463yF7ovq7pNzG
 406DlhNfFmMDBwlBisxBSdBfmZ4Sfddo5RMEtor8BRDP6oAMe8Cqem4yKYx94eTt/6J2
 a+VkP3xSkzCFFV39oG207kRajZtbEgMjGTgwTnznA45mOJnhf6hl57eb0mjLIT1b7yAO
 SxvhzqTl9rn80xbozrI8ab6LpeKTsiRNhUX2H9Jaq6Vcgl0fAIPboeBPYPurTGidnCP5
 NzTWBVAV02BbZfLaNfo0yCXcVIscYaPMrb1lyqicA7eMZdVYeU4zn3l5KkOcEnhT7DjT
 tJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KU0L7HoiTfXHEnpKdKbEtcdMjtpbb22uEejOrgQORew=;
 b=TL7DqFZwrGFdR49dcjaYIgPW52ds9WxgXgNH2+n3TjuYvevOH/pe+pAH8JcZ8MVe0o
 nqZZPXoGjLJF8jupr6CXs/UcSFOp0vJAkHjq5EnMktL2+dW31EZ0pJqFa0Dq76XMjm/N
 eoHcjVqzjkX59RzWv9IvzvDJtRmOZBqNad+1rU60Rq0+t1j/YQrnD5HZChRsBUgF0OPr
 7WdzQ1RD3Riia7qA7AL9mVkWsdJLLdAJcqMmhNrbxCS6oEtFkGP7R46o2Sh+oLbqX80x
 ohEVI7BhPrYCzShYoLKq704GL3+TP2/RRzf5AKBwUMkJMcyGwwimiWcAoKHCRTTxI3TR
 VStw==
X-Gm-Message-State: AOAM532tAcQvukzR+xqESUqBGxuMSPoMCR244NqNKKHCe0FhKLs8FB5Q
 ZLAfeNRQxBLWkbsF1W66+gDtuIBXAIA=
X-Google-Smtp-Source: ABdhPJzZ5B835F0pDkrhLRXT8wkO/XT7FYCfEgq5fXVdPb7z+qJKYTpcaxeAdblNX8+lvf9FYLUyEw==
X-Received: by 2002:a5d:6145:: with SMTP id y5mr10471814wrt.195.1590328395735; 
 Sun, 24 May 2020 06:53:15 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id s7sm1040818wrr.60.2020.05.24.06.53.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 May 2020 06:53:15 -0700 (PDT)
Subject: Re: [PATCH] hw/display/omap_dss: Replace fprintf() call by
 qemu_log_mask(LOG_UNIMP)
To: Alexander Bulekov <alxndr@bu.edu>
References: <20200524103833.8188-1-f4bug@amsat.org>
 <20200524124132.dri74sl5iei3aaxl@mozz.bu.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <61f80fea-d37d-e84b-773a-5ec083b61b94@amsat.org>
Date: Sun, 24 May 2020 15:53:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200524124132.dri74sl5iei3aaxl@mozz.bu.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/24/20 2:41 PM, Alexander Bulekov wrote:
> On 200524 1238, Philippe Mathieu-Daudé wrote:
>> Replace fprintf() call by qemu_log_mask(LOG_UNIMP), which is
>> disabled by default. This avoid flooding the terminal when
>> fuzzing the device.
>>
> Hi Philippe,
> libfuzzer also lets you pass -close_fd_mask=[1,2,3] to close stdout,
> stderr or both. As a side-effect, In this mode, libfuzzer will write the
> crashing stacktraces to individual files ./.$PID, instead of to the
> terminal's output.

Thanks, good to know.

This information is worth adding in docs/devel/fuzzing.txt :P

> As far as I know, closing the FDs doesn't bypass all
> of printf's allocation/formatting code, so getting rid of calls can
> still be a good idea for performance, sometimes.

Certainly.

> -Alex
> 
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/display/omap_dss.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/display/omap_dss.c b/hw/display/omap_dss.c
>> index 32dc0d6aa7..21fde58a26 100644
>> --- a/hw/display/omap_dss.c
>> +++ b/hw/display/omap_dss.c
>> @@ -619,7 +619,7 @@ static void omap_rfbi_transfer_start(struct omap_dss_s *s)
>>      if (s->rfbi.control & (1 << 1)) {				/* BYPASS */
>>          /* TODO: in non-Bypass mode we probably need to just assert the
>>           * DRQ and wait for DMA to write the pixels.  */
>> -        fprintf(stderr, "%s: Bypass mode unimplemented\n", __func__);
>> +        qemu_log_mask(LOG_UNIMP, "%s: Bypass mode unimplemented\n", __func__);
>>          return;
>>      }
>>  
>> -- 
>> 2.21.3
>>
> 

