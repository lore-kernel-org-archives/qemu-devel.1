Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B431C43331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 11:42:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1082220854
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 11:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1082220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Z6R-0003EY-9l
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 07:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i6Z5S-0002nM-Rc
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 07:41:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i6Z5R-0004aq-Cf
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 07:41:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45622)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i6Z5R-0004aV-4Y
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 07:41:01 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E9BC781F0D
 for <qemu-devel@nongnu.org>; Sat,  7 Sep 2019 11:40:59 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id n6so3889683wrm.20
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2019 04:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gibKIrvMOyThSj0BrH8E2Yg0CLLSns0gx7U2DGRNO+0=;
 b=kqd3r7/iXeq32vYw5erzIWOyz+qQlDoQeZz5iT8A9Jj0zkFMy/MO7trAYu+gYrzjA3
 ow9atNksYIGaomsDgDOAL215IXsWBjiTRwrexnoqgBCIbpB8OhXbYYhEm/MXa6o7Ggv0
 yAGKtVMEUXSoP9t0iEirmrcqU+PqvU4ZX+KVxv+QYtrQGer+SaLkso80Tm75FXagSnod
 dNfrCdBqR/HYy5nACTfYesXbSZakfooy4zaY5Wle06sANjehibS2dmyXBrV/J+AvPcek
 UUuEhO4rI9ER4lRN9B3bimNfTFcKq3+Aqw1B8pUqrbrJEdtxKMCUPF8fFzud0uM1vvH9
 RGkg==
X-Gm-Message-State: APjAAAU5EZVUVsW5MMLWUaI1ZsPtfUEXo0Dyx/WhLcnTbfABI4+Hkf3/
 3F+71+yIE9LTH1LbI3476s85BEhaYCws+OjnaUvdWeZKL9hIH5Pi8puE7dzc/k8LIQwvxCM9TH1
 TTi1g5mQJcTNmia4=
X-Received: by 2002:a7b:c303:: with SMTP id k3mr11321036wmj.47.1567856456974; 
 Sat, 07 Sep 2019 04:40:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxCGovJi6uNvBa3y64MAyUnixax12Rm/kC4932yO3lZ8qBDOhZw0xkZEZ0Y77Rsam54qvFw2g==
X-Received: by 2002:a7b:c303:: with SMTP id k3mr11321011wmj.47.1567856456769; 
 Sat, 07 Sep 2019 04:40:56 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id s26sm15477270wrs.63.2019.09.07.04.40.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Sep 2019 04:40:56 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190904203013.9028-1-alex.bennee@linaro.org>
 <20190904203013.9028-28-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <eb684fc6-5181-b168-2da4-5d546b747a9b@redhat.com>
Date: Sat, 7 Sep 2019 13:40:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190904203013.9028-28-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 27/42] tests/docker: use --arch-only for
 installing deps
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/19 10:29 PM, Alex Benn=C3=A9e wrote:
> The Debian QEMU packages require a bunch of cross compilers for
> building firmware which aren't available on all host architectures.
> Using --arch-only skips this particular requirement and allows us to
> install just the dependencies we need.

Nice finding!

