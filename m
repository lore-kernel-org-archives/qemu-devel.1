Received: from eggs.gnu.org ([2001:4830:134:3::10]:37166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmoX2-000379-0l
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmoX1-0006oZ-5s
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:58:48 -0400
References: <20170829122745.14309-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1dbcd6a7-7546-a547-97d1-394617cbaccd@redhat.com>
Date: Tue, 29 Aug 2017 16:58:37 -0500
MIME-Version: 1.0
In-Reply-To: <20170829122745.14309-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7jjICosqGubpcbDUPKnGWWSWRxGJJPFN0"
Subject: Re: [Qemu-devel] [PATCH v2 0/3] nbd-client: enter read_reply_co
 during init to avoid crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7jjICosqGubpcbDUPKnGWWSWRxGJJPFN0
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Message-ID: <1dbcd6a7-7546-a547-97d1-394617cbaccd@redhat.com>
Subject: Re: [PATCH v2 0/3] nbd-client: enter read_reply_co during init to
 avoid crash
References: <20170829122745.14309-1-stefanha@redhat.com>
In-Reply-To: <20170829122745.14309-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/29/2017 07:27 AM, Stefan Hajnoczi wrote:
> v2:
>  * Rewrote Patch 1 following Paolo's suggestion [Paolo]
>=20
> See Patch 1 for the segfault fix.  Patches 2 & 3 add qemu-iotests cover=
age.
>=20
> This is a rare crash that we'll probably only see in testing.  It only =
seems to
> happen with UNIX domain sockets.
>=20
> Stefan Hajnoczi (3):
>   nbd-client: avoid read_reply_co entry if send failed
>   qemu-iotests: improve nbd-fault-injector.py startup protocol
>   qemu-iotests: test NBD over UNIX domain sockets in 083

Thanks; I'm including this series in my NBD tree, and will send a pull
request once 2.11 opens up.

>=20
>  block/nbd-client.c                       |  25 ++----
>  tests/qemu-iotests/083                   | 138 ++++++++++++++++++-----=
------
>  tests/qemu-iotests/083.out               | 145 +++++++++++++++++++++++=
++++----
>  tests/qemu-iotests/common.filter         |   4 +-
>  tests/qemu-iotests/nbd-fault-injector.py |   4 +
>  5 files changed, 228 insertions(+), 88 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7jjICosqGubpcbDUPKnGWWSWRxGJJPFN0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlml440ACgkQp6FrSiUn
Q2oZbgf/Ww2AZbit7CdvY+Tv7bDoqKQGQMMu5jJuyEyl25d2Y6JRzcni4KD/iyCR
RoBaiU1OWGSYBwmGRMWHrMWb/EFf7/uuX36l63SRQH5dsv+qJdrJM30pSzPcrEaT
xGZPhHWurK7/gQjlzAY2kFalzxpB1jfchhBYjLXICXCYzR2JwAdEy+okpUWu7S6r
9WLtm7MeeFaNAlHeIdtKeOHKAr2oQpjFgUPxl9cUNj78aC3SXD8n6QYyJpnMbgGI
wDU8Y5dp+H1nKO/OSKJ6vg4WGbhpQMLM7JfDRleEdtwCKJcvwzsDtf8mPRiP8ARZ
5C09D4AE2eWdVojyjoqr3Z3FslCdKg==
=ndcd
-----END PGP SIGNATURE-----

--7jjICosqGubpcbDUPKnGWWSWRxGJJPFN0--
