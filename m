Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9DBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 16:06:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B162065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 16:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B162065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZGNc-0004PA-Lb
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 12:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jZGMj-00033e-V6
 for qemu-devel@nongnu.org; Thu, 14 May 2020 12:05:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:60266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jZGMi-0002ZI-17
 for qemu-devel@nongnu.org; Thu, 14 May 2020 12:05:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jZGMg-0004G9-7V
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 16:05:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 30C592E80E7
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 16:05:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2020 15:57:40 -0000
From: Alexander Bulekov <1878642@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: Alexander Bulekov (a1xndr)
Message-Id: <158947186100.17636.13410831714995033672.malonedeb@soybean.canonical.com>
Subject: [Bug 1878642] [NEW] Assertion failure in pci_bus_get_irq_level
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0385b538081bc4718df6fb844a3afc89729c94ce";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: b73d588af4b942a857585925e7a636ab77c5c6f1
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 11:40:56
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1878642 <1878642@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hello,
I found an input which triggers an assertion failure in pci_bus_get_irq_lev=
el:

qemu-system-i386: /home/alxndr/Development/qemu/hw/pci/pci.c:268: int pci_b=
us_get_irq_level(PCIBus *, int): Assertion `irq_num < bus->nirq' failed.
Aborted
#0  0x00007ffff686d761 in __GI_raise (sig=3Dsig@entry=3D0x6) at ../sysdeps/=
unix/sysv/linux/raise.c:50
#1  0x00007ffff685755b in __GI_abort () at abort.c:79
#2  0x00007ffff685742f in __assert_fail_base (fmt=3D0x7ffff69bdb48 "%s%s%s:=
%u: %s%sAssertion `%s' failed.\n%n", assertion=3D0x555557f9bca0 <str> "irq_=
num < bus->nirq", file=3D0x555557f9bbe0 <str> "/home/alxndr/Development/qem=
u/hw/pci/pci.c", line=3D0x10c, function=3D<optimized out>) at assert.c:92
#3  0x00007ffff6866092 in __GI___assert_fail (assertion=3D0x555557f9bca0 <s=
tr> "irq_num < bus->nirq", file=3D0x555557f9bbe0 <str> "/home/alxndr/Develo=
pment/qemu/hw/pci/pci.c", line=3D0x10c, function=3D0x555557f9bc40 <__PRETTY=
_FUNCTION__.pci_bus_get_irq_level> "int pci_bus_get_irq_level(PCIBus *, int=
)") at assert.c:101
#4  0x0000555557060c34 in pci_bus_get_irq_level (bus=3D0x61d000096080, irq_=
num=3D0xef) at /home/alxndr/Development/qemu/hw/pci/pci.c:268
#5  0x0000555556657391 in ich9_lpc_update_apic (lpc=3D0x62a000006200, gsi=
=3D0xff) at /home/alxndr/Development/qemu/hw/isa/lpc_ich9.c:249
#6  0x0000555556658ea7 in ich9_set_sci (opaque=3D0x62a000006200, irq_num=3D=
0x0, level=3D0x1) at /home/alxndr/Development/qemu/hw/isa/lpc_ich9.c:354
#7  0x0000555556ccefc6 in qemu_set_irq (irq=3D0x60600002af80, level=3D0x1) =
at /home/alxndr/Development/qemu/hw/core/irq.c:44
#8  0x0000555556bc06fd in acpi_update_sci (regs=3D0x62a000006c80, irq=3D0x6=
0600002af80) at /home/alxndr/Development/qemu/hw/acpi/core.c:723
#9  0x0000555556bccb08 in ich9_pm_update_sci_fn (regs=3D0x62a000006c80) at =
/home/alxndr/Development/qemu/hw/acpi/ich9.c:56
#10 0x0000555556bc10ee in acpi_pm_evt_write (opaque=3D0x62a000006c80, addr=
=3D0x2, val=3D0x2049, width=3D0x2) at /home/alxndr/Development/qemu/hw/acpi=
/core.c:456
#11 0x00005555564938b5 in memory_region_write_accessor (mr=3D0x62a000006db0=
, addr=3D0x2, value=3D0x7fffffff9c70, size=3D0x2, shift=3D0x0, mask=3D0xfff=
f, attrs=3D...) at /home/alxndr/Development/qemu/memory.c:483
#12 0x000055555649328a in access_with_adjusted_size (addr=3D0x2, value=3D0x=
7fffffff9c70, size=3D0x2, access_size_min=3D0x1, access_size_max=3D0x4, acc=
ess_fn=3D0x555556493360 <memory_region_write_accessor>, mr=3D0x62a000006db0=
, attrs=3D...) at /home/alxndr/Development/qemu/memory.c:544
#13 0x0000555556491df6 in memory_region_dispatch_write (mr=3D0x62a000006db0=
, addr=3D0x2, data=3D0x2049, op=3DMO_16, attrs=3D...) at /home/alxndr/Devel=
opment/qemu/memory.c:1476
#14 0x00005555562cbbf4 in flatview_write_continue (fv=3D0x606000033fe0, add=
r=3D0x5d02, attrs=3D..., ptr=3D0x7fffffffa4e0, len=3D0x4, addr1=3D0x2, l=3D=
0x2, mr=3D0x62a000006db0) at /home/alxndr/Development/qemu/exec.c:3137
#15 0x00005555562bbad9 in flatview_write (fv=3D0x606000033fe0, addr=3D0x5d0=
2, attrs=3D..., buf=3D0x7fffffffa4e0, len=3D0x4) at /home/alxndr/Developmen=
t/qemu/exec.c:3177
#16 0x00005555562bb609 in address_space_write (as=3D0x55555968f940 <address=
_space_io>, addr=3D0x5d02, attrs=3D..., buf=3D0x7fffffffa4e0, len=3D0x4) at=
 /home/alxndr/Development/qemu/exec.c:3268
