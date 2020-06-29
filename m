Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F0BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 07:14:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5FDC2332F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 07:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUFALiSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5FDC2332F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpo0I-0005y7-6t
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 03:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpnzW-0005RU-KX; Mon, 29 Jun 2020 03:14:10 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51682)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpnzR-0000cf-BX; Mon, 29 Jun 2020 03:14:10 -0400
Received: by mail-wm1-x342.google.com with SMTP id 22so14315424wmg.1;
 Mon, 29 Jun 2020 00:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AEXbd3v7VKtKczVUsCfRVwxmowKJ9/UnFbkt74nWLVI=;
 b=SUFALiSuUGxRiCtSgSnxuSWbgnmlMfO5ePcLNBq95rfpDz0h/VIjTAg6R6Vzond6Vc
 aekp4vHnrwxL3gWUybcuhsX47y+ZxyedQDhUG3MtRCfEdaJyMN+1tZ5jyNQqP0gKiX1/
 bF687JVWQky6WMF8IXXygAtms4ndDBxRybXYI1oUqiM11jE8e+STt0IsDbPfFN/NJUhd
 wFpHjNZR1/mIrSW5wX8NMwZLPIV64fMBRzA8uQ9BDKoe9uhsxvQrkSYO+q5nyCt9PYJ9
 7AK/cqioJpiFxxiz/jWsEH6J60+NIE0wRUA0GyFiNjnPkY9XwC5fUOZ1IFKV3FKpa8Z2
 oOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AEXbd3v7VKtKczVUsCfRVwxmowKJ9/UnFbkt74nWLVI=;
 b=TfXWYqmplsr6YOxqY3ti+YLZvfAeoZXYNAnoCmvaSk2DubURyHFDD7xy3OCfrD+oi1
 f4bS/LV/Be3katJI4DkCFjAeTEOAr/9Je8599TKXWULPyj4WaI7PkZXNjHLP+9AdQ/zE
 Q0pJes0N8BjxY4lHvFayMolPnuk/WFWIv8hfNVoWlOntLcZv5aZTDSD+YZtWzxtMrZeV
 NJUKXyV2AqNoK5HYktVFcz3lttdDTFS51n4aobKeys/U+FKfML+HsCCTHC2WZ8xhDfax
 4GYyw4uP5bL/bEoCvndOAU2q46mkyzPuGWuwAER05erjOG5jacIyxVFB6b9HsbsYRKbB
 F9rw==
X-Gm-Message-State: AOAM530IK+k5zHLxUEtV4SuJPQ6zWvtyLt2NW7uM2Juht6Ay3S306ue7
 TTwPBsyMk+CC4KWDt1jL2jk=
X-Google-Smtp-Source: ABdhPJzRzliXTyzMbSJis+pLIK0szbixiXPUFXP1xzZG4xyXaRqxkht3Gz0GdOowoghSv6c7wp8mPQ==
X-Received: by 2002:a7b:c345:: with SMTP id l5mr16012123wmj.31.1593414842562; 
 Mon, 29 Jun 2020 00:14:02 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id a126sm26916601wme.28.2020.06.29.00.14.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 00:14:01 -0700 (PDT)
Subject: Re: [PATCH] hw/display/bcm2835_fb.c: Initialize all fields of struct
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200628195436.27582-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ee0f5975-9293-33d6-fb9c-731b5e4ce84b@amsat.org>
Date: Mon, 29 Jun 2020 09:14:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200628195436.27582-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/28/20 9:54 PM, Peter Maydell wrote:
> In bcm2835_fb_mbox_push(), Coverity complains (CID 1429989) that we
> pass a pointer to a local struct to another function without
> initializing all its fields.  This is a real bug:
> bcm2835_fb_reconfigure() copies the whole of our new BCM2385FBConfig
> struct into s->config, so any fields we don't initialize will corrupt
> the state of the device.
> 
> Copy the two fields which we don't want to update (pixo and alpha)
> from the existing config so we don't accidentally change them.
> 
> Fixes: cfb7ba983857e40e88
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> Not sure why this wasn't a visible bug -- alpha isn't used,
> but if pixo changes from zero to non-zero we flip from
> RGB to BGR...
> ---
>  hw/display/bcm2835_fb.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
> index c6263808a27..7c0e5eef2d5 100644
> --- a/hw/display/bcm2835_fb.c
> +++ b/hw/display/bcm2835_fb.c
> @@ -282,6 +282,10 @@ static void bcm2835_fb_mbox_push(BCM2835FBState *s, uint32_t value)
>      newconf.base = s->vcram_base | (value & 0xc0000000);
>      newconf.base += BCM2835_FB_OFFSET;
>  
> +    /* Copy fields which we don't want to change from the existing config */
> +    newconf.pixo = s->config.pixo;
> +    newconf.alpha = s->config.alpha;
> +
>      bcm2835_fb_validate_config(&newconf);
>  
>      pitch = bcm2835_fb_get_pitch(&newconf);
> 


