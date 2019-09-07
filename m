Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFEEC43331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 11:34:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5BCB218DE
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 11:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BCB218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6YzI-0000gf-SI
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 07:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i6YxK-00088q-Kr
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 07:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i6YxJ-00082W-Da
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 07:32:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57178)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i6YxJ-000828-5a
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 07:32:37 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1100D85543
 for <qemu-devel@nongnu.org>; Sat,  7 Sep 2019 11:32:36 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id a4so2590821wrg.8
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2019 04:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cfbZo+SXzLpo5UzEWHW7r43LpDLa2T9eBngvWW4wT74=;
 b=J45b5WMIrB1hE5yCsxzi0oRLW3j2p7fML4h/YNouvUQFrUXPNHcfb8cVMuIOUC1/U0
 BZRUck8Rgmq8C/QJESCFb+nOtDq9gaoLIJNeX/diM7p7uzkjK0kizpICAOh2E5mnjM4s
 8I6gc2LxCOckDLoD3ybbySrsGxkWcaUbeqaSI7eRp5sEQg89yodWOW3aQ0s1Eybra4Tw
 6a06t+7uNf5SqPJGMWVnArrJlknDnwvhkF7cmiUb3Jvnvp0JgeUbuObru5HI9+PU/HRG
 MydvR2mAdmvpiwDM+OHYOeoP5xbEysJn3/JtQlIifAx6Aifi0NqQQTw2/rBHusM6In8g
 r1dg==
X-Gm-Message-State: APjAAAWgfwU0pHtQYi6gBOOZy188ysPdakTPmLd0U6nrYKztTjqGxBW/
 xG5NK/UR6YHuS051wNXLecsQV1bHShvxzKr19vg0HcQOQzHEeZw0QRhmZgke0X8HxKFVoGb9/gT
 ZtlEZCC12SBR6XJ8=
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr10307772wma.136.1567855954814; 
 Sat, 07 Sep 2019 04:32:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzW6JVTKNtMBRLk3aGp4SoPiIC1KNXLdwtxPIqGwFYy3uW9XMjIA4tg0oVVqhZwcG89QRQZZg==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr10307758wma.136.1567855954652; 
 Sat, 07 Sep 2019 04:32:34 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id r9sm13784829wra.19.2019.09.07.04.32.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Sep 2019 04:32:34 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190904203013.9028-1-alex.bennee@linaro.org>
 <20190904203013.9028-13-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <37dd1f64-8fe7-f546-242c-99abca1ca91f@redhat.com>
Date: Sat, 7 Sep 2019 13:32:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190904203013.9028-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 12/42] tests/docker: move our powerpc
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
> Now Buster is released we can stop relying on the movable feast that
> is Sid for our cross-compiler for building tests.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  tests/docker/Makefile.include                        | 2 +-
>  tests/docker/dockerfiles/debian-powerpc-cross.docker | 8 +++-----
>  2 files changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index 48c22ae40c0..7c1ff677a13 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -99,6 +99,7 @@ docker-image-debian-win32-cross: docker-image-debian9=
-mxe
>  docker-image-debian-win64-cross: docker-image-debian9-mxe
> =20
>  docker-image-debian-arm64-cross: docker-image-debian10
> +docker-image-debian-powerpc-cross: docker-image-debian10
> =20
>  docker-image-debian-alpha-cross: docker-image-debian-sid
>  docker-image-debian-hppa-cross: docker-image-debian-sid
> @@ -107,7 +108,6 @@ docker-image-debian-sh4-cross: docker-image-debian-=
sid
>  docker-image-debian-sparc64-cross: docker-image-debian-sid
>  docker-image-debian-mips64-cross: docker-image-debian-sid
>  docker-image-debian-riscv64-cross: docker-image-debian-sid
> -docker-image-debian-powerpc-cross: docker-image-debian-sid
>  docker-image-debian-ppc64-cross: docker-image-debian-sid
>  docker-image-travis: NOUSER=3D1
> =20
> diff --git a/tests/docker/dockerfiles/debian-powerpc-cross.docker b/tes=
ts/docker/dockerfiles/debian-powerpc-cross.docker
> index 5d08fad7cd3..89dd4fbf870 100644
> --- a/tests/docker/dockerfiles/debian-powerpc-cross.docker
> +++ b/tests/docker/dockerfiles/debian-powerpc-cross.docker
> @@ -1,14 +1,12 @@
>  #
>  # Docker powerpc cross-compiler target
>  #
> -# This docker target builds on the debian sid base image which
> -# contains cross compilers for Debian "ports" targets. The original
> -# Jessie based no longer builds.
> +# This docker target builds on the debian Buster base image.
>  #
> -FROM qemu:debian-sid
> +FROM qemu:debian10
> =20
>  RUN apt update && \
>      DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>      apt install -y --no-install-recommends \
>          gcc-powerpc-linux-gnu \
> -        libc6-dev-powerpc-cross || { echo "Failed to build - see debia=
n-sid.docker notes"; exit 1; }
> +        libc6-dev-powerpc-cross
>=20

