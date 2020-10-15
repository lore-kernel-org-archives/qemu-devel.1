Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423AAC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 06:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 519E622210
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 06:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O/Pr7Av1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519E622210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSxA4-00019T-99
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 02:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kSx5o-0005mg-EK
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 02:50:28 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45458)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kSx5l-0002RI-F4
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 02:50:27 -0400
Received: by mail-wr1-x442.google.com with SMTP id e17so1927646wru.12
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 23:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=7DEbBxJ56He6bKworC6vr+rGVqrya8r+C3AT7n0QyYU=;
 b=O/Pr7Av1zqZSgzsXlhBdaRDuI4p7QGTxb11nFDr34nhMO4bxAnXsI93syuf6T1YcNO
 NhdUyP8JxM+NAPnatxW67KOThOyaPMIO/n4Eq+OpF/eulABrjHkxqEE4iqyFEc6hWYyP
 kTTUSW1Hz6723A3W0oKndoy6tce/8IaDPg1b4A03SDdo0hADuXq7dPbl5AKmTkUm1myh
 SuYn+hCjAFCXGNFP2NAc5A79ZeID1NaLh3335kqMxohOH0+/7f3+ud0wXuwyc4XeJovz
 KxkIHoX6JwCCSIjuHBZfybf8/sJ/Fh/AS0Ar4bNAZwkYxH3qcTyGi3BGwYnN8+qyvmmV
 Dwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=7DEbBxJ56He6bKworC6vr+rGVqrya8r+C3AT7n0QyYU=;
 b=NBlW8LUGxVTkigSsbpLAvYlzByF2l0BPv08a+TOMVlm0zrRvtd7FPsqmyDDfUBpvTh
 YJVffnUOvo91ZTVVRYilMiU58LMb7mI5RJCW9wEDqxy9C9RI+cjl3b9UrjB6mgKBb15s
 dhir2yXnGmup7paybvdcyGgUYVAn3NMtZuM2S/pxbMFg5IYFUr/KdvFI/bkLXxvOl5UO
 8qjC82mKifUsg52AkcachSp8tJ2KbVhPEBS7w/6mdNvG4xf8P8j+kU8zyT5tl8f/NCF9
 qhDAHe4ljH5HEzwfg1f2W5rhUXfkvjeXymT49TCdIdZAE97b/AqlxdmfHLKzpICrOyaS
 EJAA==
X-Gm-Message-State: AOAM530fTV5APaYnS29kSND8O1r4jzO2kmtEfWCJQ+jiTjBu2UOco+Gr
 dqniN9Due1aBYsl+9nTXZIuXaA==
X-Google-Smtp-Source: ABdhPJyxlAuCxavqOhRko09Y4o6eEsK0rKPwkRf1ENY0f/Bs73a2RfnHRsQ3bbgmNPcJ1/nJxwmS8w==
X-Received: by 2002:adf:bbca:: with SMTP id z10mr2640568wrg.403.1602744623085; 
 Wed, 14 Oct 2020 23:50:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i10sm3139586wrq.27.2020.10.14.23.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 23:50:21 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3F53D1FF7E;
 Thu, 15 Oct 2020 07:50:21 +0100 (BST)
References: <20201014135416.1290679-1-pbonzini@redhat.com>
 <20201014135416.1290679-7-pbonzini@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6/7] add ninja to dockerfiles, CI configurations and
 test VMs
