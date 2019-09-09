Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E817C433EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 09:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F4C12086D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 09:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="chH+SRF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F4C12086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7GP9-0003eR-9t
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 05:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7GNy-00034y-1M
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 05:55:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7GNw-0005iU-Hy
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 05:55:01 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35119)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7GNw-0005i3-AW
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 05:55:00 -0400
Received: by mail-wm1-x342.google.com with SMTP id n10so13889949wmj.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 02:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=pPRzeCBUIrZuT9u6VsnSEFKGIlNmNKLZ+jQ7bEZx3UQ=;
 b=chH+SRF+Gz2skfZiRW8o/S3r1ML6ghoc3IaU7I8FX8jCzrm4DVUzH5vivOrtaDj9KD
 FX3P9MCbQqTtt/Wh8bwz4cj56DOxxPt26cngkCK78m2i6SoU7W6GTNNiQr00+6JV/vO6
 ZbXhb/aJcEdF9gKn+IzZHq+KhQKMYtwWl5PHVD45HXlXy3qSIVQ0MILn0F81ekMbT+EM
 eLcj1MUFTx+ccY396N2mptGAy2IW6Tz/CH60OCbVzw1yD562pXRuMi4zGR7tmD6pU1+X
 TKpxPyQtnPTMxuYrS4ROlT24Jcbn+2Humgz9U/PCWn5LWuU+1FH2H0rel/9d61D6HVKg
 F54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=pPRzeCBUIrZuT9u6VsnSEFKGIlNmNKLZ+jQ7bEZx3UQ=;
 b=hAJlNdTQrP/BCHlBgSUnQV4vmJH2U/pQlAtF8nv66/TrHI88EjKhdEGaatP8zUmlvL
 U4b7sZCb1yEEc3LCXlDhPnUJhKqPenAOrrO+jMyq6aGCpohfOXiyPadr2sMOneUAa7YB
 OWn+LZU5cF1zBjOrWystaJkWBIsyc+biy0dFMF2mxhBRuGDuo/VxQ5KEr++2f16Eanzi
 jyDTvv7HTLomO8qHtul5o1/hHHtrm3cLmpz5GG6SmWE1Tm8Vfd2bMmP1pcWbCKWa0OL1
 +oSitd2kzHbR9SzbaSYICHwa2QXPBxzWl1/IDkWE0giEU/M2tB6ZZLQiJNnnpzd4eZvK
 8dXA==
X-Gm-Message-State: APjAAAXvvs8p9/P0a1QArjNdB/VAmhP0uq60N8VQBB4cxdMiK5t9MqJ3
 S3zVy7q1kaxzhLdNMPO+uUpTMw==
X-Google-Smtp-Source: APXvYqzypIdGPznKXY91k5JcVOotCwK27tR4neDFoNOFjbKCWkAi17RfoQ8PjR9DmckmNmTPbu9pbg==
X-Received: by 2002:a1c:80c6:: with SMTP id b189mr1950244wmd.34.1568022899037; 
 Mon, 09 Sep 2019 02:54:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k6sm29189398wrg.0.2019.09.09.02.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2019 02:54:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BEEAC1FF87;
 Mon,  9 Sep 2019 10:54:57 +0100 (BST)
References: <20190904203013.9028-1-alex.bennee@linaro.org>
 <20190904203013.9028-23-alex.bennee@linaro.org>
 <a0b116f4-0aa8-a761-de80-1798224184d2@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
In-reply-to: <a0b116f4-0aa8-a761-de80-1798224184d2@redhat.com>
Date: Mon, 09 Sep 2019 10:54:57 +0100
Message-ID: <87tv9l23ri.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v1 22/42] tests/docker: drop powerpc-user
 image for QEMU cross builds
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
 richard.henderson@linaro.org, qemu-devel@nongnu.org, f4bug@amsat.org,
 cota@braap.org, stefanha@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, aurelien@aurel32.net,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 9/4/19 10:29 PM, Alex Benn=C3=A9e wrote:
>> Now Jessie has entered LTS the powerpc architecture has been dropped
>> so we can no longer build the image from scratch. We will still
>> support a minimal powerpc-cross image for building testcases.
>
> This one still works using:
>
> DEB_URL=3Dhttp://snapshot.debian.org/archive/debian/20180615T211437Z
>
> So I'd rather keep it with this snippet:
>
> -- >8 --
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -68,10 +68,13 @@ docker-binfmt-image-debian-%:
> $(DOCKER_FILES_DIR)/debian-bootstrap.docker
>                 $(error DEB_ARCH not set, debootstrap of debian-$* would
> fail))
>         $(if $(DEB_TYPE),,\
>                 $(error DEB_TYPE not set, debootstrap of debian-$* would
> fail))
> +       $(if $(DEB_URL),,\
> +               $(error DEB_URL not set, debootstrap of debian-$* would
> fail))

