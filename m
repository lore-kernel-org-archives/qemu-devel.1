Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F096C43331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 11:30:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6264D206BB
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 11:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6264D206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Yvg-00073I-Bz
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 07:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i6Ytu-0005sp-1V
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 07:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i6Yts-00069f-U1
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 07:29:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36580)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i6Yts-000698-M7
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 07:29:04 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B504D3CA06
 for <qemu-devel@nongnu.org>; Sat,  7 Sep 2019 11:29:03 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id j10so3898202wrb.16
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2019 04:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2TEY75rvzbSO7vi7Lvo5iz9UQfmaQe6W5DTALZ/2Y3w=;
 b=LuCeJXaV6CVA2grKy6k5VXo3uoNRJB7Bt2MjyvFSQee5qKStKuAjMADLs8EREPxEtC
 nLLcH/gGn1UtzvyzoeyGKpSfYxp37UeKhpBy3RGsVksdMpIbI3ePLa2itYqSaHsTszdK
 LIRPuPJ/cmwNkGd7vRf4gLhvmCJY9ih0RwbC/ou2pOcu9o6PGdCmFIZBoId6JgWgSqqv
 JgbMAFLIVT8YuVIsJ8gh/ZBmjX88PcPQ1htbRgG7WJUoMHftw2b6M8E94jRJXk1FaSQ0
 xnCZENxYiYS4RvUDcOOsWdC6Pez1oBeMPCtKRB/wXUjaJ/T04fDirdclfV0XxsfbjSJM
 RWjg==
X-Gm-Message-State: APjAAAX+Z4z4Ug0KKu/1YAOIVKlXArgGzBGGF1TRWtmkjRxB7xvde6lt
 eCpJoMiexII+pTJA1eO7uRh5tZe/JU8WJW46Ese+cPeKdB+v/gRzqUeWyRd0pRCf+VijAIEqGkY
 LhS2aD8QUJYNxvng=
X-Received: by 2002:adf:ead2:: with SMTP id o18mr10764387wrn.107.1567855742465; 
 Sat, 07 Sep 2019 04:29:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzLi8gz1zhLhKzYjs/UXraweHtUbsI0F3Zn0tO/ZHJELPTulc54JEfkOuY2bQmmqp65h95oFg==
X-Received: by 2002:adf:ead2:: with SMTP id o18mr10764371wrn.107.1567855742290; 
 Sat, 07 Sep 2019 04:29:02 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id y3sm12645037wra.88.2019.09.07.04.29.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Sep 2019 04:29:01 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190904203013.9028-1-alex.bennee@linaro.org>
 <20190904203013.9028-21-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <4c298eb8-f91e-ee1a-badc-c9e3a247485f@redhat.com>
Date: Sat, 7 Sep 2019 13:29:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190904203013.9028-21-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 20/42] tests/docker: move our ppc64
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
>  tests/docker/Makefile.include                      | 4 ++--
>  tests/docker/dockerfiles/debian-ppc64-cross.docker | 7 +++----
>  2 files changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index 93190b1e2a2..b6c04059502 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -104,11 +104,11 @@ docker-image-debian-hppa-cross: docker-image-debi=
an10
>  docker-image-debian-m68k-cross: docker-image-debian10
>  docker-image-debian-mips64-cross: docker-image-debian10
>  docker-image-debian-powerpc-cross: docker-image-debian10
> +docker-image-debian-ppc64-cross: docker-image-debian10
>  docker-image-debian-riscv64-cross: docker-image-debian10
>  docker-image-debian-sh4-cross: docker-image-debian10
>  docker-image-debian-sparc64-cross: docker-image-debian10
> =20
> -docker-image-debian-ppc64-cross: docker-image-debian-sid
>  docker-image-travis: NOUSER=3D1
> =20
>  # Specialist build images, sometimes very limited tools
> @@ -117,7 +117,7 @@ docker-image-tricore-cross: docker-image-debian9
>  # These images may be good enough for building tests but not for test =
builds
>  DOCKER_PARTIAL_IMAGES +=3D debian-alpha-cross debian-hppa-cross debian=
-m68k-cross debian-sh4-cross
>  DOCKER_PARTIAL_IMAGES +=3D debian-sparc64-cross debian-mips64-cross de=
bian-riscv64-cross
> -DOCKER_PARTIAL_IMAGES +=3D debian-tricore-cross debian-powerpc-cross f=
edora-i386-cross
> +DOCKER_PARTIAL_IMAGES +=3D debian-tricore-cross debian-powerpc-cross d=
ebian-ppc64-cross fedora-i386-cross
>  DOCKER_PARTIAL_IMAGES +=3D fedora-cris-cross
> =20
>  # Rules for building linux-user powered images
> diff --git a/tests/docker/dockerfiles/debian-ppc64-cross.docker b/tests=
/docker/dockerfiles/debian-ppc64-cross.docker
> index e5757fe46ee..4bf88ab02dd 100644
> --- a/tests/docker/dockerfiles/debian-ppc64-cross.docker
> +++ b/tests/docker/dockerfiles/debian-ppc64-cross.docker
> @@ -1,12 +1,11 @@
>  #
>  # Docker ppc64 cross-compiler target
>  #
> -# This docker target builds on the debian sid base image which
> -# contains cross compilers for Debian "ports" targets.
> -FROM qemu:debian-sid
> +# This docker target builds on the debian Buster base image.
> +FROM qemu:debian10
> =20
>  RUN apt update && \
>      DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>      apt install -y --no-install-recommends \
>         gcc-powerpc64-linux-gnu \
> -       libc6-dev-ppc64-cross || { echo "Failed to build - see debian-s=
id.docker notes"; exit 1; }
> +       libc6-dev-ppc64-cross
>=20

