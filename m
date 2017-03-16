Received: from eggs.gnu.org ([2001:4830:134:3::10]:47734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1coPxr-00048x-6d
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1coPxm-000107-Ep
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:36:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1coPxm-0000zJ-8l
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:36:46 -0400
Date: Thu, 16 Mar 2017 15:36:38 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170316073638.GE17296@stefanha-x1.localdomain>
References: <20170313195547.21466-1-eblake@redhat.com>
	<20170313195547.21466-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5xSkJheCpeK0RUEJ"
Content-Disposition: inline
In-Reply-To: <20170313195547.21466-4-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 03/30] trace: Avoid abuse of
 amdvi_mmio_read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>


--5xSkJheCpeK0RUEJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2017 at 02:55:20PM -0500, Eric Blake wrote:
> hw/i386/trace-events has an amdvi_mmio_read trace that is used for
> both normal reads (listing the register name, address, size, and
> offset) and for an error case (abusing the register name to show
> an error message, the address to show the maximum value supported,
> then shoehorning address and size into the size and offset
> parameters).  The change from a wide address to a narrower size
> parameter could truncate a (rather-large) bogus read attempt, so
> it's better to create a separate dedicated trace with correct types,
> rather than abusing the trace mechanism.  Broken since its
> introduction in commit d29a09c.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  hw/i386/amd_iommu.c  | 3 +--
>  hw/i386/trace-events | 1 +
>  2 files changed, 2 insertions(+), 2 deletions(-)

Thanks, applied to my tracing-next tree:
https://github.com/stefanha/qemu/commits/tracing-next

Stefan

--5xSkJheCpeK0RUEJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYykCGAAoJEJykq7OBq3PIubAIAJU0xvXCF2u+xswWglbDeYic
yaxqbTahRKqddDA6bxp+vkFEuJVtPqqe+Cb4fEOZG34VAJg0ij9oaMtF+1Si9/+C
J3z5+cGAQy9fdQvm3p/ZFEJlXT/cA0gcVE/GkpVgKRwfNrhWe0AI0IT4iacmiW/j
p50p7hWgcAHG0WSVNA5nDMf7zMivtir+jGeZK72UkW5qvQuHU8CVBSlwNxzTU4M+
NV+Qcp07Je4L0ojJQ3at20iZ/AB3PNfPnD3Fm8+0iLeLYrUIw7LSuBxoALss/UmI
llvLXETejkH2v5CWzgh2onCFbWMrHrtHIa/l6uZI1gPZQkSMYQhDnLyeSwUeWxM=
=UPbt
-----END PGP SIGNATURE-----

--5xSkJheCpeK0RUEJ--
