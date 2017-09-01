Received: from eggs.gnu.org ([2001:4830:134:3::10]:35151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1dnvHG-0002aI-3m
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 19:23:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1dnvHC-0002yB-W7
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 19:23:06 -0400
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <150420240019.3063.7604695454722520315@loki>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<150420240019.3063.7604695454722520315@loki>
Message-ID: <150430817105.14429.17528343463628373147@loki>
Date: Fri, 01 Sep 2017 18:22:51 -0500
Subject: Re: [Qemu-devel] [PATCH 00/79] Patch Round-up for stable 2.9.1,
 freeze on 2017-09-04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

Quoting Michael Roth (2017-08-31 13:00:00)
> Quoting Michael Roth (2017-08-28 19:13:35)
> > Hi everyone,
> > =

> > The following new patches are queued for QEMU stable v2.9.1:
> > =

> >   https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_mdr=
oth_qemu_commits_stable-2D2.9-2Dstaging&d=3DDwIFaQ&c=3Djf_iaSHvJObTbx-siA1Z=
Og&r=3DsThPI1c0u5x-3sg5Nw8wNqjg_5Z5xLzfPGC18E94zn8&m=3Dhoyg_NnavbPJKZEF_zct=
-EdpBD-Nb3rhYLms_7k54A4&s=3Ddc2xpZH9f2d88cyYQblkq-w_a99BSN8i6ypQkAYf5Pw&e=
=3D =

> =

> Thank you for the recommendations. Branch updated with the following
> additional patches:
> =

>  s390-ccw: Fix alignment for CCW1
>  vnc: Set default kbd delay to 10ms
>  qemu-nbd: Ignore SIGPIPE
>  usb-redir: fix stack overflow in usbredir_log_data
>  megasas: do not read SCSI req parameters more than once from frame
>  megasas: do not read command more than once from frame
>  megasas: do not read DCMD opcode more than once from frame
>  megasas: do not read iovec count more than once from frame
>  megasas: do not read sense length more than once from frame
>  9pfs: local: forbid client access to metadata (CVE-2017-7493)
>  scsi: avoid an off-by-one error in megasas_mmio_write
>  audio: release capture buffers
>  vmw_pvscsi: check message ring page count at initialisation
>  hw/ppc/spapr_iommu: Fix crash when removing the "spapr-tce-table" device
>  hw/ppc/spapr_rtc: Mark the RTC device with user_creatable =3D false
>  qdev: Replace cannot_instantiate_with_device_add_yet with !user_creatable
>  fix qemu-system-unicore32 crashing when calling without -kernel
>  hw/s390x/ipl: Fix crash with virtio-scsi-pci device
>  slirp: fix clearing ifq_so from pending packets
>  slirp: tftp, copy sockaddr_size
>  monitor: Check whether TCG is enabled before running the "info jit" code
>  target-s390x: Mask the SIGP order_code to 8bit.
> =


Branch updated with the following additional patches:

  exec: Add lock parameter to qemu_ram_ptr_length
  xen/mapcache: store dma information in revmapcache entries for debugging
  exec: use qemu_ram_ptr_length to access guest ram
  xhci: only update dequeue ptr on completed transfers
  vl.c/exit: pause cpus before closing block devices
  PPC: E500: update u-boot to match shipped binary

>=20