>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  tests/docker/dockerfiles/debian-arm64-cross.docker    | 2 +-
>  tests/docker/dockerfiles/debian-armel-cross.docker    | 2 +-
>  tests/docker/dockerfiles/debian-armhf-cross.docker    | 2 +-
>  tests/docker/dockerfiles/debian-mips-cross.docker     | 6 +++---
>  tests/docker/dockerfiles/debian-mips64el-cross.docker | 2 +-
>  tests/docker/dockerfiles/debian-mipsel-cross.docker   | 2 +-
>  tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 2 +-
>  tests/docker/dockerfiles/debian-s390x-cross.docker    | 2 +-
>  8 files changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests=
/docker/dockerfiles/debian-arm64-cross.docker
> index 55045ff5d5a..09ca0a1ba79 100644
> --- a/tests/docker/dockerfiles/debian-arm64-cross.docker
> +++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
> @@ -13,7 +13,7 @@ RUN apt update && \
>          crossbuild-essential-arm64
>  RUN apt update && \
>      DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> -    apt build-dep -yy -a arm64 qemu
> +    apt build-dep -yy -a arm64 --arch-only qemu
> =20
>  # Specify the cross prefix for this image (see tests/docker/common.rc)
>  ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Daarch64-linux-gnu-
> diff --git a/tests/docker/dockerfiles/debian-armel-cross.docker b/tests=
/docker/dockerfiles/debian-armel-cross.docker
> index 363a162a253..15378f8ea2c 100644
> --- a/tests/docker/dockerfiles/debian-armel-cross.docker
> +++ b/tests/docker/dockerfiles/debian-armel-cross.docker
> @@ -11,7 +11,7 @@ RUN dpkg --add-architecture armel && \
>      apt update && \
>      apt install -yy crossbuild-essential-armel && \
>      DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> -    apt build-dep -yy -a armel qemu
> +    apt build-dep -yy -a armel --arch-only qemu
> =20
>  # Specify the cross prefix for this image (see tests/docker/common.rc)
>  ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Darm-linux-gnueabi-
> diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests=
/docker/dockerfiles/debian-armhf-cross.docker
> index d5365881e79..4a20af6fe1a 100644
> --- a/tests/docker/dockerfiles/debian-armhf-cross.docker
> +++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
> @@ -13,7 +13,7 @@ RUN apt update && \
>          crossbuild-essential-armhf
>  RUN apt update && \
>      DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> -    apt build-dep -yy -a armhf qemu
> +    apt build-dep -yy -a armhf --arch-only qemu
> =20
>  # Specify the cross prefix for this image (see tests/docker/common.rc)
>  ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Darm-linux-gnueabihf-
> diff --git a/tests/docker/dockerfiles/debian-mips-cross.docker b/tests/=
docker/dockerfiles/debian-mips-cross.docker
> index a54efa7253a..08a8e1c29cc 100644
> --- a/tests/docker/dockerfiles/debian-mips-cross.docker
> +++ b/tests/docker/dockerfiles/debian-mips-cross.docker
> @@ -1,9 +1,9 @@
>  #
>  # Docker mips cross-compiler target
>  #
> -# This docker target builds on the debian Stretch base image.
> +# This docker target builds on the debian Buster base image.
>  #
> -FROM qemu:debian9
> +FROM qemu:debian10
> =20
>  MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> =20
> @@ -16,7 +16,7 @@ RUN apt update && \
> =20
>  RUN apt update && \
>      DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> -    apt build-dep -yy -a mips qemu
> +    apt build-dep -yy -a mips --arch-only qemu
> =20
>  # Specify the cross prefix for this image (see tests/docker/common.rc)
>  ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Dmips-linux-gnu-
> diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/te=
sts/docker/dockerfiles/debian-mips64el-cross.docker
> index a1481e16e2c..2fca1124053 100644
> --- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
> +++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
> @@ -17,7 +17,7 @@ RUN dpkg --add-architecture mips64el && \
> =20
>  RUN apt update && \
>      DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> -    apt build-dep -yy -a mips64el qemu
> +    apt build-dep -yy -a mips64el --arch-only qemu
> =20
>  # Specify the cross prefix for this image (see tests/docker/common.rc)
>  ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Dmips64el-linux-gnuabi64-
> diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/test=
s/docker/dockerfiles/debian-mipsel-cross.docker
> index 88accad2692..4abf7832ac6 100644
> --- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
> +++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
> @@ -16,7 +16,7 @@ RUN apt update && \
> =20
>  RUN apt update && \
>      DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> -    apt build-dep -yy -a mipsel qemu
> +    apt build-dep -yy -a mipsel --arch-only qemu
> =20
>  # Specify the cross prefix for this image (see tests/docker/common.rc)
>  ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Dmipsel-linux-gnu-
> diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tes=
ts/docker/dockerfiles/debian-ppc64el-cross.docker
> index f10883c8188..9973df9ff74 100644
> --- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
> +++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
> @@ -12,7 +12,7 @@ RUN dpkg --add-architecture ppc64el && \
> =20
>  RUN apt update && \
>      DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> -    apt build-dep -yy -a ppc64el qemu
> +    apt build-dep -yy -a ppc64el --arch-only qemu
> =20
>  # Specify the cross prefix for this image (see tests/docker/common.rc)
>  ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Dpowerpc64le-linux-gnu-
> diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests=
/docker/dockerfiles/debian-s390x-cross.docker
> index efa346007d6..eb73c988559 100644
> --- a/tests/docker/dockerfiles/debian-s390x-cross.docker
> +++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
> @@ -17,7 +17,7 @@ RUN apt update && \
> =20
>  RUN apt update && \
>      DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> -    apt build-dep -yy -a s390x qemu
> +    apt build-dep -yy -a s390x --arch-only qemu
> =20
>  # Specify the cross prefix for this image (see tests/docker/common.rc)
>  ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Ds390x-linux-gnu-
>=20

