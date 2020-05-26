Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66E6C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:26:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A012E2053B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SFlzWi/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A012E2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdXiz-0008Fu-SM
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 07:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdXhA-00062r-IR
 for qemu-devel@nongnu.org; Tue, 26 May 2020 07:24:32 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdXh9-0008BS-PT
 for qemu-devel@nongnu.org; Tue, 26 May 2020 07:24:32 -0400
Received: by mail-wm1-x344.google.com with SMTP id u12so2841115wmd.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 04:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=laM7y7+lT6/5na9RQFiDucmGI7iVmSETqGLjzOL9ruI=;
 b=SFlzWi/49McvSGtLnAWt3dUkvXsfByyqGvXhF6lSAbFd0C5+xaBxlfi+YXQPe8ux24
 6l1gFkFrk8G2btkKKAL4O8P8bGEHTlKEtEMNFLCZib6kaQlk+W4KyhqvIsFHYclotcs8
 PQrqUFBe4Og2GgS/MnMPOtGN6X+eF3H6Xzqm9c60T0+IpItBa/2tuvfK58dVNpEkeKBE
 OpgZ8tQXhZBDCHtCMlMSPtH1RhDN2s3RKevvfZQ2verw7+dMGBBkUWlc4GpcVNJwYTf+
 ahNO6kvkIRB5M/YtEnUJl90sV8Szz6xis/Dgr7/ALRoPR3+YzT4X3eCgwKZCIGnQDzvh
 5U2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=laM7y7+lT6/5na9RQFiDucmGI7iVmSETqGLjzOL9ruI=;
 b=eywf/4ydtEyQUze0QD1X2VqQ+CZdu9lSh34ENTj+kWVmFOvg3OAwsyATUUpuVy1TTu
 yyz2/V9Wf9T71fq1dY3LgKeL9ay2PgEmegA82F7q5ynJitAknvubPKBfQ175PZbhNpAH
 84OCsKNweVZkP0sih2d933JD+sqki5dYsfmd+nCgqb6B5D93W0lABefqvwyqMMYfq9F3
 ALYMU3FacoENZd4i7xeMqy/Y2kJF+r7aQ2oRr56VXPNR8xBnXOFe5trNYaZYCnc1VQWg
 CqcKmv29QskNd/aQGUBujJn4yReMkhrKE9ck1poRKyQtUtDJSp4d02H0dulsn6aCFkTT
 BcHw==
X-Gm-Message-State: AOAM533MvduQTFhW7OaZYrvkyCX/S6NWfnbPfxUHehVuQOnCgdCs5c6V
 dlmIqbviSXc67TGaNw+F5H6n9A==
X-Google-Smtp-Source: ABdhPJxZl4Xnak3TsptoybcPp2zwPQDqJ41s4wxNyQyxi/sPf/9bcwBAbp/w7X+XlKAtGJplAJWbgg==
X-Received: by 2002:a1c:7c0b:: with SMTP id x11mr963108wmc.149.1590492270182; 
 Tue, 26 May 2020 04:24:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a12sm15891505wrs.70.2020.05.26.04.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 04:24:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6346E1FF7E;
 Tue, 26 May 2020 12:24:28 +0100 (BST)
References: <20200524215654.13256-1-f4bug@amsat.org>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH] scripts/clean-includes: Mark 'qemu/qemu-plugin.h' as
 special header
In-reply-to: <20200524215654.13256-1-f4bug@amsat.org>
Date: Tue, 26 May 2020 12:24:28 +0100
Message-ID: <87ftbn6is3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: qemu-trivial@nongnu.org, "Emilio G . Cota" <cota@braap.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> "qemu/qemu-plugin.h" isn't meant to be include by QEMU codebase,
> but by 3rd party plugins that QEMU can use. These plugins can be
> built out of QEMU and don't include "qemu/osdep.h".
> Mark "qemu/qemu-plugin.h" as a special header that doesn't need
> to be cleaned for "qemu/osdep.h".
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  scripts/clean-includes | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/clean-includes b/scripts/clean-includes
> index dd938daa3e..795b3bea31 100755
> --- a/scripts/clean-includes
> +++ b/scripts/clean-includes
> @@ -123,6 +123,7 @@ for f in "$@"; do
>        ;;
>      *include/qemu/osdep.h | \
>      *include/qemu/compiler.h | \
> +    *include/qemu/qemu-plugin.h | \
>      *include/glib-compat.h | \
>      *include/sysemu/os-posix.h | \
>      *include/sysemu/os-win32.h | \


Queued to plugins/next, thanks.

--=20
Alex Benn=C3=A9e

