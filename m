Received: from eggs.gnu.org ([2001:4830:134:3::10]:60181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dG74z-0000QY-9g
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:06:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dG74w-0007zv-2e
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:06:41 -0400
Received: from 3.mo5.mail-out.ovh.net ([46.105.40.108]:52178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dG74v-0007yY-Re
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:06:37 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 07EA8EED8E
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 19:06:35 +0200 (CEST)
Date: Wed, 31 May 2017 19:06:29 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170531190629.1cd2089d@bahia.lan>
In-Reply-To: <20170531185106.126f19ac@p-imbrenda.boeblingen.de.ibm.com>
References: <20170531150933.10156-1-alex.bennee@linaro.org>
	<20170531150933.10156-3-alex.bennee@linaro.org>
	<20170531181737.230cbded@p-imbrenda.boeblingen.de.ibm.com>
	<20170531183324.03bf98fe@bahia.lan>
	<20170531185106.126f19ac@p-imbrenda.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/_NvN=3NiifY+tDw=u=X/Dcd";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v1 2/2] gdbstub: don't fail on vCont; C04:0;
 c packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, pbonzini@redhat.com, doug16k@gmail.com, qemu-devel@nongnu.org

--Sig_/_NvN=3NiifY+tDw=u=X/Dcd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 31 May 2017 18:51:06 +0200
Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:
[...]
> > >=20
> > > This is strange. cpu_index() is defined as:
> > >=20
> > > static inline int cpu_index(CPUState *cpu)
> > > {
> > > #if defined(CONFIG_USER_ONLY)
> > >     return cpu->host_tid;
> > > #else
> > >     return cpu->cpu_index + 1;
> > > #endif
> > > }
> > >=20
> > > therefore it shouldn't return 0 under any circumstance, and   =20
> >=20
> > I think it is 0 for first_cpu in user mode. =20
>=20
> in linux-user/syscall.c:
>=20
> info->tid =3D gettid();
> cpu->host_tid =3D info->tid;
>=20
> kernel thread-ids are system-wide unique and can't be 0
> =20

This is correct but these lines are in clone_func(). This gets called for
all threads but the "main" thread which I believe to be associated to
first_cpu.

--Sig_/_NvN=3NiifY+tDw=u=X/Dcd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlku+BUACgkQAvw66wEB28KMSQCaArcpMpyJCFzFnx3oOKzLmory
e30An16jXeNQbqR2uZ2+crt5tzzEKQGv
=MOCO
-----END PGP SIGNATURE-----

--Sig_/_NvN=3NiifY+tDw=u=X/Dcd--
