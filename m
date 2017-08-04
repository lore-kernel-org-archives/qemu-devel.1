Received: from eggs.gnu.org ([2001:4830:134:3::10]:47920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ddZoZ-0004Wo-3D
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 06:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ddZoY-0001Uj-0z
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 06:26:43 -0400
Date: Fri, 4 Aug 2017 12:20:34 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170804102034.GB4108@localhost.localdomain>
References: <20170803150301.10177-1-kwolf@redhat.com>
	<20170803150301.10177-3-kwolf@redhat.com>
	<8dfbc0ca-9a02-3620-d9e5-41aadee69d52@redhat.com>
	<a7a5e25c-fef4-d508-4a9c-ff2d57c1b2ee@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <a7a5e25c-fef4-d508-4a9c-ff2d57c1b2ee@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/5] block: Allow reopen rw
 without BDRV_O_ALLOW_RDWR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 04.08.2017 um 03:49 hat Eric Blake geschrieben:
> On 08/03/2017 10:21 AM, Eric Blake wrote:
> > On 08/03/2017 10:02 AM, Kevin Wolf wrote:
> >> BDRV_O_ALLOW_RDWR is a flag that tells whether qemu can internally
> >> reopen a node read-write temporarily because the user requested
> >> read-write for the top-level image, but qemu decided that read-only is
> >> enough for this node (a backing file).
> >>
> >> bdrv_reopen() is different, it is also used for cases where the user
> >> changed their mind and wants to update the options. There is no reason
> >> to forbid making a node read-write in that case.
> >=20
> > Hmm, I wonder.  https://bugzilla.redhat.com/show_bug.cgi?id=3D1465320
> > details a failure when starting qemu with a read-write NBD disk, then
> > taking several snapshots (nbd <- snap1 <- snap2 <- snap3), then where
> > intermediate commit (snap2 into nbd) works but live commit (snap3 into
> > nbd) fails with a message that nbd does not support reopening.  I'm
> > presuming that your series may help to address that; I'll give it a spin
> > and see what happens.
>=20
> Nope, even with your patches, I'm still getting:
>=20
> {'execute':'block-commit','arguments':{'device':'drive-image1','top':'bar=
2'}}
> {"return": {}}
> {"timestamp": {"seconds": 1501811285, "microseconds": 439748}, "event":
> "BLOCK_JOB_COMPLETED", "data": {"device": "drive-image1", "len":
> 2097152, "offset": 2097152, "speed": 0, "type": "commit"}}
>=20
> {'execute':'block-commit','arguments':{'device':'drive-image1','top':'bar=
3'}}
> {"error": {"class": "GenericError", "desc": "Block format 'nbd' used by
> node '#block048' does not support reopening files"}}

That's simply NBD not implementing .bdrv_reopen_*. In other words, not a
bug, but just a missing feature.

Kevin

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZhEpyAAoJEH8JsnLIjy/WM3MP/3oeNNMV9E58iXu/sKmxWUa7
r1UVfKpAGDLwXxzToF1RVK8qSnwGvb/tIi89tpY0lPOPmiHb5dt4nbtKWgeA+W/Y
D5oheJcazcIxPdPaxHefsBTw8e5V1HStDPPr6yC4y9qtNEx/duwZCgsL3dmrHjD8
VwrKL+EaTF4hfCk92L60hzlnxsSu1MsWq4debJcBrlAZvH/n8wrKNwp/vSrn3gJg
YlOD+UwU5yH8G6zxT2nqTlHOJDfwJ8ko9yurfdQmRDTgFY7B8w0FbJ6uYjWvca2+
3NsBuF8wiIRG+mePUBpRYYUtr1+UAoYU1U+z2FioKHOBsj9grIgWoEtySK8zCDSS
RxX0u0L6MvzEux73dMCXIZYzAaCEbaXy5eRhlCmzZ6p6eD+LHzrWWYUs+c1cW3cI
JP7uY6OelXlRjEhnBfSw2E+T0qqpiowglswYx1MCzYI5PxGLrXzqqELLdtDlOk3V
iKi7S4PsgPoXWvPodqEmDzo9tdTrhVDPFmQskk8iZ3V8FTH9X9itKtYVJwkSTd10
+74mo1uYs+jm0oM5UHHFp4zA4/YOKjPNzc+4e7fV3z8xiQ6Mx8Z2WGs/8AAVldfe
a+P5Ype1ujnu4kdD8w21tLUrZEVPMe9iX+SyCxC7eUtGy1ijaM1gA6oMmzDP8Sdj
aaPoXaKnDYE3yLqWkR89
=1yzK
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
