Received: from eggs.gnu.org ([2001:4830:134:3::10]:52588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVT8B-00081g-U7
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 21:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVT87-0002fj-TZ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 21:41:27 -0400
Date: Thu, 13 Jul 2017 11:22:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170713012228.GU4083@umbus.fritz.box>
References: <149985291912.20899.12562819149683053534.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0rpW5bEisVBStM29"
Content-Disposition: inline
In-Reply-To: <149985291912.20899.12562819149683053534.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] spapr: fix potential memory leak in
 spapr_core_plug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-devel@nongnu.org


--0rpW5bEisVBStM29
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2017 at 11:48:39AM +0200, Greg Kurz wrote:
> Since commit 5c1da81215c7 ("spapr: Remove unnecessary differences between
> hotplug and coldplug paths"), the CPU DT for the DRC is always allocated.
> This causes a memory leak for pseries-2.6 and older machine types, that
> don't support CPU hotplug and don't allocate DRCs for CPUs.
>=20
> Reported-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  hw/ppc/spapr.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 12b3f099d4c9..4a480e1c1dd9 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2993,8 +2993,6 @@ static void spapr_core_plug(HotplugHandler *hotplug=
_dev, DeviceState *dev,
>      CPUState *cs =3D CPU(core->threads);
>      sPAPRDRConnector *drc;
>      Error *local_err =3D NULL;
> -    void *fdt =3D NULL;
> -    int fdt_offset =3D 0;
>      int smt =3D kvmppc_smt_threads();
>      CPUArchId *core_slot;
>      int index;
> @@ -3009,9 +3007,12 @@ static void spapr_core_plug(HotplugHandler *hotplu=
g_dev, DeviceState *dev,
> =20
>      g_assert(drc || !mc->has_hotpluggable_cpus);
> =20
> -    fdt =3D spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
> -
>      if (drc) {
> +        void *fdt;
> +        int fdt_offset;
> +
> +        fdt =3D spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
> +
>          spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
>          if (local_err) {
>              g_free(fdt);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0rpW5bEisVBStM29
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZZstUAAoJEGw4ysog2bOSlYAQAKjZl8EYMDADzu6/tyYzKzUM
aSmgeDQzDTetGwtP4PZbuXfcHCileaKOT3ZOiNUCqUXmJtTjnwmfjUfQep3oGPb1
j4CFKI+rQEU6FXIufe0kSqxTN3znGzx9o+6pO/Tc9ZIIgKTVQfvxDXkSod53YpLN
0h6ySvLuv5pPAmMb4urEhVWXPTqnGA+BLuBTSHEvUNwy+ltQtSO3Ob2yDNCoR/K6
HdOg+MCYn90OAYkmzhAF9m5dlIRd7SogDl3jOXAFmjRoa5KbRbPWU/uWv3zoTDM/
MsNFdpE0R5MQbrebdkTvxmDYs/01I2oNrNwRPAH7wQKaSKEQ5Edmzd+1lne/VqUz
FgfHrBqlYcHuSyBHc2NlWo9AtbHtijoXJhs0moplhkVNS9eMQV9UwRWh1Ek+ROo1
ITe5D9YaxPavmqo8EYaf2BcrWOjSSrfUhLfudzLVQVmcXYy2cRk2/QueHEmfKOy+
Lirqh+NS/lOkTo6iW0XQ3Xp1hqlpvmjpkNCMPyP4cPAAh/vXC0q7iuN3F/WvvPzk
aTJSeblCpSf081XfBwrxf2hzFiXndIO4N/y9U8QndT5Bn/vRuCWLv5pEA/bVUDLy
Qa1pitYGG72S7GuQbwjgJGAEJpzKqqjQ3/H2Ylr3qOCU+aCbxZmf1W3He54aRSdg
LrCKJzi55ATUIJCeFbDg
=0KXQ
-----END PGP SIGNATURE-----

--0rpW5bEisVBStM29--
