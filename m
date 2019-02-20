Received: from eggs.gnu.org ([209.51.188.92]:53846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwIbG-0005NW-8s
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:31:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwIbE-0003V3-Sh
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:31:09 -0500
Date: Wed, 20 Feb 2019 14:22:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190220032219.GE9345@umbus.fritz.box>
References: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<155059667853.1466090.16527852453054217565.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zBZpvCNcoXwafAjP"
Content-Disposition: inline
In-Reply-To: <155059667853.1466090.16527852453054217565.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 05/17] spapr/drc: Drop
 spapr_drc_attach() fdt argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>


--zBZpvCNcoXwafAjP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 06:17:58PM +0100, Greg Kurz wrote:
> All DRC subtypes have been converted to generate the FDT fragment at
> configure connector time instead of attach time. The fdt and fdt_offset
> arguments of spapr_drc_attach() aren't needed anymore. Drop them and
> make the implementation of the dt_populate() method mandatory.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

I've applied the first 5 patches to ppc-for-4.0, but as a followup...

[...]
> @@ -1113,8 +1104,6 @@ static void rtas_ibm_configure_connector(PowerPCCPU=
 *cpu,
> =20
>      drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> =20
> -    g_assert(drc->fdt || drck->dt_populate);
> -
>      if (!drc->fdt) {

=2E.you can now remove this conditional, since it will always be true.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zBZpvCNcoXwafAjP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxsx+gACgkQbDjKyiDZ
s5JjCQ//c2LtF9GBSGjJU8skWtFKorUexgi8gkXi+Edt+VcoIsTu2L0qowi57cna
eb3NHIJ+Y06bVEXYihVTQcNXqmwmEWIOJjhtGhnMQymeVZEJmooobwQHT7o44x3U
h6w5OivXtA7bnJHMyE4N7YeqzFKQJTPUN3yobywQPFlmXV8WwMQ6R5K6unRinBGP
cCo1dRyEOVySGEEry9FD4KP0+EyjcHuiANLcvRTM0pnZsn97QFRaSgGJV/FUqGcO
6Z1dSVsRsQTmYrsPBHTjsDRG8hKjipn6nts7zWEZqeXr+f+oZNzWh8mN0s+/OwFb
LLDGE6uf8uiLy/LED2wDBeVzRvpm5iR0BLh91DGCcfkFN+E60UNTGhZ0fA7O+fuW
pQaZxz3zawmaprCXIrpOM7Vdoz9wYsZAoezNRfGpaIVRyskFVQSWjc8fCYWn06LA
Ud5rJIdsYoYNug/pWJdephpZCpOVDDTZOGgk/u3nOSgaWvl/+cSVE/jatNrhduDI
B2ubUexI0qSGBdLe5s6M5BmhUpn29kYq6XJrMJivVwwOHLvmt2y2D1lProjzOHYj
WxksABmyZ3urqH4RxTYpLTh8o5w7NheuOv9Rw7pPExSd68fcdJcR5Xho/0CojB3h
D6MmzQCXV24YVsStGup216u9m0j2ez+XRR7ETtlIdnm35dEM+s8=
=h9ju
-----END PGP SIGNATURE-----

--zBZpvCNcoXwafAjP--
