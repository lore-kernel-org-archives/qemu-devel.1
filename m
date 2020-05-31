Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBA2C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 10:19:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D44920707
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 10:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TYzlqmHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D44920707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfL3W-00054L-RT
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 06:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jfL2k-0004Wt-Pk
 for qemu-devel@nongnu.org; Sun, 31 May 2020 06:18:14 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40459)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jfL2i-0003ZZ-9j
 for qemu-devel@nongnu.org; Sun, 31 May 2020 06:18:14 -0400
Received: by mail-wm1-x344.google.com with SMTP id r15so8471796wmh.5
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 03:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=6VitTAZO31NvPPlsjIBNuIBVg2qH7etlYXXjt/e8mgQ=;
 b=TYzlqmHiv84y8bpUjv0Ke12DDtKnf4Xvg8OC3xK0dYn88yFuLUe/NvOHL/GSql+fPq
 +Hwq3kpJZy3lK/dgMbHIzCqW5FjGh/KxlA91/QgD6NuMqW7mLX5JdGUl6IhnCDHJWiJp
 6MeKaO1+vVRHEstq0nMqxWJPFCa4uxjI5z0UEMiOGpnHEEKS0Ecr6FMNl9FvHMT23qrJ
 m8w/UrrZ3lI9gHQLrDmdGiw6cBRa0Qud/1a34Wpb7885HFT9sW1D7WSsNZXwZDRcTRth
 nARRbj2mj0S0MVWcHKq5VGc20PgBTZCuhuK0lVPnUrszphtZuOMLHCm57eo7rSvzB5r3
 PlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=6VitTAZO31NvPPlsjIBNuIBVg2qH7etlYXXjt/e8mgQ=;
 b=dN8GkYHHGPVm7MojedPwOR/PQS+1dT6PCaVcLNL64gHg1Wa1zQcFrsrPyD/e4GEVAE
 dnTbe+XiqbQlpecXJC9cRHXay8i0n9GuEnnA618uH4WeGL/NZsyFlgEMgmKETyzCfI0F
 riw7sgk9wkxRB++gpcxPSwF0L0sv0sCbFS1FdXsThYiuKkYaVd4EZOD1cBU6AUCqTmyx
 QnVRsV7eFxvGvFAcWHYhwdLgNIHyKiq3IqGdJwBxWdNp/d4drKEmPGYC1my6/8KLDvy3
 jnDnTEF3ckR5n1nlrZEXEM8xkEzRXrszrKdGckwTxP5JVrKPVYb9hlvnJ7qQEzKmHSaG
 7Xmg==
X-Gm-Message-State: AOAM5323ufZYqPKcef0LW4uCH1Ma0y3rfQtbJfoL2NFD2YubNDAd61Nb
 geC6k2OAmtsBiOMmi1SW15MAWg==
X-Google-Smtp-Source: ABdhPJzkvgHbHJQFB0Vl9pkW/Iow3gjSEDxxH4fOhnneQefphexvAd84zisQveMIWr0xT/Y+QYFMEg==
X-Received: by 2002:a1c:7308:: with SMTP id d8mr17552813wmb.6.1590920290135;
 Sun, 31 May 2020 03:18:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f71sm2667547wmf.22.2020.05.31.03.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 03:18:08 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 04E951FF7E;
 Sun, 31 May 2020 11:18:08 +0100 (BST)
References: <20200530092306.26628-1-f4bug@amsat.org>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 0/5] hw/sh4: current patch queue
In-reply-to: <20200530092306.26628-1-f4bug@amsat.org>
Date: Sun, 31 May 2020 11:18:07 +0100
Message-ID: <87eer0v25c.fsf@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>, qemu-trivial@nongnu.org,
 Magnus Damm <magnus.damm@gmail.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Hi,
>
> As there is no SH4 active maintainer, I gathered various
> patches in a single series, in case someone is willing to
> apply them.

I'm sure you you could put yourself down as an "Odd Fixes" maintainer
and put together a PR if you want?

>
> CI report:
> https://travis-ci.org/github/philmd/qemu/builds/692828388
>
> Regards,
>
> Phil.
>
> Philippe Mathieu-Daud=C3=A9 (3):
>   hw/sh4: Use MemoryRegion typedef
>   hw/sh4: Extract timer definitions to 'hw/timer/tmu012.h'
>   hw/timer/sh_timer: Remove unused 'qemu/timer.h' include
>
> Thomas Huth (2):
>   tests/acceptance: Add boot tests for sh4 QEMU advent calendar image
>   .travis.yml: Test SH4 QEMU advent calendar image
>
>  include/hw/sh4/sh.h                    | 12 +-----------
>  include/hw/timer/tmu012.h              | 23 +++++++++++++++++++++++
>  hw/sh4/sh7750.c                        |  1 +
>  hw/timer/sh_timer.c                    |  3 ++-
>  .travis.yml                            |  2 +-
>  tests/acceptance/boot_linux_console.py | 13 +++++++++++--
>  6 files changed, 39 insertions(+), 15 deletions(-)
>  create mode 100644 include/hw/timer/tmu012.h


--=20
Alex Benn=C3=A9e

