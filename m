Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E992CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 08:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B90F42063A
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 08:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mo/vorCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90F42063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeE3D-0004B1-0O
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 04:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jeE2f-0003kj-Ev
 for qemu-devel@nongnu.org; Thu, 28 May 2020 04:37:33 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33055)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jeE2e-00071k-5K
 for qemu-devel@nongnu.org; Thu, 28 May 2020 04:37:32 -0400
Received: by mail-wm1-x341.google.com with SMTP id j198so3984937wmj.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 01:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=QIRJUCrOmnItilJILJITHVol5OPeBUjeImrjw2DaJTo=;
 b=Mo/vorCEPBJLRdOmNfaYlGZtXE4EvP+w8OTcZwrUwr5KWJ6myiCdLdZy7Ry/Ta9SH4
 mrpUUdVSCczBbXFRKWvvLMO0ITkzJr/Q5Z+BPox3DMCscfL6JqfeCfFwlIjWZgo3ghcM
 miH8RTPENCrbkA9Sm0lsWBdxSifygxvEiHaGusOX8/sOn3i3uJGfOMh0quoY3Hg7b/lm
 n7D3XPU9Dldh342ksGZ4jyXC5isoyb/U9QWypjKVcmS+PWN50I8yomsq/59zU3nKp9qr
 nRNFD8U27+grtvZu8s3EElzFPBhccwjpPjC7SDdXttYRZAQZs0NBuWwAoeI6otGDbcK1
 Ilrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=QIRJUCrOmnItilJILJITHVol5OPeBUjeImrjw2DaJTo=;
 b=AgbSEGLdTPk/WAFde2EWLq1ry4L0Q4aexBvF3YDqTo6PK2q1JLoc4QGInEDjH8pj9+
 N1S5c+QcQHe80HjGhzrUKiWP/epEYYxeoJeosOzhWHOqbWB0CGqnu/oasA/yBgyjp+Qk
 3ibomAra2yZMEsGj+cjSOLwcNFFb9PD/gVRbzj8jr83fyFTvOq97Y2Nn0m4/ckninBQW
 PgjHfa/tIRs5Xwtz1ccyPySuMg3byMqjSZcPK8p1Zii+XhFPoX9uvQmeJ9yCwmjGgmXZ
 fTQv9zCX3hqlszRdkpoAbognxya7ueGMAkgFoVL+4G9+qjc70aweXjjy2SY3KdSggrEB
 kw3Q==
X-Gm-Message-State: AOAM5333nPLCKggWJk0wHDpvPDRjhfPZEMqQR1YeXWCPWGtv6s4JAlON
 4yQdFUqG8rVTMmk8Dwhpo5H4Yj8UQwE=
X-Google-Smtp-Source: ABdhPJyAOkIPaDqNbK8Tx0o+ao1WoPRk0wGx0Q4MXWJ0vphyW2zuDyZiUAGlBmK4LaxOoOPxYTqGeQ==
X-Received: by 2002:a1c:4009:: with SMTP id n9mr2300232wma.104.1590655049240; 
 Thu, 28 May 2020 01:37:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j18sm5422286wrn.59.2020.05.28.01.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 01:37:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2E8A11FF7E;
 Thu, 28 May 2020 09:37:27 +0100 (BST)
References: <20200525131823.715-1-thuth@redhat.com>
 <20200525131823.715-6-thuth@redhat.com>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 5/7] gitlab-ci: Do not use the standard container images
 from gitlab
In-reply-to: <20200525131823.715-6-thuth@redhat.com>
Date: Thu, 28 May 2020 09:37:27 +0100
Message-ID: <87sgfk4fqw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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

> Currently all pipelines of the gitlab CI are failing, except for the
> "build-user" pipeline. There is an issue with the default container
> image (likely Debian stable) where they imported something bad in one
> of the system headers:
>
>  /usr/include/linux/swab.h: In function '__swab':
>  /builds/huth/qemu/include/qemu/bitops.h:20:34: error: "sizeof" is not
>   defined, evaluates to 0 [-Werror=3Dundef]
>  #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
>
> We could maybe work-around this issue or wait for the default containers
> to get fixed, but considering that we use Ubuntu (and thus Debian-style)
> CI in Travis already to a very large extent, we should consider to use
> some RPM-based distros in our gitlab CI instead. Thus let's change the
> failing pipelines to use Fedora and CentOS (and also one Ubuntu 19.10,
> since 20.04 is broken, too) now.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

