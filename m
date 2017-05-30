Received: from eggs.gnu.org ([2001:4830:134:3::10]:60876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFojg-00060T-Iw
	for qemu-devel@nongnu.org; Tue, 30 May 2017 17:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFojc-0006UL-Cv
	for qemu-devel@nongnu.org; Tue, 30 May 2017 17:31:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dFojc-0006Tw-4q
	for qemu-devel@nongnu.org; Tue, 30 May 2017 17:31:24 -0400
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
	<20170530143052.165002-6-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6425e4b9-3047-12dc-2698-80921690cdf8@redhat.com>
Date: Tue, 30 May 2017 16:31:21 -0500
MIME-Version: 1.0
In-Reply-To: <20170530143052.165002-6-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="O1XauhW01Rxe7FtprAiOKQJX0c3D9LXSV"
Subject: Re: [Qemu-devel] [PATCH 05/19] nbd/server: refactor
 nbd_co_receive_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O1XauhW01Rxe7FtprAiOKQJX0c3D9LXSV
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org
Message-ID: <6425e4b9-3047-12dc-2698-80921690cdf8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/19] nbd/server: refactor
 nbd_co_receive_request
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
 <20170530143052.165002-6-vsementsov@virtuozzo.com>
In-Reply-To: <20170530143052.165002-6-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 09:30 AM, Vladimir Sementsov-Ogievskiy wrote:
> Move function tail, about receiving next request out of the function.
> Error path is simplified and nbd_co_receive_request becomes more
> corresponding to its name.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 41 +++++++++++++----------------------------
>  1 file changed, 13 insertions(+), 28 deletions(-)

Quite the diffstat.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--O1XauhW01Rxe7FtprAiOKQJX0c3D9LXSV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLeSpAAoJEKeha0olJ0NqM0AH/37s/gN2GBwbLzZqi+8IaOTU
sD6vysPzgiS4gHxh0qDna53TQU3QzkcyVmTCioAP7Aq03A0WOU2In8+IAR8UykMA
eQuj8cPMJMBaCyuaMMdFNylzAvnKJs5AVUW+KZs3UfTCFi/GiLHy7SuDnToG9XjJ
TcRygOrUsYcQ1tqnqkq/55ZYJNZpncHHo+lLp/tOmDdLaAQEzcFBXD0ie+i1GfFB
BLtiBvO+roy3oaxYPGodEy0ALjL4/ONu+0dfG6KiRq0LWqlssN8uNyfRXUAKET2w
tC3TNNNZ50Tl0NVmc/bKBkp2AzkezFjBheTBohgpAVxpXw7jMF6JgjQQpW/s+ys=
=WclN
-----END PGP SIGNATURE-----

--O1XauhW01Rxe7FtprAiOKQJX0c3D9LXSV--
