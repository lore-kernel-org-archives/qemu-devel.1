Received: from eggs.gnu.org ([2001:4830:134:3::10]:49002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eYwMx-0003dB-Nr
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:03:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eYwMs-00060Z-RU
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:03:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eYwMs-0005z0-JG
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:03:14 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w09FxxJX103415
	for <qemu-devel@nongnu.org>; Tue, 9 Jan 2018 11:03:10 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fcvjawp5s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 11:03:09 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 9 Jan 2018 11:03:08 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <CAFEAcA-Mzyf2S3yW04LNVy7pAZ6gmzXo3aiFdPxrbWAAAX7N0Q@mail.gmail.com>
References: <20180108055348.20444-1-david@gibson.dropbear.id.au>
	<CAFEAcA_vmTqHdjL6QfKtn-Khg2RHBA7Vs3QxreXwe2J_7mhGAQ@mail.gmail.com>
	<20180109121653.GN2131@umbus.fritz.box>
	<CAFEAcA-Mzyf2S3yW04LNVy7pAZ6gmzXo3aiFdPxrbWAAAX7N0Q@mail.gmail.com>
Date: Tue, 09 Jan 2018 10:02:55 -0600
Message-Id: <151551377581.2579.2269090053428846143@sif>
Subject: Re: [Qemu-devel] [PULL 00/12] ppc-for-2.12 queue 20180108
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: surajjs@au1.ibm.com, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

Quoting Peter Maydell (2018-01-09 09:15:25)
> On 9 January 2018 at 12:16, David Gibson <david@gibson.dropbear.id.au> wr=
ote:
> > Thanks.  Even if you can identify which patch it is and we can
> > postpone that one would be a bug help.
> =

> Bisection blames this one:
> =

> pbonzini@redhat.com (1):
>       target-ppc: optimize cmp translation
> =

> A plain boot doesn't work either:
> ./build/ppc/ppc64-softmmu/qemu-system-ppc64 -display none -serial stdio
> =

> =

> SLOF ********************************************************************=
**
> QEMU Starting
>  Build Date =3D Jul 24 2017 15:15:46
>  FW Version =3D git-89f519f09bf85091
>  Press "s" to enter Open Firmware.
> =

> Populating /vdevice methods
> Populating /vdevice/vty@71000000
> Populating /vdevice/nvram@71000001
> Populating /vdevice/l-lan@71000002
> Populating /vdevice/v-scsi@71000003
>        SCSI: Looking for devices
>           00000000 CD-ROM   : "QEMU     QEMU CD-ROM      2.5+"
> =

> Populating /pci@0000000
>                      00 0000 (D) : 1234 1111    qemu vga
>                      00 0800 (D) : 1033 0194    serial bus [ usb-xhci ]
> No NVRAM common partition, re-initializing...
> E
> =

> and then keeps printing out spaces for ever as far as I can see.
> =

> A working build does
> =

> =

> SLOF ********************************************************************=
**
> QEMU Starting
>  Build Date =3D Jul 24 2017 15:15:46
>  FW Version =3D git-89f519f09bf85091
>  Press "s" to enter Open Firmware.
> =

> Populating /vdevice methods
> Populating /vdevice/vty@71000000
> Populating /vdevice/nvram@71000001
> Populating /vdevice/l-lan@71000002
> Populating /vdevice/v-scsi@71000003
>        SCSI: Looking for devices
>           8200000000000000 CD-ROM   : "QEMU     QEMU CD-ROM      2.5+"
> Populating /pci@800000020000000
>                      00 0000 (D) : 1234 1111    qemu vga
>                      00 0800 (D) : 1033 0194    serial bus [ usb-xhci ]
> No NVRAM common partition, re-initializing...
> Installing QEMU fb
> =

> =

> =

> Scanning USB
>   XHCI: Initializing
>     USB Keyboard
>     USB mouse
> No console specified using screen & keyboard
> =

> [etc etc]
> =

> so you can see it's already diverged because it prints out
> a different value for the name of the pci node and the
> SCSI line has 8200000000000000 vs 00000000.

FYI I actually see this with a raspberry pi 3 too, with repeating spaces
as well. I didn't notice it before since in my case the
ufd_version_check() in test-migration.c was failing so the migration tests
were reporting success but were actually just getting skipped.

> =

> (This is a build for arm32, running in a chroot on an aarch64
> box, non-debug build.)
> =

> thanks
> -- PMM
>=20
