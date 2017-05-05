Received: from eggs.gnu.org ([2001:4830:134:3::10]:56113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d6lYH-0000jj-L8
	for qemu-devel@nongnu.org; Fri, 05 May 2017 18:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d6lYG-00081W-Cp
	for qemu-devel@nongnu.org; Fri, 05 May 2017 18:18:17 -0400
References: <20170504030755.1001-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c157232e-5ec4-ddb2-0e35-be8eae2309f5@redhat.com>
Date: Sat, 6 May 2017 00:18:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170504030755.1001-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="M4kggJGu2mfCMGbkC8atFXBuCqJIOdj42"
Subject: Re: [Qemu-devel] [PATCH v12 00/10] qcow2 zero-cluster tweaks [was
 add blkdebug tests]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M4kggJGu2mfCMGbkC8atFXBuCqJIOdj42
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <c157232e-5ec4-ddb2-0e35-be8eae2309f5@redhat.com>
Subject: Re: [PATCH v12 00/10] qcow2 zero-cluster tweaks [was add blkdebug
 tests]
References: <20170504030755.1001-1-eblake@redhat.com>
In-Reply-To: <20170504030755.1001-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.05.2017 05:07, Eric Blake wrote:
> I've collected several improvements for qcow2 zero-cluster handling.
>=20
> Available as a tag at:
> git fetch git://repo.or.cz/qemu/ericb.git nbd-blkdebug-v12
>=20
> Marked as v12 for "hysterical raisins", since it it the half of
> v10 [1] that was not resubmitted as v11 [2].
>=20
> Depends on Max's block tree:
> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg00641.html
> and on Max's qcow2 cleanups:
> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg00689.html
>=20
> [1] https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05227.html=

> [2] https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05896.html=

>=20
> Changes since last posting:
> - lots of tweaks to resolve Max's review findings, including
> rewriting my additions to test 154
> - a new patch splitting QCOW2_CLUSTER_ZERO that fell out from
> my review of Max's work
> - defer any optimizations of a backing file with different length
> until later (I will still post an RFC patch to explore what
> optimizations a BDRV_BLOCK_EOF would allow, but didn't want to
> hold up this series any further)

I have given an R-b for every patch, so I could apply the series as-is
(with the really minor fixes we have talked about, and the thing in
patch 8), and I would be more or less OK with that. But I did have my
fair share of nit picks and before I discard all of them, I'd like to
know for sure that you don't intend to address them, or address them in
a follow-up.

I'm saying this because some of the issues I had do not really lend
themselves nicely to a follow-up; for instance the
s/Data cluster/Cluster allocation/ for patch 4.

=46rom my perspective, it's not much more difficult to review a respin of=

this series which just these minor points changed and maybe some very
small patches (the follow-up, basically) added to it.

Max


--M4kggJGu2mfCMGbkC8atFXBuCqJIOdj42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkM+h4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AWyoIAL2FrdrRVn3rGjVRohAOAmN/47P4byuv
h/NDK0+u7Hm7oETgaArRwmaKPzZ1SVekOzXckGypftZ0M30YKal1gtSyuM6h7jaZ
N/9GY+4KBnLoZwRrsRh+P8gYtGyuCwKyP1+lpWB+2qDXj0/9pr3cS+KOK1+WgtW6
ilyEhnFgmfWr5xh0mIde3DfmdSXSv26rk7lfXsuUNzO5tHFj6OtaF6pZVoGWjACc
QFWz9EPIKURdSt/DmAO/gE1Re4Xiz+DFAHLCAm4fmCZmMZeBQxikj9LquBGDoqKG
7vO5i3Gln2Kyi/U8d2FDaJYLFfdLJFS2Yi3/0TNJyM81ONhteGakfAQ=
=B8ZV
-----END PGP SIGNATURE-----

--M4kggJGu2mfCMGbkC8atFXBuCqJIOdj42--
