Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AA1C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 19:35:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C083C20715
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 19:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTaGwTfa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C083C20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j09PO-0000Ke-SH
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 14:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1j09Oo-0008Kc-Ao
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 14:34:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1j09Om-0004ie-6l
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 14:34:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54306
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1j09Om-0004g7-1L
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 14:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581104083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EosZAJUl0LW761DxTRuFtsXK1EYIwzI6SXMcS8/f7j4=;
 b=YTaGwTfaCK0aW/AbnekBMkouej9nXzB16yU4GM8SUa8SI+N5ms6KGkJTeyGIntHDQZVCik
 xHhYIMPlDKRDiCikBIZdn54UIVTRyzcDMarSls9muZzDtmELMUQ9qmcjn6yvj2iOTOiM2R
 UG/pA8TO8SWd1RZvqcUh+N38Uptho0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-2Ia0HSlFOxS9D6YZDJ4mTA-1; Fri, 07 Feb 2020 14:34:35 -0500
X-MC-Unique: 2Ia0HSlFOxS9D6YZDJ4mTA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8C93801FB3;
 Fri,  7 Feb 2020 19:34:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-208.rdu2.redhat.com
 [10.10.123.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC1581BC6D;
 Fri,  7 Feb 2020 19:34:31 +0000 (UTC)
Date: Fri, 7 Feb 2020 14:34:29 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [RFC PATCH 2/2] GitLab CI: crude mapping of PMM's scripts to jobs
Message-ID: <20200207193429.GB13258@localhost.localdomain>
References: <20200203032328.12051-1-crosa@redhat.com>
 <20200203032328.12051-2-crosa@redhat.com>
 <a87e5634-903d-2ad5-4f33-b65f77703302@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a87e5634-903d-2ad5-4f33-b65f77703302@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2020 at 03:36:28PM -0200, Wainer dos Santos Moschetta wrote=
:
> Hi Cleber,
>=20
> On 2/3/20 1:23 AM, Cleber Rosa wrote:
> > This is a crude and straightforward mapping of Peter's
> > "remake-merge-builds" and "pull-buildtest" scripts.
> >=20
> > Some characteristics were removed for simplicity sake (but eventually
> > will), including:
> >   * number of simultaneous make jobs
> >   * make's synchronous output, not needed because of previous point
> >   * out-of-tree builds
> >=20
> > This covers the "x86-64 Linux with a variety of different build
> > configs"[1].  I've personally tested all of them, and only had
> > issues with the "notcg" job[2], but it seems to be a test specific
> > issue with the nested KVM I was using.
>=20
>=20
> Could you put a comment in the commit text or in-code explaining why it
> builds QEMU with=A0 --disable-libssh on all the jobs?
>

Yes, sure.  Answering it now, it's because of
https://bugs.launchpad.net/qemu/+bug/1838763, which was present
in tests/docker/dockerfiles/ubuntu1804.docker, and that I've hit
when I tried to be stubborn and ignore it. :)

> >=20
> > [1] - https://wiki.qemu.org/Requirements/GatingCI#Current_Tests
> > [2] - https://paste.centos.org/view/1dd43a1c
> >=20
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >   .gitlab-ci.yml | 116 ++++++++++++++++++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 116 insertions(+)
> >=20
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index d2c7d2198e..eb4077e2ab 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -2,6 +2,8 @@ include:
> >     - local: '/.gitlab-ci-edk2.yml'
> >   build-system1:
> > + rules:
> > + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
> >    before_script: &before_scr_apt
> >    - apt-get update -qq
> >    - apt-get install -y -qq flex bison libglib2.0-dev libpixman-1-dev g=
enisoimage
> > @@ -17,6 +19,8 @@ build-system1:
> >    - make -j2 check
> >   build-system2:
> > + rules:
> > + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
> >    before_script:
> >     *before_scr_apt
> >    script:
> > @@ -31,6 +35,8 @@ build-system2:
> >    - make -j2 check
> >   build-disabled:
> > + rules:
> > + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
> >    before_script:
> >     *before_scr_apt
> >    script:
> > @@ -47,6 +53,8 @@ build-disabled:
> >    - make -j2 check-qtest SPEED=3Dslow
> >   build-tcg-disabled:
> > + rules:
> > + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
> >    before_script:
> >     *before_scr_apt
> >    script:
> > @@ -67,6 +75,8 @@ build-tcg-disabled:
> >               248 250 254 255 256
> >   build-user:
> > + rules:
> > + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
> >    before_script:
> >     *before_scr_apt
> >    script:
> > @@ -78,6 +88,8 @@ build-user:
> >    - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
> >   build-clang:
> > + rules:
> > + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
> >    before_script:
> >     *before_scr_apt
> >    script:
> > @@ -92,6 +104,8 @@ build-clang:
> >    - make -j2 check
> >   build-tci:
> > + rules:
> > + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
> >    before_script:
> >     *before_scr_apt
> >    script:
> > @@ -111,3 +125,105 @@ build-tci:
> >    - QTEST_QEMU_BINARY=3D"x86_64-softmmu/qemu-system-x86_64" ./tests/qt=
est/pxe-test
> >    - QTEST_QEMU_BINARY=3D"s390x-softmmu/qemu-system-s390x"
> >      ./tests/qtest/pxe-test -m slow
> > +
> > +ubuntu-18.04.3-x86_64-notools:
> > + tags:
> > + - ubuntu_18.04.3
> > + - x86_64
> > + rules:
> > + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
> > + script:
> > + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/r=
emake-merge-builds#n22
> > + - ./configure --target-list=3Darm-softmmu --disable-tools --disable-l=
ibssh
> > + # There is no make / make check in the "pull-buildtest" script for th=
is.
> > + # Question: should it at least be built? Or dropped?
> > + - make
> > +
> > +ubuntu-18.04.3-x86_64-all-linux-static:
>=20
> Doesn't it need to LD_PRELOAD on this runner too? ->
>=20
> |https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-b=
uildtest#n24
> |
>=20
> > + tags:
> > + - ubuntu_18.04.3
> > + - x86_64
> > + rules:
> > + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
> > + script:
> > + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/r=
emake-merge-builds#n25
> > + - ./configure --enable-debug --static --disable-system --disable-glus=
terfs --disable-libssh
>=20
> Shouldn't it --disable-gnutls instead of --disable-glusterfs?
>

