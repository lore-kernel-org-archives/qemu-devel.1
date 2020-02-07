Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C72C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 19:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17343217BA
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 19:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7MLh0HS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17343217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j09bV-00051T-2F
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 14:47:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1j09aj-0004Yb-9h
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 14:47:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1j09ah-0004WE-4v
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 14:47:04 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36246
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1j09ag-0004Vw-Tv
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 14:47:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581104821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CtisXZV9AeWomkOl/M2uCNGcCuaX0RA/AAmHa4tpSNM=;
 b=T7MLh0HSFyu/V2bkSiKBYhjPYBzIhInAQIks5t/vwM4VaksZlAk3tF75C2CIfVl9WdRs5y
 5eR+e7mJwxmeUIdh4+rYjOeMGPwWAiN1vYTuyeHLiQkkN98Hc4SzrTLob3JOJapyDt3KE7
 lz8yIYOWeCNIwmT6F4A/rg69AH0yzl8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-X6PC_IuJNsWo69PqrMw41A-1; Fri, 07 Feb 2020 14:46:50 -0500
X-MC-Unique: X6PC_IuJNsWo69PqrMw41A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 596B010753F3;
 Fri,  7 Feb 2020 19:46:49 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-208.rdu2.redhat.com
 [10.10.123.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A886119C7F;
 Fri,  7 Feb 2020 19:46:45 +0000 (UTC)
Date: Fri, 7 Feb 2020 14:46:43 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH 2/2] GitLab CI: crude mapping of PMM's scripts to jobs
Message-ID: <20200207194643.GC13258@localhost.localdomain>
References: <20200203032328.12051-1-crosa@redhat.com>
 <20200203032328.12051-2-crosa@redhat.com>
 <5d0def0e-0943-3345-784d-80f8ccc318b9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5d0def0e-0943-3345-784d-80f8ccc318b9@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2020 at 09:37:16AM +0100, Thomas Huth wrote:
> On 03/02/2020 04.23, Cleber Rosa wrote:
> > This is a crude and straightforward mapping of Peter's
> > "remake-merge-builds" and "pull-buildtest" scripts.
> >=20
> > Some characteristics were removed for simplicity sake (but eventually
> > will), including:
> >  * number of simultaneous make jobs
> >  * make's synchronous output, not needed because of previous point
> >  * out-of-tree builds
> >=20
> > This covers the "x86-64 Linux with a variety of different build
> > configs"[1].  I've personally tested all of them, and only had
> > issues with the "notcg" job[2], but it seems to be a test specific
> > issue with the nested KVM I was using.
> >=20
> > [1] - https://wiki.qemu.org/Requirements/GatingCI#Current_Tests
> > [2] - https://paste.centos.org/view/1dd43a1c
> >=20
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >  .gitlab-ci.yml | 116 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 116 insertions(+)
>=20
> Thanks for doing this! The patch looks basically fine to me, but some
> comments below...
>=20
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index d2c7d2198e..eb4077e2ab 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -2,6 +2,8 @@ include:
> >    - local: '/.gitlab-ci-edk2.yml'
> > =20
> >  build-system1:
> > + rules:
> > + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
> >   before_script: &before_scr_apt
> >   - apt-get update -qq
> >   - apt-get install -y -qq flex bison libglib2.0-dev libpixman-1-dev ge=
nisoimage
> > @@ -17,6 +19,8 @@ build-system1:
> >   - make -j2 check
> > =20
> >  build-system2:
> > + rules:
> > + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
> >   before_script:
> >    *before_scr_apt
> >   script:
> > @@ -31,6 +35,8 @@ build-system2:
> >   - make -j2 check
> > =20
> >  build-disabled:
> > + rules:
> > + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
> >   before_script:
> >    *before_scr_apt
> >   script:
> > @@ -47,6 +53,8 @@ build-disabled:
> >   - make -j2 check-qtest SPEED=3Dslow
> > =20
> >  build-tcg-disabled:
> > + rules:
> > + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
> >   before_script:
> >    *before_scr_apt
> >   script:
> > @@ -67,6 +75,8 @@ build-tcg-disabled:
> >              248 250 254 255 256
> > =20
> >  build-user:
> > + rules:
> > + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
> >   before_script:
> >    *before_scr_apt
> >   script:
> > @@ -78,6 +88,8 @@ build-user:
> >   - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
> > =20
> >  build-clang:
> > + rules:
> > + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
> >   before_script:
> >    *before_scr_apt
> >   script:
> > @@ -92,6 +104,8 @@ build-clang:
> >   - make -j2 check
> > =20
> >  build-tci:
> > + rules:
> > + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
> >   before_script:
> >    *before_scr_apt
> >   script:
>=20
> Question to Peter/Alex/Stefan/Howevermergespullreqsinthefuture:
>=20
> Should the above jobs really be skipped for pull requests, or would it
> be ok to include them there, too? (in the latter case, the above changes
> could just be dropped)
>=20
> > @@ -111,3 +125,105 @@ build-tci:
> >   - QTEST_QEMU_BINARY=3D"x86_64-softmmu/qemu-system-x86_64" ./tests/qte=
st/pxe-test
> >   - QTEST_QEMU_BINARY=3D"s390x-softmmu/qemu-system-s390x"
> >     ./tests/qtest/pxe-test -m slow
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
>=20
> Line 22 currently seems to be disabled, so I think you could drop this jo=
b?
>