I'm not sure we want to force a fail here - DEB_URL will set to a
reasonable default if not set.

>         $(if $(wildcard $(EXECUTABLE)),
>         \
>                 $(call quiet-command,
>         \
>                         DEB_ARCH=3D$(DEB_ARCH)
>         \
>                         DEB_TYPE=3D$(DEB_TYPE)
>         \
> +                       DEB_URL=3D$(DEB_URL)
>                 \
>                         $(DOCKER_SCRIPT) build qemu:debian-$* $<
>         \
>                         $(if $V,,--quiet) $(if $(NOCACHE),--no-cache)
>         \
>                         $(if $(NOUSER),,--add-current-user)
>         \
> @@ -130,6 +133,7 @@ DOCKER_PARTIAL_IMAGES +=3D fedora-cris-cross
>  # broken so we need a qemu-linux-user for this target
>  docker-binfmt-image-debian-powerpc-user: DEB_ARCH =3D powerpc
>  docker-binfmt-image-debian-powerpc-user: DEB_TYPE =3D jessie
> +docker-binfmt-image-debian-powerpc-user: DEB_URL =3D
> http://snapshot.debian.org/archive/debian/20180615T211437Z

These seems reasonable though.

>  docker-binfmt-image-debian-powerpc-user: EXECUTABLE =3D
> ${BUILD_DIR}/ppc-linux-user/qemu-ppc
>  docker-image-debian-powerpc-user-cross:
> docker-binfmt-image-debian-powerpc-user
>  DOCKER_USER_IMAGES +=3D debian-powerpc-user
> ---
>
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>  tests/docker/Makefile.include                     |  8 --------
>>  .../dockerfiles/debian-powerpc-user-cross.docker  | 15 ---------------
>>  2 files changed, 23 deletions(-)
>>  delete mode 100644 tests/docker/dockerfiles/debian-powerpc-user-cross.d=
ocker
>>
>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.inclu=
de
>> index 59fbebbe2e6..f4e9dfc0120 100644
>> --- a/tests/docker/Makefile.include
>> +++ b/tests/docker/Makefile.include
>> @@ -126,14 +126,6 @@ DOCKER_PARTIAL_IMAGES +=3D fedora-cris-cross
>>  # work around issues with poorly working multi-arch systems and broken
>>  # packages.
>>
>> -# Jessie is the last supported release for powerpc, but multi-arch is
>> -# broken so we need a qemu-linux-user for this target
>> -docker-binfmt-image-debian-powerpc-user: DEB_ARCH =3D powerpc
>> -docker-binfmt-image-debian-powerpc-user: DEB_TYPE =3D jessie
>> -docker-binfmt-image-debian-powerpc-user: EXECUTABLE =3D ${BUILD_DIR}/pp=
c-linux-user/qemu-ppc
>> -docker-image-debian-powerpc-user-cross: docker-binfmt-image-debian-powe=
rpc-user
>> -DOCKER_USER_IMAGES +=3D debian-powerpc-user
>> -
>>  # Expand all the pre-requistes for each docker image and test combinati=
on
>>  $(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES) $(DO=
CKER_DEPRECATED_IMAGES)), \
>>  	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
>> diff --git a/tests/docker/dockerfiles/debian-powerpc-user-cross.docker b=
/tests/docker/dockerfiles/debian-powerpc-user-cross.docker
>> deleted file mode 100644
>> index 6938a845ee2..00000000000
>> --- a/tests/docker/dockerfiles/debian-powerpc-user-cross.docker
>> +++ /dev/null
>> @@ -1,15 +0,0 @@
>> -#
>> -# Docker powerpc cross-compiler target for QEMU
>> -#
>> -# We can't use current Debian stable cross-compilers to build powerpc
>> -# as it has been dropped as a release architecture. Using Debian Sid
>> -# is just far too sketchy a build environment. This leaves us the
>> -# final option of using linux-user. This image is based of the
>> -# debootstrapped qemu:debian-powerpc-user but doesn't need any extra
>> -# magic once it is setup.
>> -#
>> -FROM qemu:debian-powerpc-user
>> -
>> -RUN echo man-db man-db/auto-update boolean false | debconf-set-selectio=
ns
>> -RUN apt-get update && \
>> -    DEBIAN_FRONTEND=3Dnoninteractive apt-get build-dep -yy qemu
>>


--
Alex Benn=C3=A9e

