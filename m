Received: from eggs.gnu.org ([209.51.188.92]:38703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eroken1@gmail.com>) id 1hB1RE-00017e-Pq
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 14:13:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eroken1@gmail.com>) id 1hB1RD-00008P-Vv
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 14:13:40 -0400
Date: Mon, 1 Apr 2019 19:13:50 +0100
From: Ernest Esene <eroken1@gmail.com>
Message-ID: <20190401181350.GA31823@erokenlabserver>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
Subject: [Qemu-devel]  [PATCH v3 2/3] Categorize devices: i82374
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, qemu-ppc@nongnu.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Set category and description for iommu devices

Signed-off-by: Ernest Esene <eroken1@gmail.com>

---
v3:
  * remove user_creatable
v2:
  * split into separate patches
---
 hw/dma/i82374.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
index 892f655a7e..aeb3da8ba6 100644
--- a/hw/dma/i82374.c
+++ b/hw/dma/i82374.c
@@ -147,6 +147,9 @@ static void i82374_class_init(ObjectClass *klass, void =
*data)
     dc->realize =3D i82374_realize;
     dc->vmsd =3D &vmstate_i82374;
     dc->props =3D i82374_properties;
+    dc->desc =3D "Intel Enhanced DMA controller";
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->user_creatable =3D false;
 }
=20
 static const TypeInfo i82374_info =3D {
--=20
2.14.2


--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEFkNmxXgplc+HqgQGJZ4JoaCvxKoFAlyiVN4ACgkQJZ4JoaCv
xKqcmw//R0CusPt9zu/iAdLb4BsUSbT+GAZe1aJRbOulQm7q7aMesEv0SaT8gFhs
umYsSL9TmBeL2+gBdJfR0dmUXghq3+HSKoC+oWkaealiuFdYdl6eObG71bq5IR9I
F46GuI53nxJ5zmcXrPu9dEWGvy1Ns/FQV2dt3baTh2JZmz1cWUC4B25VB+bCgOZ9
liK+2J2qKotYutg/JATbei8tKI0AOflLxyJ/qGLljPH+sKn06/jkCOBju//su3bE
LZfSwWshPrrnQRVUIlV5d1B/qyBu8bqt5W4WVxw1Cwt0sN6V2nmOyx7CrAWj1TGu
vQ5wkelaWQ7w4tI/+gNWG6K70D3LR5f9xlBHDwtsW8mcDW8oyGYAyya1fpXjn+j0
p7o8UyEOdBpWgpTvwb4qSmmyP1rWqoEY/Llw15CstIdTLUU9ddB7hfRq9GOxgUYJ
YabsuFeHyfvWmmi5m07H8Lf2sXEHkxO8jwUyXb7pxpSE4BPD5BhnrqTldCHq7vPn
nehytWoqB04pxwXILk5id/+QMcyqUx/KLQXg5pLOaVXeCpiwaDsNDV/NIqgnXj6w
E2aDwgHFvYbHlsGYS2ubVxVrE5bRpRnRzED0824op89xhSgEJdJXSju4O2nSJ1QG
f+EnBTOAHV/P7wL2tozpvf01HLGEcHXtekN5X/0CtwrJv9Xczw4=
=5j+F
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
