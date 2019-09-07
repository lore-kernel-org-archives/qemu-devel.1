Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638ABC43331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 11:33:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 304AD218AF
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 11:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304AD218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6YyU-0008Vp-AM
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 07:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i6YtF-0005AQ-Fg
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 07:28:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i6YtE-0005aY-Cw
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 07:28:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45944)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i6YtE-0005XP-4t
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 07:28:24 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 93B75C049E10
 for <qemu-devel@nongnu.org>; Sat,  7 Sep 2019 11:28:22 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id o5so3878996wrg.15
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2019 04:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rj1T/ZCBg/SxkFk6DNXBCozWakeN1EF6MQ+cQ9WobW4=;
 b=NJHryaODV2RJWPxLc2xVDTbSJ5ch5T4TxhZAsDUO6d4cBpBHgUaIPNesFRzuldnKQc
 om999wzZ1QtZX2dP0Y57dlihIL/OChBu/WlLMF3PRW2s4mtP7AZPUwL4VXJq2gBfuS7Q
 alLF167grLWMxM2Hr9apZB9GbJ9BJbmPj754iNyH68c/dYqZWVXFuUWMnyym+yNgqf65
 SRjUFSpCoY0vFxwbckaWiR+GTuyXSNYsNZ4G8Vbhiy3b5QnrXIX0rBEc2voVr2yL6VRD
 wF4zkkjGVBtjDZ1QmmhuUk+pp0QgEqAuLgNxvPjnHUhC8Xo/vD8FGa+2nMZfwKRjl5Zc
 lWoA==
X-Gm-Message-State: APjAAAWTI+h15N/3LwnKEpdx5Tre/TUINr7BgT5QOqaqhddSnPvzikeB
 7EBbpGLHoN4nRvgKWAYJWFic9+dU6rA5OxpOlku4jea1jNmgbVk8im6N/Y4C7xSEah3rdo3e9kD
 2Spuqe/GO9YiD9p0=
X-Received: by 2002:adf:e881:: with SMTP id d1mr11007543wrm.301.1567855701334; 
 Sat, 07 Sep 2019 04:28:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzVYrfdnkUF+aM5C+VAcqZjwUEsNY0G5QJg1DOyUQAgKccOnwemE1FDC0O/N0a5roAHDg7hMQ==
X-Received: by 2002:adf:e881:: with SMTP id d1mr11007533wrm.301.1567855701186; 
 Sat, 07 Sep 2019 04:28:21 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id z1sm6816204wre.40.2019.09.07.04.28.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Sep 2019 04:28:20 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190904203013.9028-1-alex.bennee@linaro.org>
 <20190904203013.9028-16-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <4eeb12bc-64e9-a36a-8c7e-c2e75205fcf8@redhat.com>
Date: Sat, 7 Sep 2019 13:28:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190904203013.9028-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 15/42] tests/docker: move our m68k cross
 compile to Buster
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
> Now Buster is released we can stop relying on the movable feast that
> is Sid for our cross-compiler for building tests.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  tests/docker/Makefile.include                     | 2 +-
>  tests/docker/dockerfiles/debian-m68k-cross.docker | 5 ++---
>  2 files changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index ba5a624eaec..62f2733eb66 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -101,9 +101,9 @@ docker-image-debian-win64-cross: docker-image-debia=
n9-mxe
>  docker-image-debian-alpha-cross: docker-image-debian10
>  docker-image-debian-arm64-cross: docker-image-debian10
>  docker-image-debian-hppa-cross: docker-image-debian10
> +docker-image-debian-m68k-cross: docker-image-debian10
>  docker-image-debian-powerpc-cross: docker-image-debian10
> =20
> -docker-image-debian-m68k-cross: docker-image-debian-sid
>  docker-image-debian-sh4-cross: docker-image-debian-sid
>  docker-image-debian-sparc64-cross: docker-image-debian-sid
>  docker-image-debian-mips64-cross: docker-image-debian-sid
> diff --git a/tests/docker/dockerfiles/debian-m68k-cross.docker b/tests/=
docker/dockerfiles/debian-m68k-cross.docker
> index 4311c9cf86d..25edc80e9a3 100644
> --- a/tests/docker/dockerfiles/debian-m68k-cross.docker
> +++ b/tests/docker/dockerfiles/debian-m68k-cross.docker
> @@ -1,10 +1,9 @@
>  #
>  # Docker cross-compiler target
>  #
> -# This docker target builds on the debian sid base image which
> -# contains cross compilers for Debian "ports" targets.
> +# This docker target builds on the debian Buster base image.
>  #
> -FROM qemu:debian-sid
> +FROM qemu:debian10
> =20
>  RUN apt update && \
>      DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>=20

