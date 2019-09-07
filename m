Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E88C43331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 11:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 909DF218AF
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 11:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909DF218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Z0j-0001qy-FC
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 07:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i6Yy1-0008VN-1c
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 07:33:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i6Yxy-0008Fz-Qs
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 07:33:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60060)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i6Yxx-0008FS-9k
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 07:33:18 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 494A5335E8
 for <qemu-devel@nongnu.org>; Sat,  7 Sep 2019 11:33:16 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id a4so2591354wrg.8
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2019 04:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gv0Xr4Y9hVMKW7qxGExd99/E5estZ5BAH+HtMSvI2Lc=;
 b=peV/1yPNVtwCY2bdrGqVCeNLZZpBjYmDsZEYD2V7XShMsfWtapLy6ucY2nYtE2ySIu
 Ylljk2w7AYPZx4yeZMVYVhazRWw6v8hQVlOoWoOwqZeeEDILaHrbf0pjDZjjB00fiiKD
 oHjsL8tX+LFtBLrKAdcTt8SyBDSDtol3hn9phe/EW/r3J+OmGbfAN1qHnZDIA98gW66O
 +9PfcxIR4kKUxBPaxw+/UWhSD0b8XaMeUiwDVOrtalr11VuilUAjBeL2CPLff2IX72cg
 iO2q/cAbRWbOJkpbpcDKmyjCTv21jpj3j3Mzmv9eh4leTeAvo9IE7VDONRj6WKiOA3tG
 9qQg==
X-Gm-Message-State: APjAAAUB1M4lUMOTcbXE0Qd1pAFJkhH5xiXxBP/WTWFLd0u2pdQFZSP8
 aCtN+hZVLwx7Ii1k0lSg2ECcs3uTLkANnjAu8+JZssGKmNaINsGCzQ5MItePZcq4lHcqIVhLZ2w
 4l7JvzMt9j/lrJYo=
X-Received: by 2002:adf:dec2:: with SMTP id i2mr11427570wrn.92.1567855995047; 
 Sat, 07 Sep 2019 04:33:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzeZOod1iwscOJYCfHUOMaLk/GGUeXZNeJdrfuEXb9d0s3yFZgxpzVBE96OjwS3AaUFTHTddg==
X-Received: by 2002:adf:dec2:: with SMTP id i2mr11427548wrn.92.1567855994872; 
 Sat, 07 Sep 2019 04:33:14 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id v11sm13634041wrv.54.2019.09.07.04.33.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Sep 2019 04:33:14 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190904203013.9028-1-alex.bennee@linaro.org>
 <20190904203013.9028-19-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <fdd24c5d-d180-041e-3d71-1d20cc9ed9b3@redhat.com>
Date: Sat, 7 Sep 2019 13:33:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190904203013.9028-19-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 18/42] tests/docker: move our mips64
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
Cc: fam@euphon.net, berrange@redhat.com,
 Aleksandar Markovic <amarkovic@wavecomp.com>, stefanb@linux.vnet.ibm.com,
 Aleksandar Rikalo <arikalo@wavecomp.com>, richard.henderson@linaro.org,
 f4bug@amsat.org, cota@braap.org, stefanha@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net
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
>  tests/docker/Makefile.include                       | 2 +-
>  tests/docker/dockerfiles/debian-mips64-cross.docker | 5 ++---
>  2 files changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index e946aae14fa..896c1c5a601 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -102,11 +102,11 @@ docker-image-debian-alpha-cross: docker-image-deb=
ian10
>  docker-image-debian-arm64-cross: docker-image-debian10
>  docker-image-debian-hppa-cross: docker-image-debian10
>  docker-image-debian-m68k-cross: docker-image-debian10
> +docker-image-debian-mips64-cross: docker-image-debian10
>  docker-image-debian-powerpc-cross: docker-image-debian10
>  docker-image-debian-sh4-cross: docker-image-debian10
>  docker-image-debian-sparc64-cross: docker-image-debian10
> =20
> -docker-image-debian-mips64-cross: docker-image-debian-sid
>  docker-image-debian-riscv64-cross: docker-image-debian-sid
>  docker-image-debian-ppc64-cross: docker-image-debian-sid
>  docker-image-travis: NOUSER=3D1
> diff --git a/tests/docker/dockerfiles/debian-mips64-cross.docker b/test=
s/docker/dockerfiles/debian-mips64-cross.docker
> index bf0073a4662..1a79505d696 100644
> --- a/tests/docker/dockerfiles/debian-mips64-cross.docker
> +++ b/tests/docker/dockerfiles/debian-mips64-cross.docker
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

