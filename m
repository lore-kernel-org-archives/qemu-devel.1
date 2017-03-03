Received: from eggs.gnu.org ([2001:4830:134:3::10]:35597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjrvz-0004Wj-BT
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:28:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjrvw-0005HV-8S
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:28:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cjrvw-0005H3-0h
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:28:04 -0500
References: <mailman.56273.1488553194.22740.qemu-devel@nongnu.org>
	<8FB6923C-8F97-497C-95DC-6F2D937725BC@gmail.com>
	<20170303164426.42472535@bahia.lan>
	<AA7BADA2-06D5-4A20-A38F-57D374B6C58D@gmail.com>
	<20170303162128.GD13631@redhat.com> <20170303174353.676c1a7b@bahia.lan>
	<a93b0903-cf60-d21b-2d68-cd182e06aed3@redhat.com>
	<20170303191524.048b2d1f@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <10a63c3b-26d7-998c-4dcc-c162f144e8b7@redhat.com>
Date: Fri, 3 Mar 2017 12:28:01 -0600
MIME-Version: 1.0
In-Reply-To: <20170303191524.048b2d1f@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ffhBejd3QB6RSAf7dxklAHe328qWRFNLf"
Subject: Re: [Qemu-devel] git master build failure in 9pfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, G 3 <programmingkidx@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ffhBejd3QB6RSAf7dxklAHe328qWRFNLf
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 G 3 <programmingkidx@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>
Message-ID: <10a63c3b-26d7-998c-4dcc-c162f144e8b7@redhat.com>
Subject: Re: [Qemu-devel] git master build failure in 9pfs
References: <mailman.56273.1488553194.22740.qemu-devel@nongnu.org>
 <8FB6923C-8F97-497C-95DC-6F2D937725BC@gmail.com>
 <20170303164426.42472535@bahia.lan>
 <AA7BADA2-06D5-4A20-A38F-57D374B6C58D@gmail.com>
 <20170303162128.GD13631@redhat.com> <20170303174353.676c1a7b@bahia.lan>
 <a93b0903-cf60-d21b-2d68-cd182e06aed3@redhat.com>
 <20170303191524.048b2d1f@bahia.lan>
In-Reply-To: <20170303191524.048b2d1f@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2017 12:15 PM, Greg Kurz wrote:

>=20
> O_PATH | O_NOFOLLOW is a special case as described in the last paragrap=
h
> of O_PATH in the man page:
>=20
>               If  pathname  is a symbolic link and the O_NOFOLLOW flag =
is also
>               specified, then the call returns a file descriptor referr=
ing  to
>               the  symbolic  link.   This  file  descriptor can be used=
 as the
>               dirfd argument in calls to fchownat(2),  fstatat(2),  lin=
kat(2),
>               and readlinkat(2) with an empty pathname to have the call=
s oper=E2=80=90
>               ate on the symbolic link.

Only when coupled with AT_EMPTY_PATHNAME.  Without that additional flag,
then it must be a directory.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--ffhBejd3QB6RSAf7dxklAHe328qWRFNLf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYubWxAAoJEKeha0olJ0NqLNIH/1i9YTV0rLxC/KKjujKYra+4
cAJXTjChBN71Wb1ZFgOar1uYpH+s+LigwoQDvtRPaSTEeSlJESGCFyRZSj8yx+vg
CF6kD6iV/VOH+pvvKbFBbCNXGFT/FGC3nud8J3UTR82LtZVG9jiLhMeTgz/TOuQ0
HAM3QKur0BVW81Wi4o+pawcl02j/UL+4fwLpMN1BxDMxqHecdOhsb9VS+yJDe6A/
0qpi0/wu/QQySvsyQVYvHfZ26PrdjIr6LCrSyVqyA14etY7d/XTV0lpfOyKQiRXl
pyNrdVWKLOnIx+IO5jksxjukkyt+Yji7kaQuCqSSr9XqqCtHY61aEP51/9L4H3k=
=4fAC
-----END PGP SIGNATURE-----

--ffhBejd3QB6RSAf7dxklAHe328qWRFNLf--
