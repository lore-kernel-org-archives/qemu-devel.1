Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009EEC388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:30:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E81FC2463F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVaR65QG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E81FC2463F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVdTm-0003Uj-Vx
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 12:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kVdSU-0002tw-QX
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 12:28:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54640)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kVdSP-00057f-8m
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 12:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603384131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=p7r5PdrSLhLRPpmTiQ7r/eEggD2eY/gAUmvvdc192ZY=;
 b=eVaR65QGh9e18mhJMGIf+zAwUfDqRjUktUiTwr1+IyTYOZcohK/QrZodMnqJ/koTE1+VV1
 E0/EkyCyYCFKJyzRduUDbrXFkUBM2d0s1gRXRx47n31A/a5sYSUES510yRoQmtFGKzpjY9
 NTF8CWMokTSFlnOYe8FLXwkQY5EpkCs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-PE5sxqazOi2YkRECJWwyew-1; Thu, 22 Oct 2020 12:28:46 -0400
X-MC-Unique: PE5sxqazOi2YkRECJWwyew-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69664186DD28;
 Thu, 22 Oct 2020 16:28:45 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-13.rdu2.redhat.com [10.10.119.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 389846EF42;
 Thu, 22 Oct 2020 16:28:44 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] CHANGELOG: remove disused file
Date: Thu, 22 Oct 2020 12:28:43 -0400
Message-Id: <20201022162843.1841780-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:09:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There's no reason to keep this here; the versions described are
ancient. Everything here is still mirrored on
https://wiki.qemu.org/ChangeLog/old if anyone is curious; otherwise, use
the git history.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 Changelog | 580 ------------------------------------------------------
 1 file changed, 580 deletions(-)
 delete mode 100644 Changelog

