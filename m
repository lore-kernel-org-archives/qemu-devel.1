Received: from eggs.gnu.org ([2001:4830:134:3::10]:46763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTVWN-0004po-UU
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:50:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTVWM-0003Gg-Vd
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:50:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dTVWM-0003GL-Mr
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:50:18 -0400
References: <20170707152918.23086-1-vsementsov@virtuozzo.com>
	<20170707152918.23086-8-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1be36b10-9f6a-c254-58dd-cc420454718c@redhat.com>
Date: Fri, 7 Jul 2017 10:50:13 -0500
MIME-Version: 1.0
In-Reply-To: <20170707152918.23086-8-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Vd6rLSAEHbxxFLRWhStXHD1qNDwolIKAl"
Subject: Re: [Qemu-devel] [PATCH v3 07/10] nbd/server: fix TRACE in
 nbd_negotiate_send_rep_len
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, berrange@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Vd6rLSAEHbxxFLRWhStXHD1qNDwolIKAl
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 den@openvz.org
Message-ID: <1be36b10-9f6a-c254-58dd-cc420454718c@redhat.com>
Subject: Re: [PATCH v3 07/10] nbd/server: fix TRACE in
 nbd_negotiate_send_rep_len
References: <20170707152918.23086-1-vsementsov@virtuozzo.com>
 <20170707152918.23086-8-vsementsov@virtuozzo.com>
In-Reply-To: <20170707152918.23086-8-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/07/2017 10:29 AM, Vladimir Sementsov-Ogievskiy wrote:
> Fix wrong order of TRACE arguments.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Vd6rLSAEHbxxFLRWhStXHD1qNDwolIKAl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZX621AAoJEKeha0olJ0NqAigIAI4trYrhWVP71L3xyHBXKaeJ
hjAkp6sAlWwrtPKn6aDBlaANq12NLU/HHFglBBB2nV7aOQrLCui5n7j00mF/+HjP
TZP0EyumtXRmRn6208zc86I8l+2Xl3xss6W3PsdKAUh1trmar4JcjIaVMselhHD6
s0DrLtrxme+WfbLbQuBwgr9D4c0+S9fBN3oL8Vfx3tALXhay8PHu3yUm5tLj0Bsb
TD8yQ75ZoZpIeBF6EfQpvlDAUESZec6kfs97Vj1dgmgvW0dHUK9by9S2SY1EvpmH
5KQ/00O6z2dWohOnkLhdchRP5T+tKC4zjd6vveQpPLJSbO0R9K2J6YROmSgiEXU=
=U/VB
-----END PGP SIGNATURE-----

--Vd6rLSAEHbxxFLRWhStXHD1qNDwolIKAl--