I'd gladly drop it.  I think the reason I kept it was to hear from
Peter what to actually do about those commented out lines.

> > + - ./configure --target-list=3Darm-softmmu --disable-tools --disable-l=
ibssh
> > + # There is no make / make check in the "pull-buildtest" script for th=
is.
> > + # Question: should it at least be built? Or dropped?
> > + - make
> > +
> > +ubuntu-18.04.3-x86_64-all-linux-static:
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
> > + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/p=
ull-buildtest#n36
> > + - make
> > + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/p=
ull-buildtest#n45
> > + - make check V=3D1
> > + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/p=
ull-buildtest#n48
> > + - make check-tcg V=3D1
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
> I think "make check" should now work with TCI, too, there was a fix for
> it some months ago (commit 2f160e0f9797c7522bfd0d09218d0c9340a5137c).
> At least it's worth a try to enable it...
>

I did try, and this is what I got:

ERROR:tests/qtest/prom-env-test.c:42:check_guest_memory: assertion failed (=
signature =3D=3D MAGIC): (0x00000000 =3D=3D 0xcafec0de)
ERROR - Bail out! ERROR:tests/qtest/prom-env-test.c:42:check_guest_memory: =
assertion failed (signature =3D=3D MAGIC): (0x00000000 =3D=3D 0xcafec0de)
/home/gitlab-runner/builds/E8tS7ajQ/0/crosa/qemu/tests/Makefile.include:629=
: recipe for target 'check-qtest-sparc64' failed
ERROR: Job failed: exit status 1

The full log can be found here: https://cleber.fedorapeople.org/ubuntu-18.0=
4.3-x86_64-tci.txt

> Alternatively, I think we don't urgently need to introduce this job -
> there is already "build-tci" in gitlab-ci.yml which should cover
> --enable-tcg-interpreter already and does some testing, too.
>

OK, I'm fine with that, but I think Peter should have the final saying
here (as it's "his" job).

Thanks,
- Cleber.

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl49vqEACgkQZX6NM6Xy
CfMNkxAAt9x4FUvc0IXIZo/0EFb+eA6kPZxdkdBgy40HZ5qeYxjpYC0Uy/GZ/dGE
L9lCcMXRAhkPlY20VNoaXe+b6zR1lxklO9Xjc62w7t0YczxhQ0TT10MOzlqoZqmH
Y4LlXRdwsB5iC7Dd0xMJAWgHjsrGj/WDryIADyK1/OMHMfLB5OzijyvGEH/NsG0I
VqmtY+sj1TiHiJn+ctMJNx70UHku5EbDwEw8KsnHM5z19NJonI6G2e6qs+It+9BD
3ICErEh0yYxDJhN7be5umMbODTPmtEwhUsRhUDgtsB0TPg1PJmCombj+Ii9CW6u4
HGC2jec1JcOsU6wd2VfWuRZD6V2PJ8g7Ijo7+Y/THYJB9Ta8YgJdYEbsnRFUP8b9
uPOeMSOYCz6/0W4XtqHsm0odlCYGD+2umr1ssC6kno1aB1NCQjGPAYBXjxjuyC22
rjcMIyOPiLAh/8F4NtJvKGMvnA6PPqIV+r/Os8nUPzBsxv0CkHzYM2fqRTNIXwSJ
8hGo4Z7zwqqSCD94Pb5zx2TduQwpUEAjNUtVjoL07UCmnSL++l9JYzyLlnLlEZd7
373pH4KQRMG3EBQyADyokChoJrkaDHkBIpAze4CHwO4dFIPAdmPpyKuJl6pXSs+o
xc/RKkBR6Gy1yeKmZEjmXUAvdk7j9amALdl/bAsYM3rM3jkoOVw=
=bJDF
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--


