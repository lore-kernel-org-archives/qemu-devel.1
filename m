Received: from eggs.gnu.org ([2001:4830:134:3::10]:49333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gK0l6-0004l5-K0
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:47:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gK0b8-0004Np-9t
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:36:48 -0500
Received: from ozlabs.org ([203.11.71.1]:42903)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gK0b7-000499-Ii
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:36:46 -0500
Date: Tue, 6 Nov 2018 23:20:36 +1100
From: 'David Gibson' <david@gibson.dropbear.id.au>
Message-ID: <20181106122036.GA24589@umbus.fritz.box>
References: <20181030093031.10131.17221.stgit@pasha-VirtualBox>
	<20181103132509.GF24365@umbus.hotspot.internet-for-guests.com>
	<003301d47597$749c0340$5dd409c0$@ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <003301d47597$749c0340$5dd409c0$@ru>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: fix mtmsr instruction for
 icount
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, maria.klimushenkova@ispras.ru, agraf@suse.de


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 06, 2018 at 09:10:45AM +0300, Pavel Dovgalyuk wrote:
> > From: David Gibson [mailto:david@gibson.dropbear.id.au]
> > On Tue, Oct 30, 2018 at 12:30:31PM +0300, Pavel Dovgalyuk wrote:
> > > This patch fixes processing of mtmsr instructions in icount mode.
> > > In this mode writing to interrupt/peripheral state is controlled
> > > by can_do_io flag. This flag must be set explicitly before helper
> > > function invocation.
> > >
> > > Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
> > > Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> >=20
> > Applied to ppc-for-3.1, thanks.
>=20
> Thanks. What about this one
> https://patchew.org/QEMU/20181030122134.11055.15711.stgit@pasha-VirtualBo=
x/
> There is a mess with the subject, but the code is ok :)

I've been procrastinating on that because I don't understand icount
well enough to review it easily, and no-one has replied with
Reviewed-by or Tested-by.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvhhxQACgkQbDjKyiDZ
s5JAoA//Ta3MYeGjF5KeiaRMv//W9XNXs7WnspCDT/YTyODm49ypmMvDeCAk5afR
nNfoKajGZBpRfMDKlbXsUNlvbxWRYSEMiR59ebxn2BFY7/cz3lw4s4wKwP7WCsEF
l7a3ib3PMpodburtq3PCm+W2ZkaIomQSDu35SnV/LQs+hssXpiig27ztEld8eFj2
rpc6RK5PVvHx5LaLDtz23FklZmmSjcfFgxFWYdtU2mUtnXH68JMXvu0IPgRxPLJK
6pLn9M5D87TXlvaDzOtoNCQ3fEi8mMtt9eOAyyjod05evNZMDI0OW1N8YoBfMPgP
Ff+tPCQtigBoYdskTH/W07Gi6cm52+ExMcnncePGqxOSZbcunGCsT23Bzyzpr99z
w3ER4Y/Usdbhsy3uX5iaDMr//gG0QaWqTyWnJhoAOy5/TZvoW7aJQjMq36wtKqcL
L4CXjlUwREGs235bXeCyGbMeEld1tcgwkYRSyLgGPGTPWcrJO6wu1uUvJmk2Ixy3
H6FDnhB85SiQJCJ+S/XzCDz2bXHZGGsTcyjF7QuRSZLkjFyT1W9ZrGHa6nJNX7Gh
8+lInDkrR1UQR08GpntVj2U4tuKicnCN6LikU4Fh8SABA2ukk4UTFK1AuxmezsKr
KCpG2YSV6X+yHpRKbs9Cj3SoPUJ7rQ1B5LQOFnvkxdKud7gsSOc=
=byHL
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
