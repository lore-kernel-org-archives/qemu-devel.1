Received: from eggs.gnu.org ([2001:4830:134:3::10]:44595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciqtJ-0005sy-VP
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 18:09:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciqtG-0000nP-Ps
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 18:09:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ciqtG-0000mj-Je
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 18:09:06 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C298E61BB5
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 23:09:06 +0000 (UTC)
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
	<20170221141451.28305-10-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0b8c786d-3e63-9880-41ae-88d64cc9eb4b@redhat.com>
Date: Tue, 28 Feb 2017 17:09:04 -0600
MIME-Version: 1.0
In-Reply-To: <20170221141451.28305-10-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lGugRkdj76oPLbVGowOKUilhGwXMTa0u2"
Subject: Re: [Qemu-devel] [PATCH v2 09/30] tests: fix vhost-user-test leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lGugRkdj76oPLbVGowOKUilhGwXMTa0u2
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <0b8c786d-3e63-9880-41ae-88d64cc9eb4b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 09/30] tests: fix vhost-user-test leaks
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
 <20170221141451.28305-10-marcandre.lureau@redhat.com>
In-Reply-To: <20170221141451.28305-10-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/21/2017 08:14 AM, Marc-Andr=C3=A9 Lureau wrote:
> Spotted by ASAN.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/libqos/virtio-pci.h |  2 ++
>  tests/libqos/virtio-pci.c |  6 ++++++
>  tests/vhost-user-test.c   | 11 +++++++----
>  3 files changed, 15 insertions(+), 4 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--lGugRkdj76oPLbVGowOKUilhGwXMTa0u2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtgMQAAoJEKeha0olJ0Nqj8kH/0j7AQ44q3MwFgs0C8zxs7/6
4fQlXbD+Qtpx6AcuAnfh60mV1HZJTwGxn0UK6jUagt9YzYIwXvxf6gS2K7pI9C0O
IHYEjh4WoQsPBHHGdpOnJuZGMCZ4s5Hmby4xvI54tjxux2zZlQlqhodOk22hGpmZ
zFTCaJ3sPcQ6XnObLu9UPKZVUlFlvAiqBlBxAcxZt67VhGd5ZiSpRUO6v5bEi7A/
d1q4nIw/PrBeN/GUYA8jwegBT34ur7dwC45qmUznXzT/rQcRT8e46FdHeS/jFEcJ
eLPyQRxu7sEsrNj1+GL2PiL/OLQoeM2jOzkIZu79hnbk9YCsPGPdNwUiqTTwwMI=
=lcgd
-----END PGP SIGNATURE-----

--lGugRkdj76oPLbVGowOKUilhGwXMTa0u2--
