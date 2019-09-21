Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C922C49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 08:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C485B217F5
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 08:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C485B217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBb5B-0002mg-V8
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 04:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBb3t-00023w-8F
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:48:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBb3r-0004LZ-Er
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:48:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50586)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBb3r-0004J6-6C
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:48:11 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 19DBF81F07
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 08:48:10 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id r187so5168405wme.0
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 01:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mgYDJ7Yhu7ZSijioNQnaXM/hXeFWQfHDmsC6B5oDxXI=;
 b=Lkdhh1ZtBcB/xJdCQrvCvPqxzSvW+cnNbSpHG9DsuOZPxr1CirJdXzcVcuVsevV+rr
 YfC9uknx2zsl/w5WoBZ22acqGDy0Ub1aX67Uhwl2LW0rpJ0YeLVgokKgxJsEuXeG9LOt
 q151peifpiVIa8MiPLxIo+0ZQTH3II8M+7156hMQMYK6C2KiCiDw59I8zwvd9CNibeIV
 DQqzNHFM3HqpirfmkP2PW/bjJE9CgV1pBA/YiCa2gc0vm9C11ojV5/VoMQuZKqT89ZFp
 UIkbhEvW6blRcwP9p84nblrYGCPJARqWRQH7yRugOp1+GXhQtYup4ftdRF/B1BH7TMhQ
 NWBg==
X-Gm-Message-State: APjAAAUFfuDqyaoQ6rIL1LBRMsV833VniOZn0ZOuXILg/h/p0SAGUN9Y
 /ngHNy6QZa0Kl9/bFO13kf1y8Xxq6VuECrq1P8s1qp9a0Fs9iOPVfc3SfMyQDbDPFvZOTlzqMIs
 K0U4qqhs1sV9/BvQ=
X-Received: by 2002:a5d:5381:: with SMTP id d1mr3972386wrv.315.1569055688279; 
 Sat, 21 Sep 2019 01:48:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyEU46TY+7tSnLatl9x9rBVZYu/fwnu74Kmnqe+12aGjWdCdLYRQdjMLPL+n9NuFj3YCLtIfA==
X-Received: by 2002:a5d:5381:: with SMTP id d1mr3972377wrv.315.1569055688052; 
 Sat, 21 Sep 2019 01:48:08 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id g73sm6870591wme.10.2019.09.21.01.48.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Sep 2019 01:48:07 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] docker: move tests from python2 to python3
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20190920221255.30412-1-jsnow@redhat.com>
 <20190920221255.30412-2-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <4ed65a51-051c-0a61-d63c-042306740a7d@redhat.com>
Date: Sat, 21 Sep 2019 10:48:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190920221255.30412-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/19 12:12 AM, John Snow wrote:
> As part of the push to drop python2 support, replace any explicit pytho=
n2
> dependencies with python3 versions.
>=20
> For centos, python2 still exists as an implicit dependency, but by addi=
ng
> python3 we will be able to build even if the configure script begins to
> require python 3.5+.
>=20
> Tested with centos7, fedora, ubuntu, ubuntu1804, and debian 9 (amd64).
> Tested under a custom configure script that requires Python 3.5+.
>=20
> the travis dockerfile is also moved to using python3, which was tested
> by running `make docker-test-build@travis`, which I hope is sufficient.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

> Message-id: 20190920200049.27216-1-jsnow@redhat.com
  ^ remove

v1 has:
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

> ---
>  tests/docker/dockerfiles/centos7.docker             | 2 +-
>  tests/docker/dockerfiles/debian-ports.docker        | 2 +-
>  tests/docker/dockerfiles/debian-sid.docker          | 2 +-
>  tests/docker/dockerfiles/debian-xtensa-cross.docker | 2 +-
>  tests/docker/dockerfiles/debian10.docker            | 2 +-
>  tests/docker/dockerfiles/debian8.docker             | 3 +--

If you queue this patch at the end of your series, no need to patch
debian8.docker.

