Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A4CC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26EE120673
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26EE120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCnLw-0001Ba-Vh
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 12:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iCmQj-0003w5-Pb
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iCmQh-0006lS-VI
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:08:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53970)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iCmQh-0006kg-MN
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:08:39 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 44D513B708
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 15:08:37 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id w10so706211wrl.5
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 08:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/eLWCNCbBZEZVnzV9wLsZW+54PNGqBeL1MsCH5zOS4Y=;
 b=rfplqAQmaNVEasnk39dx2E77ufCBU3CUWP6UVeVrmnN0exucu6pwIDFCeOSoNM4bOL
 EKQ+9qtEamPsV9dQmUEUd1s7R0SA04IT6LtMe1eHmZB0opgmS53W2pAtGnvjhl3zCE4d
 TO23YOb/oaXc/E2bNms3wjVeOjxdFU895BOOGyTloxWsw4Pi9VCAuG0JNTAW/Qqj7Iqs
 2nNVyrHQ7X/K+pl98qN/EUscY9oIjwdHMhjjhVts3B8cnDSTgCx9HPH/NCpsVC8eNyMJ
 jKqTsNemDT7Q6KuDvZHzkjTM1cgTIW//pnNdD5/S/3rwxUqZHuPBSCE1e0XAUNnuZRuY
 sRpQ==
X-Gm-Message-State: APjAAAXFDHfwl/yy+zJbf+HhPb+BKJisFtuF29+xlIAc1mZSljo6uoOj
 s5hk1hHTzXUINv2gv303+xlrq0bg3fAy+oBXJqTwZMdKZ2O4308fwxZ+Yc13K9fakzI1Bax/NH2
 YBWnpvUiGqRk7TlI=
X-Received: by 2002:a1c:7c15:: with SMTP id x21mr589604wmc.154.1569337715873; 
 Tue, 24 Sep 2019 08:08:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwTIpheVzgqx6KYwvvuV99hl6AXului8OsBumqocX4VdN6fRPrSA4saLdx3L/kT6J9ul1NOfw==
X-Received: by 2002:a1c:7c15:: with SMTP id x21mr589575wmc.154.1569337715658; 
 Tue, 24 Sep 2019 08:08:35 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id i1sm403255wmb.19.2019.09.24.08.08.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2019 08:08:34 -0700 (PDT)
Subject: Re: [PATCH v3 6/6] docker: move tests from python2 to python3
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20190923181140.7235-1-jsnow@redhat.com>
 <20190923181140.7235-7-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8723e5c0-7336-3d5b-e8b0-92bea31b350b@redhat.com>
Date: Tue, 24 Sep 2019 17:08:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190923181140.7235-7-jsnow@redhat.com>
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

On 9/23/19 8:11 PM, John Snow wrote:
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

It seems this one already has:

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

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

