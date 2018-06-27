Received: from eggs.gnu.org ([2001:4830:134:3::10]:45828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fY9mL-0003os-Rt
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fY9mK-00070O-Nv
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:42:33 -0400
Date: Wed, 27 Jun 2018 14:42:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180627124158.GC4340@localhost.localdomain>
References: <20180626142434.22090-1-kwolf@redhat.com>
	<20180627115801.GL5955@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
In-Reply-To: <20180627115801.GL5955@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] file-posix: Make
 truncate/preallocate asynchronous
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 27.06.2018 um 13:58 hat Stefan Hajnoczi geschrieben:
> On Tue, Jun 26, 2018 at 04:24:28PM +0200, Kevin Wolf wrote:
> > This fixes the problem that blockdev-create on a local file blocks the
> > main loop despite being a background job. This was caused by file-posix
> > preallocating the image with blocking syscalls rather than moving this
> > to the thread pool and yielding the coroutine meanwhile.
> >=20
> > v2:
> > - Add locking to qcow2_co_discard()
> > - Extra qcow2 fix and cleanup related to the locking code
> > - Use tracked requests infrastructure for serialising I/O requests
> >   against truncate in newly allocated areas
>=20
> Looks good!

Thanks for the review! Applied to my block branch.

Kevin

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbM4YtAAoJEH8JsnLIjy/WQeQP/iIlKa4JsIVRxPMo7ht8tQwD
lxUNyzG459SWOuL/ON7XkW1Sr/iAQjOU2hZQg2L9buCQRClpIsrp64uQBu4U/Z5E
/hQTnciwwvy23XVhPfJickLsgNnvamMTgZrr/pHl5BNqmLA4HQSPxMFy0MIjrW5B
0SfSkhf9etgSXsEmsLQ0X2BlUNearoYrzePHOU/VDe9jvTOMtdpqjO/rTkuowqFf
QlMmeOiCltym9bsAtgv1FVWhT/Q60aNQfCZhnzl0KFd/gXndDk5hhld0s/gzCLK1
2HFH6MdQvPXe2Hl3AzBA76PWT1dJTM9f+NJkMc7JESEJGI4F+jWfPH6OC/DNYQFh
7DRuXEnoGUxXmWpd4EAeXz3Ebd1X4QQkVd58QVKk9Ax3vejWvRpPcF6JzPoICbHV
nFJiDN9fgVMQK4aIw65MoIl793IEnOuL4Kr8DGuFIYqs/X+AUva4ljE8rg+vepq0
izqjg/pskEgVhzvPEtwNZBOasbAFE0Wblt8X07xPcqQS3jgDMti1W+FaJTAhhhSh
J4UaJuw9MjEzc66zo72jAOUCjhsN4CF0ILGpzzM3DCUUeOOQNkcz/XhX+OKxIrTR
urhW8ZQbv8gdqMkubX1H71F5EgeRBaGd+alRNFWrOp6lDjWSqS9poJN1BBPH/y9P
M5Oj0Co21Rg4ZqadTvcu
=m1Pb
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
