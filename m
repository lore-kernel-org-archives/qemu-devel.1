Received: from eggs.gnu.org ([2001:4830:134:3::10]:43233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3Mvv-0006Al-BU
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3Mvt-0000xN-TY
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:24:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d3Mvt-0000ww-J0
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:24:37 -0400
References: <201704260920380633515@zte.com.cn>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dccb2383-f94f-63e7-4319-4222e435c83b@redhat.com>
Date: Wed, 26 Apr 2017 08:24:34 -0500
MIME-Version: 1.0
In-Reply-To: <201704260920380633515@zte.com.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="C9cWbSB9Wt6p9J582nJMHPoRpSmogkvsj"
Subject: Re: [Qemu-devel] [PATCH v4] qga: Add support network
 interfacestatistics in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lu.zhipeng@zte.com.cn, mdroth@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C9cWbSB9Wt6p9J582nJMHPoRpSmogkvsj
From: Eric Blake <eblake@redhat.com>
To: lu.zhipeng@zte.com.cn, mdroth@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org
Message-ID: <dccb2383-f94f-63e7-4319-4222e435c83b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] qga: Add support network
 interfacestatistics in
References: <201704260920380633515@zte.com.cn>
In-Reply-To: <201704260920380633515@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2017 08:20 PM, lu.zhipeng@zte.com.cn wrote:
> =EF=BC=9E +   */=EF=BC=9E +        colon =3D strchr(line, ':')=EF=BC=9E=
 +        if (!colon) {=EF=BC=9E +            continue=EF=BC=9E +        =
}=EF=BC=9E +        *colon =3D '\0'=EF=BC=9E +        if (colon - path_le=
n =EF=BC=9E=3D line && strcmp(colon - path_len, path) =3D=3D 0) {colon - =
path_len =EF=BC=9E line would imply the current line isn't a matcheither,=
 so i think that can be tightened to colon - path_len =3D=3D line.

Ouch. Your mailer doesn't know how to quote properly, rendering your
email illegible.

>=20
> ------------
>=20
> The text reading from /proc/net/dev/ is  aligned to the right. so i thi=
nk it should be colon - path_len =EF=BC=9E=3D line

<snip>

> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A =EF=BC=9Cmdroth@linux.vnet.ibm.com=
=EF=BC=9E
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A=E8=8A=A6=E5=BF=97=E6=9C=8B10108272=

> =E6=8A=84=E9=80=81=E4=BA=BA=EF=BC=9A=E8=8A=A6=E5=BF=97=E6=9C=8B10108272=
 =EF=BC=9Cqemu-devel@nongnu.org=EF=BC=9E
> =E6=97=A5 =E6=9C=9F =EF=BC=9A2017=E5=B9=B404=E6=9C=8826=E6=97=A5 05:17
> =E4=B8=BB =E9=A2=98 =EF=BC=9ARe: [Qemu-devel] [PATCH v4] qga: Add suppo=
rt network interfacestatistics in
>=20

Also, we prefer that you do not top-post on technical lists, but instead
reply inline to the relevant portions of the email.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--C9cWbSB9Wt6p9J582nJMHPoRpSmogkvsj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAJ+SAAoJEKeha0olJ0Nqt+sH/Az8JV7hUbg6gtv5IwTA7y+P
gP5LI3qC//9tc0XToehV++ULF2S1kbNuw3YwDlWcpSZNFRqkOsKWP6m4GsgTQhxi
20Mllal62mhLeqxsv4w3oSxSQ5gUc/qg6J8pDgjZXtTx/n9o6089PFWVBXPrXm5L
CgLA5NMMX7jQW/xhvcG2cuETvIJjfWShYy1ej4rQZ2KmgWhslVsHR1yr5d+gi24k
bLBP8L/sO71zotQLOmnrVYGMxhVKfTMHVrwPepogqKkGHDedQqoWp6Mmk7CXT+rh
tUAsWeczMzZGt58/GBNMjNqv0fWdxtf0ifriJuof1x7f0Hg5wx6pl933TBeGwdY=
=brzy
-----END PGP SIGNATURE-----

--C9cWbSB9Wt6p9J582nJMHPoRpSmogkvsj--
