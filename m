Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DAFC3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:38:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A416206BB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A416206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5p9d-0004vh-IM
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 06:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i5p72-0002Dl-Ck
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i5p70-0006ZE-8D
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:35:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46344)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i5p6y-0006TU-9V
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:35:34 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 655A281DF7
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2019 10:35:30 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id i4so804188wri.1
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 03:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WT6VB0oEqrdNuI08LJ9f1W4UlLzvbMsiHat4YVtId6A=;
 b=HNBUniaDeeqAeH/pelGcK5McrR85i1i74hGn5DJt5TZVClw0I1BcACeR/m7uWllKew
 0lbalfupdg9hH77ikSFJ97DEzDksl+zDW+yl+Oo7YByYk8aPzZx0XXrtqSrlQ4XMdQir
 T0p38MZF3iZYbuVHDboXvme6c9a/L5cOygTXXFu45lB+p3QUYE16uUwT8GSExFlurYHL
 BAngkiPp1UToxR5A9nbKXD1zNiyxd+al7WIo0Iu4pKQpXwTyOJXuDBdIf8R0Q0dt9waB
 FVvm+fQS/3NCEugJJmIHqMS1xpXZAv84Jgo2u+P2h+O8kOUwUyW2wrIYwhWdApHPEYiw
 gmAg==
X-Gm-Message-State: APjAAAUSoN/nCgzSMfGnzNdbHXIKZ8WM7oBSG/astKM9pEkAZQ6uMSs8
 +vk2bC0y2JviPUpyQawdzLOjKrpPuxstktwS7JtCcvg+TGb1zCDTIfY2prZ1UEqZUTJtdI3Bs+F
 VVygg2CrPe0YP7bg=
X-Received: by 2002:adf:a499:: with SMTP id g25mr2037481wrb.204.1567679729182; 
 Thu, 05 Sep 2019 03:35:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxc9Ers3AHecMJ4KyttIwvXOU+h2mq1TKvOX4fOlGr2oszF3C/OVq0lrv1P/HYe0MDoxRHKTg==
X-Received: by 2002:adf:a499:: with SMTP id g25mr2037453wrb.204.1567679729011; 
 Thu, 05 Sep 2019 03:35:29 -0700 (PDT)
Received: from [192.168.1.48] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id g24sm2786426wrb.35.2019.09.05.03.35.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2019 03:35:28 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190904203013.9028-1-alex.bennee@linaro.org>
 <20190904203013.9028-12-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9aaafb8c-d892-94f1-d573-f60cf4dfe520@redhat.com>
Date: Thu, 5 Sep 2019 12:35:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190904203013.9028-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 11/42] tests/docker: move our arm64
 cross compile to Buster
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
> Now Buster is released we can unify our cross build images for both
> QEMU and tests.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/docker/Makefile.include                    |  5 ++---
>  .../docker/dockerfiles/debian-arm64-cross.docker |  4 ++--
>  .../dockerfiles/debian-buster-arm64-cross.docker | 16 ----------------
>  tests/tcg/configure.sh                           |  2 +-
>  4 files changed, 5 insertions(+), 22 deletions(-)
>  delete mode 100644 tests/docker/dockerfiles/debian-buster-arm64-cross.=
docker
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index 89881fb5f5d..48c22ae40c0 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -86,13 +86,10 @@ docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/d=
ebian-bootstrap.docker
>  endif
> =20
>  # Enforce dependencies for composite images
> -docker-image-debian: docker-image-debian9
>  docker-image-debian9-mxe: docker-image-debian9
>  docker-image-debian-amd64: docker-image-debian9
>  docker-image-debian-armel-cross: docker-image-debian9
>  docker-image-debian-armhf-cross: docker-image-debian9
> -docker-image-debian-arm64-cross: docker-image-debian9
> -docker-image-debian-buster-arm64-cross: docker-image-debian10
>  docker-image-debian-mips-cross: docker-image-debian9
>  docker-image-debian-mipsel-cross: docker-image-debian9
>  docker-image-debian-mips64el-cross: docker-image-debian9
> @@ -101,6 +98,8 @@ docker-image-debian-s390x-cross: docker-image-debian=
9
>  docker-image-debian-win32-cross: docker-image-debian9-mxe
>  docker-image-debian-win64-cross: docker-image-debian9-mxe
> =20
> +docker-image-debian-arm64-cross: docker-image-debian10
> +
>  docker-image-debian-alpha-cross: docker-image-debian-sid
>  docker-image-debian-hppa-cross: docker-image-debian-sid
>  docker-image-debian-m68k-cross: docker-image-debian-sid
> diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests=
/docker/dockerfiles/debian-arm64-cross.docker
> index 6b59ef0843a..55045ff5d5a 100644
> --- a/tests/docker/dockerfiles/debian-arm64-cross.docker
> +++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
> @@ -1,9 +1,9 @@
>  #
>  # Docker arm64 cross-compiler target
>  #
> -# This docker target builds on the debian Stretch base image.
> +# This docker target builds on the debian Buster base image.
>  #
> -FROM qemu:debian9
> +FROM qemu:debian10
> =20
>  # Add the foreign architecture we want and install dependencies
>  RUN dpkg --add-architecture arm64
> diff --git a/tests/docker/dockerfiles/debian-buster-arm64-cross.docker =
b/tests/docker/dockerfiles/debian-buster-arm64-cross.docker
> deleted file mode 100644
> index 52787edcc2c..00000000000
> --- a/tests/docker/dockerfiles/debian-buster-arm64-cross.docker
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -#
> -# Docker arm64 cross-compiler target
> -#
> -# This docker target builds on the Debian's Buster base image. There
> -# are no QEMU pre-requistes so this image can only be used to build
> -# test cases.
> -#
> -FROM qemu:debian10
> -
> -# Add the foreign architecture we want and install dependencies
> -RUN dpkg --add-architecture arm64
> -RUN apt update && \
> -    DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata && \
> -    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> -    apt-get install -y --no-install-recommends \
> -        crossbuild-essential-arm64
> diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
> index 5f794b664b8..2a351a00048 100755
> --- a/tests/tcg/configure.sh
> +++ b/tests/tcg/configure.sh
> @@ -95,7 +95,7 @@ for target in $target_list; do
>    case $target in
>      aarch64-*)
>        # We don't have any bigendian build tools so we only use this fo=
r AArch64
> -      container_image=3Ddebian-buster-arm64-cross
> +      container_image=3Ddebian-arm64-cross
>        container_cross_cc=3Daarch64-linux-gnu-gcc
>        ;;
>      alpha-*)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

