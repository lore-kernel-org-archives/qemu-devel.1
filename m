Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEF0C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:51:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35BFF2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35BFF2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBEdP-0005bO-Ku
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 04:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBEbO-0003mz-Er
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:49:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBEbM-0001kg-GC
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:49:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58468)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBEbK-0001je-Fw
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:49:14 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 150F03C919
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 08:49:12 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id k67so785247wmf.3
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 01:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RVAEszXiIWDuX4gNnW3OknLHwPOA2LLp/b9WTG7Qrxs=;
 b=fMT+bYDfHhykYGLzvFmZqd9AVwpwWpCqgFYmkF4ywiweWilsiuxjqycDiav1W3BHSU
 WBZ3ZWoIMJDDdotva7f/9bzoxLUI+8Fg5LutlvQcPVLkACb1SzaWWKuaBgCyS/bOeVb5
 W4xYlfFbjmbNO/MshjNr+kB6YFdKd+362Y40+RNRc0/TcRg0XhUuG+0qj7hLa/JA8PCk
 7F7UPUXPmgbaYrs7uTwgLHM3IivHDXrP49YwmqqEaqaqhUZj6K2LdlnFLylUkeDZfv1O
 NPaj/RCaRWpHSgOrqUabA/l5z8JVFY+vv9IPpqwqZCeWHEj2z6vzSvP4kXuZLA14xa2b
 b8kA==
X-Gm-Message-State: APjAAAXfofUDVn2d1pwGNNfGanpY0dMNUZJckBY/F2e6+OvY5CzcRr9e
 5hNFfk343x9cvkkpMbMsFbHsRX6ISnOjSRhTVbcFNH6c8hPpiHdJrgS9OKAhEBdGZWmjmyQ4+Wh
 6LVnMt7gPJWWCNYI=
X-Received: by 2002:a05:600c:230d:: with SMTP id
 13mr2623100wmo.114.1568969350821; 
 Fri, 20 Sep 2019 01:49:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyvUQ/f1t0dewxYzL1S1w/eNQnpFGOK88jNFR1coerD3e2MhYlFmsLl/CeCjntW4Ob9LHE2Vw==
X-Received: by 2002:a05:600c:230d:: with SMTP id
 13mr2623085wmo.114.1568969350597; 
 Fri, 20 Sep 2019 01:49:10 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id g13sm1386687wrm.42.2019.09.20.01.49.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2019 01:49:10 -0700 (PDT)
Subject: Re: [PATCH 3/3] docker: remove unused debian-sid and debian-ports
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20190920001413.22567-1-jsnow@redhat.com>
 <20190920001413.22567-4-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <731ae95b-7c70-43ca-bea9-28b00de232d5@redhat.com>
Date: Fri, 20 Sep 2019 10:49:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190920001413.22567-4-jsnow@redhat.com>
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

On 9/20/19 2:14 AM, John Snow wrote:
> These are listed as "partial" images, but have no user.
> Remove them.

