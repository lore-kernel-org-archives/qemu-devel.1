Received: from eggs.gnu.org ([2001:4830:134:3::10]:40285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cwVFa-0004mh-BK
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:52:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cwVFX-0003HT-49
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:52:34 -0400
Date: Fri, 7 Apr 2017 15:52:27 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170407145227.GM16146@stefanha-x1.localdomain>
References: <20170406190847.29347-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S66JdqtemGhvbcZP"
Content-Disposition: inline
In-Reply-To: <20170406190847.29347-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.9] throttle: Remove
 block from group on hot-unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--S66JdqtemGhvbcZP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 06, 2017 at 02:08:47PM -0500, Eric Blake wrote:
> When a block device that is part of a throttle group is hot-unplugged,
> we forgot to remove it from the throttle group. This leaves stale
> memory around, and causes an easily reproducible crash:
>=20
> $ ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdio \
> -device virtio-scsi-pci,bus=3Dpci.0 -drive \
> id=3Ddrive_image2,if=3Dnone,format=3Draw,file=3Dfile2,bps=3D512000,iops=
=3D100,group=3Dfoo \
> -device scsi-hd,id=3Dimage2,drive=3Ddrive_image2 -drive \
> id=3Ddrive_image3,if=3Dnone,format=3Draw,file=3Dfile3,bps=3D512000,iops=
=3D100,group=3Dfoo \
> -device scsi-hd,id=3Dimage3,drive=3Ddrive_image3
> {'execute':'qmp_capabilities'}
> {'execute':'device_del','arguments':{'id':'image3'}}
> {'execute':'system_reset'}
>=20
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1428810
>=20
> Suggested-by: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/block-backend.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--S66JdqtemGhvbcZP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY56erAAoJEJykq7OBq3PIV+sIAKvSYkFaTnmLtnghPnnvoTYe
VI8UPMCDxHwzTrVk90bDOpUcRManbcQ3goMRybqJqUpheBQxnwELckpYPBZq1s7i
UOGtsg11AvKFBnoIia8nxHFpFR7u0PKKEcnmBUm7DJXxPrg3eFEpv9L+C/TVUJpQ
OJ0hs/951cOK1u9QXBdUSOywjv1bku5t525YL5S8EBPzJkJymr/7qiA5yy5jpJLp
/6vJxCNwvbEpJoAR70HlbFqLTXT+el7eQo57q1pkTqM7CKWk+XqT47xaRqbMtvaz
v1262ljsPYt82fRtrzPNSt4pM/7eP/FCzgzS8d2yBeUjdOkuhwTouGN4zljUiow=
=WpYr
-----END PGP SIGNATURE-----

--S66JdqtemGhvbcZP--
