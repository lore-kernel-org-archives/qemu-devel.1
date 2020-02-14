Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3990C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 10:27:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DD05206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 10:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="heubI5sL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD05206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2YC7-0000M1-Rd
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 05:27:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j2YBV-0008NO-UC
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 05:26:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j2YBU-0006ds-Gx
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 05:26:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31153)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j2YBU-0006dO-Cr
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 05:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581676015;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WQj2QGp+on7URM3kgktKgucz1pQFF5s1CCNHZxu+zb0=;
 b=heubI5sL3LdyV+3Xj1HfRTmqcJC7il2wVIsUeoke1v7rWXPHoxZKltpX0lIuYZ2uV3e8Zn
 nEqlChM1eLQeUKLIYdYal7L6OlQ1P2uLLKGanlfj+8SXVjIqP3Wvu5Jvr79CTbf79mS6fx
 tfX0ppWdgyV/xrul/YXok3fZxBWbwdU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-iyR2b9pANYqgTbgbPZdYKA-1; Fri, 14 Feb 2020 05:26:54 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 247F81137851
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:26:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E96690094;
 Fri, 14 Feb 2020 10:26:51 +0000 (UTC)
Date: Fri, 14 Feb 2020 10:26:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v5 6/8] configure: Enable test and libs for zstd
Message-ID: <20200214102649.GB613610@redhat.com>
References: <20200129115655.10414-1-quintela@redhat.com>
 <20200129115655.10414-7-quintela@redhat.com>
 <20200211201107.GR55376@redhat.com> <87k14qjitw.fsf@secure.laptop>
