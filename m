Received: from eggs.gnu.org ([2001:4830:134:3::10]:51377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVJYE-0004M7-II
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVJYD-0007Kb-IF
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:27:42 -0400
References: <1499864249-26305-1-git-send-email-kwolf@redhat.com>
	<1499864249-26305-5-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7d956609-b912-77f8-dbee-bd2d0aa694b9@redhat.com>
Date: Wed, 12 Jul 2017 10:27:29 -0500
MIME-Version: 1.0
In-Reply-To: <1499864249-26305-5-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="77v3C84n3JBxTxUIuOSwpEE3A881M0Slq"
Subject: Re: [Qemu-devel] [PATCH 4/9] block/qapi: Use blk_all_next() for
 query-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--77v3C84n3JBxTxUIuOSwpEE3A881M0Slq
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org
Message-ID: <7d956609-b912-77f8-dbee-bd2d0aa694b9@redhat.com>
Subject: Re: [PATCH 4/9] block/qapi: Use blk_all_next() for query-block
References: <1499864249-26305-1-git-send-email-kwolf@redhat.com>
 <1499864249-26305-5-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499864249-26305-5-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/12/2017 07:57 AM, Kevin Wolf wrote:
> This patch replaces the blk_next() loop in query-block by a
> blk_all_next() one so that we also get access to BlockBackends that
> aren't owned by the monitor. For now, the next thing we do is check
> whether each BB has a name, so there is no semantical difference.

s/semantical/semantic/

>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qapi.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--77v3C84n3JBxTxUIuOSwpEE3A881M0Slq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZj/iAAoJEKeha0olJ0NqtAwH/iGmW9iU/nRa7yTQHI9sJEVb
I+JjEWJ8RXV3GsubkqWVOCV1OO/Grl2Z/K+Wif2AD/wZRYTZGp8J8fVY0D80cxb1
XIq+ltpuVmy/fQ5VYDH2YvCrazc+zUA063aOP5CrOcHC6TsjU+MXb4HWkIgFEich
snyW+ZPTmw8Yt5g+q1tsr7taTTtpK+7FhfkpgXg2ps5QgP02/THMpcJ3a8674S1s
iNlpgdVe+AccdlnCdv6Qsy1J8NwD9ICHRHWwrzD953P0VsZGpYyM7rLspFQRIGJ/
5pKNKtcAPXnLylNocUhAQk0ImhfFN3Et0/soDTWdVMBfEXoioFcqPilpQKUiGR4=
=8BUd
-----END PGP SIGNATURE-----

--77v3C84n3JBxTxUIuOSwpEE3A881M0Slq--
