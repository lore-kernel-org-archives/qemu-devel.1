Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED95AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 18:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7C4A2077D
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 18:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7+F8I0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C4A2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jguVn-0007OH-Rk
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 14:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jguU5-0006Rj-3Q
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 14:20:57 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55684)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jguU4-0005ye-5x
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 14:20:56 -0400
Received: by mail-wm1-x342.google.com with SMTP id c71so6153357wmd.5
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 11:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NtU3cEk2spEp8traurmMOtrxP57QI7MwSlKjM/wspKQ=;
 b=C7+F8I0V3NnVBQOsKNc+agmJYGSeqxZt537TWIGDlpggaJrd8lktstsJZbRsN7jOG5
 mMluGJD51mVXhOlrBqzBTSNlQGRZVx6crvrLHsLCNDXhrO1RwRBnT0zZrUF0TyZ3YSr9
 rXWwUfOwHvcTbPFB69AiHIJM6AiC7p+vMKa5IcuJXvxJiULTLTrcG0blEd9nyUIdhT/P
 szSsDyKseUBSl3uxJQ1C90ct+JIddJ0e0ZfnSP5oF2YJKBvQUJ88C8T+I9fUZmZHO6N4
 H9+72xuwuZXn5i7frPRA0ZBdVMa4HiqW9t86ZH+LM+RAROfrdQHs2y7rR5F5uxd2VU3Y
 rKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NtU3cEk2spEp8traurmMOtrxP57QI7MwSlKjM/wspKQ=;
 b=YoTB7hW2JuCs2q5Ssq29KwFZzunnQUjsKSiEXcWEiURV2bz7T4Ql49WnnkQhOPNJSo
 qgbeP62WuuI9ucyFun02WMV216ao3CvNc/+BWvArWix3AoYZ7hV6scBk3sj3ma7ZJLaT
 MDzXjZ4dz7jhEPCR6AG+RxgL3y6SDEF+e3e0T82qFMXBoOcG8T4lT9o5/bdPSrdko+Cn
 i1A2ajb+fu5/GWaUxcSb39WUZndl+1fwOts2mxT3K6ibOGz74OqhdgdX7cXfu0MTp/oD
 83NrmG0dfOryXd9/Rri+Y1GWKolW7c2+9qbLhYRV6m4Rci7RL2sBtDKlblPaTrni8Kn2
 gBOw==
X-Gm-Message-State: AOAM5314D3mmr2NIAVLFtwczLKf7AWiUONxuGVkd7/EUs9uvpMYIw/Is
 SeNmupBT2fXJM1ExHoG6J6s=
X-Google-Smtp-Source: ABdhPJyaELN0GF/bKZgtjpWgHyyNKH2FQ9AX0vP8TyYR1+yvyOCUGKC8EawpRsT1ArtF2i1aLjmyzQ==
X-Received: by 2002:a05:600c:21d3:: with SMTP id
 x19mr5605014wmj.137.1591294851800; 
 Thu, 04 Jun 2020 11:20:51 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id e5sm8993555wrw.19.2020.06.04.11.20.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 11:20:50 -0700 (PDT)
Subject: Re: [PATCH] hw/sd/sdcard: Verify CMD24 (Block Write) address is valid
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200604173410.21074-1-f4bug@amsat.org>
 <980fde76-8e26-c5bc-a708-317997f4e329@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <211a55bf-0d1b-31f4-995f-eca8608e9e6c@amsat.org>
Date: Thu, 4 Jun 2020 20:20:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <980fde76-8e26-c5bc-a708-317997f4e329@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, 1880822@bugs.launchpad.net,
 Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/20 8:03 PM, Paolo Bonzini wrote:
> On 04/06/20 19:34, Philippe Mathieu-Daudé wrote:
>> Avoid OOB access by verifying the requested address belong to
>> the actual card size. Return ADDRESS_ERROR when not in range.
>>
>>   "SD Specifications Part 1 Physical Layer Simplified Spec. v3.01"
>>
>>   4.3.4 Data Write
>>
>>   * Block Write
>>
>>   Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>>   occurred and no data transfer is performed.
>>
>> Fixes: CVE-2020-13253
>> Reported-by: Alexander Bulekov <alxndr@bu.edu>
>> Buglink: https://bugs.launchpad.net/qemu/+bug/1880822
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> Cc: Prasad J Pandit <pjp@fedoraproject.org>
>> ---
>>  hw/sd/sd.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index 3c06a0ac6d..0ced3b5e14 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -1211,6 +1211,10 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>>              /* Writing in SPI mode not implemented.  */
>>              if (sd->spi)
>>                  break;
>> +            if (addr >= sd->size) {
>> +                sd->card_status |= ADDRESS_ERROR;
>> +                return sd_r1;
>> +            }
>>              sd->state = sd_receivingdata_state;
>>              sd->data_start = addr;
>>              sd->data_offset = 0;
>>
> 
> I'm not sure if you want me to queue it, but I did.

Hmm I guess I typed "^RPrasad" in my shell to have the last git-publish
command with his email, and I didn't noticed you were also there...

Anyway looking at it again, this patch is wrong because I should check
for addr + blksize < sd_size instead. Can you drop it please?

>  Probably we should
> add qemu-block@nongnu.org to the hw/sd stanza.

OK will do.

> 
> Paolo
> 

