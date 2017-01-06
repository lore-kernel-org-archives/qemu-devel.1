Received: from eggs.gnu.org ([2001:4830:134:3::10]:45386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPcu3-00022B-L0
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 17:22:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPcu0-0001jM-Gr
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 17:22:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPcu0-0001jG-AZ
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 17:22:24 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6BF7721722
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 22:22:23 +0000 (UTC)
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
	<20170105165329.17227-16-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a4670f8a-f288-50a1-6728-b29b0a1af6d6@redhat.com>
Date: Fri, 6 Jan 2017 16:22:20 -0600
MIME-Version: 1.0
In-Reply-To: <20170105165329.17227-16-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JoMjsFt0n5qKdkG0DoaL7HegblhbaSw2m"
Subject: Re: [Qemu-devel] [PATCH 15/20] spice-char: improve error reporting
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
--JoMjsFt0n5qKdkG0DoaL7HegblhbaSw2m
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <a4670f8a-f288-50a1-6728-b29b0a1af6d6@redhat.com>
Subject: Re: [PATCH 15/20] spice-char: improve error reporting
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
 <20170105165329.17227-16-marcandre.lureau@redhat.com>
In-Reply-To: <20170105165329.17227-16-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 10:53 AM, Marc-Andr=C3=A9 Lureau wrote:
> Set errp to report errors up to the right monitor.
>=20
> Use error_append_hint() to give hints about parameters on !qmp monitors=
,
> instead of a direct fprintf() call.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  spice-qemu-char.c | 30 ++++++++++--------------------
>  1 file changed, 10 insertions(+), 20 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--JoMjsFt0n5qKdkG0DoaL7HegblhbaSw2m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYcBicAAoJEKeha0olJ0NqDoEH/ieLHwOsSTpoL7RKKM53g6j/
pH/q4jP60R8RqaoBBI8Ou6fXOP0Iv18h+ycN6ywgwU/YYCfSYEaaFTa93XDKyoLq
exzrMCWNYSWfs0UJ/NBGdPS+W6f0CjLmYIduBBnFjD7X17FN0puud1jz19xedWOR
1K45KSGx8/ktcogTzPX8a7h8DYAa1OgDuPyLN6SiEMaTM7DcRUSn4nZrafc//gd2
SA0X2L8/sFPUcNBbpScwtkyuOfb0mif062wEH9RRQIduh1/+dWEvYyVWOF+RwxB4
HVBhvwernLsjdrIW9wDGmaV1MlEGIcih//Xemr9C7B+LDx/XY7sXoJr3anP+pYI=
=hCRr
-----END PGP SIGNATURE-----

--JoMjsFt0n5qKdkG0DoaL7HegblhbaSw2m--
