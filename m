Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF85BC433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 06:21:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD70C20674
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 06:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1WJK6lU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD70C20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jurqd-0006XD-UZ
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 02:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jurq2-00066H-Gp
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 02:21:18 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51272)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jurq0-0007cA-SY
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 02:21:18 -0400
Received: by mail-wm1-x341.google.com with SMTP id 22so12125950wmg.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2020 23:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XF7yXRHjg759G4LdhCaCgwxFq7xzEs+Xe/u+bkd39Cw=;
 b=S1WJK6lU1Cu7L+KkwRyj1nzbKxrdcM0HRsp+mqBDuLKSGiX+9MH6fRju/8D5yVcuMV
 KqSG9tQiMx3V4kQw5GlPS+ZxFNDJn+ngT32C+0tCYtvpmPf3AcS74nQfN8FiiIVQQ3a3
 umrujr7wyG67rCkZ/C3pwbYVY2tCqskvoN0xbfmqhLiK0GN9aI93gahivRQf3L1ldapu
 cvJAuxF1PXIGYxaGRMeFQERHrhyKw7njgLVOaxHxMPX3s6hINGj8L534TlsCeeh80X27
 VhN8V9Lq/rFgq4MqOTGYgszi9ilhsN9BrtsSweie1E71lSlm7bD9ZGQaqFtKwi9Rb8mx
 RwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XF7yXRHjg759G4LdhCaCgwxFq7xzEs+Xe/u+bkd39Cw=;
 b=jl8bQeIL0AdYnQXTINcGysgiKJPUkXJUh/vm2k2QzB2lgwIgbkyD0v0R/t2mpKsjJa
 qTNbTNmqlI1r0gZnrOCoucJLJage2IBh+FERMD90Qh35RNGvwpzRYQTm9HcEufb9rBqT
 WwHTgCwnx8vzvjNC651s5VR5u79mlANug4ZhFdqQMLcnBUcZDgHf+0pT3Gpei+kbDW0y
 Tx2YL0UiX0pg8jFFyFbI3HWEUZn5gLEbM7yPGpBB50yyIheRLBYhcjLp4phGbzR18inf
 kokudZzxxLnT2WwDY5BMbKWm56j0NGKiv//UgzE6Vwi3hFEHiu3iz92yDIEl8S4u6MDq
 yqUg==
X-Gm-Message-State: AOAM532gWLHB9CYcp7DotrVBJi3HoP3ryEn2xUavWTKmYwSgQ0Lsfnc0
 5bp7+WKhrHN9riiUaf5h370=
X-Google-Smtp-Source: ABdhPJxYfJzmIvozEEroxzaO0ZoR9n7tNjj0arUS2hRmrzE+MhvOT1zjFNfrgvEQYlKDCzpMBui5Ag==
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr18213299wml.183.1594621274738; 
 Sun, 12 Jul 2020 23:21:14 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 1sm20537507wmf.0.2020.07.12.23.21.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jul 2020 23:21:14 -0700 (PDT)
Subject: Re: [PATCH] target/openrisc: Remove superfluous breaks
To: Yi Wang <wang.yi59@zte.com.cn>, qemu-devel@nongnu.org
References: <1594600448-23328-1-git-send-email-wang.yi59@zte.com.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <43df876c-45d2-a6e0-1e80-210400de6bd2@amsat.org>
Date: Mon, 13 Jul 2020 08:21:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1594600448-23328-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: xue.zhihong@zte.com.cn, wang.liang82@zte.com.cn,
 Liao Pingfang <liao.pingfang@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 7/13/20 2:34 AM, Yi Wang wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> Remove superfluous breaks, as there is a "return" before them.
> 
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>

This patch (and various other you posted recently) misses your
S-o-b tag, see:
https://wiki.qemu.org/Contribute/SubmitAPatch#Patch_emails_must_include_a_Signed-off-by:_line

When reposting with your S-o-b please amend:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/openrisc/sys_helper.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
> index d9fe6c5..d9691d0 100644
> --- a/target/openrisc/sys_helper.c
> +++ b/target/openrisc/sys_helper.c
> @@ -289,10 +289,8 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
>  
>      case TO_SPR(5, 1):  /* MACLO */
>          return (uint32_t)env->mac;
> -        break;
>      case TO_SPR(5, 2):  /* MACHI */
>          return env->mac >> 32;
> -        break;
>  
>      case TO_SPR(8, 0):  /* PMR */
>          return env->pmr;
> 


