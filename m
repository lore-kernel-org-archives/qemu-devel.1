Return-Path: <SRS0=QkNH=UV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAFFC43613
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 14:28:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB24320675
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 14:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB24320675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41044 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heh0V-0003hY-4Q
	for qemu-devel@archiver.kernel.org; Sat, 22 Jun 2019 10:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55974)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hegyK-0001bq-Jj
 for qemu-devel@nongnu.org; Sat, 22 Jun 2019 10:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hegyI-0001kX-Rz
 for qemu-devel@nongnu.org; Sat, 22 Jun 2019 10:26:28 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:56164
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hegyE-0001eT-V9; Sat, 22 Jun 2019 10:26:23 -0400
Received: from host86-173-229-95.range86-173.btcentralplus.com
 ([86.173.229.95] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1heguZ-0003zT-61; Sat, 22 Jun 2019 15:22:35 +0100
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20190619221933.1981-1-laurent@vivier.eu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Openpgp: preference=signencrypt
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <c4f2215d-a147-d2b9-f1fd-bda38a20d63f@ilande.co.uk>
Date: Sat, 22 Jun 2019 15:22:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190619221933.1981-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.173.229.95
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: Re: [Qemu-devel] [PATCH v8 00/10] hw/m68k: add Apple Machintosh
 Quadra 800 machine
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/06/2019 23:19, Laurent Vivier wrote:

> I'm rebasing some of these patches for seven years now,
> too many years...
> 
> if you want to test the machine, I'm sorry, it doesn't boot
> a MacROM, but you can boot a linux kernel from the command line.
> 
> You can install your own disk using debian-installer, with:
> 
>     ...
>     -M q800 \
>     -serial none -serial mon:stdio \
>     -m 1000M \
>     -net nic,model=dp83932,addr=09:00:07:12:34:57 \
>     -append "console=ttyS0 vga=off" \
>     -kernel vmlinux-4.16.0-1-m68k \
>     -initrd initrd.gz \
>     -drive file=debian-10.0-m68k-NETINST-1.iso,media=cdrom \
>     -drive file=m68k.qcow2,format=qcow2 \
>     -nographic
> 
> If you use a graphic adapter instead of "-nographic", you can use "-g" to set the
> size of the display (I use "-g 1600x800x24").
> 
> You can get the ISO from:
> 
> https://cdimage.debian.org/cdimage/ports/10.0/m68k/iso-cd/debian-10.0-m68k-NETINST-1.iso
> 
> and extract the kernel and initrd.gz:
> 
> guestfish --add debian-10.0-m68k-NETINST-1.iso --ro \
>           --mount /dev/sda:/ <<_EOF_
> copy-out /install/cdrom/initrd.gz .
> copy-out /install/kernels/vmlinux-4.16.0-1-m68k .
> _EOF_
> 
> The mirror to use is: http://ftp.ports.debian.org/debian-ports/
> when it fails, continue without boot loader.
> 
> In the same way, you can extract the kernel and the initramfs from the qcow2
> image to use it with "-kernel" and "-initrd":
> 
> guestfish --add m68k.qcow2 --mount /dev/sda2:/ <<_EOF_
> copy-out /boot/vmlinux-4.16.0-1-m68k .
> copy-out /boot/initrd.img-4.16.0-1-m68k .
> _EOF_
> 
> and boot with:
> 
>    ...
>    -append "root=/dev/sda2 rw console=ttyS0 console=tty \
>    -kernel vmlinux-4.16.0-1-m68k \
>    -initrd initrd.img-4.16.0-1-m68k
> 
> NOTE: DHCP doesn't work but you can assign a static IP address.
>       We need some patches for dp8393x that are not ready to be merged.
>       See http://patchwork.ozlabs.org/patch/927020/
>           http://patchwork.ozlabs.org/patch/927030/
>           http://patchwork.ozlabs.org/patch/927026/
> 
> v8: rebase (new blk_new(), add "qemu-common.h")
>     update bootinfo information and license
>     add some braces
>     Rename Q800IRQState to GLUEState:
>     it's more like a Logic Unit than an IRQ controller,
>     and Apple calls it "GLUE" (Mark: I prefer to keep it
>     like this for the moment, in the future this part
>     need to be reworked, we have to review the IRQ levels
>     and to wire NUBUS IRQ. The implementation is really trivial
>     for the moment and we will move it to QOM in the future)

Okay fine with me - as you say once the wiring part has been worked out the switch to
QOM is reasonably trivial.

> v7: rebase and port to Kconfig
>     move IRQ controller back to q800.c (we don't need an object for this)
>     update log message for ESP changes and add some g_assert()
>     re-order patches: put esp, escc and dp8393x first
> 
> v6: Rebase onto git master (this now includes the m68k EXCP_ILLEGAL fix required
>       for this patchset to boot)
>     Add Hervé's R-B tags
>     Drop ASC (Apple Sound Chip) device since the Linux driver is broken and
>       it is not required for a successful boot
>     Remove extra esp_raise_irq() from ESP pseudo-DMA patch (Hervé)
>     Remove "return" from unimplemented write functions and instead add a
>       "read only" comment (Hervé)
>     Rename MAX_FD to SWIM_MAX_FD in SWIM floppy controller patch to prevent
>       potential conflicts with other files (Hervé)
> 
> v5: Rebase onto git master
>     Add Philippe's R-B to patch 10
>     Include the command line to boot a Linux kernel under the q800 machine in the
>     commit message for patch 11 (Philippe)
>     Fix up comments in hw/misc/mac_via.c (Thomas)
>     Add asserts to VIA ADB support to prevent potential buffer overflows (Thomas)
>     Move macfb surface/resolution checks to realise and remove hw_error (Thomas)
>     Move macfb draw_line functions inline and remove macfb-template.h (Mark)
>     Use guest address rather than source pointer in draw_line functions - this brings
>       macfb in line with the VGA device and can prevent a potential buffer overflow
>     Use g_strdup_printf() for memory region names in NuBus devices instead of
>       hardcoded length char arrays (Thomas)
>     Move NuBus QOM types from patch 7 to patch 8 (spotted by Thomas)
>     Move CONFIG_COLDFIRE sections together in hw/m68k/Makefile.objs (Thomas)
>     Remove obsolete comment from q800.c in patch 11 (Thomas)
> 
> v4: Drop RFC from subject prefix as this is getting close to final
>     Rebased onto master (fixing ESP, rom_ptr() conflicts)
>     Reworked q800.c based upon Thomas' comments about cpu_init() and
>       qemu_check_nic_model()
>     Address Thomas' comments on using error_report() instead of hw_error()
>     Change the NuBus memory regions from DEVICE_NATIVE_ENDIAN to
>       DEVICE_BIG_ENDIAN
>     Split macfb Nubus support into separate commit
>     Change VMSTATE_BUFFER_UNSAFE() to VMSTATE_UINT8_ARRAY() in macfb.c as
>       suggested by David
>     Remove dummy Apple Sound Chip migration state as pointed out by David
>     Keep VIA ADB state and buffers in the mac_via device rather than adding
>       to existing ADBState (this matches the pattern used in the PPC CUDA/PMU
>       VIAs)
>     Remove blacklisting for q800 machine from "make check" as requested by
>       Thomas with the following fixes:
>         - Fix incorrect MemoryRegion owner in ASC device
>         - Add qtest_enabled() check in q800_init() to allow testing when no
>           kernel is specified
>         - Move some Mac VIA initialisation from init to realize
>     Remove legacy drive properties from SWIM floppy controller and instead
>       expose separate floppy bus and drive devices as requested by Kevin
> 
> v3: fix subject prefix "C" -> "RFC"
> 
> v2: remove the dp8393x fixes, because one of the patch breaks something
>     Update "dp8393x: manage big endian bus" with idea from Thomas
>     Mark has reworked most of the patches:
>     - use mos6522
>     - some code move, renamings and cleanup
> 
> Laurent Vivier (9):
>   escc: introduce a selector for the register bit
>   esp: add pseudo-DMA as used by Macintosh
>   dp8393x: manage big endian bus
>   hw/m68k: add via support
>   hw/m68k: implement ADB bus support for via
>   hw/m68k: add macfb video card
>   hw/m68k: add Nubus support
>   hw/m68k: add a dummy SWIM floppy controller
>   hw/m68k: define Macintosh Quadra 800
> 
> Mark Cave-Ayland (1):
>   hw/m68k: add Nubus support for macfb video card
> 
>  MAINTAINERS                         |  14 +
>  arch_init.c                         |   4 +
>  default-configs/m68k-softmmu.mak    |   1 +
>  hw/Kconfig                          |   1 +
>  hw/Makefile.objs                    |   1 +
>  hw/block/Kconfig                    |   3 +
>  hw/block/Makefile.objs              |   1 +
>  hw/block/swim.c                     | 415 ++++++++++++++
>  hw/char/escc.c                      |  30 +-
>  hw/display/Kconfig                  |   4 +
>  hw/display/Makefile.objs            |   1 +
>  hw/display/macfb.c                  | 475 +++++++++++++++
>  hw/m68k/Kconfig                     |  12 +
>  hw/m68k/Makefile.objs               |   1 +
>  hw/m68k/bootinfo.h                  | 114 ++++
>  hw/m68k/q800.c                      | 377 ++++++++++++
>  hw/misc/Kconfig                     |   4 +
>  hw/misc/Makefile.objs               |   1 +
>  hw/misc/mac_via.c                   | 857 ++++++++++++++++++++++++++++
>  hw/net/dp8393x.c                    |  88 ++-
>  hw/nubus/Kconfig                    |   2 +
>  hw/nubus/Makefile.objs              |   4 +
>  hw/nubus/mac-nubus-bridge.c         |  45 ++
>  hw/nubus/nubus-bridge.c             |  34 ++
>  hw/nubus/nubus-bus.c                | 111 ++++
>  hw/nubus/nubus-device.c             | 215 +++++++
>  hw/scsi/esp.c                       | 296 +++++++++-
>  include/hw/block/swim.h             |  76 +++
>  include/hw/char/escc.h              |   1 +
>  include/hw/display/macfb.h          |  64 +++
>  include/hw/misc/mac_via.h           | 114 ++++
>  include/hw/nubus/mac-nubus-bridge.h |  24 +
>  include/hw/nubus/nubus.h            |  69 +++
>  include/hw/scsi/esp.h               |   7 +
>  qemu-options.hx                     |   2 +-
>  vl.c                                |   3 +-
>  36 files changed, 3403 insertions(+), 68 deletions(-)
>  create mode 100644 hw/block/swim.c
>  create mode 100644 hw/display/macfb.c
>  create mode 100644 hw/m68k/bootinfo.h
>  create mode 100644 hw/m68k/q800.c
>  create mode 100644 hw/misc/mac_via.c
>  create mode 100644 hw/nubus/Kconfig
>  create mode 100644 hw/nubus/Makefile.objs
>  create mode 100644 hw/nubus/mac-nubus-bridge.c
>  create mode 100644 hw/nubus/nubus-bridge.c
>  create mode 100644 hw/nubus/nubus-bus.c
>  create mode 100644 hw/nubus/nubus-device.c
>  create mode 100644 include/hw/block/swim.h
>  create mode 100644 include/hw/display/macfb.h
>  create mode 100644 include/hw/misc/mac_via.h
>  create mode 100644 include/hw/nubus/mac-nubus-bridge.h
>  create mode 100644 include/hw/nubus/nubus.h


ATB,

Mark.

