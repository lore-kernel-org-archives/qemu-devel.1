Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF74AC43331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 20:22:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88CB421835
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 20:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CB421835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6hE9-0000ZI-Ll
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 16:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i6hDO-000061-Eg
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 16:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i6hDM-0007Xn-1s
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 16:21:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52606)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i6hDL-0007Tn-QX
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 16:21:44 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 20320356C9
 for <qemu-devel@nongnu.org>; Sat,  7 Sep 2019 20:21:42 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id h6so1900026wrh.6
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2019 13:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MRmDDRyECLkuqyEjdSWSwrj5lUC1OqNGt9uQM7FWuZ8=;
 b=pCb1IV8jqI7WGKhUyN9lNsw0Nk0IZ6omwI5zvR3ijPIq8t/or7oddSMxe7m8/lxVag
 mQAClJc846C2hTs5ULntTO9/VASotVFclU9T5JaGotBfYVIKLeks+YRNpB2QXBPFgH1N
 4HaqOJa6JNad+JEUWIaHUgLtAEOaIN6EFIYLdOiMks6HsQZhlytyYGmkidvovdMcaxj0
 ijzmY1kP15oUFzMhTGVieRXroSAqgsF6dLLTbdmlSdlRa35b+ba+PSSNQIXFAu3jluyG
 BVOvx13D6mH/NwCGOj6+whF7kiA6i50U7tPVawCJTc6a5Pfl1Nqm9va8zvbYjMHUWktb
 Yc/g==
X-Gm-Message-State: APjAAAW0zRxEbXvbZVT/2zP7a11VSoEBjB5T5XfII51GEtRd1H68FF9b
 WKxdoh6HuzEvGcopcJGkG9bHDVjtbb2KomBBbhrg8+UWEs75Rj30c2yFjGgRGn5EmVBvdlCK6xO
 KB89WN0SLj6QjLnc=
X-Received: by 2002:a5d:49c7:: with SMTP id t7mr11930197wrs.229.1567887700888; 
 Sat, 07 Sep 2019 13:21:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzLX0KmalhPebFVLfT7w1aRAO+iEUyUJY7wd4U+nXM9jG+7CQnnfiLz7djThreDLyepwfIypg==
X-Received: by 2002:a5d:49c7:: with SMTP id t7mr11930182wrs.229.1567887700682; 
 Sat, 07 Sep 2019 13:21:40 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id r18sm10484647wrx.36.2019.09.07.13.21.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Sep 2019 13:21:40 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190904203013.9028-1-alex.bennee@linaro.org>
 <20190904203013.9028-23-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a0b116f4-0aa8-a761-de80-1798224184d2@redhat.com>
Date: Sat, 7 Sep 2019 22:21:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190904203013.9028-23-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/19 10:29 PM, Alex Benn=C3=A9e wrote:
> Now Jessie has entered LTS the powerpc architecture has been dropped
> so we can no longer build the image from scratch. We will still
> support a minimal powerpc-cross image for building testcases.

This one still works using:

DEB_URL=3Dhttp://snapshot.debian.org/archive/debian/20180615T211437Z

So I'd rather keep it with this snippet:

-- >8 --
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -68,10 +68,13 @@ docker-binfmt-image-debian-%:
$(DOCKER_FILES_DIR)/debian-bootstrap.docker
                $(error DEB_ARCH not set, debootstrap of debian-$* would
fail))
        $(if $(DEB_TYPE),,\
                $(error DEB_TYPE not set, debootstrap of debian-$* would
fail))
+       $(if $(DEB_URL),,\
+               $(error DEB_URL not set, debootstrap of debian-$* would
fail))
        $(if $(wildcard $(EXECUTABLE)),
        \
                $(call quiet-command,
        \
                        DEB_ARCH=3D$(DEB_ARCH)
        \
                        DEB_TYPE=3D$(DEB_TYPE)
        \
+                       DEB_URL=3D$(DEB_URL)
                \
                        $(DOCKER_SCRIPT) build qemu:debian-$* $<
        \
                        $(if $V,,--quiet) $(if $(NOCACHE),--no-cache)
        \
                        $(if $(NOUSER),,--add-current-user)
        \
@@ -130,6 +133,7 @@ DOCKER_PARTIAL_IMAGES +=3D fedora-cris-cross
 # broken so we need a qemu-linux-user for this target
 docker-binfmt-image-debian-powerpc-user: DEB_ARCH =3D powerpc
 docker-binfmt-image-debian-powerpc-user: DEB_TYPE =3D jessie
+docker-binfmt-image-debian-powerpc-user: DEB_URL =3D
http://snapshot.debian.org/archive/debian/20180615T211437Z
 docker-binfmt-image-debian-powerpc-user: EXECUTABLE =3D
${BUILD_DIR}/ppc-linux-user/qemu-ppc
 docker-image-debian-powerpc-user-cross:
docker-binfmt-image-debian-powerpc-user
 DOCKER_USER_IMAGES +=3D debian-powerpc-user
---

>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> ---
>  tests/docker/Makefile.include                     |  8 --------
>  .../dockerfiles/debian-powerpc-user-cross.docker  | 15 ---------------
>  2 files changed, 23 deletions(-)
>  delete mode 100644 tests/docker/dockerfiles/debian-powerpc-user-cross.=
docker
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index 59fbebbe2e6..f4e9dfc0120 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -126,14 +126,6 @@ DOCKER_PARTIAL_IMAGES +=3D fedora-cris-cross
>  # work around issues with poorly working multi-arch systems and broken
>  # packages.
> =20
> -# Jessie is the last supported release for powerpc, but multi-arch is
> -# broken so we need a qemu-linux-user for this target
> -docker-binfmt-image-debian-powerpc-user: DEB_ARCH =3D powerpc
> -docker-binfmt-image-debian-powerpc-user: DEB_TYPE =3D jessie
> -docker-binfmt-image-debian-powerpc-user: EXECUTABLE =3D ${BUILD_DIR}/p=
pc-linux-user/qemu-ppc
> -docker-image-debian-powerpc-user-cross: docker-binfmt-image-debian-pow=
erpc-user
> -DOCKER_USER_IMAGES +=3D debian-powerpc-user
> -
>  # Expand all the pre-requistes for each docker image and test combinat=
ion
>  $(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES) $(D=
OCKER_DEPRECATED_IMAGES)), \
>  	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
> diff --git a/tests/docker/dockerfiles/debian-powerpc-user-cross.docker =
b/tests/docker/dockerfiles/debian-powerpc-user-cross.docker
> deleted file mode 100644
> index 6938a845ee2..00000000000
> --- a/tests/docker/dockerfiles/debian-powerpc-user-cross.docker
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -#
> -# Docker powerpc cross-compiler target for QEMU
> -#
> -# We can't use current Debian stable cross-compilers to build powerpc
> -# as it has been dropped as a release architecture. Using Debian Sid
> -# is just far too sketchy a build environment. This leaves us the
> -# final option of using linux-user. This image is based of the
> -# debootstrapped qemu:debian-powerpc-user but doesn't need any extra
> -# magic once it is setup.
> -#
> -FROM qemu:debian-powerpc-user
> -
> -RUN echo man-db man-db/auto-update boolean false | debconf-set-selecti=
ons
> -RUN apt-get update && \
> -    DEBIAN_FRONTEND=3Dnoninteractive apt-get build-dep -yy qemu
>=20