MIME-Version: 1.0
In-Reply-To: <87k14qjitw.fsf@secure.laptop>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: iyR2b9pANYqgTbgbPZdYKA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 13, 2020 at 10:08:59PM +0100, Juan Quintela wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> > On Wed, Jan 29, 2020 at 12:56:53PM +0100, Juan Quintela wrote:
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >> ---
> >>  configure | 30 ++++++++++++++++++++++++++++++
> >>  1 file changed, 30 insertions(+)
> >
> > This is adding a new 3rd party library to QEMU that we've not previousl=
y
> > built and so isn't included in any of our CI platforms.
>=20
> Ok.
>=20
> Learning how one does that.
>=20
> > This commit should be updating at least some of our CI platforms to
> > request the libzstd library installation to get CI coverage for the
> > latest patches in this series.
>=20
> > Probably the docker files,
>=20
> I added it in all debian/centos/fedora files that zlib-dev or xen-dev
>=20
> > the VM installs for FreeBSD at least,
>=20
> A fast google finds that library is called "zstd" and that it includes
> the includes (put intended)
>=20
> tests/vm/freebsd
>=20
> Once there, include it in fedora
>=20
> > travis and
>=20
> I added it to .travis.yml
>=20
> > gitlab CI.
>=20
> gitlab-ci.yml (just when we compile x86_64-softmmu)
>=20
> I have something like this, but net real clue how to test that I haven't
> broken anything:
>=20
> commit 59d8694dfcfc3d5ef36bc72a5c02bedaa3a6a6ec
> Author: Juan Quintela <quintela@redhat.com>
> Date:   Thu Feb 13 22:06:16 2020 +0100
>=20
>     Use zstd packages
>    =20
>     Signed-off-by: Juan Quintela <quintela@redhat.com>
>=20
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index c15e394f09..72f8b8aa51 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -21,6 +21,7 @@ build-system2:
>   script:
>   - apt-get install -y -qq libsdl2-dev libgcrypt-dev libbrlapi-dev libaio=
-dev
>        libfdt-dev liblzo2-dev librdmacm-dev libibverbs-dev libibumad-dev
> +      libzstd-dev
>   - mkdir build
>   - cd build
>   - ../configure --enable-werror --target-list=3D"tricore-softmmu unicore=
32-softmmu
> diff --git a/.travis.yml b/.travis.yml
> index 5887055951..dd17301f3b 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -48,6 +48,7 @@ addons:
>        - libusb-1.0-0-dev
>        - libvdeplug-dev
>        - libvte-2.91-dev
> +      - libzstd-dev
>        - sparse
>        - uuid-dev
>        - gcovr
> diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/docke=
rfiles/centos7.docker
> index 562d65be9e..cdd72de7eb 100644
> --- a/tests/docker/dockerfiles/centos7.docker
> +++ b/tests/docker/dockerfiles/centos7.docker
> @@ -33,6 +33,7 @@ ENV PACKAGES \
>      tar \
>      vte-devel \
>      xen-devel \
> -    zlib-devel
> +    zlib-devel \
> +    libzstd-devel
>  RUN yum install -y $PACKAGES
>  RUN rpm -q $PACKAGES | sort > /packages.txt
> diff --git a/tests/docker/dockerfiles/fedora-i386-cross.docker b/tests/do=
cker/dockerfiles/fedora-i386-cross.docker
> index 9106cf9ebe..cd16cd1bfa 100644
> --- a/tests/docker/dockerfiles/fedora-i386-cross.docker
> +++ b/tests/docker/dockerfiles/fedora-i386-cross.docker
> @@ -7,7 +7,8 @@ ENV PACKAGES \
>      gnutls-devel.i686 \
>      nettle-devel.i686 \
>      pixman-devel.i686 \
> -    zlib-devel.i686
> +    zlib-devel.i686 \
> +    libzstd-devel.i686
> =20
>  RUN dnf install -y $PACKAGES
>  RUN rpm -q $PACKAGES | sort > /packages.txt
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/docker=
files/fedora.docker
> index 987a3c170a..a6522228c0 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -92,7 +92,8 @@ ENV PACKAGES \
>      vte291-devel \
>      which \
>      xen-devel \
> -    zlib-devel
> +    zlib-devel \
> +    libzstd-devel
>  ENV QEMU_CONFIGURE_OPTS --python=3D/usr/bin/python3
> =20
>  RUN dnf install -y $PACKAGES
> diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/docker=
files/ubuntu.docker
> index 4177f33691..b6c7b41ddd 100644
> --- a/tests/docker/dockerfiles/ubuntu.docker
> +++ b/tests/docker/dockerfiles/ubuntu.docker
> @@ -58,6 +58,7 @@ ENV PACKAGES flex bison \
>      libvdeplug-dev \
>      libvte-2.91-dev \
>      libxen-dev \
> +    libzstd-dev \
>      make \
>      python3-yaml \
>      python3-sphinx \
> diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/do=
ckerfiles/ubuntu1804.docker
> index 0766f94cf4..1efedeef99 100644
> --- a/tests/docker/dockerfiles/ubuntu1804.docker
> +++ b/tests/docker/dockerfiles/ubuntu1804.docker
> @@ -44,6 +44,7 @@ ENV PACKAGES flex bison \
>      libvdeplug-dev \
>      libvte-2.91-dev \
>      libxen-dev \
> +    libzstd-dev \
>      make \
>      python3-yaml \
>      python3-sphinx \
> diff --git a/tests/vm/fedora b/tests/vm/fedora
> index 4d7d6049f4..4843b4175e 100755
> --- a/tests/vm/fedora
> +++ b/tests/vm/fedora
> @@ -53,7 +53,10 @@ class FedoraVM(basevm.BaseVM):
>          # libs: audio
>          '"pkgconfig(libpulse)"',
>          '"pkgconfig(alsa)"',
> -    ]
> +
> +        # libs: migration
> +        '"pkgconfig(libzstd)"',
> +]
> =20
>      BUILD_SCRIPT =3D """
>          set -e;
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index fb54334696..86770878b6 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -55,6 +55,9 @@ class FreeBSDVM(basevm.BaseVM):
>          # libs: opengl
>          "libepoxy",
>          "mesa-libs",
> +
> +        # libs: migration
> +        "zstd",
>      ]
> =20
>      BUILD_SCRIPT =3D """
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index c5069a45f4..55590f4601 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -49,6 +49,9 @@ class NetBSDVM(basevm.BaseVM):
>          "SDL2",
>          "gtk3+",
>          "libxkbcommon",
> +
> +        # libs: migration
> +        "zstd",
>      ]
> =20
>      BUILD_SCRIPT =3D """
> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> index 22cd9513dd..ab6abbedab 100755
> --- a/tests/vm/openbsd
> +++ b/tests/vm/openbsd
> @@ -51,6 +51,9 @@ class OpenBSDVM(basevm.BaseVM):
>          "sdl2",
>          "gtk+3",
>          "libxkbcommon",
> +
> +        # libs: migration
> +        "zstd",
>      ]
> =20
>      BUILD_SCRIPT =3D """

This looks good to me, thanks.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