#17 0x0000555556478c0a in cpu_outl (addr=3D0x5d02, val=3D0xedf82049) at /ho=
me/alxndr/Development/qemu/ioport.c:80
#18 0x000055555648166f in qtest_process_command (chr=3D0x555559691d00 <qtes=
t_chr>, words=3D0x60300009ef20) at /home/alxndr/Development/qemu/qtest.c:396
#19 0x000055555647f187 in qtest_process_inbuf (chr=3D0x555559691d00 <qtest_=
chr>, inbuf=3D0x61900000f680) at /home/alxndr/Development/qemu/qtest.c:710
#20 0x000055555647e8b4 in qtest_read (opaque=3D0x555559691d00 <qtest_chr>, =
buf=3D0x7fffffffca40 "outl 0xcf8 0x8400f841\noutl 0xcfc 0xebed205d\noutl 0x=
5d02 0xedf82049\n-M pc-q35-5.0 -device intel-hda,id=3Dhda0 -device hda-outp=
ut,bus=3Dhda0.0 -device hda-micro,bus=3Dhda0.0 -device hda-duplex,bus=3Dhda=
0.0 -display none -nodefaults -nographic\n", size=3D0xe9) at /home/alxndr/D=
evelopment/qemu/qtest.c:722
#21 0x00005555579c260c in qemu_chr_be_write_impl (s=3D0x60f000001f30, buf=
=3D0x7fffffffca40 "outl 0xcf8 0x8400f841\noutl 0xcfc 0xebed205d\noutl 0x5d0=
2 0xedf82049\n-M pc-q35-5.0 -device intel-hda,id=3Dhda0 -device hda-output,=
bus=3Dhda0.0 -device hda-micro,bus=3Dhda0.0 -device hda-duplex,bus=3Dhda0.0=
 -display none -nodefaults -nographic\n", len=3D0xe9) at /home/alxndr/Devel=
