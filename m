Received: from eggs.gnu.org ([2001:4830:134:3::10]:40540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwuLm-0005I4-59
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:12:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwuLl-0004TV-10
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:12:54 -0400
References: <20170829122745.14309-1-stefanha@redhat.com>
	<20170829122745.14309-2-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1fef363e-7ff3-a39e-bad6-18e9d927b37d@redhat.com>
Date: Tue, 26 Sep 2017 13:12:42 -0500
MIME-Version: 1.0
In-Reply-To: <20170829122745.14309-2-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="m5DJNMVqmWag1b65IuTpATId7UNhCRhtT"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] nbd-client: avoid read_reply_co
 entry if send failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m5DJNMVqmWag1b65IuTpATId7UNhCRhtT
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 qemu-stable <qemu-stable@nongnu.org>
Message-ID: <1fef363e-7ff3-a39e-bad6-18e9d927b37d@redhat.com>
Subject: Re: [PATCH v2 1/3] nbd-client: avoid read_reply_co entry if send
 failed
References: <20170829122745.14309-1-stefanha@redhat.com>
 <20170829122745.14309-2-stefanha@redhat.com>
In-Reply-To: <20170829122745.14309-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

CC: qemu-stable@nongnu.org

On 08/29/2017 07:27 AM, Stefan Hajnoczi wrote:
> The following segfault is encountered if the NBD server closes the UNIX=

> domain socket immediately after negotiation:
>=20
>   Program terminated with signal SIGSEGV, Segmentation fault.
=2E..
> Note this only happens with UNIX domain sockets on Linux.  It doesn't
> seem possible to reproduce this with TCP sockets.
>=20
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/nbd-client.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--m5DJNMVqmWag1b65IuTpATId7UNhCRhtT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnKmJoACgkQp6FrSiUn
Q2oyIwgAqXcopzZweOKAX2fO5/evaEeEgFUGgENTfPY2Ni1sIpM4niYnDhzbYuLj
2pgJRGgQ8jS2aQ1UeedOHWrOho4FSfUKbnQgGRSzcLWLau2k3NITHMTcGwTbk1WE
RSClSeoFU9mYWrgxF1ZjGJ2+nTzxS7Z/ZrhxQLCZgmzNJcoa/aqU7TXozPj/CZcN
iyEls7uv1hrM2VZuXKBeC8lX7Fl3nd2Ma/vrYuFRpMw7klLcKRvL46G3tqPpD09L
Ly3JDFLudDRfCGWSjlxfgbv1PlnZyd5tb+HY4NY3g8ea8ErrpH4ipSOM+2o/w2AB
PkCz2Z+4KnpSlkt7rpAqEgZTx/JLMg==
=+c74
-----END PGP SIGNATURE-----

--m5DJNMVqmWag1b65IuTpATId7UNhCRhtT--