Actually, `--disable-glusterfs` was intended because I couldn't find
static versions of the glusterfs libs on that system (or maybe they're
not available anywhere).  That should be documented though.

Also, the build and make steps worked fine without `--disable-gnutls`.
I was trying to not carry over any "exception" type of arguments,
unless they proved to be necessary.  Maybe Peter can give some more
info about this (should it be kept or not)?

> > + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/p=
ull-buildtest#n36
> > + - make
> > + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/p=
ull-buildtest#n45
> > + - make check V=3D1
> > + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/p=
ull-buildtest#n48
> > + - make check-tcg V=3D1
>=20
>=20
> Any special reason to split it in 3 steps instead of a single `make check
> check-tcg`?
>=20
> That pattern continues on next jobs...
>=20
>

I think it's simply because it's easier to track the command that
failed on the GitLab CI output.

> > +
> > +ubuntu-18.04.3-x86_64-all:
> > + tags:
> > + - ubuntu_18.04.3
> > + - x86_64
> > + rules:
> > + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
> > + script:
> > + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/r=
emake-merge-builds#n26
> > + - ./configure --disable-libssh
> > + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/p=
ull-buildtest#n28
> > + - make
> > + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/p=
ull-buildtest#n37
> > + - make check V=3D1
> > +
> > +ubuntu-18.04.3-x86_64-alldbg:
> > + tags:
> > + - ubuntu_18.04.3
> > + - x86_64
> > + rules:
> > + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
> > + script:
> > + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/r=
emake-merge-builds#n27
> > + - ./configure --disable-libssh
> Missing --enable-debug, right?
> > + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/p=
ull-buildtest#n27
> > + - make clean
> > + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/p=
ull-buildtest#n29
> > + - make
> > + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/p=
ull-buildtest#n37
> > + - make check V=3D1
> > +
> > +ubuntu-18.04.3-x86_64-clang:
> > + tags:
> > + - ubuntu_18.04.3
> > + - x86_64
> > + rules:
> > + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
> > + script:
> > + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/r=
emake-merge-builds#n31
> > + - ./configure --disable-libssh --cc=3Dclang --cxx=3Dclang++ --enable-=
gtk --extra-cflags=3D'-fsanitize=3Dundefined -fno-sanitize=3Dshift-base -We=
rror'
> > + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/p=
ull-buildtest#n33
> > + - make
> > + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/p=
ull-buildtest#n39
> > + - make check V=3D1
> > +
> > +ubuntu-18.04.3-x86_64-tci:
> > + tags:
> > + - ubuntu_18.04.3
> > + - x86_64
> > + rules:
> > + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
> > + script:
> > + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/r=
emake-merge-builds#n33
> > + - ./configure --disable-libssh --enable-debug --enable-tcg-interprete=
r
> > + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/p=
ull-buildtest#n34
> > + - make
>=20
> Would make sense to add a commented `make check` entry as well?
>=20
> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-bu=
ildtest#n40
>

Not sure about that, but surely every one of those exceptions need to
be tracked.

- Cleber.

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl49u8EACgkQZX6NM6Xy
CfMpIBAAj4oG3VV00gQkL2hrLVrJf91zpBN7RTLX3kgvjq43KC7r7A8NDrk+QBjF
jOYB+hvHbFjA0wq7n310lJGVaINp9lBBm562OMLKjyZhM21bc3fMpwwBmc5n7WZh
wC6VMA3Fso/h2cQJZ/DtrsY70DLhdw+KLogRJLfKy2dB2fC14Z6dVJJz7dKQqoOp
67x9gatGhJOynxTK+JHJKiNVfQ8OL1gnk4/6nB6mX5cUBT9nMC45kYJsRKahiNCo
P3YJ6QedWv13fCnAKmQ02gsdfCBdVnHbZSbzVC60w4FXs0no89l28bf1nxxjU+X4
E1II2mO2ZLugmebjYYao3KoRQjpLnXbfesaoQjIgn1N6ezh8IxysVEPMAe/REdrw
G9ksBvz2WBNwlhve/ljeK8cOusmBd0NTUiCh4P7CKu7avP0y+p5KKZ/4Gnu9WLDN
Z+sU96OO7JJfHd+OLyw1SkPLkKNUvP21Lk9s7rvXYRg+1agq6iRq2vt6Fc7qpDoy
i9kl2KsQwxuvTFvj1sfUJB+3PFJOzOI930Dabh/VMFZy8zCU5EWlx5gIRbcXrGFC
mVTep79F7LXl9n6XPlLUoDLTjFuCsFGxJ/dsI6QxDzoq8SPr5sk3zIs7Gf9sP91/
ri+lKTAbzNgqyxjXOk1d4Qs4O7MZL0lyZrrJQnL4HbWQmxGPNxM=
=aGFC
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--