opment/qemu/chardev/char.c:183
#22 0x00005555579c275b in qemu_chr_be_write (s=3D0x60f000001f30, buf=3D0x7f=
ffffffca40 "outl 0xcf8 0x8400f841\noutl 0xcfc 0xebed205d\noutl 0x5d02 0xedf=
82049\n-M pc-q35-5.0 -device intel-hda,id=3Dhda0 -device hda-output,bus=3Dh=
da0.0 -device hda-micro,bus=3Dhda0.0 -device hda-duplex,bus=3Dhda0.0 -displ=
ay none -nodefaults -nographic\n", len=3D0xe9) at /home/alxndr/Development/=
qemu/chardev/char.c:195
#23 0x00005555579cb97a in fd_chr_read (chan=3D0x6080000026a0, cond=3DG_IO_I=
N, opaque=3D0x60f000001f30) at /home/alxndr/Development/qemu/chardev/char-f=
d.c:68
#24 0x0000555557a530ea in qio_channel_fd_source_dispatch (source=3D0x60c000=
02ef00, callback=3D0x5555579cb540 <fd_chr_read>, user_data=3D0x60f000001f30=
) at /home/alxndr/Development/qemu/io/channel-watch.c:84
#25 0x00007ffff7ca8898 in g_main_context_dispatch () at /usr/lib/x86_64-lin=
ux-gnu/libglib-2.0.so.0
#26 0x0000555557c10b85 in glib_pollfds_poll () at /home/alxndr/Development/=
qemu/util/main-loop.c:219
#27 0x0000555557c0f57e in os_host_main_loop_wait (timeout=3D0x0) at /home/a=
lxndr/Development/qemu/util/main-loop.c:242
#28 0x0000555557c0f177 in main_loop_wait (nonblocking=3D0x0) at /home/alxnd=
r/Development/qemu/util/main-loop.c:518
#29 0x000055555689fd1e in qemu_main_loop () at /home/alxndr/Development/qem=
u/softmmu/vl.c:1664
#30 0x0000555557a6a29d in main (argc=3D0x17, argv=3D0x7fffffffe148, envp=3D=
0x7fffffffe208) at /home/alxndr/Development/qemu/softmmu/main.c:49

I can reproduce this in qemu 5.0 using these qtest commands:

cat << EOF | ./qemu-system-i386 \
-qtest stdio -nographic -monitor none -serial none \
-M pc-q35-5.0
outl 0xcf8 0x8400f841
outl 0xcfc 0xebed205d
outl 0x5d02 0xedf82049
EOF

Please let me know if I can provide any further info.
-Alex

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1878642

Title:
  Assertion failure in pci_bus_get_irq_level

Status in QEMU:
  New

Bug description:
  Hello,
  I found an input which triggers an assertion failure in pci_bus_get_irq_l=
evel:

  qemu-system-i386: /home/alxndr/Development/qemu/hw/pci/pci.c:268: int pci=
_bus_get_irq_level(PCIBus *, int): Assertion `irq_num < bus->nirq' failed.
  Aborted
  #0  0x00007ffff686d761 in __GI_raise (sig=3Dsig@entry=3D0x6) at ../sysdep=
s/unix/sysv/linux/raise.c:50
  #1  0x00007ffff685755b in __GI_abort () at abort.c:79
  #2  0x00007ffff685742f in __assert_fail_base (fmt=3D0x7ffff69bdb48 "%s%s%=
s:%u: %s%sAssertion `%s' failed.\n%n", assertion=3D0x555557f9bca0 <str> "ir=
q_num < bus->nirq", file=3D0x555557f9bbe0 <str> "/home/alxndr/Development/q=
emu/hw/pci/pci.c", line=3D0x10c, function=3D<optimized out>) at assert.c:92
  #3  0x00007ffff6866092 in __GI___assert_fail (assertion=3D0x555557f9bca0 =
<str> "irq_num < bus->nirq", file=3D0x555557f9bbe0 <str> "/home/alxndr/Deve=
lopment/qemu/hw/pci/pci.c", line=3D0x10c, function=3D0x555557f9bc40 <__PRET=
TY_FUNCTION__.pci_bus_get_irq_level> "int pci_bus_get_irq_level(PCIBus *, i=
nt)") at assert.c:101
  #4  0x0000555557060c34 in pci_bus_get_irq_level (bus=3D0x61d000096080, ir=
