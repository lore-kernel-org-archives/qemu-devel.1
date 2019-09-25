Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DE0C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE624205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE624205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDFiG-0007AJ-B5
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 18:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDFgI-00059s-56
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:22:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDFgG-0002oM-Nj
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:22:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46224)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDFgE-0002iC-HQ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:22:40 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 35DAB81F2F
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 22:22:29 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id 190so154822wme.4
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 15:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rlNSDOfeNx1Rl0Dgigrtkz7MRb7J8QrhNmvk6MgumQ0=;
 b=E9yCuo8x8zt6S5S24xdoqmTd+z0B6fmMVOmbmFBrCcbFru9T2fmFl+6uK2vqv50rRJ
 nuh0R+JswRrCdFNe0LlEH0UQYWJ8yWWOxbjz1uIHX+w0MBrWCUF+apqmHR0ktY1jOpsO
 EgVWkeXC2+VitrTO+olfmxfFLH0gR/b4cx4cAiFxnSKdPRam4AEGDZw0RyRROK20o1a5
 fDDkaoiTICweIfMJcSgsf861mZ6yN9iiosuCRxSCIaDI0UDYcxhVlI1uBE2LjZuTgzmr
 ZtGb41/0f+NhjUB8b4dhfRVTSucGH8/he3KjBhdzjOcMZZaMfwU5g0+rkKUMMD3hozQa
 6u8Q==
X-Gm-Message-State: APjAAAXdsuAQ57Zc0/pbHe9VKapYD6JuX3tCJ1g87Jn5mzS8xoHl4ML5
 Y+qjLbdMWPt4wOmWH+6+YsdWAsMZOszmqXLkraynlibj8VeaxDprWqRy+AtdwKsXjc/v11nqAnx
 j1a4WMsT59O1Kt68=
X-Received: by 2002:a05:600c:2186:: with SMTP id
 e6mr355896wme.154.1569450147946; 
 Wed, 25 Sep 2019 15:22:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyAig6XNwhkgdjSAD5V2D3OotAiQUxQY2nUL19SFOgxRqIUCRfUy++CimpkXDdXf7PFq9ZpKA==
X-Received: by 2002:a05:600c:2186:: with SMTP id
 e6mr355887wme.154.1569450147718; 
 Wed, 25 Sep 2019 15:22:27 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id w125sm842674wmg.32.2019.09.25.15.22.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 15:22:27 -0700 (PDT)
Subject: Re: [PATCH v3 32/33] docker: move tests from python2 to python3
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190924210106.27117-1-alex.bennee@linaro.org>
 <20190924210106.27117-33-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a9bf1bae-baa5-f209-c814-a73567933f55@redhat.com>
Date: Thu, 26 Sep 2019 00:22:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190924210106.27117-33-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, jsnow@redhat.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/19 11:01 PM, Alex Benn=C3=A9e wrote:
> From: John Snow <jsnow@redhat.com>
>=20
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
> Message-Id: <20190923181140.7235-7-jsnow@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  tests/docker/dockerfiles/centos7.docker             | 2 +-
>  tests/docker/dockerfiles/debian-xtensa-cross.docker | 2 +-
>  tests/docker/dockerfiles/debian10.docker            | 2 +-
>  tests/docker/dockerfiles/debian9.docker             | 2 +-
>  tests/docker/dockerfiles/travis.docker              | 2 +-
>  tests/docker/dockerfiles/ubuntu.docker              | 2 +-
>  tests/docker/dockerfiles/ubuntu1804.docker          | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/doc=
kerfiles/centos7.docker
> index e0b9d7dbe9f..953637065c4 100644
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
> diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/test=
s/docker/dockerfiles/debian-xtensa-cross.docker
> index b9c2e2e5317..e6f93f65ee2 100644
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
> index 30a78813f27..dad498b52e3 100644
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
> diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/doc=
kerfiles/debian9.docker
> index b36f1d4ed83..8cbd742bb5f 100644
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
> index e72dc85ca7a..ea14da29d97 100644
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
> index a4f601395c8..f4864922240 100644
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
> index 883f9bcf31c..3cc4f492c4a 100644
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