Anyway,
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>  tests/docker/dockerfiles/debian9.docker             | 2 +-
>  tests/docker/dockerfiles/travis.docker              | 2 +-
>  tests/docker/dockerfiles/ubuntu.docker              | 2 +-
>  tests/docker/dockerfiles/ubuntu1804.docker          | 2 +-
>  10 files changed, 10 insertions(+), 11 deletions(-)
>=20
> diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/doc=
kerfiles/centos7.docker
> index e0b9d7dbe9..953637065c 100644
> --- a/tests/docker/dockerfiles/centos7.docker
> +++ b/tests/docker/dockerfiles/centos7.docker
> @@ -25,6 +25,7 @@ ENV PACKAGES \
>      nettle-devel \
>      perl-Test-Harness \
>      pixman-devel \
> +    python3 \
>      SDL-devel \
>      spice-glib-devel \
>      spice-server-devel \
> @@ -34,4 +35,3 @@ ENV PACKAGES \
>      zlib-devel
>  RUN yum install -y $PACKAGES
>  RUN rpm -q $PACKAGES | sort > /packages.txt
> -
> diff --git a/tests/docker/dockerfiles/debian-ports.docker b/tests/docke=
r/dockerfiles/debian-ports.docker
> index 61bc3f2993..f1ea8d3bd1 100644
> --- a/tests/docker/dockerfiles/debian-ports.docker
> +++ b/tests/docker/dockerfiles/debian-ports.docker
> @@ -31,6 +31,6 @@ RUN apt-get update && \
>          git \
>          pkg-config \
>          psmisc \
> -        python \
> +        python3 \
>          texinfo \
>          $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cu=
t -d\  -f2)
> diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/=
dockerfiles/debian-sid.docker
> index 2a1bcc33b2..dcb8e83715 100644
> --- a/tests/docker/dockerfiles/debian-sid.docker
> +++ b/tests/docker/dockerfiles/debian-sid.docker
> @@ -31,5 +31,5 @@ RUN apt update && \
>          git \
>          pkg-config \
>          psmisc \
> -        python \
> +        python3 \
>          texinfo || { echo "Failed to build - see debian-sid.docker not=
es"; exit 1; }
> diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/test=
s/docker/dockerfiles/debian-xtensa-cross.docker
> index b9c2e2e531..e6f93f65ee 100644
> --- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
> +++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
> @@ -18,7 +18,7 @@ RUN apt-get update && \
>          flex \
>          gettext \
>          git \
> -        python-minimal
> +        python3-minimal
> =20
>  ENV CPU_LIST csp dc232b dc233c
>  ENV TOOLCHAIN_RELEASE 2018.02
> diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/do=
ckerfiles/debian10.docker
> index 30a78813f2..dad498b52e 100644
> --- a/tests/docker/dockerfiles/debian10.docker
> +++ b/tests/docker/dockerfiles/debian10.docker
> @@ -26,7 +26,7 @@ RUN apt update && \
>          git \
>          pkg-config \
>          psmisc \
> -        python \
> +        python3 \
>          python3-sphinx \
>          texinfo \
>          $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cu=
t -d\  -f2)
> diff --git a/tests/docker/dockerfiles/debian8.docker b/tests/docker/doc=
kerfiles/debian8.docker
> index 1212a85c35..be67023826 100644
> --- a/tests/docker/dockerfiles/debian8.docker
> +++ b/tests/docker/dockerfiles/debian8.docker
> @@ -30,5 +30,4 @@ RUN apt update && \
>          git \
>          gnupg \
>          pkg-config \
> -        python-minimal
> -
> +        python3-minimal
> diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/doc=
kerfiles/debian9.docker
> index b36f1d4ed8..8cbd742bb5 100644
> --- a/tests/docker/dockerfiles/debian9.docker
> +++ b/tests/docker/dockerfiles/debian9.docker
> @@ -26,7 +26,7 @@ RUN apt update && \
>          git \
>          pkg-config \
>          psmisc \
> -        python \
> +        python3 \
>          python3-sphinx \
>          texinfo \
>          $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cu=
t -d\  -f2)
> diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/dock=
erfiles/travis.docker
> index e72dc85ca7..ea14da29d9 100644
> --- a/tests/docker/dockerfiles/travis.docker
> +++ b/tests/docker/dockerfiles/travis.docker
> @@ -5,7 +5,7 @@ ENV LC_ALL en_US.UTF-8
>  RUN sed -i "s/# deb-src/deb-src/" /etc/apt/sources.list
>  RUN apt-get update
>  RUN apt-get -y build-dep qemu
> -RUN apt-get -y install device-tree-compiler python2.7 python-yaml dh-a=
utoreconf gdb strace lsof net-tools gcovr
> +RUN apt-get -y install device-tree-compiler python3 python3-yaml dh-au=
toreconf gdb strace lsof net-tools gcovr
>  # Travis tools require PhantomJS / Neo4j / Maven accessible
>  # in their PATH (QEMU build won't access them).
>  ENV PATH /usr/local/phantomjs/bin:/usr/local/phantomjs:/usr/local/neo4=
j-3.2.7/bin:/usr/local/maven-3.5.2/bin:/usr/local/cmake-3.9.2/bin:/usr/lo=
cal/clang-5.0.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sb=
in:/bin
> diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dock=
erfiles/ubuntu.docker
> index a4f601395c..f486492224 100644
> --- a/tests/docker/dockerfiles/ubuntu.docker
> +++ b/tests/docker/dockerfiles/ubuntu.docker
> @@ -60,7 +60,7 @@ ENV PACKAGES flex bison \
>      libvte-2.91-dev \
>      libxen-dev \
>      make \
> -    python-yaml \
> +    python3-yaml \
>      python3-sphinx \
>      sparse \
>      texinfo \
> diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/=
dockerfiles/ubuntu1804.docker
> index 883f9bcf31..3cc4f492c4 100644
> --- a/tests/docker/dockerfiles/ubuntu1804.docker
> +++ b/tests/docker/dockerfiles/ubuntu1804.docker
> @@ -47,7 +47,7 @@ ENV PACKAGES flex bison \
>      libvte-2.91-dev \
>      libxen-dev \
>      make \
> -    python-yaml \
> +    python3-yaml \
>      python3-sphinx \
>      sparse \
>      texinfo \
>=20

