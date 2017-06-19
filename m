Received: from eggs.gnu.org ([2001:4830:134:3::10]:32946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dMtfI-0008La-32
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:12:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dMtfE-00034M-3e
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:12:12 -0400
Received: from 10.mo179.mail-out.ovh.net ([46.105.79.46]:46538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dMtfD-00033g-TL
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:12:08 -0400
Received: from player716.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 441664D986
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 12:12:06 +0200 (CEST)
Date: Mon, 19 Jun 2017 12:11:57 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170619121157.21434b7d@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170608050930.2613-2-david@gibson.dropbear.id.au>
References: <20170608050930.2613-1-david@gibson.dropbear.id.au>
	<20170608050930.2613-2-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/Cl=OP/3l.60+GbdPfeXCoGc";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 1/6] spapr: Start hotplugged PCI devices in
 ISOLATED state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

--Sig_/Cl=OP/3l.60+GbdPfeXCoGc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu,  8 Jun 2017 15:09:25 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> PCI DRCs, and only PCI DRCs, are immediately moved to UNISOLATED isolation
> state once the device is attached.  This has been there from the initial
> implementation, and it's not clear why.
>=20
> The state diagram in PAPR 13.4 suggests PCI devices should start in
> ISOLATED state until the guest moves them into UNISOLATED, and the code in
> the guest-side drmgr tool seems to work that way too.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_drc.c | 10 ----------
>  1 file changed, 10 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 15ef67d..6186f79 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -315,16 +315,6 @@ void spapr_drc_attach(sPAPRDRConnector *drc, DeviceS=
tate *d, void *fdt,
>      }
>      g_assert(fdt || coldplug);
> =20
> -    /* NOTE: setting initial isolation state to UNISOLATED means we can't
> -     * detach unless guest has a userspace/kernel that moves this state
> -     * back to ISOLATED in response to an unplug event, or this is done
> -     * manually by the admin prior. if we force things while the guest
> -     * may be accessing the device, we can easily crash the guest, so we
> -     * we defer completion of removal in such cases to the reset() hook.
> -     */
> -    if (spapr_drc_type(drc) =3D=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> -        drc->isolation_state =3D SPAPR_DR_ISOLATION_STATE_UNISOLATED;
> -    }
>      drc->dr_indicator =3D SPAPR_DR_INDICATOR_ACTIVE;
> =20
>      drc->dev =3D d;


--Sig_/Cl=OP/3l.60+GbdPfeXCoGc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllHo20ACgkQAvw66wEB28I/MQCfXbM8C7bkTJM+lLyNS9r+q8ik
M0QAn2CxzRIKDtGpYP/F4DGfd9YMka/B
=bt9N
-----END PGP SIGNATURE-----

--Sig_/Cl=OP/3l.60+GbdPfeXCoGc--
