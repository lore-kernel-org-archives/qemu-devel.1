Received: from eggs.gnu.org ([2001:4830:134:3::10]:38980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOsx5-0006c1-HZ
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:18:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOsx0-0006vS-KZ
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:18:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cOsx0-0006v6-CB
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:18:26 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 834F981227
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 21:18:26 +0000 (UTC)
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
	<20161212224325.20790-10-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9fd438bf-6dc6-292e-e8b6-57c89e22e938@redhat.com>
Date: Wed, 4 Jan 2017 15:18:24 -0600
MIME-Version: 1.0
In-Reply-To: <20161212224325.20790-10-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lFHWU9IR03CjQ1F12Pgtcxc5IleLmo0sa"
Subject: Re: [Qemu-devel] [PATCH 09/54] bt: use qemu_chr_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lFHWU9IR03CjQ1F12Pgtcxc5IleLmo0sa
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <9fd438bf-6dc6-292e-e8b6-57c89e22e938@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/54] bt: use qemu_chr_alloc()
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
 <20161212224325.20790-10-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-10-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/12/2016 04:42 PM, Marc-Andr=C3=A9 Lureau wrote:
> Use common allocator for CharDriverState.
>=20
> Rename the now untouched parent field.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/bt/hci-csr.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>=20

>=20
>  static inline void csrhci_fifo_wake(struct csrhci_s *s)
>  {
> -    CharBackend *be =3D s->chr.be;
> +    CharDriverState *chr =3D (CharDriverState *)s;

Another one of those temporary casts that got me stuck on 8/54. So with
the same idea of the commit message mentioning that it gets better later
in the series,

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--lFHWU9IR03CjQ1F12Pgtcxc5IleLmo0sa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYbWagAAoJEKeha0olJ0Nq59AH/2OVCh8KXSedOBA5LF4j58EH
ZsvIbKM4UbUEEY0pgvQ+xo0lX2tLRODqETyw0DHqacwf6tMb1Ckp7tTwT4FXO1Eq
/cSO4rug99gQ6J/uaNGy+GaedLkfd6lYeUh2OV6PbssRdmTBZukQGpzPFSWr3r75
rkDt6J4T8Q4z1J9PCXsbjBnGohJgrvo4As8HHpdQGE78pn+2HfZagt14ejZLXQdi
sd9Zv7jjayUc3bF9irqg7rjJur49EDyKWqxYatMmW8TzYDKQ2oEU3m0SLcewGr9K
jaJjwbGA6644gaPBIPDv+0eTrROXN+K6F19gFR2ZSrNZuR8Y4vZkJhzdEUkIC80=
=4JR2
-----END PGP SIGNATURE-----

--lFHWU9IR03CjQ1F12Pgtcxc5IleLmo0sa--
