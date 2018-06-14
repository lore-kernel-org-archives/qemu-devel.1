Received: from eggs.gnu.org ([2001:4830:134:3::10]:46310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTcIr-0003l0-Ie
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 20:09:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTcIo-0008WQ-AR
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 20:09:21 -0400
Date: Fri, 15 Jun 2018 09:59:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180614235944.GA4129@umbus.fritz.box>
References: <152901299450.252222.14219708016930421485.stgit@bahia.lan>
	<152901301117.252222.1572533397608306446.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <152901301117.252222.1572533397608306446.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 1/5] spapr_cpu_core: convert last
 snprintf() to g_strdup_printf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 11:50:11PM +0200, Greg Kurz wrote:
> Because this is the preferred practice in QEMU.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-3.0, thanks.

> ---
>  hw/ppc/spapr_cpu_core.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 7e3a9e78d090..27602245fd55 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -190,7 +190,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, =
Error **errp)
> =20
>      sc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
>      for (i =3D 0; i < cc->nr_threads; i++) {
> -        char id[32];
> +        char *id;
>          CPUState *cs;
>          PowerPCCPU *cpu;
> =20
> @@ -208,8 +208,9 @@ static void spapr_cpu_core_realize(DeviceState *dev, =
Error **errp)
>          /* Set NUMA node for the threads belonged to core  */
>          cpu->node_id =3D sc->node_id;
> =20
> -        snprintf(id, sizeof(id), "thread[%d]", i);
> +        id =3D g_strdup_printf("thread[%d]", i);
>          object_property_add_child(OBJECT(sc), id, obj, &local_err);
> +        g_free(id);
>          if (local_err) {
>              goto err;
>          }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsjAW0ACgkQbDjKyiDZ
s5LBMw//TK9uh+4doXBZPEMup/BO7N5ERboDHn5J9i2y7OAKAxr1ZvWbC/e/wKaD
LVbQMNdpIaunmKhLEcIrL0Q5UONU3o7Vf6rVaihtmNADD+Z+1AkMY7d0ucNoQdqG
eCADrYjl2bjOZW/sf0/AWa4aJeQ1Wo3qH+EdRW0OHg6a1fZnFak2EraOAYDIVLsr
Q+sxUOlfpYa5HWpw/VZAiBDiNo+SVlQPsoVlQLGyklkPoz8h4F5+8MNBN0S0tvdZ
Dl6kMn+9WNmCnkw05aRJzzl+48T/HK3iKZ5VmHI9ZLKUlrkm52J6HW55fOqJ/AMl
G1ogzs/KP4qFwIelHIKnPNQTcwmDFvrlQjW21urEJ6PrAANX2ylE/Jb+spC9OzTv
TYC0mY3ms70UiTFX3hMoAxZZKMYKG5L2YXIc9ET8b/uWCz0fo2PJ85BnkGm9haVz
beRx55ORodd+JTqs1fBxYEL5GZdOmjOoESATaqCFj+KtYNM/Bm3KpUaYSNA/EQci
3Q19blYC465D2J4UfWxh1lqvv17sCwc09BifyCWnLOiUQEHO/PsZ4DkdK0EpjTiv
fMkVDMvgIEIAhJoYxRdaQjwzwDwcpzzZnIWlam33k9/sykXqMj4JNs6ffC340McN
RQPmbr1L3Y4L1yAiD5cmVLOqvAv4XfqGoi94aWwmEqcXmeDL6wU=
=yoqY
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
