Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F39C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1A17205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A17205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDFiK-0007Hq-QP
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 18:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDFgh-0005cq-Uj
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDFgg-0003PR-K9
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:23:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52182)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDFgg-0003Nl-Be
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:23:06 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 32E3D8BE70
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 22:23:05 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id k67so106942wmf.3
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 15:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xIRWKHwuhmGgQ2DBdDv7braUmXvt/dPR0puqbDZkaBM=;
 b=WYm5hvwVwk9wrMBJZIox+rgqB1fbM4UrIWumzv+k2l0QgJ5ZeCAlnBzuMjezvCVWsd
 0LdRioq3t+MPixuHj/0ttVs9/boku51vKo9KVaVGs0cq98hEL8wiSQqtxf3xLA0twYqH
 G/M8ly08T+uMvdAbPVdAosfNhlSbSzVabnmGdu+z4Zbu2ptI2/QB71Kp1lokgMbKEKZa
 hLHf6KZsv0sXQC3ciTcYqEF7uC2b2rpudBRffpgDYIbmfWDAL4DCrwpcgqpet85zeRaF
 cRr9r7o+LrLUUe267KCs9NH78CYZqim6ltRJsLp5TS8AXDDJKv7ze4SpaW4jFnRxM682
 JfGg==
X-Gm-Message-State: APjAAAUpC7dDFP02lKA/ZAtDG+lbdLVJaK7pfEDIVzv+ILuaJ2q3nKWn
 mZc5WT23KBSnZ4NlY9766pxedDfD3c6dCridYQltQ4N/JZ1UwwoEQlsUIXrX0jgnGYvZYf9J/u7
 3xg1JeYbg1cdoYYw=
X-Received: by 2002:a05:600c:2151:: with SMTP id
 v17mr327286wml.56.1569450183756; 
 Wed, 25 Sep 2019 15:23:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqywDEQ1GhInVyc3sC0+4E9wDn2lAf1BoGyeUvlwno+oZpeIykILU88nnvHQO2fxPYmT2C2Nuw==
X-Received: by 2002:a05:600c:2151:: with SMTP id
 v17mr327274wml.56.1569450183575; 
 Wed, 25 Sep 2019 15:23:03 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id z13sm293911wrq.51.2019.09.25.15.23.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 15:23:03 -0700 (PDT)
Subject: Re: [PATCH v3 30/33] docker: remove unused debian-ports
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190924210106.27117-1-alex.bennee@linaro.org>
 <20190924210106.27117-31-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <5d31902d-1cd4-ba04-ff7a-76214b9cabe7@redhat.com>
Date: Thu, 26 Sep 2019 00:23:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190924210106.27117-31-alex.bennee@linaro.org>
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
> debian-ports is listed as a partial image, so we cannot run tests again=
st it.
> Since it isn't used by any other testable image, remove it for now as i=
t
> is prone to bitrot.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> Message-Id: <20190923181140.7235-5-jsnow@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  tests/docker/Makefile.include                |  2 +-
>  tests/docker/dockerfiles/debian-ports.docker | 36 --------------------
>  2 files changed, 1 insertion(+), 37 deletions(-)
>  delete mode 100644 tests/docker/dockerfiles/debian-ports.docker
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index fd6f470fbf8..053c418d8cd 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -6,7 +6,7 @@ DOCKER_SUFFIX :=3D .docker
>  DOCKER_FILES_DIR :=3D $(SRC_PATH)/tests/docker/dockerfiles
>  # we don't run tests on intermediate images (used as base by another i=
mage)
>  DOCKER_PARTIAL_IMAGES :=3D debian9 debian10 debian-sid
> -DOCKER_PARTIAL_IMAGES +=3D debian9-mxe debian-ports debian-bootstrap
> +DOCKER_PARTIAL_IMAGES +=3D debian9-mxe debian-bootstrap
>  DOCKER_IMAGES :=3D $(sort $(notdir $(basename $(wildcard $(DOCKER_FILE=
S_DIR)/*.docker))))
>  DOCKER_TARGETS :=3D $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
>  # Use a global constant ccache directory to speed up repetitive builds
> diff --git a/tests/docker/dockerfiles/debian-ports.docker b/tests/docke=
r/dockerfiles/debian-ports.docker
> deleted file mode 100644
> index 61bc3f2993a..00000000000
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
>=20

