Received: from eggs.gnu.org ([2001:4830:134:3::10]:60366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOpU0-0005eB-NS
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 12:36:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOpTx-0000Xo-G6
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 12:36:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cOpTx-0000WM-8z
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 12:36:13 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 425D78124F
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 17:36:13 +0000 (UTC)
References: <20161223182641.2718-1-pbonzini@redhat.com>
	<20161223182641.2718-4-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4537411b-0d82-e79f-8b6b-90c5673419c7@redhat.com>
Date: Wed, 4 Jan 2017 11:36:10 -0600
MIME-Version: 1.0
In-Reply-To: <20161223182641.2718-4-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jKDgxUV6KdkGeRl95pwlJo8hugsv9cJ0D"
Subject: Re: [Qemu-devel] [PATCH 3/3] nbd: do not block on partial reply
 header reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jKDgxUV6KdkGeRl95pwlJo8hugsv9cJ0D
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Message-ID: <4537411b-0d82-e79f-8b6b-90c5673419c7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] nbd: do not block on partial reply
 header reads
References: <20161223182641.2718-1-pbonzini@redhat.com>
 <20161223182641.2718-4-pbonzini@redhat.com>
In-Reply-To: <20161223182641.2718-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/23/2016 12:26 PM, Paolo Bonzini wrote:
> Read the replies from a coroutine.  qio_channel_yield is used so that
> the right coroutine is restarted automatically, eliminating the need
> for send_coroutine in NBDClientSession.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/nbd-client.c | 108 +++++++++++++++++++++------------------------=
--------
>  1 file changed, 42 insertions(+), 66 deletions(-)
>=20

Looks like a nice simplification. I'm not quite confident enough of my
understanding of coroutines to give R-b yet, but I can certainly try and
play with the patches to provide some test results (especially since
this series still depends on others being reviewed).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--jKDgxUV6KdkGeRl95pwlJo8hugsv9cJ0D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYbTKKAAoJEKeha0olJ0Nq9jkH/isj83iY5cVDCyF/a8nza84Z
zjCIc72xsQOSV9eiV0bsaF8hB3FdgjXfzUB7DLhctCNMxvkeTPpYVtD5k/K7OmYi
KoZb8bsiQwJStel5FNtFsWWvp7jf+XYmZeUsXYluYQOHLnT5l30yEbA6HqVGbCdU
NvAlJ5A3cVhQrovDH+/gobRUov4kJwjHkKBPPuA6M6Fz6F/8Kjtczegzp4AkkeLp
FxDIkYWP2ZZFfMXxPI8ahoMpVjmuUZnIX1UCTTuiw2uWEeRkGVny/FXlWqSsJaYv
RESaP9idgJuWG5J53N2Qd5zyDryr5b0PEMAdpj4OjUlqsXbkDwNT11uO/upMSxw=
=s1Wa
-----END PGP SIGNATURE-----

--jKDgxUV6KdkGeRl95pwlJo8hugsv9cJ0D--
