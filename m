Received: from eggs.gnu.org ([2001:4830:134:3::10]:35695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1gO4q9-0007qQ-F8
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 12:57:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1gO4q5-0000AS-Kb
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 12:57:05 -0500
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733]:40682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1gO4q2-00007D-St
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 12:56:59 -0500
Received: by mail-qk1-x733.google.com with SMTP id y16so42648265qki.7
	for <qemu-devel@nongnu.org>; Sat, 17 Nov 2018 09:56:56 -0800 (PST)
Date: Sat, 17 Nov 2018 12:56:53 -0500
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20181117175653.GA6175@morn.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [ANNOUNCE] SeaBIOS 1.12.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seabios@seabios.org, qemu-devel@nongnu.org, coreboot@coreboot.org

The 1.12.0 version of SeaBIOS has now been released.  For more
information on the release, please see:

http://seabios.org/Releases


New in this release:

* Initial support for "TPM CRB" hardware
* Improved cdrom media reporting in the boot menu on QEMU
* Improved floppy support on real floppy hardware
* SeaVGABIOS support for QEMU "bochs-display" and QEMU "ramfb" displays
* Several bug fixes and code cleanups


For information on obtaining SeaBIOS, please see:

http://seabios.org/Download


===== git shortlog -n rel-1.11.0..rel-1.12.0 =====

Gerd Hoffmann (12):
      optionrom: enable non-vga display devices
      cbvga: factor out cbvga_setup_modes()
      qemu: add bochs-display support
      cbvga_setup_modes: use real mode number instead of 0x140
      cbvga_list_modes: don't list current mode twice
      cbvga_set_mode: disable clearmem in windows x86 emulator.
      bochs_display_setup: return error on failure
      pmm: use tmp zone on oom
      vgasrc: add allocate_pmm()
      qemu: add qemu ramfb support
      cbvga_set_mode: refine clear display logic
      pretty boot menu entry for cdrom drives

Nikolay Nikolov (11):
      floppy: Introduce the floppy_dor_read() function
      floppy: Introduce floppy_dor_mask()
      floppy: Introduce FLOPPY_DOR_XXX constants
      floppy: Preserve motor and drive sel bits when resetting the floppy controller
      floppy: Reset the floppy motor count in floppy_drive_pio()
      floppy: Use timer_check() in floppy_wait_irq()
      floppy: hold the DOR reset bit low for 4 microseconds, when resetting
      floppy: Execute a SPECIFY command after sensing the media type
      floppy: Support up to 4 floppy drives when turning on the floppy motor
      floppy: Wait for the floppy motor to reach a stable speed, after starting
      floppy: Send 4 sense interrupt commands during controller initialization

Kevin O'Connor (10):
      docs: Add sercon-port to Runtime_config.md documentation
      paravirt: Only enable sercon in NOGRAPHIC mode if no other console specified
      shadow: Don't invoke a shutdown on reboot unless in a reboot loop
      build: Use git describe --always
      docs: Update Download.md to use git clone via https
      ssdt: Fix building of legacy acpi tables on current iasl compiler
      docs: Update download file link
      sdcard: Increase SDHCI_POWER_ON_TIME to 5ms
      shadow: Rework bios copy code to prevent gcc array-bounds warning
      docs: Note v1.12.0 release

Stefan Berger (5):
      tpm: Add support for TPM2 ACPI table
      tpm: Wait for tpmRegValidSts flag on CRB interface before probing
      tpm: revert return values for successful/failed CRB probing
      tpm: when CRB is active, select, lock it, and check addresses
      tpm: Request access to locality 0

Marc-André Lureau (4):
      x86: add readq()
      tpm: generalize init_timeout()
      tpm: use get_tpm_version() callback
      tpm: add TPM CRB device support

Jing Liu (3):
      pci: fix the return value for truncated capability
      pci: clean up the debug message for pci capability found
      pci: recognize RH PCI legacy bridge resource reservation capability

Stephen Douthit (3):
      tpm: Refactor duplicated wait code in tis_wait_sts() & crb_wait_reg()
      tpm: Wait for interface startup when probing
      tpm: Handle unimplemented TIS_REG_IFACE_ID in tis_get_tpm_version()

Matt DeVillier (2):
      nvme: fix I/O queue length calculation overflow
      SeaVGABios/cbvga: Fix bpp for coreboot framebuffer

Marcel Apfelbaum (1):
      pci: fix 'io hints' capability for RedHat PCI bridges

Paul Menzel (1):
      docs/Download: Use more secure HTTPS URLs where possible

Shmuel Eiderman (1):
      pvscsi: Scan all 64 possible targets
