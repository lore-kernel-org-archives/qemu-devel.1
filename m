Received: from eggs.gnu.org ([2001:4830:134:3::10]:35524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gLvS9-00028j-1g
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 14:31:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gLvS6-0005KE-3X
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 14:31:24 -0500
References: <1541453919-25973-1-git-send-email-Liam.Merwick@oracle.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <52c61f58-8b9c-69c9-00c5-739088b28022@redhat.com>
Date: Sun, 11 Nov 2018 20:31:02 +0100
MIME-Version: 1.0
In-Reply-To: <1541453919-25973-1-git-send-email-Liam.Merwick@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9HFA2MOTzqyRMACK0axMsKnCOYqRCCq2q"
Subject: Re: [Qemu-devel] [PATCH v5 0/5] off-by-one and NULL pointer
 accesses detected by static analysis
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <Liam.Merwick@oracle.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9HFA2MOTzqyRMACK0axMsKnCOYqRCCq2q
From: Max Reitz <mreitz@redhat.com>
To: Liam Merwick <Liam.Merwick@oracle.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com,
 berrange@redhat.com
Message-ID: <52c61f58-8b9c-69c9-00c5-739088b28022@redhat.com>
Subject: Re: [PATCH v5 0/5] off-by-one and NULL pointer accesses detected by
 static analysis
References: <1541453919-25973-1-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1541453919-25973-1-git-send-email-Liam.Merwick@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.11.18 22:38, Liam Merwick wrote:
> Below are a number of fixes to some off-by-one, read outside array boun=
ds, and
> NULL pointer accesses detected by an internal Oracle static analysis to=
ol (Parfait).
> https://labs.oracle.com/pls/apex/f?p=3Dlabs:49:::::P49_PROJECT_ID:13

I decided to just fix the issue I had in patch 4 (dropped the "if" block
that was not doing much, and fixed the DLOG() indentation) and applied
the patch to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--9HFA2MOTzqyRMACK0axMsKnCOYqRCCq2q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvog3YACgkQ9AfbAGHV
z0A96QgAgXpql1DfNjAGYhYY5ZXoc3i/a1STpDMQxAhfhZjXAbM//iLQge+R/cbb
s4FsIw7emwE7FxvCOGoZvnUB+HRsDltg8+fwVsFInrZo5LnqocTgbRuhLIoSTkHU
ibHI7oR3MHmSBuCTgU4+0XfCrPUiCdMPd7BqFwtlMhdiZj1BX2DQX1Q1TEcLjy01
uW2LREFNJB2yFYV6Z5M5bgn6HnvvY09LEMyptJiwkGgdd+jXThXgws/BHgj6+S5K
e2p8T/AdpBRJBZgwBWUbXz4GQypYWA0xAZJf7U0+6f6ainjT3u2wTaHc9OxR3tY1
vEFa8DjBdDKg5wYRmO9Vzdk/wxn/Zw==
=Idf2
-----END PGP SIGNATURE-----

--9HFA2MOTzqyRMACK0axMsKnCOYqRCCq2q--
