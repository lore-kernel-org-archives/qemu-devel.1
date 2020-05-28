Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20019C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 08:42:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DABB62075F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 08:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LQtv8DLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DABB62075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeE7Q-00071Y-3n
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 04:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jeE6o-0006ad-0A
 for qemu-devel@nongnu.org; Thu, 28 May 2020 04:41:50 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43863)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jeE6m-00089H-0d
 for qemu-devel@nongnu.org; Thu, 28 May 2020 04:41:49 -0400
Received: by mail-wr1-x441.google.com with SMTP id l10so4227517wrr.10
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 01:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=TkZMAY7TuPApvGJNz71wpVcyDaMfY32S9C54ZGFb7U8=;
 b=LQtv8DLpmkzJ7ItqUd2uixfalCMr6TjF3d4RiQAyBjhZGrTzSwnOdIBv6ZvG+imedN
 mh1aB1EN4J0qOeyNuO/m2a/EH9xeJVOJCZ+wpO0d3iiZGnUB1LNCQ5ivYrdtkGko8Fjp
 2Tnj0+yLbtfabkK1IiBMlZbp81GzBPSl9aELdyYvsLdbPNEzQuh9O+NJClyMulyQ1Sgo
 GCa7iQHtNC4lixsLe6/dv2mx37NESWX9yFiBofs5dDAM7c9K8oqSrGyWJWoehCIUManD
 rIAOeu0aJNGWpt2sBjeXV37r3z40bd81eXY0zIEIa0/nmp8/sREliOGXQEFAdVf65YXz
 MwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=TkZMAY7TuPApvGJNz71wpVcyDaMfY32S9C54ZGFb7U8=;
 b=ilvl19dbQtGF6HHai7ijLMMQWNBmUi78daJzmXZXrhiR6GOkEvkyri7s71n7yORXKi
 20fOy9xVX7FnQY0TW51ftRjIjdZYBHahI4xyidnLmTubgjatMfHISV7TpGfePwbod8ti
 3ugSNix1kax1BHaxKI3hZx0r1KQAI9ut4ayRPtWO3B6brGbXXYpJxxSCI/SljdCvRjst
 zZER7AgKVPBWngJsBKH6zJmIjtio9Y5qkb0fzFtqs8Xe7aNUM09wsUYJ9iybjvmKkYLo
 RpZEQSJt+8oJ9fRpXlEqR6HWjIlqhQnPVaaLG6P/3iAMRf+RnnfZwy6SParmpdQ0CYRj
 L3ig==
X-Gm-Message-State: AOAM533zAwFJ8Wdw1LqcV41LSHI7hn8sfjLCMBoyeNxXboELgUo2hbsW
 MVcQ9V806nRNTaD6Hme+N4WfRxkJ5hs=
X-Google-Smtp-Source: ABdhPJzQKlVVC6ucZcPJltECcvx7OQ4tY1afsgO6q1O1Im4OL70FbGf8ChaBGRZkmwOiKvMcILt72w==
X-Received: by 2002:adf:82cf:: with SMTP id 73mr2352165wrc.382.1590655305672; 
 Thu, 28 May 2020 01:41:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a16sm5182935wrx.8.2020.05.28.01.41.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 01:41:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5C3CA1FF7E;
 Thu, 28 May 2020 09:41:43 +0100 (BST)
References: <20200525131823.715-1-thuth@redhat.com>
 <20200525131823.715-7-thuth@redhat.com>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 6/7] gitlab-ci: Determine the number of jobs dynamically
In-reply-to: <20200525131823.715-7-thuth@redhat.com>
Date: Thu, 28 May 2020 09:41:43 +0100
Message-ID: <87pnao4fjs.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> Some people might want to run the gitlab CI pipelines in an environment
> where multiple CPUs are available to the runners, so let's rather get
> the number for "-j" from the "nproc" program (increased by 1 to compensate
> for jobs that wait for I/O) instead of hard-coding it.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
<snip>
> @@ -25,8 +27,8 @@ build-system1:
>   - ../configure --enable-werror --target-list=3D"aarch64-softmmu alpha-s=
oftmmu
>        cris-softmmu hppa-softmmu lm32-softmmu moxie-softmmu microblazeel-=
softmmu
>        mips64el-softmmu m68k-softmmu ppc-softmmu riscv64-softmmu sparc-so=
ftmmu"
> - - make -j2
> - - make -j2 check
> + - make -j"$JOBS"
> + - make -j"$JOBS" check
>=20=20
>  build-system2:
>   image: fedora:latest
> @@ -40,8 +42,8 @@ build-system2:
>   - ../configure --enable-werror --target-list=3D"tricore-softmmu unicore=
32-softmmu
>        microblaze-softmmu mips-softmmu riscv32-softmmu s390x-softmmu sh4-=
softmmu
>        sparc64-softmmu x86_64-softmmu xtensa-softmmu nios2-softmmu or1k-s=
oftmmu"
> - - make -j2
> - - make -j2 check
> + - make -j"$JOBS"
> + - make -j"$JOBS" check
>=20=20
>  build-disabled:
>   image: fedora:latest
> @@ -56,8 +58,8 @@ build-disabled:
>        --disable-qom-cast-debug --disable-spice --disable-vhost-vsock
>        --disable-vhost-net --disable-vhost-crypto --disable-vhost-user
>        --target-list=3D"i386-softmmu ppc64-softmmu mips64-softmmu i386-li=
nux-user"
> - - make -j2
> - - make -j2 check-qtest SPEED=3Dslow
> + - make -j"$JOBS"
> + - make -j"$JOBS" check-qtest SPEED=3Dslow

I would make all the check jobs use a single core as it otherwise gets
hard to figure out exactly where something broke/hung.

<snip>
> @@ -100,8 +102,8 @@ build-clang:
>   - ../configure --cc=3Dclang --cxx=3Dclang++ --enable-werror
>        --target-list=3D"alpha-softmmu arm-softmmu m68k-softmmu mips64-sof=
tmmu
>                       ppc-softmmu s390x-softmmu x86_64-softmmu arm-linux-=
user"
> - - make -j2
> - - make -j2 check
> + - make -j"$JOBS"
> + - make -j"$JOBS" check

Ditto for this check

>=20=20
>  build-tci:
>   image: centos:8
> @@ -112,7 +114,7 @@ build-tci:
>   - cd build
>   - ../configure --enable-tcg-interpreter
>        --target-list=3D"$(for tg in $TARGETS; do echo -n ${tg}'-softmmu '=
; done)"
> - - make -j2
> + - make -j"$JOBS"
>   - make run-tcg-tests-x86_64-softmmu
>   - make tests/qtest/boot-serial-test tests/qtest/cdrom-test tests/qtest/=
pxe-test
>   - for tg in $TARGETS ; do

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

