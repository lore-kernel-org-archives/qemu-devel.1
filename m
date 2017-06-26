Received: from eggs.gnu.org ([2001:4830:134:3::10]:37953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dPWDg-0003mM-8Y
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dPWDb-0001Vu-A4
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:46:32 -0400
Date: Mon, 26 Jun 2017 16:46:23 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170626154623.GI29664@stefanha-x1.localdomain>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+PbGPm1eXpwOoWkI"
Content-Disposition: inline
In-Reply-To: <20170623124700.1389-1-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC v3 0/8] I/O Throtting
 block filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>


--+PbGPm1eXpwOoWkI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2017 at 03:46:52PM +0300, Manos Pitsidianakis wrote:
> This patch series adds a filter driver that uses the existing I/O throttle
> code. Throttle groups can be then created and managed with QOM.
>=20
> The 'remove legacy I/O throttling' patch replaces existing interface (com=
mand
> line, qmp, hmp) to use the throttle filter transparently so as to not bre=
ak
> backwards compatibility. The created throttle node is stored in a field in
> BlockBackendPublic so that the legacy interface can access it. The patch
> currently breaks test 129 which commits, mirrors and backups a device with
> legacy throttling options. I assume the internal throttling node affects =
this,
> so I'd like some advice on how to approach this.
>=20
> Test 139 could be updated to include the throttle driver though I'm not s=
ure if
> it's needed.
>=20
> I'm also not sure about the test I created for this (last patch).
>=20
> v2:=20
> - Move throttle group membership to ThrottleGroupMember struct
> v3:
> - add ThrottleGroup object
> - convert legacy interface to use the driver
> - add tests
>=20
>=20
> Manos Pitsidianakis (8):
>   block: move ThrottleGroup membership to ThrottleGroupMember
>   block: Add aio_context field in ThrottleGroupMember
>   block: add throttle block filter driver
>   block: convert ThrottleGroup to object with QOM
>   block: add BlockDevOptionsThrottle to QAPI
>   block: add options parameter to bdrv_new_open_driver()
>   block: remove legacy I/O throttling
>   block: add throttle block filter driver interface tests

Can BlockBackendPublic be removed now?  Since throttling only knows
about ThrottleGroupMember there may be no need for BlockBackendPublic
as a public struct anymore.  It's fields can be inlined inside
BlockBackend.

Stefan

--+PbGPm1eXpwOoWkI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZUSxPAAoJEJykq7OBq3PIt/sIALJ2N5P7sajcCgr+Fd28ls9m
OUozG0IplZKga1EnmApU6nvSiYd6O4Uoo6DVZ2l/wOaTglfe5IledMBE7Az+0bki
8sZ0fcyijBYambAK43biMgCtH5SLX70sAdomTUZk2OGkMxdptXX/JPg1OcmckeTx
632DuJGndksqcDQkS6bCA1P3bUrSYRRzoF8fLgiTA1pgpLNnFZqXo6R6Pbma4JYP
lxS0/s1ujv2Ntx7KJiLIYOxVc8WZWUiC2sluSihcfM1n53eZTL4cFIO5do6EHrUS
+3VYJ/6/TrIOBxD6rcLkIwx9s3eTYfara/+PC5ltXJ2cqo8w5x7SwnLNUFI8jDo=
=iKIj
-----END PGP SIGNATURE-----

--+PbGPm1eXpwOoWkI--
