Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47415C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 12:45:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1385B20673
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 12:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1385B20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD6fK-0000DD-6n
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 08:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iD6eJ-0008DQ-M3
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iD6eH-0000hf-Ut
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:44:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38832)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iD6eH-0000hT-NH
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:44:01 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5ABD6C059758
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 12:44:00 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id v13so2308176wrq.23
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 05:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kY76yfW2qiOorEdllzesQ8tQV1w8H+KhYDIJKcqb0qY=;
 b=a6bXt3m1XpqsnlFCxuhjzZ4EW2wp+7vVs3NvOWEce/AHJPxyIyOpc/g/tjxT13X7ur
 KLduA5dNh7aMSU26HGSpouwdP8dUuanXVxvxEOKQwPdZZBRLr2A+yJ4HJ7fK7d/yHcpR
 FNnErxlTKrupe9q25A7MhCUOlG/eLSyQMJECbSnn3itHQflhvTuM80CVv/v9WleVBNrE
 Es+zrdxMCzDVTsNtQCuIIjZwE7Db97MqvDwESytuyBhXzohN4u+XcSadejbCSk7MwGFY
 0L/Yl8UxviZCdgZ5G8rhpeLSpYfJdR/emSaaySfQDBHQK4W188KoDyFMuewrg51MgEN7
 U3WA==
X-Gm-Message-State: APjAAAW0AtJS8DLWyaZqnN2urAT9ZdFmMZ75buEaahZ3kq324rdOVeJM
 DS+TsTa4OycM+FdTr6uIHU43TSSJr88a8lwuRo9TMKAe7dE8GZr6asxOI83JHCNnDa4kpfCLL8L
 Qs/fJ8DuAr3bjE6E=
X-Received: by 2002:a05:600c:20a:: with SMTP id
 10mr8073367wmi.75.1569415439066; 
 Wed, 25 Sep 2019 05:43:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw76V/1VhBd7/lrlsOdmLzJPhfW9baqt+ZUUAVrQs77Gq1kHb+Ps1ITT8tOJEuU496Aw9fn9Q==
X-Received: by 2002:a05:600c:20a:: with SMTP id
 10mr8073347wmi.75.1569415438886; 
 Wed, 25 Sep 2019 05:43:58 -0700 (PDT)
Received: from [10.201.33.84] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id c8sm4061031wrr.49.2019.09.25.05.43.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 05:43:58 -0700 (PDT)
Subject: Re: [PATCH v3 28/33] docker: removed unused debian8 partial image
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190924210106.27117-1-alex.bennee@linaro.org>
 <20190924210106.27117-29-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <611d514a-b2f8-99db-2ddc-e269fb1bd756@redhat.com>
Date: Wed, 25 Sep 2019 14:43:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190924210106.27117-29-alex.bennee@linaro.org>
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

"removed" -> "remove" in subject?

On 9/24/19 11:01 PM, Alex Benn=C3=A9e wrote:
> From: John Snow <jsnow@redhat.com>
>=20
> debian8 partial base is also not consumed by any image, so remove it.
> For QEMU's development cycle, we only support debian9 (stretch) and
> debian10 (buster).
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Message-Id: <20190923181140.7235-3-jsnow@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/docker/Makefile.include           |  2 +-
>  tests/docker/dockerfiles/debian8.docker | 34 -------------------------
>  2 files changed, 1 insertion(+), 35 deletions(-)
>  delete mode 100644 tests/docker/dockerfiles/debian8.docker
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index 47d2273f29d..82d5a8a5393 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -6,7 +6,7 @@ DOCKER_SUFFIX :=3D .docker
>  DOCKER_FILES_DIR :=3D $(SRC_PATH)/tests/docker/dockerfiles
>  DOCKER_DEPRECATED_IMAGES :=3D debian
>  # we don't run tests on intermediate images (used as base by another i=
mage)
> -DOCKER_PARTIAL_IMAGES :=3D debian debian8 debian9 debian10 debian-sid
> +DOCKER_PARTIAL_IMAGES :=3D debian debian9 debian10 debian-sid
>  DOCKER_PARTIAL_IMAGES +=3D debian9-mxe debian-ports debian-bootstrap
>  DOCKER_IMAGES :=3D $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(n=
otdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
>  DOCKER_TARGETS :=3D $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
> diff --git a/tests/docker/dockerfiles/debian8.docker b/tests/docker/doc=
kerfiles/debian8.docker
> deleted file mode 100644
> index 1212a85c35b..00000000000
> --- a/tests/docker/dockerfiles/debian8.docker
> +++ /dev/null
> @@ -1,34 +0,0 @@
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
> -        python-minimal
> -
>=20

