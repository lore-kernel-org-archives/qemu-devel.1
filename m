Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D0EC49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 08:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6871820820
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 08:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6871820820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBazs-0007vF-Jl
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 04:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBayp-0007Qc-8h
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBaym-0001IJ-Ix
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:42:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60376)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBaym-0001Hm-Bj
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:42:56 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 506488665D
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 08:42:55 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id d10so2032081wmb.0
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 01:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p9zMh6ZEcbH8qh/wudH3/JdbV+OxSbApP1rivciriaI=;
 b=Lcq+hLkcey9Tw/ybQBTjIS/MvizYbBk5XZZxzBi1r8dfKFFq+rNsln7tBniXa0PFVw
 jghfnRxevg9ZNRHrdTy9Eilw6FgW2g+xtOt/r2WolM7JvSvgBKJ+hoYHq6HPs5MEgW6M
 cSwnNZw/9jfYD1YlUY2fpqH0u/nrNAYFBUGQ3r0/kvZ32L4CW6qAFzmlJOioIVXVf+fE
 TY4CVZAj0GR/KT32evu0LtAdq+TItRUFsaSo6Dsd0kFgRBsCSDTc70ULoYmefLbLlmM0
 pfniXEEaf++AyYf5vxXhLCLcNjxtFQ/tmyKHdG6J6sCngUlbvq88sYYDRczChG89UGdL
 +6Pg==
X-Gm-Message-State: APjAAAWYVCehF05cAn6IW67U83wtxB0PpurHERTBu6I8SYWkBzO5bv/H
 SI9RdEkERHslEpxR2WmEHU6K4sw/YHXLAccHy6bATSD0ebh9FYhW28Gd3xGSGz1kKbybWIj5MaB
 y1tpZTgxOz3+R4Uw=
X-Received: by 2002:a7b:cf1a:: with SMTP id l26mr6734711wmg.38.1569055373289; 
 Sat, 21 Sep 2019 01:42:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwafU4AnvEb03qBqeKNT6oGKpodR6PpMMblsxFBCesyS8Vb/UsyfwLXg68jhrb3atZRFZEiQA==
X-Received: by 2002:a7b:cf1a:: with SMTP id l26mr6734700wmg.38.1569055373073; 
 Sat, 21 Sep 2019 01:42:53 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id q15sm8712920wrg.65.2019.09.21.01.42.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Sep 2019 01:42:52 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] docker: removed unused debian8 partial image
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20190920221255.30412-1-jsnow@redhat.com>
 <20190920221255.30412-6-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <301ec2a8-bd6a-2f7a-69a6-bbe411682178@redhat.com>
Date: Sat, 21 Sep 2019 10:42:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190920221255.30412-6-jsnow@redhat.com>
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
> debian8 partial base is also not consumed by any image, so remove it.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/docker/Makefile.include           |  3 +--
>  tests/docker/dockerfiles/debian8.docker | 33 -------------------------
>  2 files changed, 1 insertion(+), 35 deletions(-)
>  delete mode 100644 tests/docker/dockerfiles/debian8.docker
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index cb41652885..b9430822b8 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -5,8 +5,7 @@
>  DOCKER_SUFFIX :=3D .docker
>  DOCKER_FILES_DIR :=3D $(SRC_PATH)/tests/docker/dockerfiles
>  # we don't run tests on intermediate images (used as base by another i=
mage)
> -DOCKER_PARTIAL_IMAGES :=3D debian8 debian9 debian10
> -DOCKER_PARTIAL_IMAGES +=3D debian9-mxe debian-bootstrap
> +DOCKER_PARTIAL_IMAGES :=3D debian9 debian9-mxe debian10 debian-bootstr=
ap
>  DOCKER_IMAGES :=3D $(sort $(notdir $(basename $(wildcard $(DOCKER_FILE=
S_DIR)/*.docker))))
>  DOCKER_TARGETS :=3D $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
>  # Use a global constant ccache directory to speed up repetitive builds
> diff --git a/tests/docker/dockerfiles/debian8.docker b/tests/docker/doc=
kerfiles/debian8.docker
> deleted file mode 100644
> index be67023826..0000000000
> --- a/tests/docker/dockerfiles/debian8.docker
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -#
> -# Docker multiarch cross-compiler target
> -#
> -# This docker target is builds on Debian and Emdebian's cross compiler=
 targets
> -# to build distro with a selection of cross compilers for building tes=
t binaries.
> -#
> -# On its own you can't build much but the docker-foo-cross targets
> -# build on top of the base debian image.
> -#
> -FROM debian:jessie-slim
> -
> -MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> -
> -# Duplicate deb line as deb-src
> -RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/s=
ources.list
> -
> -# Setup some basic tools we need
> -RUN apt update && \
> -    DEBIAN_FRONTEND=3Dnoninteractive apt-get install -yy eatmydata && =
\
> -    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> -    apt-get install -y --no-install-recommends \
> -        bison \
> -        binutils-multiarch \
> -        build-essential \
> -        ca-certificates \
> -        clang \
> -        curl \
> -        flex \
> -        gettext \
> -        git \
> -        gnupg \
> -        pkg-config \
> -        python3-minimal
>=20

