Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395D4C4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:02:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13DA72084D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13DA72084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7M77-0001qL-AY
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 12:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7M4A-0008On-4V
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7M46-0001ac-Ln
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:58:57 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:44567)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1i7M46-0001aB-19; Mon, 09 Sep 2019 11:58:54 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M2etD-1i8BOt2qDf-004EHi; Mon, 09 Sep 2019 17:58:21 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Mon,  9 Sep 2019 17:58:04 +0200
Message-Id: <20190909155813.27760-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NwjZrCvErK9/KEsrjRT5rS6sJ7obqwx+vg+H7uWj3mfl2fvx3pz
 RUhxVrMAoxIz6XLokGvHgT80mm2t49DmlMuYBJM/jKEciDk8NhkUb3+ca3ibrhT9ZxEy+1m
 RASX+37Q7bv4T++aWmJzvTbHEa04u9/a3C8NWahNusJp7ujXK6aMpA0YyvTSnIybQShtbTI
 Bbt8V0U83jTHCRHcZ5gyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7QDGwXyEwsA=:vbkXgEyxoGyIeeEitinAtQ
 jsRwLg+v07tjXXzXf9WNqHqJaU3F5XlvYbgrqDpyIU1B/cGYacE70ZgtU1kn642p9IJ7ltWBS
 Vnc6/PwRC3ir/KHPygodDqP8WlOAHWbbzfE7Zxd0X78B7TH3oSWaIU2fUO76qutI8EJmwrC49
 PlTlcTS4XsyhNeUV9FlMEy9VXKRJALFtmSIrNSfUIOOtN7EYQg3oVdOug6iTqDhrGYa6hb9m0
 8h8ke8se78g5fLua70IiPvBFlqeuqBtX44kh1uUFJS//Mg35YwafB6sN2dy7ZxLM1xuAdCd1w
 x7590WAR6/lEA9QQUZWFkMFRSAVdnTjWgncr6xD/RPjIdNav+pNIlWgKHFjNBv3HEyGaI7/N/
 sQE51rZ+wnjSq35M1+gWHEotFkYWzZWBYeBWTOzQOdIZyrutuNGmL/dfp1TfhzqoewTfyYGTs
 hQll8TBMqkJ1tafp7YZFXmudO5hAa0WUhwuWQOhDT5iEepJTU0CDf0a5uYYmxyWVNHsHjnjsB
 7yoUYIg0XIjET6Rolw6Rbj6Ofj7Bap7m65if/Vqrf89S4jyIjhHYlRuhXPjRyEpQJ4mxZ/hTy
 lM/LUrR4exuDX85+RAOwbVITm+zyCDjb7vX+SuBNswc8o0URFbFLIj/V18SDv6XrxgsZNh7gN
 fSqMNjH8xXc2fi4XjxBXQ3cVIiy+QutKa46uwEw6crNXxLMVK3fWsV3KlybCAkOtPHLpo2Vod
 zL4eqKF2aK0KpgiuzIYIFrLjG8AL9Re8UoE4KzE7GTxuJWN3u5lyxIrzzSbimkICJNSuU+P0z
 3m2g7DvGcFL/B5UP72vYp+YGz1I9LWPQxs7xto4juCmGRfI7fU=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
Subject: [Qemu-devel] [PATCH v9 0/9] hw/m68k: add Apple Machintosh Quadra
 800 machine
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm rebasing some of these patches for seven years now,
too many years...

if you want to test the machine, I'm sorry, it doesn't boot
a MacROM, but you can boot a linux kernel from the command line.

You can install your own disk using debian-installer, with:

    ...
    -M q800 \
    -serial none -serial mon:stdio \
    -m 1000M \
    -net nic,model=dp83932,addr=09:00:07:12:34:57 \
    -append "console=ttyS0 vga=off" \
    -kernel vmlinux-4.16.0-1-m68k \
    -initrd initrd.gz \
    -drive file=debian-10.0-m68k-NETINST-1.iso,media=cdrom \
    -drive file=m68k.qcow2,format=qcow2 \
    -nographic

If you use a graphic adapter instead of "-nographic", you can use "-g" to set the
size of the display (I use "-g 1600x800x24").

You can get the ISO from:

https://cdimage.debian.org/cdimage/ports/10.0/m68k/iso-cd/debian-10.0-m68k-NETINST-1.iso

