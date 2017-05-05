Received: from eggs.gnu.org ([2001:4830:134:3::10]:56777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6ege-0008Az-2u
	for qemu-devel@nongnu.org; Fri, 05 May 2017 10:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6ega-000833-3J
	for qemu-devel@nongnu.org; Fri, 05 May 2017 10:58:28 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:34636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d6egZ-00082p-Sa
	for qemu-devel@nongnu.org; Fri, 05 May 2017 10:58:24 -0400
Received: by mail-wr0-x244.google.com with SMTP id 6so953811wrb.1
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 07:58:23 -0700 (PDT)
Date: Fri, 5 May 2017 15:58:20 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170505145820.GC14316@stefanha-x1.localdomain>
References: <20170502133604.17735-1-cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qjNfmADvan18RZcF"
Content-Disposition: inline
In-Reply-To: <20170502133604.17735-1-cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PULL 00/12] next batch of s390x patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: peter.maydell@linaro.org, borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org


--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 02, 2017 at 03:35:52PM +0200, Cornelia Huck wrote:
> The following changes since commit 38bb54f323bf7c83496b6a044cfd28896e997a=
00:
>=20
>   replication: Make --disable-replication compile again (2017-04-28 16:50=
:16 +0100)
>=20
> are available in the git repository at:
>=20
>   git://github.com/cohuck/qemu tags/s390x-20170502
>=20
> for you to fetch changes up to 99efaa2696caaf6182958e27d553449674894b27:
>=20
>   hw/s390x/ipl: Fix crash with virtio-scsi-pci device (2017-05-02 15:08:5=
4 +0200)
>=20
> ----------------------------------------------------------------
> More s390x patches, this time boot related:
> - LOADPARM machine property, exposed to the guest via SCLP and
>   diagnose 308
> - Use LOADPARM in the s390-ccw bios to select a boot entry
> - Fix a crash in the ipl device code when a virtio-scsi-pci device
>   has been specified
>=20
> ----------------------------------------------------------------
>=20
> Cornelia Huck (1):
>   pc-bios/s390-ccw.img: update image
>=20
> Eugene (jno) Dvurechenski (2):
>   pc-bios/s390-ccw: Make ebcdic/ascii conversion public
>   pc-bios/s390-ccw: add boot entry selection to El Torito routine
>=20
> Farhan Ali (8):
>   hw/s390x: provide loadparm property for the machine
>   hw/s390x/ipl: enable LOADPARM in IPIB for a boot device
>   hw/s390x/sclp: update LOADPARM in SCP Info
>   util/qemu-config: Add loadparm to qemu machine_opts
>   pc-bios/s390-ccw: get LOADPARM stored in SCP Read Info
>   pc-bios/s390-ccw: provide a function to interpret LOADPARM value
>   pc-bios/s390-ccw: provide entry selection on LOADPARM for SCSI disk
>   pc-bios/s390-ccw: add boot entry selection for ECKD DASD
>=20
> Thomas Huth (1):
>   hw/s390x/ipl: Fix crash with virtio-scsi-pci device
>=20
>  hw/s390x/ipl.c                            |  39 ++++++++++++++++++++++++=
+++---
>  hw/s390x/ipl.h                            |   3 +++
>  hw/s390x/s390-virtio-ccw.c                |  37 ++++++++++++++++++++++++=
++++
>  hw/s390x/sclp.c                           |   9 +++++++
>  include/hw/s390x/s390-virtio-ccw.h        |   1 +
>  pc-bios/s390-ccw.img                      | Bin 26456 -> 26472 bytes
>  pc-bios/s390-ccw/Makefile                 |   2 +-
>  pc-bios/s390-ccw/bootmap.c                |  34 +++++++++++++++++-------=
--
>  pc-bios/s390-ccw/bootmap.h                |  24 +-----------------
>  pc-bios/s390-ccw/main.c                   |  38 ++++++++++++++++++++++++=
++++-
>  pc-bios/s390-ccw/s390-ccw.h               |  17 ++++++++++++-
>  pc-bios/s390-ccw/{sclp-ascii.c =3D> sclp.c} |  12 +++++++++
>  pc-bios/s390-ccw/sclp.h                   |   2 ++
>  util/qemu-config.c                        |   6 +++++
>  14 files changed, 184 insertions(+), 40 deletions(-)
>  rename pc-bios/s390-ccw/{sclp-ascii.c =3D> sclp.c} (87%)
>=20
> --=20
> 2.11.0
>=20
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--qjNfmADvan18RZcF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZDJMMAAoJEJykq7OBq3PI2hkH/0lMj5Y9zIkEGstk7sxCWRWr
/eiHfTR932ZMK8kgRdf3GZCjI6CNCaM6yQmxbvD7Ag4IR2pNQhA4YWD52vrtl/ol
5nYNETG4l3BKnT2dWcARxjUEFW0SdrhaRKmIrO6RVMXb6cRWc3T2vQ8iN2rl/A5W
sdKkJPheWD9hdofZanbjrqBCCaAwOjzAm/WNbTOwD5HAEPLYOjPEaULIJSCmmBki
QGExTD8Hoah19qUoM2k9vA6hzoHwnD677xPhWMn5rQlwNy/P7Hr2iY05w4+mX1Ae
RSxp4nJ1Me5XuseR/lgWuObRuN2bdyF34n5bD3fV5OiWVVnDw0RPS6jBviszIuU=
=pY9l
-----END PGP SIGNATURE-----

--qjNfmADvan18RZcF--