q_num=3D0xef) at /home/alxndr/Development/qemu/hw/pci/pci.c:268
  #5  0x0000555556657391 in ich9_lpc_update_apic (lpc=3D0x62a000006200, gsi=
=3D0xff) at /home/alxndr/Development/qemu/hw/isa/lpc_ich9.c:249
  #6  0x0000555556658ea7 in ich9_set_sci (opaque=3D0x62a000006200, irq_num=
=3D0x0, level=3D0x1) at /home/alxndr/Development/qemu/hw/isa/lpc_ich9.c:354
  #7  0x0000555556ccefc6 in qemu_set_irq (irq=3D0x60600002af80, level=3D0x1=
) at /home/alxndr/Development/qemu/hw/core/irq.c:44
  #8  0x0000555556bc06fd in acpi_update_sci (regs=3D0x62a000006c80, irq=3D0=
x60600002af80) at /home/alxndr/Development/qemu/hw/acpi/core.c:723
  #9  0x0000555556bccb08 in ich9_pm_update_sci_fn (regs=3D0x62a000006c80) a=
t /home/alxndr/Development/qemu/hw/acpi/ich9.c:56
  #10 0x0000555556bc10ee in acpi_pm_evt_write (opaque=3D0x62a000006c80, add=
r=3D0x2, val=3D0x2049, width=3D0x2) at /home/alxndr/Development/qemu/hw/acp=
i/core.c:456
  #11 0x00005555564938b5 in memory_region_write_accessor (mr=3D0x62a000006d=
b0, addr=3D0x2, value=3D0x7fffffff9c70, size=3D0x2, shift=3D0x0, mask=3D0xf=
fff, attrs=3D...) at /home/alxndr/Development/qemu/memory.c:483
  #12 0x000055555649328a in access_with_adjusted_size (addr=3D0x2, value=3D=
0x7fffffff9c70, size=3D0x2, access_size_min=3D0x1, access_size_max=3D0x4, a=
ccess_fn=3D0x555556493360 <memory_region_write_accessor>, mr=3D0x62a000006d=
b0, attrs=3D...) at /home/alxndr/Development/qemu/memory.c:544
  #13 0x0000555556491df6 in memory_region_dispatch_write (mr=3D0x62a000006d=
b0, addr=3D0x2, data=3D0x2049, op=3DMO_16, attrs=3D...) at /home/alxndr/Dev=
elopment/qemu/memory.c:1476
  #14 0x00005555562cbbf4 in flatview_write_continue (fv=3D0x606000033fe0, a=
ddr=3D0x5d02, attrs=3D..., ptr=3D0x7fffffffa4e0, len=3D0x4, addr1=3D0x2, l=
=3D0x2, mr=3D0x62a000006db0) at /home/alxndr/Development/qemu/exec.c:3137
  #15 0x00005555562bbad9 in flatview_write (fv=3D0x606000033fe0, addr=3D0x5=
d02, attrs=3D..., buf=3D0x7fffffffa4e0, len=3D0x4) at /home/alxndr/Developm=
ent/qemu/exec.c:3177
  #16 0x00005555562bb609 in address_space_write (as=3D0x55555968f940 <addre=
ss_space_io>, addr=3D0x5d02, attrs=3D..., buf=3D0x7fffffffa4e0, len=3D0x4) =
at /home/alxndr/Development/qemu/exec.c:3268
  #17 0x0000555556478c0a in cpu_outl (addr=3D0x5d02, val=3D0xedf82049) at /=
home/alxndr/Development/qemu/ioport.c:80
  #18 0x000055555648166f in qtest_process_command (chr=3D0x555559691d00 <qt=
est_chr>, words=3D0x60300009ef20) at /home/alxndr/Development/qemu/qtest.c:=
396
  #19 0x000055555647f187 in qtest_process_inbuf (chr=3D0x555559691d00 <qtes=
