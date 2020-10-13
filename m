Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA76C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01D7D25215
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D7D25215
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSMbT-0006jh-4b
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 11:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kSMaN-0005T8-6h
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:51:35 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:59037)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kSMaK-00066I-Th
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:51:34 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MgzWP-1jyFy92vz3-00hNif; Tue, 13 Oct 2020 17:51:28 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] m68k: add Virtual M68k Machine
Date: Tue, 13 Oct 2020 17:51:20 +0200
Message-Id: <20201013155124.451774-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5maaWEAlVL3+AHNaBhP7/ZUcRZrsdaYknWPuItgwvvqtOR3R750
 m5fFhfHhieO5G8IbqDx0AJhbGWVKqwmy15onV0EFK9BBb6bkSTmBBvltTqymUs8mJWnTb3V
 1TZxrQ7xWbeRY0Jdc8gODWGY4LMia1uF9eL0+Om+cirwEx0nYfsWwlMcO8SckJbUxfr4Aff
 I6wK6ysI0bS2EVOSYejhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xbRCWQOZ3IA=:3xtMdsQlw6b5irYOxzXrP7
 vMtmJ/g7eSZ9M0l1CCo8LilB1AU4KUIa0vWHgz7H9E8bQ1FB7AzjRctVb7oGIc/LHXRHuSxJT
 tmt2OLD61+gJLchMubWwIUZ1aj2h0mU5LLPM5mvmtf+J8SXd6o8DAtDdyZx6+sb2Bm6wZJNiz
 bsljf5OqvCBPIYT6Z8VDS2EPCmMroqTmgQk/hrKDpFHe18W96u7e3+UySHXey/57pWtik2a/h
 COB7nGYzL0P0PrTdDTNfgK4lVPZpgIuvGK/BAbYefyzUs5jrcMWQQ9WHyD+wr11xTeJf55FQZ
 YwFQXnEvPs0v+zD5cz0ADSLuEo38qcUK03XsKaHdeGOJ32JJuzizUyU4GmW2ebDHDV4EitfNr
 OgQDUc7zfDjUv/U7PHJujUNlg8P8w4sT0fIRBIEOv479iTvZm2/lImt3efhdEGlLXR6bwwIbb
 EKr5+mbhhVSK2bcYgdWn4o3NFNKMg5JfHPQY7khFXInODHoWiJiQS6TxYwX832k2n08faLtKj
 TNa/QR9sQmq+N17nD6xiPKaJPoj9CAYJM+ztn+KXfAeNkBEcQdma+oonTUE2jXEnLfygVjTdP
 5uoU0zIUd64CLOPd6hqJOl+epfXFLD6ZHGAAv+sCn3LMm2WLVXEsaXPnZV6JVzyDipi//ojpp
 zerYwgdFjshcm2jV3tnTG1eEsw56TgWjPwWiFZoDXPMX0Imo5l9FuW+5JUOmfsiAkKIeCviNl
 qrUH6FJBCPvlTL9j1IIrzyLbQHsI91SmBm6V5c8nQoEGEBv7M9E3ZcYMNjwrwo9SB9U5HZDjC
 swmFoDuy32qZe275BSK1tg9+gS/F38oKT16wMH1elipOsMybsB2vPujAadcEorlJZfU89Jv
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 11:51:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Quadra 800 machine is very limited to run linux, it manages=0D
only 1 GiB of memory and only some specific interfaces.=0D
=0D
The Virtual M68k Machine is based on Goldfish interfaces defined by Google=
=0D
for Android simulator. It uses Goldfish-rtc (timer and RTC),=0D
Goldfish-pic (PIC) and Goldfish-tty (for serial port and early tty).=0D
=0D
https://android.googlesource.com/platform/external/qemu/+/master/docs/GOLDF=
IS=3D=0D
H-VIRTUAL-HARDWARE.TXT=0D
=0D
The machine is created with 128 virtio-mmio busses, and they can=0D
be used to add serial console, GPU, disk, NIC, HID, ...=0D
=0D
This series re-use the goldfish-rtc implemented for RISCV, and=0D
adds the two others based on the goldfish specs, the kernel driver=0D
and android simulator ones.=0D
=0D
The machine can manage up to 3.2 GiB of memory, not because of an hardware=
=0D
limitation but because the kernel crashes after this value.=0D
=0D
Simply configure qemu with:=0D
=0D
    .../configure --target-list=3D3Dm68k-softmmu=0D
=0D
To run the machine you need a modified kernel you can find here:=0D
=0D
    https://github.com/vivier/linux/tree/m68k-virt=0D
=0D
You need to compile the kernel with:=0D
=0D
    make virt_defconfig=0D
    make vmlinux=0D
=0D
The disk must be installed using the q800 machine because the debian instal=
ler=0D
doesn't want to be used with a kernel that is not the one on the ISO.=0D
=0D
And then you can run the machine with something like:=0D
=0D
qemu-system-m68k -M virt \=0D
  -m 3399672K \=0D
  -chardev stdio,signal=3D3Doff,mux=3D3Don,id=3D3Dchar0 \=0D
  -mon chardev=3D3Dchar0,mode=3D3Dreadline \=0D
  -kernel vmlinux \=0D
  -append "console=3D3Dhvc0 root=3D3D/dev/vda2" \=0D
  -blockdev node-name=3D3Dsystem,driver=3D3Dfile,filename=3D3Ddebian-10.0.q=
