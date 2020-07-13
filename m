Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A346AC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:11:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CAF82067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etECCddx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CAF82067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juuUV-0007QG-FK
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 05:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1juuTA-0005o3-HG
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:09:52 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1juuT8-000441-VF
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:09:52 -0400
Received: by mail-wm1-x341.google.com with SMTP id o2so12416797wmh.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 02:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Vj1GcgnYRfEBWHK78BHK+XrASvNnJc1d64fFhAeFiew=;
 b=etECCddxA3xQePrnbJtX+KgS3u+fpbefd+sXHtVY7TNCD8Ar+i6OtwgO0wlK9vZxOi
 ZyqKCC6mGtXsJ/TkEH1CfjH9fX6SwcQsgaYmS53nBMUYGs+FCMjJb7MhJFQR7oWdJTdO
 eol+fO72kvvp51XZMqQxhk6sNUiBL2FINspXDxaz9+6SOvy6hKD1uRvAtLYpTJmXrcsO
 L/Dz2p4GEBJpatqiQA3Cyj53pxQ38jcQxk/FActSwvYcCAIN3HDOCKWgJ9+oF/nnZhYs
 i40+O2jN+YlnECjL4DzqWHapRaEyLCT2FKkT4kfN+MYV9980UN/lB5WFtIQle3RSmEkU
 PAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vj1GcgnYRfEBWHK78BHK+XrASvNnJc1d64fFhAeFiew=;
 b=alH4APLQ6Ii1W2CCFAwWlYEMQTZxigbnLaPCNBc5UJCCFCuCIP9DY6kv+NxwDe7AvC
 zkPjLPSeapG7ynITjk7izpzbAcgtzu8Dc2rkc/UloVd+oyroqQvBQv4EAm/TNKeIJXaf
 y8CAeEyq/8H9oI9HPBUY8SigOZLSJn5ldQ7Y2sHZphRs3kEqqnIKN9Ij9pMGJgpjc4Y7
 qDSCHOCcwGIRM6EVtDYaIqT2LypX73sTJOj1xUmWRt4XtMfDrGP7cfTK85Uhea8xK5sM
 b8O9GNdPmtBMsXN6d/1VaGcvE+ohRmyYGTMsRtzvQVXelV8/KHvModGSemwWeQEw797R
 vhEg==
X-Gm-Message-State: AOAM5315XeYk0Q410+W1xNwx3LBHREvkTn1ZSpvpracPu1wr1uAyoLIS
 VSk7ZQA/5VedRPf4F6mMGW4=
X-Google-Smtp-Source: ABdhPJwaNztxk1PyCtv9dfNTk8oN/YCY9K8LOwg4LYMYdX2GJiIc3mMWpT9KShzU8kRuqJHjEFShoQ==
X-Received: by 2002:a1c:28a:: with SMTP id 132mr17662004wmc.109.1594631389429; 
 Mon, 13 Jul 2020 02:09:49 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 22sm23401635wmb.11.2020.07.13.02.09.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 02:09:48 -0700 (PDT)
Subject: Re: [PATCH 10/12] target/openrisc: Remove superfluous breaks
To: Yi Wang <wang.yi59@zte.com.cn>, qemu-devel@nongnu.org
References: <1594631134-36688-1-git-send-email-wang.yi59@zte.com.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <251966e8-0afa-ab9b-d715-aac376d2a10a@amsat.org>
Date: Mon, 13 Jul 2020 11:09:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1594631134-36688-1-git-send-email-wang.yi59@zte.com.cn>
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

On 7/13/20 11:05 AM, Yi Wang wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> Remove superfluous breaks, as there is a "return" before them.
> 
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

FYI the subject should say this is "PATCH v2", see:
https://wiki.qemu.org/Contribute/SubmitAPatch#When_resending_patches_add_a_version_tag

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