t_chr>, inbuf=3D0x61900000f680) at /home/alxndr/Development/qemu/qtest.c:710
  #20 0x000055555647e8b4 in qtest_read (opaque=3D0x555559691d00 <qtest_chr>=
, buf=3D0x7fffffffca40 "outl 0xcf8 0x8400f841\noutl 0xcfc 0xebed205d\noutl =
0x5d02 0xedf82049\n-M pc-q35-5.0 -device intel-hda,id=3Dhda0 -device hda-ou=
tput,bus=3Dhda0.0 -device hda-micro,bus=3Dhda0.0 -device hda-duplex,bus=3Dh=
da0.0 -display none -nodefaults -nographic\n", size=3D0xe9) at /home/alxndr=
/Development/qemu/qtest.c:722
  #21 0x00005555579c260c in qemu_chr_be_write_impl (s=3D0x60f000001f30, buf=
=3D0x7fffffffca40 "outl 0xcf8 0x8400f841\noutl 0xcfc 0xebed205d\noutl 0x5d0=
2 0xedf82049\n-M pc-q35-5.0 -device intel-hda,id=3Dhda0 -device hda-output,=
bus=3Dhda0.0 -device hda-micro,bus=3Dhda0.0 -device hda-duplex,bus=3Dhda0.0=
 -display none -nodefaults -nographic\n", len=3D0xe9) at /home/alxndr/Devel=
opment/qemu/chardev/char.c:183
  #22 0x00005555579c275b in qemu_chr_be_write (s=3D0x60f000001f30, buf=3D0x=
7fffffffca40 "outl 0xcf8 0x8400f841\noutl 0xcfc 0xebed205d\noutl 0x5d02 0xe=
df82049\n-M pc-q35-5.0 -device intel-hda,id=3Dhda0 -device hda-output,bus=
=3Dhda0.0 -device hda-micro,bus=3Dhda0.0 -device hda-duplex,bus=3Dhda0.0 -d=
isplay none -nodefaults -nographic\n", len=3D0xe9) at /home/alxndr/Developm=
ent/qemu/chardev/char.c:195
  #23 0x00005555579cb97a in fd_chr_read (chan=3D0x6080000026a0, cond=3DG_IO=
_IN, opaque=3D0x60f000001f30) at /home/alxndr/Development/qemu/chardev/char=
-fd.c:68
  #24 0x0000555557a530ea in qio_channel_fd_source_dispatch (source=3D0x60c0=
0002ef00, callback=3D0x5555579cb540 <fd_chr_read>, user_data=3D0x60f000001f=
30) at /home/alxndr/Development/qemu/io/channel-watch.c:84
  #25 0x00007ffff7ca8898 in g_main_context_dispatch () at /usr/lib/x86_64-l=
inux-gnu/libglib-2.0.so.0
  #26 0x0000555557c10b85 in glib_pollfds_poll () at /home/alxndr/Developmen=
t/qemu/util/main-loop.c:219
  #27 0x0000555557c0f57e in os_host_main_loop_wait (timeout=3D0x0) at /home=
/alxndr/Development/qemu/util/main-loop.c:242
  #28 0x0000555557c0f177 in main_loop_wait (nonblocking=3D0x0) at /home/alx=
ndr/Development/qemu/util/main-loop.c:518
  #29 0x000055555689fd1e in qemu_main_loop () at /home/alxndr/Development/q=
emu/softmmu/vl.c:1664
  #30 0x0000555557a6a29d in main (argc=3D0x17, argv=3D0x7fffffffe148, envp=
=3D0x7fffffffe208) at /home/alxndr/Development/qemu/softmmu/main.c:49

  I can reproduce this in qemu 5.0 using these qtest commands:

  cat << EOF | ./qemu-system-i386 \
  -qtest stdio -nographic -monitor none -serial none \
  -M pc-q35-5.0
  outl 0xcf8 0x8400f841
  outl 0xcfc 0xebed205d
  outl 0x5d02 0xedf82049
  EOF

  Please let me know if I can provide any further info.
  -Alex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1878642/+subscriptions

