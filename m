Received: from eggs.gnu.org ([2001:4830:134:3::10]:51407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ddHEd-00063h-8T
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ddHEa-0006FH-7K
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:36:23 -0400
Received: from 5.mo7.mail-out.ovh.net ([178.32.120.239]:48487)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ddHEZ-0006DS-SB
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:36:20 -0400
Received: from player788.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 17F7467075
	for <qemu-devel@nongnu.org>; Thu,  3 Aug 2017 16:36:18 +0200 (CEST)
Date: Thu, 3 Aug 2017 16:36:11 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170803163611.154d2883@bahia.lan>
In-Reply-To: <928f0ce3-159a-e371-6309-078fac31eace@amsat.org>
References: <150168523493.31663.3716600121804656211.stgit@bahia.lan>
	<928f0ce3-159a-e371-6309-078fac31eace@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/ax0v+i.1hDqqC3/fYVy_Zbk";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] kvm: workaround build break on gcc-7.1.1 /
 fedora26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, Alex =?UTF-8?B?QmVubsOp?= =?UTF-8?B?ZQ==?= <alex.bennee@linaro.org>

--Sig_/ax0v+i.1hDqqC3/fYVy_Zbk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Aug 2017 10:46:47 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Hi Greg,
>=20
> On 08/02/2017 11:47 AM, Greg Kurz wrote:
> > Building QEMU on fedora26 with the latest gcc package fails:
> >=20
> >    CC      ppc64-softmmu/target/ppc/kvm.o
> > In file included from include/sysemu/hw_accel.h:16:0,
> >                   from target/ppc/kvm.c:31:
> > target/ppc/kvm.c: In function =E2=80=98kvmppc_booke_watchdog_enable=E2=
=80=99:
> > include/sysemu/kvm.h:449:35: error: =E2=80=98args_tmp[i]=E2=80=99 may b=
e used uninitialized
> >   in this function [-Werror=3Dmaybe-uninitialized]
> >               cap.args[i] =3D args_tmp[i];                             =
  \
> >                                     ^
> > target/ppc/kvm.c: In function =E2=80=98kvmppc_set_papr=E2=80=99:
> > include/sysemu/kvm.h:449:35: error: =E2=80=98args_tmp[i]=E2=80=99 may b=
e used uninitialized
> >   in this function [-Werror=3Dmaybe-uninitialized]
> > cc1: all warnings being treated as errors =20
>=20
> I'm trying to reproduce this in our docker images (all x86_64 based) but=
=20
> can't reproduce.
>=20
> ./configure shows:
>=20
> KVM support       yes
>=20
> but in "sysemu/kvm.h" CONFIG_KVM_IS_POSSIBLE is not defined
>=20
> I can see CONFIG_KVM defined, but no NEED_CPU_H.
>=20
>  >
>  > $ rpm -q gcc
>  > gcc-7.1.1-3.fc26.ppc64le =20
>=20
> I don't have native ppc64le to build, do you know if it is possible to=20
> cross-compile enabling kvm? It seems I have the correct Linux headers, I=
=20
> wonder if this isn't a ./configure test which disable the kvm cross-build.
>=20

I don't cross-compile personally but I see no reasons why it wouldn't be
possible. I'd say the biggest churn is to setup the cross-compile environme=
nt :)

> Regards,
>=20
> Phil.


--Sig_/ax0v+i.1hDqqC3/fYVy_Zbk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmDNNsACgkQAvw66wEB28JB/wCfTeaEI8qOv//3Y1BpeO2GX4HE
nlkAoJel68WB0GxIwPqh6phebX5Gs5BJ
=/QKn
-----END PGP SIGNATURE-----

--Sig_/ax0v+i.1hDqqC3/fYVy_Zbk--