Well, I have WiP users from them. I could restore this content when they
are ready... Ports is the base of deprecated Debian archs. On the other
side Sid is the base for edge development I use from time to time to
test latest gcc/binutils.
I'll try to find time to raise WiP branches to PoC.

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/docker/Makefile.include                |  4 +--
>  tests/docker/dockerfiles/debian-ports.docker | 36 --------------------
>  tests/docker/dockerfiles/debian-sid.docker   | 35 -------------------
>  3 files changed, 2 insertions(+), 73 deletions(-)
>  delete mode 100644 tests/docker/dockerfiles/debian-ports.docker
>  delete mode 100644 tests/docker/dockerfiles/debian-sid.docker
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index 7af476d957..c282b5c520 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -5,8 +5,8 @@
>  DOCKER_SUFFIX :=3D .docker
>  DOCKER_FILES_DIR :=3D $(SRC_PATH)/tests/docker/dockerfiles
>  # we don't run tests on intermediate images (used as base by another i=
mage)
> -DOCKER_PARTIAL_IMAGES :=3D debian8 debian9 debian10 debian-sid
> -DEBIAN_PARTIAL_IMAGES +=3D debian-9-mxe debian-ports debian-bootstrap
> +DOCKER_PARTIAL_IMAGES :=3D debian8 debian9 debian10
> +DEBIAN_PARTIAL_IMAGES +=3D debian-9-mxe debian-bootstrap
>  DOCKER_IMAGES :=3D $(sort $(notdir $(basename $(wildcard $(DOCKER_FILE=
S_DIR)/*.docker))))
>  DOCKER_TARGETS :=3D $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
>  # Use a global constant ccache directory to speed up repetitive builds
> diff --git a/tests/docker/dockerfiles/debian-ports.docker b/tests/docke=
r/dockerfiles/debian-ports.docker
> deleted file mode 100644
> index 61bc3f2993..0000000000
> --- a/tests/docker/dockerfiles/debian-ports.docker
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -#
> -# Docker multiarch cross-compiler target
> -#
> -# This docker target is builds on Debian Ports cross compiler targets
> -# to build distro with a selection of cross compilers for building tes=
t binaries.
> -#
> -# On its own you can't build much but the docker-foo-cross targets
> -# build on top of the base debian image.
> -#
> -FROM debian:unstable
> -
> -MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> -
> -RUN echo "deb [arch=3Damd64] http://deb.debian.org/debian unstable mai=
n" > /etc/apt/sources.list
> -
> -# Duplicate deb line as deb-src
> -RUN cat /etc/apt/sources.list | sed -ne "s/^deb\ \(\[.*\]\ \)\?\(.*\)/=
deb-src \2/p" >> /etc/apt/sources.list
> -
> -# Setup some basic tools we need
> -RUN apt-get update && \
> -    DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata && \
> -    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> -    apt-get install -y --no-install-recommends \
> -        bison \
> -        build-essential \
> -        ca-certificates \
> -        clang \
> -        debian-ports-archive-keyring \
> -        flex \
> -        gettext \
> -        git \
> -        pkg-config \
> -        psmisc \
> -        python \
> -        texinfo \
> -        $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cu=
t -d\  -f2)
> diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/=
dockerfiles/debian-sid.docker
> deleted file mode 100644
> index 2a1bcc33b2..0000000000
> --- a/tests/docker/dockerfiles/debian-sid.docker
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -#
> -# Debian Sid Base
> -#
> -# Currently we can build all our guests with cross-compilers in the
> -# latest Debian release (Buster). However new compilers will first
> -# arrive in Sid. However Sid is a rolling distro which may be broken
> -# at any particular time. To try and mitigate this we use Debian's
> -# snapshot archive which provides a "stable" view of what state Sid
> -# was in.
> -#
> -
> -# This must be earlier than the snapshot date we are aiming for
> -FROM debian:sid-20190812-slim
> -
> - # Use a snapshot known to work (see http://snapshot.debian.org/#Usage=
)
> -ENV DEBIAN_SNAPSHOT_DATE "20190820"
> -RUN sed -i "s%^deb \(https\?://\)deb.debian.org/debian/\? \(.*\)%deb [=
check-valid-until=3Dno] \1snapshot.debian.org/archive/debian/${DEBIAN_SNA=
PSHOT_DATE} \2%" /etc/apt/sources.list
> -
> -# Duplicate deb line as deb-src
> -RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/s=
ources.list
> -
> -# Install common build utilities
> -RUN apt update && \
> -    DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata && \
> -    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> -    apt install -y --no-install-recommends \
> -        bison \
> -        build-essential \
> -        ca-certificates \
> -        flex \
> -        git \
> -        pkg-config \
> -        psmisc \
> -        python \
> -        texinfo || { echo "Failed to build - see debian-sid.docker not=
es"; exit 1; }
>=20

