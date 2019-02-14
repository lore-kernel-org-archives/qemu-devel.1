Received: from eggs.gnu.org ([209.51.188.92]:35416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1guCC0-00073h-89
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 03:16:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1guCBz-0008P6-21
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 03:16:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1guCBy-0008OH-Oe
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 03:16:23 -0500
Date: Thu, 14 Feb 2019 16:16:19 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190214081619.GB7652@stefanha-x1.localdomain>
References: <20190214031004.32522-1-stefanha@redhat.com>
	<20190214031004.32522-2-stefanha@redhat.com>
	<20190214072629.GA18896@richard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
In-Reply-To: <20190214072629.GA18896@richard>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] hostmem: simplify ifdef-s in
 file_backend_memory_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2019 at 03:26:29PM +0800, Wei Yang wrote:
> Maybe change the title=20
>=20
>    s/hotmem/hostmem-file/
>=20
> would be more proper.
>=20
> I missed this in previous review.

You're right.  This can be fixed when merging the patch.

Stefan

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcZSPTAAoJEJykq7OBq3PILz0H/R8UbvPXIxwI5e40V39Ga7Id
ZeSl/XkwRCUmHYRGpMcPXIAOsSKaRLMQBkDwu0fF2yhWQpcM4H1wfz6zkpspeOLI
5tcgZDwZz/uPX3/wsQ04N6T3QSDjGg0gF7hUnLDtGFaQnSxMC0PyboKHdkPIM4AB
tAPCWAx3YqjFCuYyYnMDMyQfLxA6Vo8X2d5Vw+r+4xwpcdW+avOpkd5EDWsRyqwD
knoXKAj6yOes9FkJqqSkYMx6GDlZ3FoUhaZprRgIrLr3AMQzMjJ2Or8pfpPhk3PO
ujNyzTeZK56SJDKcoGPhT63VmGDb39yKhvWvibyR40jyg0oaINML9wTdKMLiCc4=
=bCcR
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
