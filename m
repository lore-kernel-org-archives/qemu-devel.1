Received: from eggs.gnu.org ([2001:4830:134:3::10]:34612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cHHQk-0005dF-0J
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 16:49:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cHHQf-0001q2-Sx
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 16:49:42 -0500
Date: Wed, 14 Dec 2016 17:20:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161214062044.GJ32647@umbus>
References: <20161212040603.27295-1-david@gibson.dropbear.id.au>
	<20161212040603.27295-5-david@gibson.dropbear.id.au>
	<1481693546.1555.26.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W/D3X8sky0X3AmG5"
Content-Disposition: inline
In-Reply-To: <1481693546.1555.26.camel@gmail.com>
Subject: Re: [Qemu-devel] [PATCHv3 4/5] pseries: Enable HPT resizing for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: paulus@samba.org, agraf@suse.de, mdroth@linux.vnet.ibm.com, thuth@redhat.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--W/D3X8sky0X3AmG5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 14, 2016 at 04:32:26PM +1100, Suraj Jitindar Singh wrote:
> On Mon, 2016-12-12 at 15:06 +1100, David Gibson wrote:
> > We've now implemented a PAPR extensions which allows PAPR guests
> > (i.e.
> > "pseries" machine type) to resize their hash page table during
> > runtime.
> >=20
> > However, that extension is only enabled if explicitly chosen on the
> > command line.=A0=A0This patch enables it by default for spapr-2.9, but
> > leaves
> > it disabled (by default) for older machine types.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> > ---
> > =A0hw/ppc/spapr.c | 5 ++++-
> > =A01 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index d057031..f05d0e5 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2779,7 +2779,7 @@ static void
> > spapr_machine_class_init(ObjectClass *oc, void *data)
> > =A0
> > =A0=A0=A0=A0=A0smc->dr_lmb_enabled =3D true;
> > =A0=A0=A0=A0=A0smc->tcg_default_cpu =3D "POWER8";
> > -=A0=A0=A0=A0smc->resize_hpt_default =3D SPAPR_RESIZE_HPT_DISABLED;
> > +=A0=A0=A0=A0smc->resize_hpt_default =3D SPAPR_RESIZE_HPT_ENABLED;
> > =A0=A0=A0=A0=A0mc->query_hotpluggable_cpus =3D spapr_query_hotpluggable=
_cpus;
> > =A0=A0=A0=A0=A0fwc->get_dev_path =3D spapr_get_fw_dev_path;
> > =A0=A0=A0=A0=A0nc->nmi_monitor_handler =3D spapr_nmi;
> > @@ -2860,8 +2860,11 @@ static void
> > spapr_machine_2_8_instance_options(MachineState *machine)
> > =A0
> > =A0static void spapr_machine_2_8_class_options(MachineClass *mc)
> > =A0{
> > +=A0=A0=A0=A0sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> > +
> > =A0=A0=A0=A0=A0spapr_machine_2_9_class_options(mc);
> > =A0=A0=A0=A0=A0SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_8);
> > +=A0=A0=A0=A0smc->resize_hpt_default =3D SPAPR_RESIZE_HPT_DISABLED;
> > =A0}
> > =A0
> > =A0DEFINE_SPAPR_MACHINE(2_8, "2.8", false);
> If people don't want this by default they should probably specify on
> the command line.

Uh.. I don't follow you.

> Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--W/D3X8sky0X3AmG5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYUOS8AAoJEGw4ysog2bOS+6wP/08wNP5q/dx0/kpyNFTNgMOW
XpEAjJwkEpuXBe9N3361OzqZLMo8qPaE+DkTvc0zuZ1KJmui/AE1fIrBKvnfT9Dn
d79qpQhj9ufJAO00vz0nCxQg3wxs9eX+1W/gv+rO6O0e6Mf7BST33ghBkLxpTuoO
szhEA6ZJ++YqjyjzJrZh3hU9+5Wu4MIvJ9LQEmuOFBsBxOZxOTJx+jkpagJnQdOh
IYzOOdGooxhOZgwj36Cw426eIZgr8lDWvkG98FaOVIdYPJ8ebwpCx4AE8gzPqG8W
6x0yqID0lRPdmMMcnT9PClPnMZF5Go9XGJkXWGCJzbsC9VIUmRtvBZcG/zkQU1Tr
eGe6bMDtMKKvmXUEYwEmN+R1mo58DQyORV20tcf8p+JgWSrXPGCtU8osELl9+K0w
2UaYNuJEihDfUC095kmXLiImFZ206MFMjg2lugMQHmtd/Cj3SlT1CUMjTUKdNCeR
TzzJAkmHv3nyElkq+Dge2TFm3vIuw7sXGLKpUmuz/dLADCrMugcDvjG0f+5/OEWm
k/YgPTlqkxnn1AkR49f9qep8Gu5o4F5NaYdBrKRh7A7I34+EZ+gvrE754apRMOIr
VyuzB6qN2oxiUdTZlfYxlDwnknLFCGUXBTXDz8NeP8WYFetz32bym3JZo9Z82+xI
+em03PlOtE9Y8KBRmn6a
=SLle
-----END PGP SIGNATURE-----

--W/D3X8sky0X3AmG5--
