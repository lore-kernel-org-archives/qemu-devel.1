Received: from eggs.gnu.org ([2001:4830:134:3::10]:40863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2G7s-0000K0-K8
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2G7m-0006QF-O7
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:28:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e2G7m-0006Q1-Ev
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:28:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62D0B46213
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 12:28:33 +0000 (UTC)
References: <20171011100959.29326-1-berrange@redhat.com>
	<20171011100959.29326-5-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7758f5e1-0f5d-a328-ad9a-51d9de3d2fe2@redhat.com>
Date: Wed, 11 Oct 2017 07:28:31 -0500
MIME-Version: 1.0
In-Reply-To: <20171011100959.29326-5-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jbrGlxrkjC0n8goHwTe9lwdXu4cbmjHSD"
Subject: Re: [Qemu-devel] [PATCH v2 4/7] io: pass a struct iovec into
 qio_channel_websock_encode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jbrGlxrkjC0n8goHwTe9lwdXu4cbmjHSD
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <7758f5e1-0f5d-a328-ad9a-51d9de3d2fe2@redhat.com>
Subject: Re: [PATCH v2 4/7] io: pass a struct iovec into
 qio_channel_websock_encode
References: <20171011100959.29326-1-berrange@redhat.com>
 <20171011100959.29326-5-berrange@redhat.com>
In-Reply-To: <20171011100959.29326-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/11/2017 05:09 AM, Daniel P. Berrange wrote:
> Instead of requiring use of another Buffer, pass a struct iovec
> into qio_channel_websock_encode, which gives callers more
> flexibility in how they process data.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  io/channel-websock.c | 69 ++++++++++++++++++++++++++++++++------------=
--------
>  1 file changed, 42 insertions(+), 27 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--jbrGlxrkjC0n8goHwTe9lwdXu4cbmjHSD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlneDm8ACgkQp6FrSiUn
Q2pXDQf/Z4Sv4N8Av6gRjFBRm1gxkFBoVgcauzRkdd45LlM//OQI56gWOcLB2K2B
PPVdIdXDER+Q3gm3yPZPn9CaZtvcfSSqQQYvDwbkQ/ewko46aO+NonGC9WkdSIw0
krF1MIHQ5m2SETUbldwULt6Fgmp6QCSTMdGZnvXfNyW+jMpz9NuKBUmfpp8eDJT7
PkviXuDeQvtqlg9WeT1ctOaZC6y3MD+v88sbogZnHWTz5TYRXff81i6pkZCGp9G8
icysT4UVDZQL0+O5CDHWwl5+eKhXlcmVcR9yjCr++hClhM63n/QWCxG8g+nzXKLk
wJ7ByvVcfH86pNghCcer1+dDL85Rtw==
=oh2B
-----END PGP SIGNATURE-----

--jbrGlxrkjC0n8goHwTe9lwdXu4cbmjHSD--
