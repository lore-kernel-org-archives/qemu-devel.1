Received: from eggs.gnu.org ([2001:4830:134:3::10]:45284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1eDCrb-0004Un-TC
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:13:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1eDCrX-0000Rq-SZ
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:13:07 -0500
Received: from mail-qt0-x22e.google.com ([2607:f8b0:400d:c0d::22e]:54176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1eDCrX-0000R3-Mc
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:13:03 -0500
Received: by mail-qt0-x22e.google.com with SMTP id n61so12608998qte.10
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:13:03 -0800 (PST)
Date: Fri, 10 Nov 2017 12:13:00 -0500
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20171110171300.GA30420@morn.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [ANNOUNCE] SeaBIOS 1.11.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seabios@seabios.org, qemu-devel@nongnu.org, coreboot@coreboot.org

The 1.11.0 version of SeaBIOS has now been released.  For more
information on the release, please see:

http://seabios.org/Releases


New in this release:

* Initial support for NVME drives
* Support for vga emulation over a serial port in SeaBIOS (sercon)
* Support for serial debugging using MMIO based serial ports
* Support for scsi devices with multiple LUNs
* Support for boot-to-boot persistent coreboot cbmem logs
* Improved coreboot vga (cbvga) mode setting compatibility
* Several bug fixes and code cleanups


For information on obtaining SeaBIOS, please see:

http://seabios.org/Download


===== git shortlog -n rel-1.10.0..rel-1.11.0 =====

Kevin O'Connor (28):
      usb: Make usb_time_sigatt variable static
      tpm: Add comment banners to tcg.c separating major parts of spec
      tpm: Don't call tpm_set_failure() from tpm12_get_capability()
      tpm: Move code around in tcgbios.c to keep like code together
      acpi: Generalize find_fadt() and find_tcpa_by_rsdp() into find_acpi_table()
      tpm: Don't call tpm_build_and_send_cmd() from tpm20_stirrandom()
      tpm: Rework tpm_build_and_send_cmd() into tpm_simple_cmd()
      ps2port: Disable keyboard/mouse prior to resetting ps2 controller
      docs: Note release dates for 1.10.1 and 1.10.2
      resume: Don't attempt to use generic reboot mechanisms on QEMU
      boot: Increase description size in boot menu
      src: Minor - remove tab characters that slipped into SeaBIOS C code
      NVMe: Allow NVMe to be enabled on real hardware
      smm: Backup and restore A20 on an SMI based mode switch
      stacks: Make sure to initialize Call16Data
      stacks: Don't update the A20 settings if they haven't changed
      stacks: There is no need to disable NMI if it is already disabled
      vga: Fix bug in stdvga_get_linesize()
      docs: Fix typos in Memory_Model.md
      tcgbios: Fix use of unitialized variable
      boot: Rename drive_g to drive
      disk: Don't require the 'struct drive_s' to be in the f-segment
      block: Rename disk_op_s->drive_gf to drive_fl
      virtio: Allocate drive_s storage in low memory
      xhci: Build TRBs directly in xhci_trb_queue()
      xhci: Verify the device is still present in xhci_cmd_submit()
      timer: Avoid integer overflows in usec and nsec calculations
      docs: Note v1.11.0 release

Roman Kagan (11):
      blockcmd: accept only disks and CD-ROMs
      blockcmd: generic SCSI luns enumeration
      virtio-scsi: enumerate luns with REPORT LUNS
      esp-scsi: enumerate luns with REPORT LUNS
      usb-uas: enumerate luns with REPORT LUNS
      pvscsi: fix the comment about lun enumeration
      mpt-scsi: try to enumerate luns with REPORT LUNS
      lsi-scsi: reset in case of a serious problem
      lsi-scsi: try to enumerate luns with REPORT LUNS
      blockcmd: start REPORT_LUNS with the smallest buffer
      Revert "lsi-scsi: reset in case of a serious problem"

Gerd Hoffmann (8):
      usb: add hub portmap
      usb-xhci: use hub portmap
      std: add cp437 to unicode map
      kbd: make enqueue_key public, add ascii_to_keycode
      romfile: add support for constant files.
      paravirt: serial console configuration.
      add serial console support
      sercon: Disable ScreenAndDebug in case both serial console and serial debug are active

Ben Warren (5):
      QEMU DMA: Add DMA write capability
      romfile-loader: Switch to using named structs
      QEMU fw_cfg: Add command to write back address of file
      QEMU fw_cfg: Add functions for accessing files by key
      QEMU fw_cfg: Write fw_cfg back on S3 resume

Daniel Verkamp (5):
      nvme: support NVMe 1.0 controllers
      nvme: extend command timeout to 5 seconds
      nvme: fix reversed loop condition in cmd_readwrite
      nvme: fix extraction of status code bits
      nvme: fix copy-paste mistake in comment

Patrick Rudolph (4):
      SeaVGABios/cbvga: Advertise correct pixel format
      SeaVGABIOS/vbe: Query driver for scanline pitch v2
      SeaVGABios/cbvga: Use active mode to clear screen
      SeaVGABios/cbvga: Advertise compatible VESA modes

Aleksandr Bezzubikov (3):
      pci: refactor pci_find_capapibilty to get bdf as the first argument instead of the whole pci_device
      pci: add QEMU-specific PCI capability structure
      pci: enable RedHat PCI bridges to reserve additional resources on PCI init

Julian Stecklina (2):
      block: add NVMe boot support
      nvme: fix out of memory behavior

Filippo Sironi (1):
      nvme: Use the Maximum Queue Entries Supported (MQES) to initialize I/O queues

Igor Mammedov (1):
      drop "etc/boot-cpus" fw_cfg file and reuse legacy QEMU_CFG_NB_CPUS

Jason Wang (1):
      virtio: IOMMU support

Julius Werner (1):
      coreboot: Adapt to upstream CBMEM console changes

Ladi Prosek (1):
      ahci: Set upper 32-bit registers to zero

Paul Menzel (1):
      vgasrc: Increase debug level

Petr Berky (1):
      config: Add function to check if fw_cfg exists

Ricardo Ribalda Delgado (1):
      serialio: Support for mmap serial ports

Stefan Berger (1):
      tpm: Log TPM 2 digest structure in little endian format

Youness Alaoui (1):
      nvme: Enable NVMe support for non-qemu hardware

Zeh, Werner (1):
      ahci: Disable Native Command Queueing
