Received: from eggs.gnu.org ([2001:4830:134:3::10]:39249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eoSSS-0008Hn-AT
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:21:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eoSSO-00064V-GK
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:21:08 -0500
Date: Wed, 21 Feb 2018 11:20:40 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180221112040.GA19501@stefanha-x1.localdomain>
References: <1519139403-2646-1-git-send-email-pl@kamp.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <1519139403-2646-1-git-send-email-pl@kamp.de>
Subject: Re: [Qemu-devel] [PATCH] migration: do not transfer ram during bulk
 storage migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, dgilbert@redhat.com, quintela@redhat.com, famz@redhat.com, jjherne@linux.vnet.ibm.com


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2018 at 04:10:03PM +0100, Peter Lieven wrote:
> this patch makes the bulk phase of a block migration to take
> place before we start transferring ram. As the bulk block migration
> can take a long time its pointless to transfer ram during that phase.
>=20
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  migration/ram.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

This makes sense to me:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJajVYIAAoJEJykq7OBq3PIup4IAJzbvoF8zVlal6HDspMR5Sq4
JnDWaK8UTerm9q6M/Ue6lo1TFbisXH39FqY6iqJyVsxuIx8ad2mmCSjOrQb4oFmd
3voCMyeAiHnojQUMQnSXqyp5Eif6N5bOjJAkpO5OaVDvp+9X5/37WDsI1ZTtYBbD
k7uFtzDWpU2d1IzEvOJJloWl/xrZTCnjvZQpPO09uUlinZH+sS1+8+W8DHRJEbug
8WGepxRtlFi6UfVqPyMGeXbl/V0zmaomTMMXk3Of9rZc4nWPwDC7xB2K2hMCa2ZC
uLsR9R/EnOriQCaU1HdkxtFqnos3BdA+sAskL7xuXas/iQSVFhIEscdszIOZtL0=
=n7Vg
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
