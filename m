Received: from eggs.gnu.org ([2001:4830:134:3::10]:51882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQxMW-0003A0-Ny
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:25:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQxMS-0000iC-P3
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:25:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52605)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cQxMS-0000ha-Il
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:25:16 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA8FC64DBE
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 14:25:15 +0000 (UTC)
References: <20170109153914.27424-1-berrange@redhat.com>
	<20170109153914.27424-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2d48aff8-924b-26b9-4a47-a13ea3648bd2@redhat.com>
Date: Tue, 10 Jan 2017 08:25:13 -0600
MIME-Version: 1.0
In-Reply-To: <20170109153914.27424-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Kl9bEVKPeA3jR0mxrI2xUjnG2OeX94eUm"
Subject: Re: [Qemu-devel] [PATCH v2 1/8] sockets: add ability to disable DNS
 resolution for InetSocketAddress
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
--Kl9bEVKPeA3jR0mxrI2xUjnG2OeX94eUm
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <2d48aff8-924b-26b9-4a47-a13ea3648bd2@redhat.com>
Subject: Re: [PATCH v2 1/8] sockets: add ability to disable DNS resolution for
 InetSocketAddress
References: <20170109153914.27424-1-berrange@redhat.com>
 <20170109153914.27424-2-berrange@redhat.com>
In-Reply-To: <20170109153914.27424-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/09/2017 09:39 AM, Daniel P. Berrange wrote:
> Add a 'numeric' flag to the InetSocketAddress struct to allow the
> caller to indicate that DNS should be skipped for the host/port
> fields. This is useful if the caller knows the address is already
> numeric and wants to guarantee no (potentially blocking) DNS
> lookups are attempted.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qapi-schema.json    | 5 +++++
>  util/qemu-sockets.c | 3 +++
>  2 files changed, 8 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Kl9bEVKPeA3jR0mxrI2xUjnG2OeX94eUm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYdO7JAAoJEKeha0olJ0NqMmEH/2VJ+Z+o8g/gEJEamBtiQQBE
Y9Dk/U4DXTZ5gnB3OZ0FNjRQcRMjcaS8oecojMmkfa6EJT2wujMoHCcHfvEXkP+E
EIa/r28mcnxk1rHq8dLo97BYOBYw4aDjO3AUmTg4dYHyUQA613voPABZZzLjT0+e
n5y8s2Yy9nHm8hpqZwrZYH8VsuHwacbQ8JibwU7M857qpTeoCgdgvVDq4VaTbWJy
Wko+aXTObwIEPgZlJj5E5b2pL9eZ/0cGABX/L9ObPweXnBRg7af32q+TiVYfQVQg
+gCwP3MHSNDpHGdUwnp9FC6Qvfs6n+9DVVDHfwazaLpeb45TcJStIbH7RTAkWaE=
=ZCh2
-----END PGP SIGNATURE-----

--Kl9bEVKPeA3jR0mxrI2xUjnG2OeX94eUm--
