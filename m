Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA20C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F9AD205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F9AD205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDFgx-0005aB-UV
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 18:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDFfZ-0004i7-Gi
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDFfW-0002Ba-HT
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:21:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4407)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDFfW-0002AN-9X
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:21:54 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7838088302
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 22:21:52 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id z205so148382wmb.7
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 15:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kyGgBwVBt2QOJGOmoWxVpIQxeLkj84kn/D4BVqscHlc=;
 b=YUhUUERiF/mmKspZ/gClVeNHWN5UPUj1sEs0JwhinlU021Us2fQQ517CHzoDhLSuWF
 yGBVLZGNpdammkTsZibHOMfvi1Me4V7ia5s9qGHl/BUFgsAvbjiEoBgDEldMiyaMztDT
 OWbJaYN0KP1OtWm9HOJMyQ5VXg1IbJNvqoV4H97c/n0rvoac+ebeJlAMkm0D+Cz/NxgN
 ugyMx1UCP4v5VZv4cIbBNoow+e8BE/ueW2wOnydPh42VdBECOYdOG8+l7bb1xYc65OS2
 EPn2edrztG/HpfHqg8zolWHCB4SvvPXsDc2puJ43XS0CZYCnh7vh+fLTtMLTOL0jYVF5
 K3WA==
X-Gm-Message-State: APjAAAWh5Duktfl6oR1bb5+ZWr4oKKMzvh0iPzPZ+88ILnxZqDRzRVUE
 Eg+Nm0xwvGFzUi2c4nthLJ9GmFzSp2YyIQvgAcwc2ij8Nsd/Bqj3fovjNphTiQtSonz3t0SuCFw
 27omj/7DybWqpYj4=
X-Received: by 2002:adf:9d88:: with SMTP id p8mr355901wre.391.1569450111186;
 Wed, 25 Sep 2019 15:21:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzt3K/brbKHPjP1DP1Gm/3/8zTsWkutbDzvTp0vLZIvxWG0v36X/FM52IWt12s0Wb+7ZT6miQ==
X-Received: by 2002:adf:9d88:: with SMTP id p8mr355850wre.391.1569450109952;
 Wed, 25 Sep 2019 15:21:49 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id i14sm254852wra.78.2019.09.25.15.21.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 15:21:49 -0700 (PDT)
Subject: Re: [PATCH v3 33/33] tests/docker: remove debian-powerpc-user-cross
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190924210106.27117-1-alex.bennee@linaro.org>
 <20190924210106.27117-34-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <622d364a-ac0a-3ff7-a8f3-b57a6545e2fd@redhat.com>
Date: Thu, 26 Sep 2019 00:21:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190924210106.27117-34-alex.bennee@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, jsnow@redhat.com,
 f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/19 11:01 PM, Alex Benn=C3=A9e wrote:
> Despite our attempts in 4d26c7fef4 to keep this going it still gets in
> the way of "make docker-test-build" completing because of course we
> can't build a modern QEMU with the image. Let's put the thing out of
> it's misery and remove it.
>=20
> People who really care about building on powerpc can still use the
> binfmt_misc support to manually build an image (or just run the build
> from pre this commit).
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  tests/docker/Makefile.include                 |  9 --------
>  .../debian-powerpc-user-cross.docker          | 21 -------------------
>  2 files changed, 30 deletions(-)
>  delete mode 100644 tests/docker/dockerfiles/debian-powerpc-user-cross.=
docker
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index 180e5439ef9..dcc37093138 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -149,15 +149,6 @@ DOCKER_PARTIAL_IMAGES +=3D fedora-i386-cross fedor=
a-cris-cross
>  # work around issues with poorly working multi-arch systems and broken
>  # packages.
> =20
> -# Jessie is the last supported release for powerpc, but multi-arch is
> -# broken so we need a qemu-linux-user for this target
> -docker-binfmt-image-debian-powerpc-user: DEB_ARCH =3D powerpc
> -docker-binfmt-image-debian-powerpc-user: DEB_TYPE =3D jessie
> -docker-binfmt-image-debian-powerpc-user: DEB_URL =3D http://snapshot.d=
ebian.org/archive/debian/20180615T211437Z
> -docker-binfmt-image-debian-powerpc-user: EXECUTABLE =3D ${BUILD_DIR}/p=
pc-linux-user/qemu-ppc
> -docker-image-debian-powerpc-user-cross: docker-binfmt-image-debian-pow=
erpc-user
> -DOCKER_USER_IMAGES +=3D debian-powerpc-user
> -
>  # Expand all the pre-requistes for each docker image and test combinat=
ion
>  $(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES)), \
>  	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
> diff --git a/tests/docker/dockerfiles/debian-powerpc-user-cross.docker =
b/tests/docker/dockerfiles/debian-powerpc-user-cross.docker
> deleted file mode 100644
> index 83749b0abb8..00000000000
> --- a/tests/docker/dockerfiles/debian-powerpc-user-cross.docker
> +++ /dev/null
> @@ -1,21 +0,0 @@
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
> -# It can be used to build old versions of QEMU, current versions need
> -# newer dependencies than Jessie provides.
> -#
> -FROM qemu:debian-powerpc-user
> -
> -RUN echo man-db man-db/auto-update boolean false | debconf-set-selecti=
ons
> -RUN apt-get update && \
> -        DEBIAN_FRONTEND=3Dnoninteractive apt-get build-dep -yy qemu
> -
> -ENV QEMU_CONFIGURE_OPTS --disable-werror
> -ENV DEF_TARGET_LIST powerpc-softmmu,arm-linux-user,aarch64-linux-user
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