and extract the kernel and initrd.gz:

guestfish --add debian-10.0-m68k-NETINST-1.iso --ro \
          --mount /dev/sda:/ <<_EOF_
copy-out /install/cdrom/initrd.gz .
copy-out /install/kernels/vmlinux-4.16.0-1-m68k .
_EOF_

The mirror to use is: http://ftp.ports.debian.org/debian-ports/
when it fails, continue without boot loader.

In the same way, you can extract the kernel and the initramfs from the qcow2
image to use it with "-kernel" and "-initrd":

guestfish --add m68k.qcow2 --mount /dev/sda2:/ <<_EOF_
copy-out /boot/vmlinux-4.16.0-1-m68k .
copy-out /boot/initrd.img-4.16.0-1-m68k .
_EOF_

and boot with:

   ...
   -append "root=/dev/sda2 rw console=ttyS0 console=tty \
   -kernel vmlinux-4.16.0-1-m68k \
   -initrd initrd.img-4.16.0-1-m68k

NOTE: DHCP doesn't work but you can assign a static IP address.
      We need some patches for dp8393x that are not ready to be merged.
      See http://patchwork.ozlabs.org/patch/927020/
          http://patchwork.ozlabs.org/patch/927030/
          http://patchwork.ozlabs.org/patch/927026/

v9: Fix comments format
    rebase on top of NeXTcube

v8: rebase (new blk_new(), add "qemu-common.h")
    update bootinfo information and license
    add some braces
    Rename Q800IRQState to GLUEState:
    it's more like a Logic Unit than an IRQ controller,
    and Apple calls it "GLUE" (Mark: I prefer to keep it
    like this for the moment, in the future this part
    need to be reworked, we have to review the IRQ levels
    and to wire NUBUS IRQ. The implementation is really trivial
    for the moment and we will move it to QOM in the future)

