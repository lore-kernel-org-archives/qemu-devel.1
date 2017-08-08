Received: from eggs.gnu.org ([2001:4830:134:3::10]:52540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1df0hi-000732-KQ
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 05:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1df0he-0004ip-Je
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 05:21:34 -0400
Received: from 18.mo4.mail-out.ovh.net ([188.165.54.143]:43571)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1df0he-0004iO-Bu
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 05:21:30 -0400
Received: from player694.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 17084892CA
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 11:21:29 +0200 (CEST)
Date: Tue, 8 Aug 2017 11:21:24 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170808112124.78b86b01@bahia.lan>
In-Reply-To: <20170808062106.GC25081@umbus.fritz.box>
References: <20170629045940.11242-1-sjitindarsingh@gmail.com>
	<20170630040317.GA13989@umbus.fritz.box>
	<1499051918.2398.1.camel@gmail.com>
	<20170703092007.GW13989@umbus.fritz.box>
	<1499841917.20288.2.camel@gmail.com>
	<20170713012118.GT4083@umbus.fritz.box>
	<20170803192806.782ebf5b@bahia.lan>
	<20170804023530.GF6553@umbus.fritz.box>
	<20170807110018.25ddce73@bahia.lan>
	<20170808062106.GC25081@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/K._zgHFH6ER8YKcIenqQN3Y";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc: Only set PCR in kvm
 if actually in a compat mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

--Sig_/K._zgHFH6ER8YKcIenqQN3Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Aug 2017 16:21:06 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:
[...]
> > > >=20
> > > > Does it make sense at all to use compat mode with KVM_PR since it
> > > > requires hypervisor privilege, that we're supposed not to have ?   =
=20
> > >=20
> > > Uh.. what?  Availability of the PCR is a question of the guest
> > > environment, and PR (at least potentially) supports various different
> > > guest environments, both with and without (apparent) hypervisor
> > > capability.
> > >  =20
> >=20
> > I mean mtpcr/mfpcr only work when the CPU is in hypervisor state, and PR
> > is supposed to be *mostly* used nested, ie, without hypervisor
> > privilege. =20
>=20
> It tends to be used that way, but it doesn't have to be.
>=20
> > Thus, I don't see the point in implementing PPC_ARCH_COMPAT in PR... but
> > I'm probably missing something :) =20
>=20
> Well, qemu expects to be able to set ARCH_COMPAT for a pseries guest,
> if that guest is going into a compatibility mode (which it usually
> does these days).  We don't want userspace to have to be constantly
> checking which KVM implementation its working against, so it makes
> sense for PR to implement the call, even if it's a no-op because it
> can't really implement the PCR fully.
>=20

Thanks for the explanation!

> >  =20
> > > > Shouldn't we check for kvm_get_one_reg(KVM_REG_PPC_ARCH_COMPAT) and
> > > > don't try to do any compat stuff if it isn't supported ? This would
> > > > include exiting QEMU if max-cpu-compat was passed on the cmdline.  =
 =20
> > >=20
> > > Oh.. right.. that's actually what I meant by setting the PCR.  PCR
> > > setting from the userspace side via PPC_ARCH_COMPAT, rather than PCR
> > > setting from the guest side.
> > >  =20
>=20
>=20
>=20


--Sig_/K._zgHFH6ER8YKcIenqQN3Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmJgpQACgkQAvw66wEB28LWgQCfVYvYx6tnr05wc342jEb2QiQr
5toAoKbVT02YyyEeYF5x9HRrsPfY2QdK
=CHf0
-----END PGP SIGNATURE-----

--Sig_/K._zgHFH6ER8YKcIenqQN3Y--
