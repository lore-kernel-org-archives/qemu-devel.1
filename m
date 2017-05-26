Received: from eggs.gnu.org ([2001:4830:134:3::10]:49463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dEJ47-0000jW-EN
	for qemu-devel@nongnu.org; Fri, 26 May 2017 13:30:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dEJ46-0007m2-LZ
	for qemu-devel@nongnu.org; Fri, 26 May 2017 13:30:19 -0400
References: <20170522195217.12991-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d3ad6b89-4666-72e3-faaa-7b80c62a99a3@redhat.com>
Date: Fri, 26 May 2017 19:30:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170522195217.12991-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4eofIbdeVmL4x5B12HKWES5IXBmoXjiuW"
Subject: Re: [Qemu-devel] [PATCH v2 0/3] block: Fix backing paths for
 filenames with colons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4eofIbdeVmL4x5B12HKWES5IXBmoXjiuW
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <d3ad6b89-4666-72e3-faaa-7b80c62a99a3@redhat.com>
Subject: Re: [PATCH v2 0/3] block: Fix backing paths for filenames with colons
References: <20170522195217.12991-1-mreitz@redhat.com>
In-Reply-To: <20170522195217.12991-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-22 21:52, Max Reitz wrote:
> There are (at least) two issues with filenames that contain colons when=

> trying to use relative backing filenames with them, for each of which
> there is a patch in this series.
>=20
> The first patch fixes an issue in the general block layer
> (path_combine() does not have the same opinion on what constitutes a
> protocol prefix as path_has_protocl()), the second fixes an issue in
> file-* (when stripping off the optional "file:" prefix we should not
> create a filename that seems to have another valid protocol prefix).
>=20
> The third patch adds a test.

Applied to my block tree, with the spelling in patch 3 fixed as
indicated by Eric.

Max


--4eofIbdeVmL4x5B12HKWES5IXBmoXjiuW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZKGYhEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQDFn
B/9bZbrgSgRNpSPjF38NViwtaG88p3AY9tdXwas5Htb5VbV5WjW1cIWatnV5YFXP
8WsvCZRMqjoOfacxLTudXHZFIYPuYZKc99Gz2gn8mg/SEgqHOlTd7UndmzwT2eiJ
Wyo9/Z9QoX7dSM2D76kI2iv2VCwYwznJ5ulyRG2ksFghFtCY5dlqbnUZFqZUaI4L
3LZvuXC0z5RI5eCv5pJMy52LTXzqDjkcxecLATV1vSTGEJU+EcDxckUdO0o2JU3t
Zy+7ZekVNGKmABs2/eyO8yNnManVEbOWiE5UBfnoFdWlZKWn3esj17Qh0RXeAVJI
TwP8oYjCDZCQZ+Adxjlpkd8b
=1nH/
-----END PGP SIGNATURE-----

--4eofIbdeVmL4x5B12HKWES5IXBmoXjiuW--
