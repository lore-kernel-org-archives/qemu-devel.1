Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1739C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 10:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A2CB20707
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 10:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C18/Cq1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2CB20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfL4O-000651-OR
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 06:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jfL2y-0004pC-01
 for qemu-devel@nongnu.org; Sun, 31 May 2020 06:18:28 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55499)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jfL2x-0003aS-1I
 for qemu-devel@nongnu.org; Sun, 31 May 2020 06:18:27 -0400
Received: by mail-wm1-x343.google.com with SMTP id c71so7965176wmd.5
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 03:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=TC+KShbAfWjzNpM1uWWNF7YuYCcmsAs2/CAoKJZm8g4=;
 b=C18/Cq1Muwq2Qgsj3xnYA1UK4CM0FeAmsdCaQxybEei1IugyjOAYTlQjjP6FJALBzZ
 Ps0wU6PEqyvkVm9pZ+NOJjLjTwwkD9V4vk180y2MXwUZXY7oo6UsGUDQUIKZpS0APW5u
 OaAykp8Xti6hES0gEkvjL9Ml7E5PopZQ4H8ZiGAJCPi0tE/HXbtmtdHfLe+UhDFJpfsH
 96FTQnuq7BcmCLmfGeAfjW3795ce8XPfBl+GD0XLPLr80H8Pxf6FLMzH7GxKMKIAYvD8
 VCOvZ3IhywybM+5i2hIJLutRcYtPw07iBWhtTS3fYM1+0cIRs24ioHlkrjK1j8AJ/2JV
 hLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=TC+KShbAfWjzNpM1uWWNF7YuYCcmsAs2/CAoKJZm8g4=;
 b=pY3jb1iLsrWAp/v/25Fo6SOpV6K76MmHgJqYKsxAtUcym0JY1EaSI+YKrq/oMkV3d7
 GB488ZFCB9i7OOh4YgtLKf0+Xm7pYl83dL0g+L7OgcLtM+JvCgwYm68fTbJire7o4oKD
 8SIesMFfQq/uo+pvXZGlVPKtleKMyLHe520gKm1uIBC385jEh+yx8f9vXDEz2/0qn1Lu
 X6gILhQjP8F2LQTInLAGgavbQgUAwG130ImDs78St7J3W6eR5OIlhEWwYNxx782RWCJM
 j3jC+xrtcEBqe2nmaHqbGnEBKFWzU42TTLJKtjvqyvW4iZe0wR/5kXGp4cQoImrmcCyB
 SAgQ==
X-Gm-Message-State: AOAM530nPGHNtIIPtM9fIlBfI27UDRjdOQMQTzoptacBXd6+z9CHhMq6
 J9KxLIkwXdo6oJSno/ITiy9Adg==
X-Google-Smtp-Source: ABdhPJwULgtxZvygEFdRg5uJjqbUHVIRwAB9Hdy6eWTS8b1NNCyyea0I4zTLEaNfx0XAPC6gKIOS9g==
X-Received: by 2002:a1c:5683:: with SMTP id k125mr17582603wmb.55.1590920305487; 
 Sun, 31 May 2020 03:18:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k14sm16689810wrq.97.2020.05.31.03.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 03:18:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8E3A61FF7E;
 Sun, 31 May 2020 11:18:23 +0100 (BST)
References: <20200530092306.26628-1-f4bug@amsat.org>
 <20200530092306.26628-6-f4bug@amsat.org>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 5/5] .travis.yml: Test SH4 QEMU advent calendar image
In-reply-to: <20200530092306.26628-6-f4bug@amsat.org>
Date: Sun, 31 May 2020 11:18:23 +0100
Message-ID: <87blm4v24w.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 qemu-trivial@nongnu.org, Magnus Damm <magnus.damm@gmail.com>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> From: Thomas Huth <thuth@redhat.com>
>
> Now that we can select the second serial console in the acceptance tests
> (see commit 746f244d9720 "Allow to use other serial consoles than default=
"),
> we can also test the sh4 image from the QEMU advent calendar 2018.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Message-Id: <20200515164337.4899-1-thuth@redhat.com>
> [PMD: Split tests/acceptance/boot_linux_console.py in previous commit]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  .travis.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 564be50a3c..e2003565d8 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -293,7 +293,7 @@ jobs:
>      - name: "GCC check-acceptance"
>        dist: bionic
>        env:
> -        - CONFIG=3D"--enable-tools --target-list=3Daarch64-softmmu,alpha=
-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-=
softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,=
sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
> +        - CONFIG=3D"--enable-tools --target-list=3Daarch64-softmmu,alpha=
-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-=
softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,=
sh4-softmmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
>          - TEST_CMD=3D"make check-acceptance"
>          - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-acceptance"
>        after_script:


--=20
Alex Benn=C3=A9e

