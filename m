Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1873C4CECF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7498C20820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7498C20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCR1m-0005Zt-GA
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 12:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iCQzI-0004B0-El
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iCQzG-00055l-9B
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:14:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43114)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iCQzG-00054e-0U
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:14:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1436C8535C;
 Mon, 23 Sep 2019 16:14:53 +0000 (UTC)
Received: from dhcp-17-179.bos.redhat.com (dhcp-17-179.bos.redhat.com
 [10.18.17.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E0FB91001B00;
 Mon, 23 Sep 2019 16:14:45 +0000 (UTC)
Date: Mon, 23 Sep 2019 12:14:43 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 1/5] docker: move tests from python2 to python3
Message-ID: <20190923161443.GB29623@dhcp-17-179.bos.redhat.com>
References: <20190920221255.30412-1-jsnow@redhat.com>
 <20190920221255.30412-2-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920221255.30412-2-jsnow@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Mon, 23 Sep 2019 16:14:53 +0000 (UTC)
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
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 20, 2019 at 06:12:51PM -0400, John Snow wrote:
> As part of the push to drop python2 support, replace any explicit python2
> dependencies with python3 versions.
> 
> For centos, python2 still exists as an implicit dependency, but by adding
> python3 we will be able to build even if the configure script begins to
> require python 3.5+.
> 
> Tested with centos7, fedora, ubuntu, ubuntu1804, and debian 9 (amd64).
> Tested under a custom configure script that requires Python 3.5+.
> 
> the travis dockerfile is also moved to using python3, which was tested
> by running `make docker-test-build@travis`, which I hope is sufficient.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> Message-id: 20190920200049.27216-1-jsnow@redhat.com
> ---
>  tests/docker/dockerfiles/centos7.docker             | 2 +-
>  tests/docker/dockerfiles/debian-ports.docker        | 2 +-
>  tests/docker/dockerfiles/debian-sid.docker          | 2 +-
>  tests/docker/dockerfiles/debian-xtensa-cross.docker | 2 +-
>  tests/docker/dockerfiles/debian10.docker            | 2 +-
>  tests/docker/dockerfiles/debian8.docker             | 3 +--
>  tests/docker/dockerfiles/debian9.docker             | 2 +-
>  tests/docker/dockerfiles/travis.docker              | 2 +-
>  tests/docker/dockerfiles/ubuntu.docker              | 2 +-
>  tests/docker/dockerfiles/ubuntu1804.docker          | 2 +-
>  10 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerfiles/centos7.docker
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
> diff --git a/tests/docker/dockerfiles/debian-ports.docker b/tests/docker/dockerfiles/debian-ports.docker
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
>          $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
> diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/dockerfiles/debian-sid.docker
> index 2a1bcc33b2..dcb8e83715 100644
> --- a/tests/docker/dockerfiles/debian-sid.docker
> +++ b/tests/docker/dockerfiles/debian-sid.docker
> @@ -31,5 +31,5 @@ RUN apt update && \
>          git \
>          pkg-config \
>          psmisc \
> -        python \
> +        python3 \
>          texinfo || { echo "Failed to build - see debian-sid.docker notes"; exit 1; }
> diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles/debian-xtensa-cross.docker
> index b9c2e2e531..e6f93f65ee 100644
> --- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
> +++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
> @@ -18,7 +18,7 @@ RUN apt-get update && \
>          flex \
>          gettext \
>          git \
> -        python-minimal
> +        python3-minimal
>  
>  ENV CPU_LIST csp dc232b dc233c
>  ENV TOOLCHAIN_RELEASE 2018.02
> diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dockerfiles/debian10.docker
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
>          $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
> diff --git a/tests/docker/dockerfiles/debian8.docker b/tests/docker/dockerfiles/debian8.docker
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
> diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/dockerfiles/debian9.docker
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
>          $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
> diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/dockerfiles/travis.docker
> index e72dc85ca7..ea14da29d9 100644
> --- a/tests/docker/dockerfiles/travis.docker
> +++ b/tests/docker/dockerfiles/travis.docker
> @@ -5,7 +5,7 @@ ENV LC_ALL en_US.UTF-8
>  RUN sed -i "s/# deb-src/deb-src/" /etc/apt/sources.list
>  RUN apt-get update
>  RUN apt-get -y build-dep qemu
> -RUN apt-get -y install device-tree-compiler python2.7 python-yaml dh-autoreconf gdb strace lsof net-tools gcovr
> +RUN apt-get -y install device-tree-compiler python3 python3-yaml dh-autoreconf gdb strace lsof net-tools gcovr
>  # Travis tools require PhantomJS / Neo4j / Maven accessible
>  # in their PATH (QEMU build won't access them).
>  ENV PATH /usr/local/phantomjs/bin:/usr/local/phantomjs:/usr/local/neo4j-3.2.7/bin:/usr/local/maven-3.5.2/bin:/usr/local/cmake-3.9.2/bin:/usr/local/clang-5.0.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
> diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
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
> diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/dockerfiles/ubuntu1804.docker
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
> -- 
> 2.21.0
> 
> 

With the exception of debian8.docker, as noted in v1 and as addressed
later in this series:

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