diff --git a/Changelog b/Changelog
deleted file mode 100644
index f7e178ccc01..00000000000
--- a/Changelog
+++ /dev/null
@@ -1,580 +0,0 @@
-This file documents changes for QEMU releases 0.12 and earlier.
-For changelog information for later releases, see
-https://wiki.qemu.org/ChangeLog or look at the git history for
-more detailed information.
-
-
-version 0.12.0:
-
-  - Update to SeaBIOS 0.5.0
-  - e1000: fix device link status in Linux (Anthony Liguori)
-  - monitor: fix QMP for balloon command (Luiz Capitulino)
-  - QMP: Return an empty dict by default (Luiz Capitulino)
-  - QMP: Only handle converted commands (Luiz Capitulino)
-  - pci: support PCI based option rom loading (Gerd Hoffman/Anthony Liguori)
-  - Fix backcompat for hotplug of SCSI controllers (Daniel P. Berrange)
-  - fdc: fix migration from 0.11 (Juan Quintela)
-  - vmware-vga: fix segv on cursor resize. (Dave Airlie)
-  - vmware-vga: various fixes (Dave Airlie/Anthony Liguori)
-  - qdev: improve property error reporting. (Gerd Hoffmann)
-  - fix vga names in default_list (Gerd Hoffmann)
-  - usb-host: check mon before using it. (Gerd Hoffmann)
-  - usb-net: use qdev for -usbdevice (Gerd Hoffmann)
-  - monitor: Catch printing to non-existent monitor (Luiz Capitulino)
-  - Avoid permanently disabled QEMU monitor when UNIX migration fails (Daniel P. Berrange)
-  - Fix loading of ELF multiboot kernels (Kevin Wolf)
-  - qemu-io: Fix memory leak (Kevin Wolf)
-  - Fix thinko in linuxboot.S (Paolo Bonzini)
-  - target-i386: Fix evaluation of DR7 register (Jan Kiszka)
-  - vnc: hextile: do not generate ForegroundSpecified and SubrectsColoured tiles (Anthony Liguori)
-  - S390: Bail out without KVM (Alexander Graf)
-  - S390: Don't tell guest we're updating config space (Alexander Graf)
-  - target-s390: Fail on unknown instructions (Alexander Graf)
-  - osdep: Fix runtime failure on older Linux kernels (Andre Przywara)
-  - Fix a make -j race (Juergen Lock)
-  - target-alpha: Fix generic ctz64. (Richard Henderson)
-  - s390: Fix buggy assignment (Stefan Weil)
-  - target-mips: fix user-mode emulation startup (Nathan Froyd)
-  - target-i386: Update CPUID feature set for TCG (Andre Przywara)
-  - s390: fix build on 32 bit host (Michael S. Tsirkin)
-	
-version 0.12.0-rc2:
-
-  - v2: properly save kvm system time msr registers (Glauber Costa)
-  - convert more monitor commands to qmp (Luiz Capitulino)
-  - vnc: fix capslock tracking logic. (Gerd Hoffmann)
-  - QemuOpts: allow larger option values. (Gerd Hoffmann)
-  - scsi: fix drive hotplug. (Gerd Hoffmann)
-  - pci: don't hw_error() when no slot is available. (Gerd Hoffmann)
-  - pci: don't abort() when trying to hotplug with acpi off. (Gerd Hoffmann)
-  - allow default devices to be implemented in config file (Gerd Hoffman)
-  - vc: colorize chardev title line with blue background. (Gerd Hoffmann)
-  - chardev: make chardevs specified in config file work. (Gerd Hoffmann)
-  - qdev: also match bus name for global properties (Gerd Hoffmann)
-  - qdev: add command line option to set global defaults for properties. (Gerd Hoffmann)
-  - kvm: x86: Save/restore exception_index (Jan Kiszka)
-  - qdev: Replace device names containing whitespace (Markus Armbruster)
-  - fix rtc-td-hack on host without high-res timers (Gleb Natapov)
-  - virtio: verify features on load (Michael S. Tsirkin)
-  - vmware_vga: add rom file so that it boots. (Dave Airlie)
-  - Do not abort on qemu_malloc(0) in production builds (Anthony Liguori)
-  - Fix ARM userspace strex implementation. (Paul Brook)
-  - qemu: delete rule target on error (Michael S. Tsirkin)
-  - QMP: add human-readable description to error response (Markus Armbruster)
-  - convert more monitor commands to QError (Markus Armbruster)
-  - monitor: Fix double-prompt after "change vnc passwd BLA" (Markus Armbruster)
-  - monitor: do_cont(): Don't ask for passwords (Luiz Capitulino)
-  - monitor: Introduce 'block_passwd' command (Luiz Capitulino)
-  - pci: interrupt disable bit support (Michael S. Tsirkin)
-  - pci: interrupt status bit implementation (Michael S. Tsirkin)
-  - pci: prepare irq code for interrupt state (Michael S. Tsirkin)
-  - msix: function mask support (Michael S. Tsirkin)
-  - msix: macro rename for function mask support (Michael S. Tsirkin)
-  - cpuid: Fix multicore setup on Intel (Andre Przywara)
-  - kvm: x86: Fix initial kvm_has_msr_star (Jan Kiszka)
-  - Update OpenBIOS images to r640 (Aurelien Jarno)	
-
-version 0.10.2:
-
-  - fix savevm/loadvm (Anthony Liguori)
-  - live migration: fix dirty tracking windows (Glauber Costa)
-  - live migration: improve error propagation (Glauber Costa)
-  - qcow2: fix image creation for > ~2TB images (Chris Wright)
-  - hotplug: fix error handling for if= parameter (Eduardo Habkost)
-  - qcow2: fix data corruption (Nolan Leake)
-  - virtio: fix guest oops with 2.6.25 kernels (Rusty Russell)
-  - SH4: add support for -kernel (Takashi Yoshii, Aurelien Jarno)
-  - hotplug: fix closing of char devices (Jan Kiszka)
-  - hotplug: remove incorrect check for device name (Eduardo Habkost)
-  - enable -k on win32 (Herve Poussineau)
-  - configure: use LANG=C for grep (Andreas Faerber)
-  - fix VGA regression (malc)
-	
-version 0.10.1:
-
-  - virtio-net: check right return size on sg list (Alex Williamson)
-  - Make qemu_announce_self handle holes (live migration after hotplug)
-    (Marcelo Tosatti)
-  - Revert r6804-r6808 (qcow2 allocation info).  This series of changes added
-    a high cost to startup for large qcow2 images (Anthony Liguori)
-  - qemu-img: fix help message (Aurelien Jarno)
-  - Fix build for non-default installs of SDL (Anthony Liguori)
-  - Fix race condition in env->interrupt_request.  When using TCG and a dynticks
-    host timer, this condition could cause TCG to get stuck in an infinite
-    loop (Aurelien Jarno)
-  - Fix reading encrypted hard disk passwords during early startup (Jan Kiszka)
-  - Fix encrypted disk reporting in 'info block' (Jan Kiszka)
-  - Fix console size with tiny displays (MusicPal) (Jan Kiszka)
-  - Improve error handling in bdrv_open2 (Jan Kiszka)
-  - Avoid leaking data in mux'ed character devices (Jan Kiszka)
-  - Fix initial character device reset (no banner in monitor) (Jan Kiszka)
-  - Fix cpuid KVM crash on i386 host (Lubomir Rintel)
-  - Fix SLES10sp2 installation by adding ISTAT1 register to LSI SCSI emulation
-    (Ryan Harper)
-
-version 0.10.0:
-
-  - TCG support (No longer requires GCC 3.x)
-  - Kernel Virtual Machine acceleration support
-  - BSD userspace emulation
-  - Bluetooth emulation and host passthrough support
-  - GDB XML register description support
-  - Intel e1000 emulation
-  - HPET emulation
-  - VirtIO paravirtual device support
-  - Marvell 88w8618 / MusicPal emulation
-  - Nokia N-series tablet emulation / OMAP2 processor emulation
-  - PCI hotplug support
-  - Live migration and new save/restore formats
-  - Curses display support
-  - qemu-nbd utility to mount supported block formats
-  - Altivec support in PPC emulation and new firmware (OpenBIOS)
-  - Multiple VNC clients are now supported
-  - TLS encryption is now supported in VNC
-  - MIPS Magnum R4000 machine (Hervé Poussineau)
-  - Braille support (Samuel Thibault)
-  - Freecom MusicPal system emulation (Jan Kiszka)
-  - OMAP242x and Nokia N800, N810 machines (Andrzej Zaborowski)
-  - EsounD audio driver (Frederick Reeve)
-  - Gravis Ultrasound GF1 sound card (Tibor "TS" Schütz)
-  - Many, many, bug fixes and new features
-
-version 0.9.1:
-
-  - TFTP booting from host directory (Anthony Liguori, Erwan Velu)
-  - Tap device emulation for Solaris (Sittichai Palanisong)
-  - Monitor multiplexing to several I/O channels (Jason Wessel)
-  - ds1225y nvram support (Herve Poussineau)
-  - CPU model selection support (J. Mayer, Paul Brook, Herve Poussineau)
-  - Several Sparc fixes (Aurelien Jarno, Blue Swirl, Robert Reif)
-  - MIPS 64-bit FPU support (Thiemo Seufer)
-  - Xscale PDA emulation (Andrzej Zaborowski)
-  - ColdFire system emulation (Paul Brook)
-  - Improved SH4 support (Magnus Damm)
-  - MIPS64 support (Aurelien Jarno, Thiemo Seufer)
-  - Preliminary Alpha guest support (J. Mayer)
-  - Read-only support for Parallels disk images (Alex Beregszaszi)
-  - SVM (x86 virtualization) support (Alexander Graf)
-  - CRIS emulation (Edgar E. Iglesias)
-  - SPARC32PLUS execution support (Blue Swirl)
-  - MIPS mipssim pseudo machine (Thiemo Seufer)
-  - Strace for Linux userland emulation (Stuart Anderson, Thayne Harbaugh)
-  - OMAP310 MPU emulation plus Palm T|E machine (Andrzej Zaborowski)
-  - ARM v6, v7, NEON SIMD and SMP emulation (Paul Brook/CodeSourcery)
-  - Gumstix boards: connex and verdex emulation (Thorsten Zitterell)
-  - Intel mainstone II board emulation (Armin Kuster)
-  - VMware SVGA II graphics card support (Andrzej Zaborowski)
-
-version 0.9.0:
-
-  - Support for relative paths in backing files for disk images
-  - Async file I/O API
-  - New qcow2 disk image format
-  - Support of multiple VM snapshots
-  - Linux: specific host CDROM and floppy support
-  - SMM support
-  - Moved PCI init, MP table init and ACPI table init to Bochs BIOS
-  - Support for MIPS32 Release 2 instruction set (Thiemo Seufer)
-  - MIPS Malta system emulation (Aurelien Jarno, Stefan Weil)
-  - Darwin userspace emulation (Pierre d'Herbemont)
-  - m68k user support (Paul Brook)
-  - several x86 and x86_64 emulation fixes
-  - Mouse relative offset VNC extension (Anthony Liguori)
-  - PXE boot support (Anthony Liguori)
-  - '-daemonize' option (Anthony Liguori)
-
-version 0.8.2:
-
-  - ACPI support
-  - PC VGA BIOS fixes
-  - switch to OpenBios for SPARC targets (Blue Swirl)
-  - VNC server fixes
-  - MIPS FPU support (Marius Groeger)
-  - Solaris/SPARC host support (Juergen Keil)
-  - PPC breakpoints and single stepping (Jason Wessel)
-  - USB updates (Paul Brook)
-  - UDP/TCP/telnet character devices (Jason Wessel)
-  - Windows sparse file support (Frediano Ziglio)
-  - RTL8139 NIC TCP segmentation offloading (Igor Kovalenko)
-  - PCNET NIC support (Antony T Curtis)
-  - Support for variable frequency host CPUs
-  - Workaround for win32 SMP hosts
-  - Support for AMD Flash memories (Jocelyn Mayer)
-  - Audio capture to WAV files support (malc)
-
-version 0.8.1:
-
-  - USB tablet support (Brad Campbell, Anthony Liguori)
-  - win32 host serial support (Kazu)
-  - PC speaker support (Joachim Henke)
-  - IDE LBA48 support (Jens Axboe)
-  - SSE3 support
-  - Solaris port (Juergen Keil)
-  - Preliminary SH4 target (Samuel Tardieu)
-  - VNC server (Anthony Liguori)
-  - slirp fixes (Ed Swierk et al.)
-  - USB fixes
-  - ARM Versatile Platform Baseboard emulation (Paul Brook)
-
-version 0.8.0:
-
-  - ARM system emulation: Arm Integrator/CP board with an arm1026ej-s
-    cpu (Paul Brook)
-  - SMP support
-  - Mac OS X cocoa improvements (Mike Kronenberg)
-  - Mac OS X CoreAudio driver (Mike Kronenberg)
-  - DirectSound driver (malc)
-  - ALSA audio driver (malc)
-  - new audio options: '-soundhw' and '-audio-help' (malc)
-  - ES1370 PCI audio device (malc)
-  - Initial USB support
-  - Linux host serial port access
-  - Linux host low level parallel port access
-  - New network emulation code supporting VLANs.
-  - MIPS and MIPSel User Linux emulation
-  - MIPS fixes to boot Linux (Daniel Jacobowitz)
-  - NX bit support
-  - Initial SPARC SMP support (Blue Swirl)
-  - Major overhaul of the virtual FAT driver for read/write support
-    (Johannes Schindelin)
-
-version 0.7.2:
-
-  - x86_64 fixes (Win2000 and Linux 2.6 boot in 32 bit)
-  - merge self modifying code handling in dirty ram page mechanism.
-  - MIPS fixes (Ralf Baechle)
-  - better user net performances
-
-version 0.7.1:
-
-  - read-only Virtual FAT support (Johannes Schindelin)
-  - Windows 2000 install disk full hack (original idea from Vladimir
-    N. Oleynik)
-  - VMDK disk image creation (Filip Navara)
-  - SPARC64 progress (Blue Swirl)
-  - initial MIPS support (Jocelyn mayer)
-  - MIPS improvements (Ralf Baechle)
-  - 64 bit fixes in user networking (initial patch by Gwenole Beauchesne)
-  - IOAPIC support (Filip Navara)
-
-version 0.7.0:
-
-  - better BIOS translation and HDD geometry auto-detection
-  - user mode networking bug fix
-  - undocumented FPU ops support
-  - Cirrus VGA: support for 1280x1024x[8,15,16] modes
-  - 'pidfile' option
-  - .dmg disk image format support (Johannes Schindelin)
-  - keymaps support (initial patch by Johannes Schindelin)
-  - big endian ARM support (Lennert Buytenhek)
-  - added generic 64 bit target support
-  - x86_64 target support
-  - initial APIC support
-  - MMX/SSE/SSE2/PNI support
-  - PC parallel port support (Mark Jonckheere)
-  - initial SPARC64 support (Blue Swirl)
-  - SPARC target boots Linux (Blue Swirl)
-  - armv5te user mode support (Paul Brook)
-  - ARM VFP support (Paul Brook)
-  - ARM "Angel" semihosting syscalls (Paul Brook)
-  - user mode gdb stub support (Paul Brook)
-  - Samba 3 support
-  - initial Cocoa support (Pierre d'Herbemont)
-  - generic FPU emulation code
-  - Virtual PC read-only disk image support (Alex Beregszaszi)
-
-version 0.6.1:
-
-  - Mac OS X port (Pierre d'Herbemont)
-  - Virtual console support
-  - Better monitor line edition
-  - New block device layer
-  - New 'qcow' growable disk image support with AES encryption and
-    transparent decompression
-  - VMware 3 and 4 read-only disk image support (untested)
-  - Support for up to 4 serial ports
-  - TFTP server support (Magnus Damm)
-  - Port redirection support in user mode networking
-  - Support for not executable data sections
-  - Compressed loop disk image support (Johannes Schindelin)
-  - Level triggered IRQ fix (aka NE2000 PCI performance fix) (Steve
-    Wormley)
-  - Fixed Fedora Core 2 problems (now you can run qemu without any
-    LD_ASSUME_KERNEL tricks on FC2)
-  - DHCP fix for Windows (accept DHCPREQUEST alone)
-  - SPARC system emulation (Blue Swirl)
-  - Automatic Samba configuration for host file access from Windows.
-  - '-loadvm' and '-full-screen' options
-  - ne2000 savevm support (Johannes Schindelin)
-  - Ctrl-Alt is now the default grab key. Ctrl-Alt-[0-9] switches to
-    the virtual consoles.
-  - BIOS floppy fix for NT4 (Mike Nordell, Derek Fawcus, Volker Ruppert)
-  - Floppy fixes for NT4 and NT5 (Mike Nordell)
-  - NT4 IDE fixes (Ben Pfaf, Mike Nordell)
-  - SDL Audio support and SB16 fixes (malc)
-  - ENTER instruction bug fix (initial patch by Stefan Kisdaroczi)
-  - VGA font change fix
-  - VGA read-only CRTC register fix
-
-version 0.6.0:
-
-  - minimalist FPU exception support (NetBSD FPU probe fix)
-  - cr0.ET fix (Win95 boot)
-  - *BSD port (Markus Niemisto)
-  - I/O access fix (signaled by Mark Jonckheere)
-  - IDE drives serial number fix (Mike Nordell)
-  - int13 CDROM BIOS fix (aka Solaris x86 install CD fix)
-  - int15, ah=86 BIOS fix (aka Solaris x86 hardware probe hang up fix)
-  - BSR/BSF "undefined behaviour" fix
-  - vmdk2raw: convert VMware disk images to raw images
-  - PCI support
-  - NE2K PCI support
-  - dummy VGA PCI support
-  - VGA font selection fix (Daniel Serpell)
-  - PIC reset fix (Hidemi KAWAI)
-  - PIC spurious irq support (aka Solaris install bug)
-  - added '-localtime' option
-  - Cirrus CL-GD54xx VGA support (initial patch by Makoto Suzuki (suzu))
-  - APM and system shutdown support
-  - Fixed system reset
-  - Support for other PC BIOSes
-  - Initial PowerMac hardware emulation
-  - PowerMac/PREP OpenFirmware compatible BIOS (Jocelyn Mayer)
-  - initial IDE BMDMA support (needed for Darwin x86)
-  - Set the default memory size for PC emulation to 128 MB
-
-version 0.5.5:
-
-  - SDL full screen support (initial patch by malc)
-  - VGA support on PowerPC PREP
-  - VBE fixes (Matthew Mastracci)
-  - PIT fixes (aka Win98 hardware probe and "VGA slowness" bug)
-  - IDE master only fixes (aka Win98 CD-ROM probe bug)
-  - ARM load/store half word fix (Ulrich Hecht)
-  - FDC fixes for Win98
-
-version 0.5.4:
-
-  - qemu-fast fixes
-  - BIOS area protection fix (aka EMM386.EXE fix) (Mike Nordell)
-  - keyboard/mouse fix (Mike Nordell)
-  - IDE fixes (Linux did not recognized slave drivers)
-  - VM86 EIP masking fix (aka NT5 install fix) (Mike Nordell)
-  - QEMU can now boot a PowerPC Linux kernel (Jocelyn Mayer)
-  - User mode network stack
-  - imul imm8 fix + 0x82 opcode support (Hidemi KAWAI)
-  - precise self modifying code (aka BeOS install bug)
-
-version 0.5.3:
-
-  - added Bochs VESA VBE support
-  - VGA memory map mode 3 access fix (OS/2 install fix)
-  - IDE fixes (Jens Axboe)
-  - CPU interrupt fixes
-  - fixed various TLB invalidation cases (NT install)
-  - fixed cr0.WP semantics (XP install)
-  - direct chaining support for SPARC and PowerPC (faster)
-  - ARM NWFPE support (initial patch by Ulrich Hecht)
-  - added specific x86 to x86 translator (close to native performance
-    in qemu-i386 and qemu-fast)
-  - shm syscalls support (Paul McKerras)
-  - added accurate CR0.MP/ME/TS emulation
-  - fixed DMA memory write access (Win95 boot floppy fix)
-  - graphical x86 linux loader
-  - command line monitor
-  - generic removable device support
-  - support of CD-ROM change
-  - multiple network interface support
-  - initial x86-64 host support (Gwenole Beauchesne)
-  - lret to outer privilege fix (OS/2 install fix)
-  - task switch fixes (SkyOS boot)
-  - VM save/restore commands
-  - new timer API
-  - more precise RTC emulation (periodic timers + time updates)
-  - Win32 port (initial patch by Kazu)
-
-version 0.5.2:
-
-  - improved soft MMU speed (assembly functions and specializing)
-  - improved multitasking speed by avoiding flushing TBs when
-    switching tasks
-  - improved qemu-fast speed
-  - improved self modifying code handling (big performance gain in
-    softmmu mode).
-  - fixed IO checking
-  - fixed CD-ROM detection (win98 install CD)
-  - fixed addseg real mode bug (GRUB boot fix)
-  - added ROM memory support (win98 boot)
-  - fixed 'call Ev' in case of paging exception
-  - updated the script 'qemu-binfmt-conf.sh' to use QEMU automagically
-    when launching executables for the supported target CPUs.
-  - PowerPC system emulation update (Jocelyn Mayer)
-  - PC floppy emulation and DMA fixes (Jocelyn Mayer)
-  - polled mode for PIC (Jocelyn Mayer)
-  - fixed PTE dirty bit handling
-  - fixed xadd same reg bug
-  - fixed cmpxchg exception safeness
-  - access to virtual memory in gdb stub
-  - task gate and NT flag fixes
-  - eflags optimisation fix for string operations
-
-version 0.5.1:
-
-  - float access fixes when using soft mmu
-  - PC emulation support on PowerPC
-  - A20 support
-  - IDE CD-ROM emulation
-  - ARM fixes (Ulrich Hecht)
-  - SB16 emulation (malc)
-  - IRET and INT fixes in VM86 mode with IOPL=3
-  - Port I/Os use TSS io map
-  - Full task switching/task gate support
-  - added verr, verw, arpl, fcmovxx
-  - PowerPC target support (Jocelyn Mayer)
-  - Major SPARC target fixes (dynamically linked programs begin to work)
-
-version 0.5.0:
-
-  - full hardware level VGA emulation
-  - graphical display with SDL
-  - added PS/2 mouse and keyboard emulation
-  - popw (%esp) fix
-  - mov to/from segment data width fix
-  - added real mode support
-  - added Bochs BIOS and LGPL'ed VGA BIOS loader in qemu
-  - m68k host port (Richard Zidlicky)
-  - partial soft MMU support for memory mapped I/Os
-  - multi-target build
-  - fixed: no error code in hardware interrupts
-  - fixed: pop ss, mov ss, x and sti disable hardware irqs for the next insn
-  - correct single stepping through string operations
-  - preliminary SPARC target support (Thomas M. Ogrisegg)
-  - tun-fd option (Rusty Russell)
-  - automatic IDE geometry detection
-  - renamed 'vl' to qemu[-fast] and user qemu to qemu-{cpu}.
-  - added man page
-  - added full soft mmu mode to launch unpatched OSes.
-
-version 0.4.3:
-
-  - x86 exception fix in case of nop instruction.
-  - gcc 3.2.2 bug workaround (RedHat 9 fix)
-  - sparc and Alpha host fixes
-  - many ARM target fixes: 'ls' and 'bash' can be launched.
-
-version 0.4.2:
-
- - many exception handling fixes (can compile a Linux kernel inside vl)
- - IDE emulation support
- - initial GDB stub support
- - deferred update support for disk images (Rusty Russell)
- - accept User Mode Linux Copy On Write disk images
- - SMP kernels can at least be booted
-
-version 0.4.1:
-
- - more accurate timer support in vl.
- - more reliable NE2000 probe in vl.
- - added 2.5.66 kernel in vl-test.
- - added VLTMPDIR environment variable in vl.
-
-version 0.4:
-
- - initial support for ring 0 x86 processor emulation
- - fixed signal handling for correct dosemu DPMI emulation
- - fast x86 MMU emulation with mmap()
- - fixed popl (%esp) case
- - Linux kernel can be executed by QEMU with the 'vl' command.
-
-version 0.3:
-
- - initial support for ARM emulation
- - added fnsave, frstor, fnstenv, fldenv FPU instructions
- - added FPU register save in signal emulation
- - initial ARM port
- - Sparc and Alpha ports work on the regression test
- - generic ioctl number conversion
- - fixed ioctl type conversion
-
-version 0.2:
-
- - PowerPC disassembly and ELF symbols output (Rusty Russell)
- - flock support (Rusty Russell)
- - ugetrlimit support (Rusty Russell)
- - fstat64 fix (Rusty Russell)
- - initial Alpha port (Falk Hueffner)
- - initial IA64 port (Matt Wilson)
- - initial Sparc and Sparc64 port (David S. Miller)
- - added HLT instruction
- - LRET instruction fix.
- - added GPF generation for I/Os.
- - added INT3 and TF flag support.
- - SHL instruction C flag fix.
- - mmap emulation for host page size > 4KB
- - self-modifying code support
- - better VM86 support (dosemu works on non trivial programs)
- - precise exception support (EIP is computed correctly in most cases)
- - more precise LDT/GDT/IDT emulation
- - faster segment load in vm86 mode
- - direct chaining of basic blocks (faster emulation)
-
-version 0.1.6:
-
- - automatic library search system. QEMU can now work with unpatched
-   ELF dynamic loader and libc (Rusty Russell).
- - ISO C warning fixes (Alistair Strachan)
- - first self-virtualizable version (works only as long as the
-   translation cache is not flushed)
- - RH9 fixes
-
-version 0.1.5:
-
- - ppc64 support + personality() patch (Rusty Russell)
- - first Alpha CPU patches (Falk Hueffner)
- - removed bfd.h dependency
- - fixed shrd, shld, idivl and divl on PowerPC.
- - fixed buggy glibc PowerPC rint() function (test-i386 passes now on PowerPC).
-
-version 0.1.4:
-
- - more accurate VM86 emulation (can launch small DOS 16 bit
-   executables in wine).
- - fixed push/pop fs/gs
- - added iret instruction.
- - added times() syscall and SIOCATMARK ioctl.
-
-version 0.1.3:
-
- - S390 support (Ulrich Weigand)
- - glibc 2.3.x compile fix (Ulrich Weigand)
- - socketcall endian fix (Ulrich Weigand)
- - struct sockaddr endian fix (Ulrich Weigand)
- - sendmsg/recvmsg endian fix (Ulrich Weigand)
- - execve endian fix (Ulrich Weigand)
- - fdset endian fix (Ulrich Weigand)
- - partial setsockopt syscall support (Ulrich Weigand)
- - more accurate pushf/popf emulation
- - first partial vm86() syscall support (can be used with runcom example).
- - added bound, cmpxchg8b, cpuid instructions
- - added 16 bit addressing support/override for string operations
- - poll() fix
-
-version 0.1.2:
-
- - compile fixes
- - xlat instruction
- - xchg instruction memory lock
- - added simple vm86 example (not working with QEMU yet). The 54 byte
-   DOS executable 'pi_10.com' program was released by Bertram
-   Felgenhauer (more information at http://www.boo.net/~jasonp/pipage.html).
-
-version 0.1.1:
-
- - glibc 2.2 compilation fixes
- - added -s and -L options
- - binary distribution of x86 glibc and wine
- - big endian fixes in ELF loader and getdents.
-
-version 0.1:
-
- - initial public release.
-- 
2.26.2


