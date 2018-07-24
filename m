Received: from eggs.gnu.org ([2001:4830:134:3::10]:39025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fhvIR-0001J4-IS
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fhvIO-0007MI-Dl
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:16:03 -0400
Date: Tue, 24 Jul 2018 13:15:50 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20180724111550.GF20399@angien.pipo.sk>
References: <20180724092413.5770-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NQTVMVnDVuULnIzU"
Content-Disposition: inline
In-Reply-To: <20180724092413.5770-1-cohuck@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] [PATCH for-3.1] s390x: remove
 's390-squash-mcss' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, Xiao Feng Ren <renxiaof@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, libvir-list@redhat.com, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>


--NQTVMVnDVuULnIzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 24, 2018 at 11:24:13 +0200, Cornelia Huck wrote:
> This option has been deprecated for two releases; remove it.
>=20
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/3270-ccw.c                |  2 +-
>  hw/s390x/css-bridge.c              |  1 -
>  hw/s390x/css.c                     |  6 ++----
>  hw/s390x/s390-ccw.c                |  2 +-
>  hw/s390x/s390-virtio-ccw.c         | 37 ++------------------------------=
-----
>  hw/s390x/virtio-ccw.c              |  2 +-
>  include/hw/s390x/css-bridge.h      |  1 -
>  include/hw/s390x/css.h             |  9 +++------
>  include/hw/s390x/s390-virtio-ccw.h |  1 -
>  qemu-deprecated.texi               |  8 --------
>  qemu-options.hx                    | 10 ----------
>  target/s390x/cpu.c                 | 10 ----------
>  target/s390x/cpu.h                 |  1 -
>  13 files changed, 10 insertions(+), 80 deletions(-)

Looks like libvirt did not use this option at all according to my brief
grepping, so it should be okay to remove it.

--NQTVMVnDVuULnIzU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAltXCmMACgkQHGwCByjY
1GodZhAAkoMH2ioByzETpMJAtR3/9W2f8w+o1YcLomle5xDxImRD931fOX5eLsmB
NOt+/g5AZtws/RACZEQqSeJyhr9Cc8nFcfkbN6B4Rr2rfjl6KE7GMuz9SlWuL2NH
IzBktYAqI7SfGsKemiJkWHPLb2GtNtkcE1ehHC7RRd1qTTWOqO1AYE1k2gOYwH/J
Hrd41YvU/CNL+9Br39ov09J1hka4pSqW3vr4LJxWpQ0mJPSNd2IgySFLN7pUTr2F
Ln+Lxu8eESzU+GvcSh+uZJZwVx8JKaKRHQcGMw6n2MO++ixdEUpJnpvvIM6nTUtj
EZarHeIt+Srnm5QteUXDFaWtC2wZRELt8t2yLDOQpalZ6UOCU3NeKlLTEsSI0pCW
CIx9r6NtUKaDdvN+yBz0CC6LYPVOU6f6oZGy5eeyErvuCBe8n3XrSqLZ+OYQRBcI
3CDmx8z/TCIA79XMliRju8BEYX4qufOYdXSGI/1iYmsg/7ZYj5nh/Qkwmb22jXRv
vUXErLqPUFW5nCUfgdBlumTFohWl6fr19U09M97fcXRumEWu1IRdI+iZepVBK71H
By3Z03koXFRMdor4vC/MS33iUcu0KNdXmgkqIgvm0W9ay07XH4YT4GhJFkXcH0jO
tagwpl3EMZh+Ntsi2K5cNUUd/EhAQ/Fdn7VNkqgI4NrMFdXoNbY=
=pCyH
-----END PGP SIGNATURE-----

--NQTVMVnDVuULnIzU--
