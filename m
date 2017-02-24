Received: from eggs.gnu.org ([2001:4830:134:3::10]:47322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1chBwz-0005i7-Tn
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:14:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1chBww-0002cy-OL
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:14:05 -0500
Received: from 9.mo6.mail-out.ovh.net ([87.98.171.146]:48005)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1chBww-0002cd-Hh
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:14:02 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 3503FAB40E
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 10:14:00 +0100 (CET)
Date: Fri, 24 Feb 2017 10:13:50 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170224101350.043b97a6@bahia.lan>
In-Reply-To: <20170224045531.7026-1-aik@ozlabs.ru>
References: <20170224045531.7026-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/LPtf+KqfFXu_u5.JUq0NN3v";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH qemu] sysemu: support up to 1024
 vCPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <gkurz@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

--Sig_/LPtf+KqfFXu_u5.JUq0NN3v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Feb 2017 15:55:31 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> From: Greg Kurz <gkurz@linux.vnet.ibm.com>
>=20
> Some systems can already provide more than 255 hardware threads.
>=20
> Bumping the QEMU limit to 1024 seems reasonable:
> - it has no visible overhead in top;
> - the limit itself has no effect on hot paths.
>=20
> Cc: Greg Kurz <gkurz@linux.vnet.ibm.com>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>=20
> With ulimit -u/-n bumped (nproc and nofile), I was able to boot a guest
> with 1024 CPUs, both with threads=3D1 and threads=3D8.
>=20
> It takes time though - 3:15 to get to the guest shell but it is probably
> expected on 160-threads machine.
>=20

I remember something similiar at the time... also I had to give more
RAM to the guest to be able to run 1024 CPUs (sth like 6 gigs versus
512 megs for 1 CPU). With the same amount of guest RAM, each extra CPU
would cause the memory used by QEMU to grow about 8 megs.

> ---
>  hw/ppc/spapr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e465d7ac98..46b81a625d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2712,7 +2712,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      mc->init =3D ppc_spapr_init;
>      mc->reset =3D ppc_spapr_reset;
>      mc->block_default_type =3D IF_SCSI;
> -    mc->max_cpus =3D 255;
> +    mc->max_cpus =3D 1024;
>      mc->no_parallel =3D 1;
>      mc->default_boot_order =3D "";
>      mc->default_ram_size =3D 512 * M_BYTE;



--Sig_/LPtf+KqfFXu_u5.JUq0NN3v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAliv+U4ACgkQAvw66wEB28L5jACdFYQn7nsXoYykpcIEHHs5A0o9
y54AniPdQdcUNXtEAabkZFPEabbJ63Tn
=pwL6
-----END PGP SIGNATURE-----

--Sig_/LPtf+KqfFXu_u5.JUq0NN3v--
