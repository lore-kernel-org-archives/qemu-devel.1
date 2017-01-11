Received: from eggs.gnu.org ([2001:4830:134:3::10]:56748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRPUJ-0004Un-Sb
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:27:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRPUF-0003ay-W7
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:27:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cRPUF-0003as-Qg
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:27:11 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0247E31B304
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 20:27:12 +0000 (UTC)
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
	<20170111172956.11255-16-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9900d01b-4ada-15a3-1a64-2c504963bca2@redhat.com>
Date: Wed, 11 Jan 2017 14:27:09 -0600
MIME-Version: 1.0
In-Reply-To: <20170111172956.11255-16-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OXx6Ao4KkTROnxrthagmq403MjRTF5V9g"
Subject: Re: [Qemu-devel] [PATCH 15/40] char: remove chr_free
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
--OXx6Ao4KkTROnxrthagmq403MjRTF5V9g
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <9900d01b-4ada-15a3-1a64-2c504963bca2@redhat.com>
Subject: Re: [PATCH 15/40] char: remove chr_free
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
 <20170111172956.11255-16-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-16-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2017 11:29 AM, Marc-Andr=C3=A9 Lureau wrote:
> Now it uses Object instance_finalize instead.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/sysemu/char.h |  8 --------
>  qemu-char.c           | 10 +---------
>  2 files changed, 1 insertion(+), 17 deletions(-)

patches 13-15: Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--OXx6Ao4KkTROnxrthagmq403MjRTF5V9g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYdpUdAAoJEKeha0olJ0NqZo0IAKnaYE97jOp9ZlHH+TTvl5+2
nPnHPPKkK8kDFmU4d/UiLC0zoxSEyoKJ43DcgQ19MwTflRJ1Dr9+FqFXdyS0aOFV
ZzcoOOGszbaynFbAGTgvVu+F0nSSCMLk++5bPGA4L3R5jVhXLGZwERUT1IN92kMh
98+r26JrSRIKKLYmLZCgt8PCr6aPK+bo0ObvIooU0ONE6DO+Hx7BxdMA2apvfdaM
Aq4LCLmERU/KDxESvTwJt1dM/dN5m1EuJPSm9zNfPRDbuivi2iSHeOP6Wx+tgYpP
v9+xAvI3iKJN54bI7NGv6cPB2lUm21yTp6HOkqwV9y+9gkM9/UNfae4Opil56CI=
=cHt5
-----END PGP SIGNATURE-----

--OXx6Ao4KkTROnxrthagmq403MjRTF5V9g--
