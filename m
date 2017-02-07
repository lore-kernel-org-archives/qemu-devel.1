Received: from eggs.gnu.org ([2001:4830:134:3::10]:42412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbBJt-00014a-RS
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 14:20:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbBJo-0003WD-W7
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 14:20:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cbBJo-0003Vo-Oj
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 14:20:48 -0500
References: <20161202210152.6880-1-lersek@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eaa65150-d42b-caa7-0666-9ab018646fc1@redhat.com>
Date: Tue, 7 Feb 2017 13:20:44 -0600
MIME-Version: 1.0
In-Reply-To: <20161202210152.6880-1-lersek@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MtIeNNHlgHeUsbharwgJHrJHRwV4ntRTt"
Subject: Re: [Qemu-devel] [PATCH v2] scripts: add "git.orderfile" for
 ordering diff hunks by pathname patterns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MtIeNNHlgHeUsbharwgJHrJHRwV4ntRTt
From: Eric Blake <eblake@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Fam Zheng <famz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <eaa65150-d42b-caa7-0666-9ab018646fc1@redhat.com>
Subject: Re: [PATCH v2] scripts: add "git.orderfile" for ordering diff hunks
 by pathname patterns
References: <20161202210152.6880-1-lersek@redhat.com>
In-Reply-To: <20161202210152.6880-1-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/02/2016 03:01 PM, Laszlo Ersek wrote:
> When passed to git-diff (and to every other git command producing diffs=

> and/or diffstats) with "-O" or "diff.orderFile", this list of patterns
> will place the more declarative / abstract hunks first, while changes t=
o
> imperative code / details will be near the end of the patches. This sav=
es
> on scrolling / searching and makes for easier reviewing.
>=20
> We intend to advise contributors in the Wiki to run
>=20
>   git config diff.orderFile scripts/git.orderfile
>=20
> once, as part of their initial setup, before formatting their first (or=
,
> for repeat contributors, next) patches.

Presumably, we'd also want this to be mentioned in HACKING?

>=20
> See the "-O" option and the "diff.orderFile" configuration variable in
> git-diff(1) and git-config(1).
>=20
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Fam Zheng <famz@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: John Snow <jsnow@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---

Is it time to revive this patch?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--MtIeNNHlgHeUsbharwgJHrJHRwV4ntRTt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYmh4MAAoJEKeha0olJ0Nq6BYIAJF1lcOMwLhv3Ud7o6y/rmrI
brIakvrXN4YfUP/u0eXsrxqRc5/zylsK/e+LRhLQXsa5rnrnavJH3v2vfjxfx3oe
JO1lmR05CqsIbnsSNhH0nlQVHpkK1buYUFWtd9YpF7etOoc//YLOrpCaL4bjEhVG
9G1JZpD3s8tnSyoyHAdCPXvnTyRqOc21Y5S7xsXyw6Zq6JOqm+1egQDGYmDCttGg
iPU2Kkz9OzD1i9vqkNys7bo202X2BdYVguQv2E+rnCepM6uzr2hyHqgJg2SHkctO
LujvDgbMORZFq3pWgeR6tUBhQN5NcDpc6vU5LJz5GJ/yu9Kp14RrEw9ufphLJyQ=
=V64y
-----END PGP SIGNATURE-----

--MtIeNNHlgHeUsbharwgJHrJHRwV4ntRTt--
