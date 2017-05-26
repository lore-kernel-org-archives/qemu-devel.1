Received: from eggs.gnu.org ([2001:4830:134:3::10]:49126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dENAl-0007zL-5Q
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dENAk-0006Gw-B2
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:53:27 -0400
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-10-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ae298810-6fc4-5fba-997c-850888c73d1a@redhat.com>
Date: Fri, 26 May 2017 16:53:17 -0500
MIME-Version: 1.0
In-Reply-To: <1495830130-30611-10-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jgCd5DmsSELS5seL5IiWVPDQb8P5RTPdd"
Subject: Re: [Qemu-devel] [PATCH 09/29] qed: Make qed_write_header()
 synchronous
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jgCd5DmsSELS5seL5IiWVPDQb8P5RTPdd
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com
Message-ID: <ae298810-6fc4-5fba-997c-850888c73d1a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/29] qed: Make qed_write_header()
 synchronous
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
 <1495830130-30611-10-git-send-email-kwolf@redhat.com>
In-Reply-To: <1495830130-30611-10-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/26/2017 03:21 PM, Kevin Wolf wrote:
> Note that this code is generally not running in coroutine context, so
> this is an actual blocking synchronous operation. We'll fix this in a
> moment.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed.c | 76 +++++++++++++++++++++++------------------------------=
--------
>  1 file changed, 29 insertions(+), 47 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--jgCd5DmsSELS5seL5IiWVPDQb8P5RTPdd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEbBAEBCAAGBQJZKKPNAAoJEKeha0olJ0NqbkcH+P4PyyzZ24lvUp2R9WwRiVhx
Ht9QTN0mkW5zC94wPAMj17mvtlnhbsJUh3Dvg8su2U86MBBi0HncK0U004fXrx6w
d8djH53HBjqEqZdmgT+pl+nucL+Ahv/ZpADBrPUTjmisbnbKZ2Iqu4qN7BS8pthl
xaobeLW7m+3+O6KrWBsG0HSwrchUhtp2pch5T5V4YDXWplzW75GjPUuzIcxbgrfA
abGZNdMDc0TnL3DF15W3PWf3R0JnH+MET8JPBEXGIO/LLvGsDQzd97wwygxsykgh
alKG6dU3y+N9r+VJYObemBG10OrZAB8xwiLDUux/5DCyEfLkQodP3HQ490/Y1Q==
=lJRN
-----END PGP SIGNATURE-----

--jgCd5DmsSELS5seL5IiWVPDQb8P5RTPdd--
