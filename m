Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EA9C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:03:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 408B62313C
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qkYw4IJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408B62313C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpphZ-0002rA-GM
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 05:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jppfg-0001a1-1F; Mon, 29 Jun 2020 05:01:51 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34191)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jppfe-0002Vm-Bl; Mon, 29 Jun 2020 05:01:47 -0400
Received: by mail-wr1-x442.google.com with SMTP id f7so12717885wrw.1;
 Mon, 29 Jun 2020 02:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Qi81FFPGwwGe3yhfdkVHKsQBPa1IQiolDV9VBMKBsAQ=;
 b=qkYw4IJiWd2yXiKbBHAHRuiHl22CnhW2UIoRy8uA4uMemUDDlU5qDUKOgRd6MNUtl3
 /n9zTV+/0QH+PQyw3B4DlJ4KV8Tu+P6HMTMm1IF2vilOPVsjMBAtjKcvm3sO1Hj5Lss2
 mCZwBTLk3Hk8rIRXxtOBzAWdX5pDfiqoJoGDVyNFP9W7eJRZItscI5dZBWBOAnQaK03z
 xWercgCXWw7N//TyERyBuDzV/hRPO0MwZkevffNowW+wk1nT1pxNYUHW2Ohu//fUEF/6
 Fdi6q0UFoQF75dW6FRNsnt93MRVMgTiSunklzmjng4gOGTq8FL2rYptwbhGTzCHwWRX5
 Iw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Qi81FFPGwwGe3yhfdkVHKsQBPa1IQiolDV9VBMKBsAQ=;
 b=ZCSau1wGVgZd4G0gi3JBdl7+crVA+FLiWv4+PTol3wUhxFH3USY+h0U/+iFejiRazq
 rCFV+HNRtxpcHczmyVa0zzXFATvANpMIhxAD0dRCV9NpkCmah+DS+BzE7GNjD617r7ly
 qT+sm/nqiZ7M9+tYtba4OgUpwNMDu8SXnpm4byuqJPm6nGIUTcO3b26RZG24ukpD3Gvm
 PSBiIun+hYfa+QqRyyA1qGQDQaSGZMTIpdJnFPPIiEUyXl0NZyyrss6Ly0UM/cCee/Qu
 chRq1s1d9QOd1mhZi2HHDnlxnDkv/BD+v+k13uUKKSRYlIuIJ6VYJNIAvrrDMVIdq2lA
 cl0A==
X-Gm-Message-State: AOAM530BXwGJpG2TfrU+lU+RfR68bPq1CO2qJu9OtGekMfSwDbzUgjiU
 Mn8UvXn8OlozyrhmkFvxouw=
X-Google-Smtp-Source: ABdhPJx/0536PTqqLbNRFHVuYeeiGASUDiI1KbVDEIReY9gM0FWfdUvONjjAhHBGaceMdnf2DNIqvw==
X-Received: by 2002:adf:e5d0:: with SMTP id a16mr15419928wrn.48.1593421304436; 
 Mon, 29 Jun 2020 02:01:44 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u16sm791493wmn.11.2020.06.29.02.01.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 02:01:43 -0700 (PDT)
Subject: Re: [PATCH 07/17] hw/misc/max111x: Don't use vmstate_register()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200628142429.17111-1-peter.maydell@linaro.org>
 <20200628142429.17111-8-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9254a124-fa3a-a630-e3ef-17aeeea65cec@amsat.org>
Date: Mon, 29 Jun 2020 11:01:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200628142429.17111-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/28/20 4:24 PM, Peter Maydell wrote:
> The max111x is a proper qdev device; we can use dc->vmsd rather than
> directly calling vmstate_register().
> 
> It's possible that this is a migration compat break, but the only
> boards that use this device are the spitz-family ('akita', 'borzoi',
> 'spitz', 'terrier').
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/misc/max111x.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/misc/max111x.c b/hw/misc/max111x.c
> index d0e5534e4f5..abddfa3c660 100644
> --- a/hw/misc/max111x.c
> +++ b/hw/misc/max111x.c
> @@ -140,8 +140,6 @@ static int max111x_init(SSISlave *d, int inputs)
>  
>      s->inputs = inputs;
>  
> -    vmstate_register(VMSTATE_IF(dev), VMSTATE_INSTANCE_ID_ANY,
> -                     &vmstate_max111x, s);
>      return 0;
>  }
>  
> @@ -206,6 +204,7 @@ static void max111x_class_init(ObjectClass *klass, void *data)
>  
>      k->transfer = max111x_transfer;
>      dc->reset = max111x_reset;
> +    dc->vmsd = &vmstate_max111x;
>  }
>  
>  static const TypeInfo max111x_info = {
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

