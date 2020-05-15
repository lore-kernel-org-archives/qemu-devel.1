Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11BFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 22:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A813620657
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 22:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A813620657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZjHv-0002P4-ST
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 18:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jZjHM-0001yl-EP
 for qemu-devel@nongnu.org; Fri, 15 May 2020 18:58:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:47784)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jZjHL-00080S-EQ
 for qemu-devel@nongnu.org; Fri, 15 May 2020 18:58:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D6113ACCC;
 Fri, 15 May 2020 22:58:08 +0000 (UTC)
Subject: Re: [PATCH v2 1/5] tests/docker: Remove flex/bison packages
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200515163029.12917-1-philmd@redhat.com>
 <20200515163029.12917-2-philmd@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <a31a0a52-94dd-c073-7cc9-9d1b9578e52d@suse.de>
Date: Sat, 16 May 2020 00:58:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200515163029.12917-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:48:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/20 6:30 PM, Philippe Mathieu-Daudé wrote:
> QEMU does not use flex/bison packages.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v2: use 'does not' (Claudio)
> ---
>  tests/docker/dockerfiles/centos7.docker             | 2 --
>  tests/docker/dockerfiles/centos8.docker             | 2 --
>  tests/docker/dockerfiles/debian-xtensa-cross.docker | 2 --
>  tests/docker/dockerfiles/debian10.docker            | 2 --
>  tests/docker/dockerfiles/debian9.docker             | 2 --
>  tests/docker/dockerfiles/fedora.docker              | 2 --
>  tests/docker/dockerfiles/ubuntu.docker              | 2 +-
>  tests/docker/dockerfiles/ubuntu1804.docker          | 2 +-
>  8 files changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerfiles/centos7.docker
> index 9a2a2e515d..e197acdc3c 100644
> --- a/tests/docker/dockerfiles/centos7.docker
> +++ b/tests/docker/dockerfiles/centos7.docker
> @@ -5,13 +5,11 @@ RUN yum -y update
>  
>  # Please keep this list sorted alphabetically
>  ENV PACKAGES \
> -    bison \
>      bzip2 \
>      bzip2-devel \
>      ccache \
>      csnappy-devel \
>      dbus-daemon \
> -    flex \
>      gcc-c++ \
>      gcc \
>      gettext \
> diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/dockerfiles/centos8.docker
> index bfa0d33c9c..9852c5b9ee 100644
> --- a/tests/docker/dockerfiles/centos8.docker
> +++ b/tests/docker/dockerfiles/centos8.docker
> @@ -3,11 +3,9 @@ FROM centos:8.1.1911
>  RUN dnf -y update
>  ENV PACKAGES \
>      SDL-devel \
> -    bison \
>      bzip2 \
>      bzip2-devel \
>      dbus-daemon \
> -    flex \
>      gcc \
>      gcc-c++ \
>      gettext \
> diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles/debian-xtensa-cross.docker
> index e6f93f65ee..beb73f46ba 100644
> --- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
> +++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
> @@ -11,11 +11,9 @@ RUN apt-get update && \
>      DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
>      DEBIAN_FRONTEND=noninteractive eatmydata \
>      apt-get install -y --no-install-recommends \
> -        bison \
>          build-essential \
>          ca-certificates \
>          curl \
> -        flex \
>          gettext \
>          git \
>          python3-minimal
> diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dockerfiles/debian10.docker
> index 0769700a41..bcdff04ddf 100644
> --- a/tests/docker/dockerfiles/debian10.docker
> +++ b/tests/docker/dockerfiles/debian10.docker
> @@ -18,12 +18,10 @@ RUN apt update && \
>      DEBIAN_FRONTEND=noninteractive eatmydata \
>      apt install -y --no-install-recommends \
>          bc \
> -        bison \
>          build-essential \
>          ca-certificates \
>          clang \
>          dbus \
> -        flex \
>          gdb-multiarch \
>          gettext \
>          git \
> diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/dockerfiles/debian9.docker
> index 08cc970feb..0f0ebe530a 100644
> --- a/tests/docker/dockerfiles/debian9.docker
> +++ b/tests/docker/dockerfiles/debian9.docker
> @@ -18,11 +18,9 @@ RUN apt update && \
>      DEBIAN_FRONTEND=noninteractive eatmydata \
>      apt install -y --no-install-recommends \
>          bc \
> -        bison \
>          build-essential \
>          ca-certificates \
>          clang \
> -        flex \
>          gdb-multiarch \
>          gettext \
>          git \
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
> index 179575ecaa..92b6e11c8a 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -3,7 +3,6 @@ FROM fedora:30
>  # Please keep this list sorted alphabetically
>  ENV PACKAGES \
>      bc \
> -    bison \
>      brlapi-devel \
>      bzip2 \
>      bzip2-devel \
> @@ -13,7 +12,6 @@ ENV PACKAGES \
>      dbus-daemon \
>      device-mapper-multipath-devel \
>      findutils \
> -    flex \
>      gcc \
>      gcc-c++ \
>      gettext \
> diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
> index eeb3b22bf2..90ea6311c6 100644
> --- a/tests/docker/dockerfiles/ubuntu.docker
> +++ b/tests/docker/dockerfiles/ubuntu.docker
> @@ -10,7 +10,7 @@
>  #
>  
>  FROM ubuntu:19.04
> -ENV PACKAGES flex bison \
> +ENV PACKAGES \
>      ccache \
>      clang \
>      dbus \
> diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/dockerfiles/ubuntu1804.docker
> index f66b06f4cf..a10ea2850b 100644
> --- a/tests/docker/dockerfiles/ubuntu1804.docker
> +++ b/tests/docker/dockerfiles/ubuntu1804.docker
> @@ -1,5 +1,5 @@
>  FROM ubuntu:18.04
> -ENV PACKAGES flex bison \
> +ENV PACKAGES \
>      ccache \
>      clang \
>      gcc \
> 


Reviewed-by: Claudio Fontana <cfontana@suse.de>