I will say Fedora/CentOS won't be immune to this failure if they update
the kernel headers to somewhere between the breakage and the fix.

> ---
>  .gitlab-ci.yml | 37 +++++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 5208d93ff8..559ec2ab4d 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -5,9 +5,17 @@ include:
>  .update_apt_template: &before_script_apt
>   before_script:
>    - apt-get update -qq
> -  - apt-get install -y -qq libglib2.0-dev libpixman-1-dev genisoimage
> +  - apt-get install -y -qq git gcc libglib2.0-dev libpixman-1-dev make
> +        genisoimage
> +
> +.update_dnf_template: &before_script_dnf
> + before_script:
> +  - dnf update -y
> +  - dnf install -y bzip2 diffutils gcc git genisoimage findutils glib2-d=
evel
> +        make python3 perl-podlators perl-Test-Harness pixman-devel zlib-=
devel
>=20=20
>  build-system1:
> + image: ubuntu:19.10
>   <<: *before_script_apt
>   script:
>   - apt-get install -y -qq libgtk-3-dev libvte-dev nettle-dev libcacard-d=
ev
> @@ -21,11 +29,12 @@ build-system1:
>   - make -j2 check
>=20=20
>  build-system2:
> - <<: *before_script_apt
> + image: fedora:latest
> + <<: *before_script_dnf
>   script:
> - - apt-get install -y -qq libsdl2-dev libgcrypt-dev libbrlapi-dev libaio=
-dev
> -      libfdt-dev liblzo2-dev librdmacm-dev libibverbs-dev libibumad-dev
> -      libzstd-dev
> + - yum install -y SDL2-devel libgcrypt-devel brlapi-devel libaio-devel
> +       libfdt-devel lzo-devel librdmacm-devel libibverbs-devel libibumad=
-devel
> +       libzstd-devel
>   - mkdir build
>   - cd build
>   - ../configure --enable-werror --target-list=3D"tricore-softmmu unicore=
32-softmmu
> @@ -35,7 +44,8 @@ build-system2:
>   - make -j2 check
>=20=20
>  build-disabled:
> - <<: *before_script_apt
> + image: fedora:latest
> + <<: *before_script_dnf
>   script:
>   - mkdir build
>   - cd build
> @@ -50,9 +60,10 @@ build-disabled:
>   - make -j2 check-qtest SPEED=3Dslow
>=20=20
>  build-tcg-disabled:
> - <<: *before_script_apt
> + image: centos:8
> + <<: *before_script_dnf
>   script:
> - - apt-get install -y -qq clang libgtk-3-dev libusb-dev
> + - dnf install -y clang gtk3-devel libusbx-devel libgcrypt-devel
>   - mkdir build
>   - cd build
>   - ../configure --cc=3Dclang --enable-werror --disable-tcg --audio-drv-l=
ist=3D""
> @@ -79,10 +90,11 @@ build-user:
>   - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
>=20=20
>  build-clang:
> - <<: *before_script_apt
> + image: fedora:latest
> + <<: *before_script_dnf
>   script:
> - - apt-get install -y -qq clang libsdl2-dev libattr1-dev libcap-ng-dev
> -      xfslibs-dev libiscsi-dev libnfs-dev libseccomp-dev gnutls-dev libr=
bd-dev
> + - yum install -y clang SDL2-devel libattr-devel libcap-ng-devel xfsprog=
s-devel
> +       libiscsi-devel libnfs-devel libseccomp-devel gnutls-devel librbd-=
devel
>   - mkdir build
>   - cd build
>   - ../configure --cc=3Dclang --cxx=3Dclang++ --enable-werror
> @@ -92,7 +104,8 @@ build-clang:
>   - make -j2 check
>=20=20
>  build-tci:
> - <<: *before_script_apt
> + image: centos:8
> + <<: *before_script_dnf
>   script:
>   - TARGETS=3D"aarch64 alpha arm hppa m68k microblaze moxie ppc64 s390x x=
86_64"
>   - mkdir build


--=20
Alex Benn=C3=A9e

