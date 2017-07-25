Received: from eggs.gnu.org ([2001:4830:134:3::10]:46253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1da1Uy-0001I6-2F
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1da1Ux-0007AG-CO
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:11:48 -0400
References: <1500973176-29235-1-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <99f48803-6a21-10b4-7e46-fd1381437253@redhat.com>
Date: Tue, 25 Jul 2017 17:11:38 +0200
MIME-Version: 1.0
In-Reply-To: <1500973176-29235-1-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cmjRK45a1Th0e8CXH224nhsKOP6K2vLMs"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-iotests: Fix reference
 output for 186
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: armbru@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cmjRK45a1Th0e8CXH224nhsKOP6K2vLMs
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: armbru@redhat.com, qemu-devel@nongnu.org
Message-ID: <99f48803-6a21-10b4-7e46-fd1381437253@redhat.com>
Subject: Re: [Qemu-block] [PATCH] qemu-iotests: Fix reference output for 186
References: <1500973176-29235-1-git-send-email-kwolf@redhat.com>
In-Reply-To: <1500973176-29235-1-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-25 10:59, Kevin Wolf wrote:
> Commits 70f17a1 ('error: Revert unwanted change of warning messages')
> and e1824e5 ('qemu-iotests: Test 'info block'') had a semantic merge
> conflict, which results in failure for qemu-iotests case 186. Fix the
> reference output to consider the changes of 70f17a1.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/186.out | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

I've noticed that test 186 fails when not using qemu-system-x86_64,
though (just build with --target-list=3Di386-softmmu, for example). But
this patch doesn't make it worse, so I'll keep it.

Max


--cmjRK45a1Th0e8CXH224nhsKOP6K2vLMs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZd1+qEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQF47
B/0U6hxN1o2WfFEi6jxpTDxXGs8zWfGNfRIwpNUVd6JNBk2Xh5mYufdR9hfwcTep
NK2NYNxb6c/EnuvZUpgqey6g3lykpWI1lYJaxACAbmYdTD8IVZS9QMk8+TMeAtTt
NdWY6bHTW9i88plEMZIRJ4CboR2XrUC64iQkrg9kVxHUl0rXSei4N5lf/ifaXSos
od8NOuX16Gbb3+Ts6n0XnsI3J2peeYu4V2h857eBMvJrsmZ4p/PmjY5nLKmAx00T
m166z+sW5IfwGTCPe+s4Jd2KVLM+iYRx772ahefSBAjQYp5Cg9jFQn9D5Fw2fp9/
ghYNQiDtq6IIgY2RQ24f57/C
=OmRl
-----END PGP SIGNATURE-----

--cmjRK45a1Th0e8CXH224nhsKOP6K2vLMs--
