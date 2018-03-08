Received: from eggs.gnu.org ([2001:4830:134:3::10]:59395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etzUF-0006el-NA
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:37:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etzUA-0007YJ-Pz
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:37:51 -0500
Date: Thu, 8 Mar 2018 17:37:42 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180308173742.GH2769@stefanha-x1.localdomain>
References: <20180306204819.11266-1-stefanha@redhat.com>
	<b0babfd7-71b7-c1cb-52a2-994c7cff843b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGu/vTNewDGZ7tmp"
Content-Disposition: inline
In-Reply-To: <b0babfd7-71b7-c1cb-52a2-994c7cff843b@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/2] block: fix
 nbd-server-stop crash after blockdev-snapshot-sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Stefano Panella <spanella@gmail.com>


--MGu/vTNewDGZ7tmp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 07, 2018 at 05:27:45PM -0600, Eric Blake wrote:
> On 03/06/2018 02:48 PM, Stefan Hajnoczi wrote:
> > The blockdev-snapshot-sync command uses bdrv_append() to update all par=
ents to
> > point at the external snapshot node.  This breaks BlockBackend's
> > blk_add/remove_aio_context_notifier(), which doesn't expect a BDS chang=
e.
> >=20
> > Patch 1 fixes this by tracking AioContext notifiers in BlockBackend.
> >=20
> > See the test case in Patch 2 for a reproducer.
> >=20
> > Stefan Hajnoczi (2):
> >    block: let blk_add/remove_aio_context_notifier() tolerate BDS changes
> >    iotests: add 208 nbd-server + blockdev-snapshot-sync test case
> >=20
> >   block/block-backend.c      | 63 +++++++++++++++++++++++++++++++++++++=
+++++++++
> >   block/trace-events         |  2 ++
> >   tests/qemu-iotests/208     | 55 +++++++++++++++++++++++++++++++++++++=
+++
> >   tests/qemu-iotests/208.out |  9 +++++++
> >   tests/qemu-iotests/group   |  1 +
> >   5 files changed, 130 insertions(+)
> >   create mode 100755 tests/qemu-iotests/208
> >   create mode 100644 tests/qemu-iotests/208.out
>=20
> Whose tree should this series go through?  MAINTAINERS didn't flag it as
> directly touching any files that normally affect my NBD queue, but given
> that the iotest that reproduces the problem uses NBD, I'm fine if you want
> it to go through me.

Good question.  Max and Kevin maintain block/block-backend.c so one of
them should be happy with this series before it gets merged.

When a patch affects multiple trees, the last sub-maintainer to review
it can do the merge.

So if they have already posted their R-b when you are finished, then
feel free to merge it!  And vice versa.

Stefan

--MGu/vTNewDGZ7tmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaoXTmAAoJEJykq7OBq3PIaugIAJso7FA42ABKiaZ5UwWO7OD3
swZLZrpOzcgP4xCo6KIxgj8Dp0l1dBq2lZHGUf8PreAuWkgheyF2s49ivs+Vhu5b
jh1NoBknwQ31SSEKIOG/se+d3RfZeHmuzJ98vwK10Y2BspnMY2ApEqk64g0ZFKM3
ofveBp3iJcTg4T2vfRF4ka4mYtuuMsECJSM+w7Ea/uFJyDivnO1Gqt+vhpuMv0L7
x0+h2viEvveFP9IWLwtq6eQhV8hIH/NlVL+CY6Zuc1aedJkQ0rm5fqNh79Ui4dwk
B3EwmuKZnxtdK0SUg6S0uCeerQGBwjkW7G8t+cQ3QAL6k9CV7kKCZxciezbeuYw=
=VTom
-----END PGP SIGNATURE-----

--MGu/vTNewDGZ7tmp--