In-reply-to: <20201014135416.1290679-7-pbonzini@redhat.com>
Date: Thu, 15 Oct 2020 07:50:21 +0100
Message-ID: <875z7cx9si.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  .cirrus.yml                                |  6 +++---
>  .travis.yml                                | 13 +++++++++++++
>  tests/docker/dockerfiles/centos7.docker    |  1 +
>  tests/docker/dockerfiles/centos8.docker    |  1 +
>  tests/docker/dockerfiles/debian10.docker   |  1 +
>  tests/docker/dockerfiles/fedora.docker     |  1 +
>  tests/docker/dockerfiles/travis.docker     |  2 +-
>  tests/docker/dockerfiles/ubuntu.docker     |  1 +
>  tests/docker/dockerfiles/ubuntu1804.docker |  1 +
>  tests/docker/dockerfiles/ubuntu2004.docker |  1 +
>  tests/vm/centos                            |  2 +-
>  tests/vm/centos.aarch64                    |  2 +-
>  tests/vm/fedora                            |  2 +-
>  tests/vm/freebsd                           |  1 +
>  tests/vm/netbsd                            |  1 +
>  tests/vm/openbsd                           |  1 +
>  tests/vm/ubuntu.aarch64                    |  2 +-
>  tests/vm/ubuntu.i386                       |  2 +-
>  18 files changed, 32 insertions(+), 9 deletions(-)
>
> diff --git a/.cirrus.yml b/.cirrus.yml
> index 99d118239c..87f7b047d7 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -9,7 +9,7 @@ freebsd_12_task:
>    install_script:
>      - ASSUME_ALWAYS_YES=3Dyes pkg bootstrap -f ;
>      - pkg install -y bash curl cyrus-sasl git glib gmake gnutls gsed
> -          nettle perl5 pixman pkgconf png usbredir
> +          nettle perl5 pixman pkgconf png usbredir ninja
>    script:
>      - mkdir build
>      - cd build
> @@ -21,7 +21,7 @@ macos_task:
>    osx_instance:
>      image: catalina-base
>    install_script:
> -    - brew install pkg-config python gnu-sed glib pixman make sdl2 bash
> +    - brew install pkg-config python gnu-sed glib pixman make sdl2 bash =
ninja
>    script:
>      - mkdir build
>      - cd build
> @@ -36,7 +36,7 @@ macos_xcode_task:
>      # this is an alias for the latest Xcode
>      image: catalina-xcode
>    install_script:
> -    - brew install pkg-config gnu-sed glib pixman make sdl2 bash
> +    - brew install pkg-config gnu-sed glib pixman make sdl2 bash ninja
>    script:
>      - mkdir build
>      - cd build
> diff --git a/.travis.yml b/.travis.yml
> index 1054ec5d29..d7bfbb8bfe 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -49,6 +49,7 @@ addons:
>        - libvdeplug-dev
>        - libvte-2.91-dev
>        - libzstd-dev
> +      - ninja-build
>        - sparse
>        - uuid-dev
>        - gcovr
> @@ -177,6 +178,7 @@ jobs:
>        addons:
>          apt:
>            packages:
> +            - ninja-build
>              - python3-sphinx
>              - perl
>=20=20
> @@ -211,6 +213,10 @@ jobs:
>      # gprof/gcov are GCC features
>      - name: "GCC gprof/gcov"
>        dist: bionic
> +      addons:
> +        apt:
> +          packages:
> +            - ninja-build
>        env:
>          - CONFIG=3D"--enable-gprof --enable-gcov --disable-libssh
>                    --target-list=3D${MAIN_SOFTMMU_TARGETS}"
> @@ -281,6 +287,7 @@ jobs:
>              - liburcu-dev
>              - libusb-1.0-0-dev
>              - libvte-2.91-dev
> +            - ninja-build
>              - sparse
>              - uuid-dev
>        language: generic
> @@ -346,6 +353,7 @@ jobs:
>            - libusb-1.0-0-dev
>            - libvdeplug-dev
>            - libvte-2.91-dev
> +          - ninja-build
>            # Tests dependencies
>            - genisoimage
>        env:
> @@ -379,6 +387,7 @@ jobs:
>            - libusb-1.0-0-dev
>            - libvdeplug-dev
>            - libvte-2.91-dev
> +          - ninja-build
>            # Tests dependencies
>            - genisoimage
>        env:
> @@ -411,6 +420,7 @@ jobs:
>            - libusb-1.0-0-dev
>            - libvdeplug-dev
>            - libvte-2.91-dev
> +          - ninja-build
>            # Tests dependencies
>            - genisoimage
>        env:
> @@ -450,6 +460,7 @@ jobs:
>            - libzstd-dev
>            - nettle-dev
>            - xfslibs-dev
> +          - ninja-build
>            # Tests dependencies
>            - genisoimage
>        env:
> @@ -463,6 +474,7 @@ jobs:
>          apt_packages:
>            - libgcrypt20-dev
>            - libgnutls28-dev
> +          - ninja-build
>        env:
>          - CONFIG=3D"--disable-containers --disable-system"
>=20=20
> @@ -493,6 +505,7 @@ jobs:
>            - libusb-1.0-0-dev
>            - libvdeplug-dev
>            - libvte-2.91-dev
> +          - ninja-build
>        env:
>          - TEST_CMD=3D"make check-unit"
>          - CONFIG=3D"--disable-containers --disable-tcg --enable-kvm
> diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/docke=
rfiles/centos7.docker
> index 46277773bf..8b273725ee 100644
> --- a/tests/docker/dockerfiles/centos7.docker
> +++ b/tests/docker/dockerfiles/centos7.docker
> @@ -27,6 +27,7 @@ ENV PACKAGES \
>      mesa-libEGL-devel \
>      mesa-libgbm-devel \
>      nettle-devel \
> +    ninja-build \
>      perl-Test-Harness \
>      pixman-devel \
>      python3 \
> diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/docke=
rfiles/centos8.docker
> index e31d366fc1..b0eef13987 100644
> --- a/tests/docker/dockerfiles/centos8.docker
> +++ b/tests/docker/dockerfiles/centos8.docker
> @@ -22,6 +22,7 @@ ENV PACKAGES \
>      make \
>      mesa-libEGL-devel \
>      nettle-devel \
> +    ninja-build \
>      perl-Test-Harness \
>      pixman-devel \
>      python36 \
> diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dock=
erfiles/debian10.docker
> index 1e4188ba22..21cc671d71 100644
> --- a/tests/docker/dockerfiles/debian10.docker
> +++ b/tests/docker/dockerfiles/debian10.docker
> @@ -26,6 +26,7 @@ RUN apt update && \
>          gettext \
>          git \
>          libncurses5-dev \
> +        ninja-build \
>          pkg-config \
>          psmisc \
>          python3 \
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/docker=
files/fedora.docker
> index 85c975543d..ac79d95418 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -75,6 +75,7 @@ ENV PACKAGES \
>      mingw64-SDL2 \
>      ncurses-devel \
>      nettle-devel \
> +    ninja-build \
>      nss-devel \
>      numactl-devel \
>      perl \
> diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/docker=
files/travis.docker
> index 591282561b..cd1435a7e9 100644
> --- a/tests/docker/dockerfiles/travis.docker
> +++ b/tests/docker/dockerfiles/travis.docker
> @@ -9,7 +9,7 @@ ENV LC_ALL en_US.UTF-8
>  RUN sed -i "s/# deb-src/deb-src/" /etc/apt/sources.list
>  RUN apt-get update
>  RUN apt-get -y build-dep qemu
> -RUN apt-get -y install device-tree-compiler python3 python3-yaml dh-auto=
reconf gdb strace lsof net-tools gcovr
> +RUN apt-get -y install device-tree-compiler python3 python3-yaml dh-auto=
reconf gdb strace lsof net-tools gcovr ninja-build
>  # Travis tools require PhantomJS / Neo4j / Maven accessible
>  # in their PATH (QEMU build won't access them).
>  ENV PATH /usr/local/phantomjs/bin:/usr/local/phantomjs:/usr/local/neo4j-=
3.2.7/bin:/usr/local/maven-3.5.2/bin:/usr/local/cmake-3.9.2/bin:/usr/local/=
clang-5.0.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
> diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/docker=
files/ubuntu.docker
> index b556ed17d2..b5ef7a8198 100644
> --- a/tests/docker/dockerfiles/ubuntu.docker
> +++ b/tests/docker/dockerfiles/ubuntu.docker
> @@ -60,6 +60,7 @@ ENV PACKAGES \
>      libxen-dev \
>      libzstd-dev \
>      make \
> +    ninja-build \
>      python3-yaml \
>      python3-sphinx \
>      sparse \
> diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/do=
ckerfiles/ubuntu1804.docker
> index a6a7617da6..9b0a19ba5e 100644
> --- a/tests/docker/dockerfiles/ubuntu1804.docker
> +++ b/tests/docker/dockerfiles/ubuntu1804.docker
> @@ -48,6 +48,7 @@ ENV PACKAGES \
>      make \
>      python3-yaml \
>      python3-sphinx \
> +    ninja-build \
>      sparse \
>      xfslibs-dev
>  RUN apt-get update && \
> diff --git a/tests/docker/dockerfiles/ubuntu2004.docker b/tests/docker/do=
ckerfiles/ubuntu2004.docker
> index f4b9556b9e..17b37cda38 100644
> --- a/tests/docker/dockerfiles/ubuntu2004.docker
> +++ b/tests/docker/dockerfiles/ubuntu2004.docker
> @@ -47,6 +47,7 @@ ENV PACKAGES flex bison \
>      libxen-dev \
>      libzstd-dev \
>      make \
> +    ninja-build \
>      python3-numpy \
>      python3-opencv \
>      python3-pil \
> diff --git a/tests/vm/centos b/tests/vm/centos
> index 0ad4ecf419..efe3dbbb36 100755
> --- a/tests/vm/centos
> +++ b/tests/vm/centos
> @@ -42,7 +42,7 @@ class CentosVM(basevm.BaseVM):
>          self.wait_ssh()
>          self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
>          self.ssh_root_check("yum update -y")
> -        self.ssh_root_check("yum install -y docker make git python3")
> +        self.ssh_root_check("yum install -y docker make ninja-build git =
python3")
>          self.ssh_root_check("systemctl enable docker")
>          self.ssh_root("poweroff")
>          self.wait()
> diff --git a/tests/vm/centos.aarch64 b/tests/vm/centos.aarch64
> index d5232ecdb8..e687b93e52 100755
> --- a/tests/vm/centos.aarch64
> +++ b/tests/vm/centos.aarch64
> @@ -23,7 +23,7 @@ import aarch64vm
>  DEFAULT_CONFIG =3D {
>      'cpu'          : "max",
>      'machine'      : "virt,gic-version=3Dmax",
> -    'install_cmds' : "yum install -y make git python3 gcc gcc-c++ flex b=
ison, "\
> +    'install_cmds' : "yum install -y make ninja-build git python3 gcc gc=
c-c++ flex bison, "\
>          "yum install -y glib2-devel pixman-devel zlib-devel, "\
>          "yum install -y perl-Test-Harness, "\
>          "alternatives --set python /usr/bin/python3, "\
> diff --git a/tests/vm/fedora b/tests/vm/fedora
> index b2b478fdbc..b977efe4a2 100755
> --- a/tests/vm/fedora
> +++ b/tests/vm/fedora
> @@ -32,7 +32,7 @@ class FedoraVM(basevm.BaseVM):
>      pkgs =3D [
>          # tools
>          'git-core',
> -        'gcc', 'binutils', 'make',
> +        'gcc', 'binutils', 'make', 'ninja-build',
>=20=20
>          # perl
>          'perl-Test-Harness',
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index 5f866e09c4..04ee793381 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -34,6 +34,7 @@ class FreeBSDVM(basevm.BaseVM):
>          "bzip2",
>          "python37",
>          "py37-setuptools",
> +        "ninja",
>=20=20
>          # gnu tools
>          "bash",
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index ffb65a89be..a9da255c5a 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -32,6 +32,7 @@ class NetBSDVM(basevm.BaseVM):
>          "xz",
>          "python37",
>          "py37-setuptools",
> +        "ninja",
>=20=20
>          # gnu tools
>          "bash",
> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> index 8356646f21..ad882a76a2 100755
> --- a/tests/vm/openbsd
> +++ b/tests/vm/openbsd
> @@ -31,6 +31,7 @@ class OpenBSDVM(basevm.BaseVM):
>          "pkgconf",
>          "bzip2", "xz",
>          "py3-setuptools",
> +        "ninja",
>=20=20
>          # gnu tools
>          "bash",
> diff --git a/tests/vm/ubuntu.aarch64 b/tests/vm/ubuntu.aarch64
> index 21d454c27f..b291945a7e 100755
> --- a/tests/vm/ubuntu.aarch64
> +++ b/tests/vm/ubuntu.aarch64
> @@ -22,7 +22,7 @@ DEFAULT_CONFIG =3D {
>      'machine'      : "virt,gic-version=3D3",
>      'install_cmds' : "apt-get update,"\
>                       "apt-get build-dep -y --arch-only qemu,"\
> -                     "apt-get install -y libfdt-dev pkg-config language-=
pack-en",
> +                     "apt-get install -y libfdt-dev pkg-config language-=
pack-en ninja-build",
>      # We increase beyond the default time since during boot
>      # it can take some time (many seconds) to log into the VM
>      # especially using softmmu.
> diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
> index 5ce72610a6..47681b6f87 100755
> --- a/tests/vm/ubuntu.i386
> +++ b/tests/vm/ubuntu.i386
> @@ -18,7 +18,7 @@ import ubuntuvm
>  DEFAULT_CONFIG =3D {
>      'install_cmds' : "apt-get update,"\
>                       "apt-get build-dep -y qemu,"\
> -                     "apt-get install -y libfdt-dev language-pack-en",
> +                     "apt-get install -y libfdt-dev language-pack-en nin=
ja-build",
>  }
>=20=20
>  class UbuntuX86VM(ubuntuvm.UbuntuVM):


--=20
Alex Benn=C3=A9e