v7: rebase and port to Kconfig
    move IRQ controller back to q800.c (we don't need an object for this)
    update log message for ESP changes and add some g_assert()
    re-order patches: put esp, escc and dp8393x first

v6: Rebase onto git master (this now includes the m68k EXCP_ILLEGAL fix required
      for this patchset to boot)
    Add Hervé's R-B tags
    Drop ASC (Apple Sound Chip) device since the Linux driver is broken and
      it is not required for a successful boot
    Remove extra esp_raise_irq() from ESP pseudo-DMA patch (Hervé)
    Remove "return" from unimplemented write functions and instead add a
      "read only" comment (Hervé)
    Rename MAX_FD to SWIM_MAX_FD in SWIM floppy controller patch to prevent
      potential conflicts with other files (Hervé)

v5: Rebase onto git master
    Add Philippe's R-B to patch 10
    Include the command line to boot a Linux kernel under the q800 machine in the
    commit message for patch 11 (Philippe)
    Fix up comments in hw/misc/mac_via.c (Thomas)
    Add asserts to VIA ADB support to prevent potential buffer overflows (Thomas)
    Move macfb surface/resolution checks to realise and remove hw_error (Thomas)
    Move macfb draw_line functions inline and remove macfb-template.h (Mark)
    Use guest address rather than source pointer in draw_line functions - this brings
      macfb in line with the VGA device and can prevent a potential buffer overflow
    Use g_strdup_printf() for memory region names in NuBus devices instead of
      hardcoded length char arrays (Thomas)
    Move NuBus QOM types from patch 7 to patch 8 (spotted by Thomas)
    Move CONFIG_COLDFIRE sections together in hw/m68k/Makefile.objs (Thomas)
    Remove obsolete comment from q800.c in patch 11 (Thomas)

v4: Drop RFC from subject prefix as this is getting close to final
    Rebased onto master (fixing ESP, rom_ptr() conflicts)
    Reworked q800.c based upon Thomas' comments about cpu_init() and
      qemu_check_nic_model()
    Address Thomas' comments on using error_report() instead of hw_error()
    Change the NuBus memory regions from DEVICE_NATIVE_ENDIAN to
      DEVICE_BIG_ENDIAN
    Split macfb Nubus support into separate commit
    Change VMSTATE_BUFFER_UNSAFE() to VMSTATE_UINT8_ARRAY() in macfb.c as
      suggested by David
    Remove dummy Apple Sound Chip migration state as pointed out by David
    Keep VIA ADB state and buffers in the mac_via device rather than adding
      to existing ADBState (this matches the pattern used in the PPC CUDA/PMU
      VIAs)
    Remove blacklisting for q800 machine from "make check" as requested by
      Thomas with the following fixes:
        - Fix incorrect MemoryRegion owner in ASC device
        - Add qtest_enabled() check in q800_init() to allow testing when no
          kernel is specified
        - Move some Mac VIA initialisation from init to realize
    Remove legacy drive properties from SWIM floppy controller and instead
      expose separate floppy bus and drive devices as requested by Kevin

v3: fix subject prefix "C" -> "RFC"

v2: remove the dp8393x fixes, because one of the patch breaks something
    Update "dp8393x: manage big endian bus" with idea from Thomas
    Mark has reworked most of the patches:
    - use mos6522
    - some code move, renamings and cleanup

Laurent Vivier (8):
  esp: add pseudo-DMA as used by Macintosh
  dp8393x: manage big endian bus
  hw/m68k: add via support
  hw/m68k: implement ADB bus support for via
  hw/m68k: add macfb video card
  hw/m68k: add Nubus support
  hw/m68k: add a dummy SWIM floppy controller
  hw/m68k: define Macintosh Quadra 800

Mark Cave-Ayland (1):
  hw/m68k: add Nubus support for macfb video card

 MAINTAINERS                         |  14 +
 arch_init.c                         |   4 +
 default-configs/m68k-softmmu.mak    |   1 +
 hw/Kconfig                          |   1 +
 hw/Makefile.objs                    |   1 +
 hw/block/Kconfig                    |   3 +
 hw/block/Makefile.objs              |   1 +
 hw/block/swim.c                     | 421 +++++++++++++
 hw/display/Kconfig                  |   4 +
 hw/display/Makefile.objs            |   1 +
 hw/display/macfb.c                  | 477 +++++++++++++++
 hw/m68k/Kconfig                     |  12 +
 hw/m68k/Makefile.objs               |   1 +
 hw/m68k/bootinfo.h                  | 114 ++++
 hw/m68k/q800.c                      | 382 ++++++++++++
 hw/misc/Kconfig                     |   4 +
 hw/misc/Makefile.objs               |   1 +
 hw/misc/mac_via.c                   | 882 ++++++++++++++++++++++++++++
 hw/net/dp8393x.c                    |  88 ++-
 hw/nubus/Kconfig                    |   2 +
 hw/nubus/Makefile.objs              |   4 +
 hw/nubus/mac-nubus-bridge.c         |  45 ++
 hw/nubus/nubus-bridge.c             |  34 ++
 hw/nubus/nubus-bus.c                | 111 ++++
 hw/nubus/nubus-device.c             | 215 +++++++
 hw/scsi/esp.c                       | 296 +++++++++-
 include/hw/block/swim.h             |  76 +++
 include/hw/display/macfb.h          |  64 ++
 include/hw/misc/mac_via.h           | 114 ++++
 include/hw/nubus/mac-nubus-bridge.h |  24 +
 include/hw/nubus/nubus.h            |  69 +++
 include/hw/scsi/esp.h               |   7 +
 qemu-options.hx                     |   2 +-
 vl.c                                |   3 +-
 34 files changed, 3416 insertions(+), 62 deletions(-)
 create mode 100644 hw/block/swim.c
 create mode 100644 hw/display/macfb.c
 create mode 100644 hw/m68k/bootinfo.h
 create mode 100644 hw/m68k/q800.c
 create mode 100644 hw/misc/mac_via.c
 create mode 100644 hw/nubus/Kconfig
 create mode 100644 hw/nubus/Makefile.objs
 create mode 100644 hw/nubus/mac-nubus-bridge.c
 create mode 100644 hw/nubus/nubus-bridge.c
 create mode 100644 hw/nubus/nubus-bus.c
 create mode 100644 hw/nubus/nubus-device.c
 create mode 100644 include/hw/block/swim.h
 create mode 100644 include/hw/display/macfb.h
 create mode 100644 include/hw/misc/mac_via.h
 create mode 100644 include/hw/nubus/mac-nubus-bridge.h
 create mode 100644 include/hw/nubus/nubus.h

-- 
2.21.0


