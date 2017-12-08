Received: from eggs.gnu.org ([2001:4830:134:3::10]:54767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNKJb-00070t-9G
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:11:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNKJa-00076s-BN
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:11:51 -0500
References: <1512733868-9009-1-git-send-email-pl@kamp.de>
	<1512733868-9009-3-git-send-email-pl@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dd61b219-a965-3794-5155-1483227d5e62@redhat.com>
Date: Fri, 8 Dec 2017 09:11:43 -0600
MIME-Version: 1.0
In-Reply-To: <1512733868-9009-3-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8qpN0nUkPQfurLi0LgcJJXbhedJP41E4a"
Subject: Re: [Qemu-devel] [PATCH 2/2] block/iscsi: only report an iSCSI
 Failure if we don't handle it gracefully
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, ronniesahlberg@gmail.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8qpN0nUkPQfurLi0LgcJJXbhedJP41E4a
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, ronniesahlberg@gmail.com,
 mreitz@redhat.com
Message-ID: <dd61b219-a965-3794-5155-1483227d5e62@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] block/iscsi: only report an iSCSI
 Failure if we don't handle it gracefully
References: <1512733868-9009-1-git-send-email-pl@kamp.de>
 <1512733868-9009-3-git-send-email-pl@kamp.de>
In-Reply-To: <1512733868-9009-3-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/08/2017 05:51 AM, Peter Lieven wrote:
> we currently report an "iSCSI Failure" in iscsi_co_generic_cb if the ta=
sk
> hasn't completed with SCSI_STATUS_GOOD. However, we expect a failure in=

> some cases and handle it gracefully. This is the case for misaligned UN=
MAPs

Is the block layer still capable of producing a misaligned UNMAP?  If
so, that's probably a bug in the block layer for not honoring the block
limit geometries.

> and WRITESAME10/16 calls without UNMAP. In this case a failure in the
> logs can be quite misleading.
>=20
> While we are at it improve the logging to reveal which operation failed=

> at what LBA.
>=20
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  block/iscsi.c | 43 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 32 insertions(+), 11 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8qpN0nUkPQfurLi0LgcJJXbhedJP41E4a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloqq68ACgkQp6FrSiUn
Q2pxnAf8DUK78ufragCN9M5evDEk33uEVPB0LFhTqu+X57CwkPL16vxHym28/F+V
dv/y1xm1PtwM8NE/AwP0CC8/jvp+RtO+/KkzBrGvEDPDG7IuYeywKCYzeNIDeYbn
t5UQBGOIkvawAALx4ahcItVz8OTwC3OYt4NgX2J37toEh0H4mcyjmw77THm+qKRt
pUcTmbTctKakMOXCb7jTmL7Md1CTulhrcZtVM7D5xzT0eCS04kIZM61bVIBZ82bi
844VXSKZpRkG945fujpklx+zn3h7jufjpmngr6qnKS1OjnVGo2hVlDCkIq5RupJA
10Ii4Hdi3vuRCammI7jOb8BjPYsL7w==
=dDYr
-----END PGP SIGNATURE-----

--8qpN0nUkPQfurLi0LgcJJXbhedJP41E4a--
