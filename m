Received: from eggs.gnu.org ([2001:4830:134:3::10]:43942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRnlD-00034a-0B
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 19:31:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRnlC-00085a-0T
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 19:31:22 -0500
Date: Wed, 28 Nov 2018 09:54:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181127225403.GP2251@umbus.fritz.box>
References: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FRaepaAnLTQkJ4tS"
Content-Disposition: inline
In-Reply-To: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/9] ppc: get rid of
 g_malloc(sizeof(T) * n)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>


--FRaepaAnLTQkJ4tS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 02:04:53PM +0100, Greg Kurz wrote:
> As explained in HACKING, the g_malloc(sizeof(T) * n) construct is unsafe
> because it can't detect multiplication overflowing size_t and doesn't
> allow type checking.
>=20
> It appears to be used in a bunch of places though:
>=20
> $ git grep -E 'malloc.*sizeof' | grep ' \* '  | wc -l
> 101
>=20
> This series fixes the ppc target and ppc machine code. The changes are
> mostly trivial. Only the mac99 and e500 machines required some more work
> that should be reviewed carefully, as it was only compile-tested.

Series applied, thanks.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FRaepaAnLTQkJ4tS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv9ywkACgkQbDjKyiDZ
s5KLqhAAkhpQjyG+j37aVS3C3AmihZDH7YoCR5eRGZ35FRN2H7vvlENRcWQDN2qy
CxQNGhVjEghyYDs+IaQNomaBFQ5r7kwhp7y1f4+4DzHv4B+ZkLpCNgY1/hlL6yk4
ZhyTlqoF3RkDR8q7lfZnTNNJ2Nj26sxsBrWFwNLJ3edP2jiaf0pUFefkZJqz4NM2
A5A2+jlqu6BcwcS/JbntjcHGqwHphOM7fsbLhgaSJ/PdmHZDp/weq4xQKNJ5Wz68
IpyIJe2gkIVDdwyzmHUadWD/CkrdWCaLpLIZTsv5QPdDAGMIba5C69iILBA9nh1P
TxFHD+mZMiuEYS0VjsUFSJ6SQkh6BFsMy9q6FtcVBH6RqPF8RhZIKIckRxQNol/1
HA5J7QKHJ27YwEdAX6tcuDIaWq8AxwEeaq9He8H6uEZ0bo2nutiJNBySzovAEfwW
H69Cs/7A7qvero1wwYkzFepuW0ah0mfDdSbH6FnImf5EZK5Vl2GGlU/XOuvSv78i
EocKRlQF20t0vu6smfgiXYFTntVG/LcE4rgzpXi0WxTQ0+0U0fm1Zbvisqv9J9AD
5wZXfAfcUqDo7CsqsRpS8jlgaD+oBu6Bf0TFajX22o4AG5+nG1fR0HHhy9/a3Wh8
msW5YboKA99ztcm+8DI3zvN+mXYKlPse4wXRBy8GiQX0ERheIYk=
=QXbQ
-----END PGP SIGNATURE-----

--FRaepaAnLTQkJ4tS--
