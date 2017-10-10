Received: from eggs.gnu.org ([2001:4830:134:3::10]:56312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1yYa-0007gD-2d
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:43:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1yYZ-0005IG-74
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:43:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e1yYY-0005I7-Sq
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:43:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1D3F80B56
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 17:43:01 +0000 (UTC)
References: <20171010154328.8419-1-berrange@redhat.com>
	<20171010154328.8419-7-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5c734ef0-5cb3-30eb-1b9a-1f2238deaa96@redhat.com>
Date: Tue, 10 Oct 2017 12:42:55 -0500
MIME-Version: 1.0
In-Reply-To: <20171010154328.8419-7-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TaKbDdtLn4elghuee6JSNlq1rwJh3NjUP"
Subject: Re: [Qemu-devel] [PATCH v1 6/7] io: cope with websock 'Connection'
 header having multiple values
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
--TaKbDdtLn4elghuee6JSNlq1rwJh3NjUP
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <5c734ef0-5cb3-30eb-1b9a-1f2238deaa96@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 6/7] io: cope with websock 'Connection'
 header having multiple values
References: <20171010154328.8419-1-berrange@redhat.com>
 <20171010154328.8419-7-berrange@redhat.com>
In-Reply-To: <20171010154328.8419-7-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/10/2017 10:43 AM, Daniel P. Berrange wrote:
> The noVNC server sends a header "Connection: keep-alive, Upgrade" which=

> fails our simple equality test. Split the header on ',', trim whitespac=
e
> and then check for 'upgrade' token.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  io/channel-websock.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20

> @@ -440,7 +443,16 @@ static void qio_channel_websock_handshake_process(=
QIOChannelWebsock *ioc,
>          goto bad_request;
>      }
> =20
> -    if (strcasecmp(connection, QIO_CHANNEL_WEBSOCK_CONNECTION_UPGRADE)=
 !=3D 0) {

My first thought was whether you could just use strcasestr() instead of
strcasecmp(), rather than the malloc overhead of g_strsplit().  But that
would treat "noUpgradeGarbage" as success, making your approach a bit
stricter.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TaKbDdtLn4elghuee6JSNlq1rwJh3NjUP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlndBp8ACgkQp6FrSiUn
Q2q8Mgf8DcMQWwFiOWbAXMu4WAtnMmMTfBOUHEKeaPHEFNDZHzGWX45aXU444civ
g3ltX1F4KyV9KjXynqs4+C7ACd+N5vWs7cM4I3kdv3PP82LzSo9NNBlWEQUc1pPu
otbhNDbPkiyNI8iVRZTW0n/bFqqKUl5REzlovTd3LpGYH8EGU9yt9wMDl/OosZbD
LgiKPIst5db35SUAFIJtacWxytYJDdcS2hDuDU+bTC8dofWTR5y5xbp26G0U7n8Z
xcJYXRKLmsXlzP2uXAzuE8B7SCPv5El9gc5R61rgZFRiyC9Vb5TdWgtYpVMGKy4b
vo3+0wA9B30JccLiUxN+vMK3ttUnCA==
=/cf0
-----END PGP SIGNATURE-----

--TaKbDdtLn4elghuee6JSNlq1rwJh3NjUP--
