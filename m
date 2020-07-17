Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF458C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 19:42:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A7F420684
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 19:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwEfKMFt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7F420684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwWFZ-0004sq-Ty
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 15:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwWEi-00041C-Ax
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 15:41:36 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41914)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwWEg-00088Y-Qm
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 15:41:36 -0400
Received: by mail-wr1-x441.google.com with SMTP id z15so12245863wrl.8
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 12:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=D8JWmNIbn2NwKfz1n7e3cMzzVwSBqR8CseVfhNnvTlo=;
 b=uwEfKMFtHZeDaRcXcYHgxgC469WWnjsRlZGMEKJ6ISQ01QTr4t0gpvfVGNC7dXnXb9
 VYBtj7mbBF4l49Y35faLspVPBEdq5IY2Wi73c4lILkE73l9hJur9HWFvGgck7mbKkRAA
 9QvxFag+8dD9R3/i9y10c49+5cNjWuv47kZNfDib59YNmBdpBsGCJApgw0MSwvw/ZG1j
 HdZI4DFRB8fU5x2/wamP/X+5tYjaqDZmTduGlpc+T1I5uwnt8CTJk4HmBLUjET04qS+s
 4pOAI6UMXP6LTjzBQ+O8RljbZl0TH0ZGtK/dE8zWnlUgmOtW7+Jtzv9cZXM6xYI2dZPP
 eURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D8JWmNIbn2NwKfz1n7e3cMzzVwSBqR8CseVfhNnvTlo=;
 b=DNhFWVtn2H6MtYC2KWWtLvJQAXvSR58b0jLXoHj7/aAddjkVMh4eLMJgTdfWkZja+Y
 LwgQHBbkql1HlV/ezwKaACY8CYFrUAXipcYxQxoLPAUNVtWI/nEN9KLNvBLzGSEHViad
 UApgmSFEwSadVXheHGofdpmwT22BBCwhbRIlvSrcBohqZc+gDaRdyxS/z0JluJgdHexC
 +zEIzy97YyULZfyqvqRjxrwULVJL40Sjn6JQlJ6ZicxHb8wiPX1qdeayLiRAKih6ugr6
 6ADBrUxRGUkET5gPiUY4Zuj1g94QAbv2f6ruq6zc0bOrKoXe5Wp3iiHLOXwad4pWAAHw
 6FXw==
X-Gm-Message-State: AOAM533OQITLMNXdJISct7eY9+YHPtz5Vb03qLomG20UmEDoc2moDmxN
 Rlwf5l6vA/WMK2b6tiTo623kgNfVHzI=
X-Google-Smtp-Source: ABdhPJwM6LH7YWByJkM7Ww1yWwFF+aD9SxHcs0k/5NJKCL5oDj4ntmQiNBAm9UOKOMw+ieiAyLYoRw==
X-Received: by 2002:a05:6000:cf:: with SMTP id
 q15mr11976018wrx.203.1595014893409; 
 Fri, 17 Jul 2020 12:41:33 -0700 (PDT)
Received: from [192.168.1.43] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id x7sm16055940wrr.72.2020.07.17.12.41.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2020 12:41:32 -0700 (PDT)
Subject: Re: [PATCH v1 1/5] shippable: add one more qemu to registry url
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200717105139.25293-1-alex.bennee@linaro.org>
 <20200717105139.25293-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2bc0b2b6-2aea-b7d5-2572-0058137d7531@amsat.org>
Date: Fri, 17 Jul 2020 21:41:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200717105139.25293-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, cota@braap.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 12:51 PM, Alex Bennée wrote:
> The registry url is <project>/<repo>/qemu/<image>
> 
> Perhaps we should rationalise that some day but for now.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .shippable.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.shippable.yml b/.shippable.yml
> index f6b742432e5..89d8be4291b 100644
> --- a/.shippable.yml
> +++ b/.shippable.yml
> @@ -27,7 +27,7 @@ env:
>        TARGET_LIST=ppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
>  build:
>    pre_ci_boot:
> -    image_name: registry.gitlab.com/qemu-project/qemu/${IMAGE}
> +    image_name: registry.gitlab.com/qemu-project/qemu/qemu/${IMAGE}
>      image_tag: latest
>      pull: true
>      options: "-e HOME=/root"
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

