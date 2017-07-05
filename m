Received: from eggs.gnu.org ([2001:4830:134:3::10]:39950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSrco-0001GX-Q8
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:14:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSrcn-0005Bt-Og
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:14:18 -0400
References: <149915701334.6295.1724301929524364123.stgit@frigg.lan>
	<149915849243.6295.4484103824675839071.stgit@frigg.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d1a9d3b0-96a3-60e0-270b-3e9ef82cafac@redhat.com>
Date: Wed, 5 Jul 2017 16:14:10 -0500
MIME-Version: 1.0
In-Reply-To: <149915849243.6295.4484103824675839071.stgit@frigg.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3VlR0NJbEIOepVq1vcmSpvCeUJcf9limI"
Subject: Re: [Qemu-devel] [PATCH v11 6/6] trace: [trivial] Statically enable
 all guest events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, "open list:Trivial patches" <qemu-trivial@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3VlR0NJbEIOepVq1vcmSpvCeUJcf9limI
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>,
 qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>,
 "open list:Trivial patches" <qemu-trivial@nongnu.org>
Message-ID: <d1a9d3b0-96a3-60e0-270b-3e9ef82cafac@redhat.com>
Subject: Re: [PATCH v11 6/6] trace: [trivial] Statically enable all guest
 events
References: <149915701334.6295.1724301929524364123.stgit@frigg.lan>
 <149915849243.6295.4484103824675839071.stgit@frigg.lan>
In-Reply-To: <149915849243.6295.4484103824675839071.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/04/2017 03:54 AM, Llu=C3=ADs Vilanova wrote:
> The existing optimizations makes it feasible to have them available on =
all
> builds.

While this change may feel trivial, I think it is a misnomer to include
"[trivial]" in the subject line, and I also think it should not go in
through qemu-trivial.  The ideal trivial patch is one that can be
applied in isolation, but your patch can only be applied as part of a
series that includes the earlier optimizations that made this one possibl=
e.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3VlR0NJbEIOepVq1vcmSpvCeUJcf9limI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXVaiAAoJEKeha0olJ0NqVPoH/3qrlg+HTuT56JX1kcYY98CV
w+dw5wGsTdUxe7ew6Qlfk0RFmCvOJC/jtO8v5AT/VUXM+USCpPhxwZo92CQFvf+C
T3yhZBtG9sztXstcoXNOHJQznRa9Vh/mA5FMxFRL5YFCfot+6CXxyQYS0Dt+FvHC
IsIS+ZvYPGW7CFJpKMTi2OgqwB9MDBMS3CrErel1/0ABYmCsxXWtF8SKu+ZEpEO3
sxkvsvcxXvF18aJwZFvj9zLxfvghkUZZ0lEuVvRrh+MM6S68u1UzOhyMhj98wBBJ
01Q51WiUoqIungitMObgFh4M1ehVgsu8vNxhFnsR1YD92EH2x581+1hVeRWKHZ4=
=Ksa2
-----END PGP SIGNATURE-----

--3VlR0NJbEIOepVq1vcmSpvCeUJcf9limI--
