Received: from eggs.gnu.org ([2001:4830:134:3::10]:35535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cW6aM-0001Ac-Dm
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:16:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cW6aJ-0000mX-3q
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:16:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cW6aI-0000mP-Qt
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:16:51 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 15ED2804FE
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 19:16:51 +0000 (UTC)
References: <20170124190258.14354-1-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <58a2f89d-c366-ed7b-b1ec-ce259ebbdede@redhat.com>
Date: Tue, 24 Jan 2017 13:16:48 -0600
MIME-Version: 1.0
In-Reply-To: <20170124190258.14354-1-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PhEnW3aBU3vBtVspR77WDrk4rlemHm4wa"
Subject: Re: [Qemu-devel] [PATCHv2] vhost-user: delete chardev on cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PhEnW3aBU3vBtVspR77WDrk4rlemHm4wa
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: mst@redhat.com
Message-ID: <58a2f89d-c366-ed7b-b1ec-ce259ebbdede@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv2] vhost-user: delete chardev on cleanup
References: <20170124190258.14354-1-marcandre.lureau@redhat.com>
In-Reply-To: <20170124190258.14354-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/24/2017 01:02 PM, Marc-Andr=C3=A9 Lureau wrote:
> Remove the chardev implicitely when cleaning up the netdev. This

s/implicitely/implicitly/

> prevents from reusing the chardev since it would be in an incorrect
> state with the slave.
>=20
> Fixes:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1256618
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  net/vhost-user.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index 7aff77ee4a..179939f5c1 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -151,7 +151,10 @@ static void vhost_user_cleanup(NetClientState *nc)=

>          s->vhost_net =3D NULL;
>      }
>      if (nc->queue_index =3D=3D 0) {
> +        CharDriverState *chr =3D qemu_chr_fe_get_driver(&s->chr);
> +
>          qemu_chr_fe_deinit(&s->chr);
> +        qemu_chr_delete(chr);
>      }
> =20
>      qemu_purge_queued_packets(nc);
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--PhEnW3aBU3vBtVspR77WDrk4rlemHm4wa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYh6ggAAoJEKeha0olJ0Nq0DgIAIAVtYc68Wednz4Uah8j3ybW
4PK51S7G/inOAH2fXPDX/9XGL7TeRLHRG0npOa1n5dSL3Ab96DqEH+/aSp9W3ZWI
dP/R57yYY1Jr5JyFTd13mNGQTrFh8GVi2NGhLbE1oAiXIEWGx33xtv/g0hSDWPa5
D3QvomzwnW1NmHsS8YED7dEgNFS/IY9xpSg8TROmufXQj8bUOpQurG/eJFXDTv/J
aZ5+qvOmO/IWqaJqf+SDtb06eKZNUBfHsQyCWv4ONdeYXcyyu9wLoz/ttig8JKnD
hIx7VuFmLPI0AC/f00oPrsJ3eF9lGWQnVepAxpiJIG8+KNCS6YPqkEXvqkCZCZ0=
=KnSN
-----END PGP SIGNATURE-----

--PhEnW3aBU3vBtVspR77WDrk4rlemHm4wa--