cow2 \=0D
  -blockdev node-name=3D3Ddrive0,driver=3D3Dqcow2,file=3D3Dsystem \=0D
  -device virtio-blk-device,drive=3D3Ddrive0 \=0D
  -serial chardev:char0 \=0D
  -device virtio-net-device,netdev=3D3Dhostnet0 \=0D
  -netdev bridge,id=3D3Dhostnet0,br=3D3Dvirbr0 \=0D
  -device virtio-rng-device \=0D
  -device virtio-serial-device \=0D
  -device virtio-gpu-device \=0D
  -device virtconsole,chardev=3D3Dchar0 \=0D
  -device virtio-keyboard-device \=0D
  -device virtio-mouse-device=0D
=0D
if you want to use Goldfish-tty for the console rather than virtconsole, yo=
u=0D
can add "console=3D3DttyGF".=0D
=0D
To start the debian-installer, you can try by adding:=0D
=0D
  -device virtio-scsi-device \=0D
  -blockdev node-name=3D3Ddebian10,driver=3D3Dfile,filename=3D3Ddebian-10.0=
.0-m68k-=3D=0D
NETINST-1.iso \=0D
  -blockdev node-name=3D3Dcdrom0,driver=3D3Draw,file=3D3Ddebian10 \=0D
  -device scsi-cd,drive=3D3Dcdrom0 \=0D
  -initrd installer-m68k/20200315/images/cdrom/initrd.gz=0D
=0D
ISO:    https://cdimage.debian.org/cdimage/ports/snapshots/2020-10-12/debia=
n-=3D=0D
10.0.0-m68k-NETINST-1.iso=0D
initrd: https://cdimage.debian.org/cdimage/ports/debian-installer/2020-10-1=
2/=3D=0D
m68k/debian-installer-images_20200315_m68k.tar.gz=0D
=0D
I think there are some endianness issues with virtio-gpu, because when the=
=0D
X server starts I have some errors in the kernel logs:=0D
=0D
  vmap allocation for size 3149824 failed: use vmalloc=3D3D<size> to increa=
se s=3D=0D
ize=0D
=0D
I also tried virtiofsd but there is also an endianness problem and the serv=
er=0D
stops.=0D
=0D
Have Fun,=0D
Laurent=0D
=0D
PS:=0D
=0D
By reading the message to the end you have won the right to download the di=
sk=3D=0D
 image=0D
and the vmlinux.=0D
=0D
http://vivier.eu/debian-10.0.qcow2     343 MiB=0D
http://vivier.eu/vmlinux-virt-m68k     5.2 MiB=0D
=0D
Laurent Vivier (4):=0D
  m68k: import bootinfo headers from linux=0D
  char: add goldfish-tty=0D
  intc: add goldfish-pic=0D
  m68k: add Virtual M68k Machine=0D
=0D
 default-configs/devices/m68k-softmmu.mak      |   1 +=0D
 hw/m68k/bootinfo.h                            |  55 ----=0D
 include/hw/char/goldfish_tty.h                |  36 +++=0D
 include/hw/intc/goldfish_pic.h                |  28 ++=0D
 .../standard-headers/asm-m68k/bootinfo-mac.h  | 120 +++++++=0D
 .../standard-headers/asm-m68k/bootinfo-virt.h |  17 +=0D
 include/standard-headers/asm-m68k/bootinfo.h  | 166 ++++++++++=0D
 hw/char/goldfish_tty.c                        | 265 ++++++++++++++++=0D
 hw/intc/goldfish_pic.c                        | 178 +++++++++++=0D
 hw/m68k/q800.c                                |  20 +-=0D
 hw/m68k/virt.c                                | 296 ++++++++++++++++++=0D
 MAINTAINERS                                   |  11 +=0D
 hw/char/Kconfig                               |   3 +=0D
 hw/char/meson.build                           |   2 +=0D
 hw/char/trace-events                          |   9 +=0D
 hw/intc/Kconfig                               |   3 +=0D
 hw/intc/meson.build                           |   1 +=0D
 hw/intc/trace-events                          |   8 +=0D
 hw/m68k/Kconfig                               |   8 +=0D
 hw/m68k/meson.build                           |   1 +=0D
 20 files changed, 1160 insertions(+), 68 deletions(-)=0D
 create mode 100644 include/hw/char/goldfish_tty.h=0D
 create mode 100644 include/hw/intc/goldfish_pic.h=0D
 create mode 100644 include/standard-headers/asm-m68k/bootinfo-mac.h=0D
 create mode 100644 include/standard-headers/asm-m68k/bootinfo-virt.h=0D
 create mode 100644 include/standard-headers/asm-m68k/bootinfo.h=0D
 create mode 100644 hw/char/goldfish_tty.c=0D
 create mode 100644 hw/intc/goldfish_pic.c=0D
 create mode 100644 hw/m68k/virt.c=0D
=0D
--=3D20=0D
2.26.2=0D
=0D

