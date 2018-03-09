Received: from eggs.gnu.org ([2001:4830:134:3::10]:38714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1euDgc-0004n1-E7
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 03:47:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1euDgZ-0007g6-AC
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 03:47:34 -0500
Date: Fri, 9 Mar 2018 19:27:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180309082736.GW3083@umbus.fritz.box>
References: <1520578898-2610-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Vo2ArcSjcOqS/fzO"
Content-Disposition: inline
In-Reply-To: <1520578898-2610-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/spapr: Allow "spapr-vlan" as NIC
 model name beside "ibmveth"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--Vo2ArcSjcOqS/fzO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2018 at 08:01:38AM +0100, Thomas Huth wrote:
> With the new "--nic" command line parameter option, the "old" way of
> specifying a NIC model via the nd_table[] is becoming more prominent
> again. But for the pseries "spapr-vlan" device, there is a confusing
> discrepancy between the model name that is used for "--device" (i.e.
> "spapr-vlan") and the model name that has to be used for "--net nic"
> or the new "--nic" parameter (i.e. "ibmveth"). Since "spapr-vlan" is
> the "real" name of the device, let's allow "spapr-vlan" to be used
> as model name for the nd_table[] entries, too.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied, thanks.

> ---
>  hw/ppc/spapr.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 7e1c858..dfa9e43 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2607,10 +2607,11 @@ static void spapr_machine_init(MachineState *mach=
ine)
>          NICInfo *nd =3D &nd_table[i];
> =20
>          if (!nd->model) {
> -            nd->model =3D g_strdup("ibmveth");
> +            nd->model =3D g_strdup("spapr-vlan");
>          }
> =20
> -        if (strcmp(nd->model, "ibmveth") =3D=3D 0) {
> +        if (g_str_equal(nd->model, "spapr-vlan") ||
> +            g_str_equal(nd->model, "ibmveth")) {
>              spapr_vlan_create(spapr->vio_bus, nd);
>          } else {
>              pci_nic_init_nofail(&nd_table[i], phb->bus, nd->model, NULL);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Vo2ArcSjcOqS/fzO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqiRXUACgkQbDjKyiDZ
s5LKjhAAyrjkF/Ho3IxyIbMU5AqitGZ2wA08GvZJC1VXD9/to74+9O4wNVB9oGCQ
eyLzPGKrwPljvfnlNIShpxOUEwfZtimmqH6yOhbQLoqWjBKKFjer7epVIPdN2Sdh
suYGdeXEUI0MHm0nU9IN6xBVhBove7h8bP2CnBCyS4YIjgCARE7albT/AMYpwwRf
ZYcC3VI17nZzEhXo4ic6FaqL3bT9DX5fF7rhK9e6YEbnKNjsUNzuFds9XAK+8BP9
urQIzIIyxIrGGldOysxMPbyqROn1VeDj4AyYLU2F6NOKCRM0Jtpb/XGQy/AqwpmH
/YGUMOtpNdfoM7Tj6frs/uZ2dITbijIowR+aleESXpPjdy0JOrhR7atEOsdYDG8F
yzD6/32e+zusw+1MRjebRi8sM4k4zJ0V5WkMtMj7VS1s2PfNuKV2jcpDwUdOaXLM
IcyoULhVbw9k2heFx6GKhraRuEmeiZ904kGGvg0DxcAiHzezeV+xGjWyAfW71LVx
HPfoWFKcdeaa20Ed2KnzS099VIPdJjQbK0eeOJxDxBm/5iE4UnVrv3sSQnj09Gxk
WfEChctnvXoCKXhuCwH3QtdFjIqap56yj8SmPxSj+xcMbgerYnQQ/g87JtbqZekS
PnE1eWxeiX/oVyMeQlf7O+PoEsbY+nvElyysQqFTnFbOgmJOFi0=
=LaYl
-----END PGP SIGNATURE-----

--Vo2ArcSjcOqS/fzO--
