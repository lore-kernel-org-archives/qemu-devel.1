Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45B1C0650E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 22:41:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DCC12189E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 22:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DCC12189E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjAQ9-00066Q-HJ
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 18:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33627)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hjAPQ-0005hM-2u
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 18:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hjAPN-0002Bt-Nm
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 18:40:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:46798)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hjAPN-0002BW-Em
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 18:40:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hjAPL-0000KO-Gx
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 22:40:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7915F2E802E
 for <qemu-devel@nongnu.org>; Thu,  4 Jul 2019 22:40:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jul 2019 22:33:45 -0000
From: Jakub Jankowski <1835466@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: shastah
X-Launchpad-Bug-Reporter: Jakub Jankowski (shastah)
X-Launchpad-Bug-Modifier: Jakub Jankowski (shastah)
Message-Id: <156227962582.22875.12169494608827824655.malonedeb@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19007";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: e78b8cc70c7f825226680684667a04b754434b41
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1835466] [NEW] qemu 4.0.0 abort()s in
 audio_get_pdo_in (poisoned drv->driver?)
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
Reply-To: Bug 1835466 <1835466@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

After upgrading qemu from 3.0.0 to 4.0.0 (compiled from release
tarball), I'm seeing a (reproducible) crash related to audio subsystem.

I recompiled qemu with debugging options and got it to crash under gdb:

Thread 6 "qemu-system-x86" received signal SIGABRT, Aborted.
0x00007ffff52e420b in raise () from /lib64/libc.so.6
(gdb) bt
#0  0x00007ffff52e420b in raise () at /lib64/libc.so.6
#1  0x00007ffff52c6524 in abort () at /lib64/libc.so.6
#2  0x000000000041ec33 in audio_get_pdo_in (dev=3D<optimized out>) at audio=
/audio_template.h:328
#3  0x00000000005d0123 in AUD_open_in
    (card=3D0x7ffdde98dbc8, sw=3D0x7ffff17444e0, name=3D0x999d80 "adc", cal=
lback_opaque=3Dcallback_opaque@entry=3D0x7ffdde98fd58, callback_fn=3D0x6109=
40 <hda_audio_input_cb>, as=3Das@entry=3D0x7ffdde98fd84) at audio/audio_tem=
plate.h:434
#4  0x000000000060fe2e in hda_audio_setup (st=3D0x7ffdde98fd58) at hw/audio=
/hda-codec.c:490
#5  0x000000000061051b in hda_audio_command (hda=3D0x7ffdde98db40, nid=3D4,=
 data=3D<optimized out>) at hw/audio/hda-codec.c:590
#6  0x000000000060ea20 in intel_hda_send_command (d=3Dd@entry=3D0x7ffff0a2f=
c00, verb=3Dverb@entry=3D4341777) at hw/audio/intel-hda.c:301
#7  0x000000000060ebbe in intel_hda_corb_run (d=3D<optimized out>) at hw/au=
dio/intel-hda.c:336
#8  0x000000000060ebbe in intel_hda_corb_run (d=3D0x7ffff0a2fc00) at hw/aud=
io/intel-hda.c:305
#9  0x0000000000495b99 in memory_region_write_accessor
    (mr=3Dmr@entry=3D0x7ffff0a307a0, addr=3D72, value=3Dvalue@entry=3D0x7ff=
feddfe568, size=3Dsize@entry=3D2, shift=3D<optimized out>, mask=3Dmask@entr=
y=3D65535, attrs=3D...)
    at memory.c:502
#10 0x000000000049448e in access_with_adjusted_size
    (addr=3Daddr@entry=3D72, value=3Dvalue@entry=3D0x7fffeddfe568, size=3Ds=
ize@entry=3D2, access_size_min=3D<optimized out>, access_size_max=3D<optimi=
zed out>, access_fn=3Daccess_fn@entry=3D0x495b10 <memory_region_write_acces=
sor>, mr=3D0x7ffff0a307a0, attrs=3D...) at memory.c:568
#11 0x00000000004974f3 in memory_region_dispatch_write (mr=3Dmr@entry=3D0x7=
ffff0a307a0, addr=3D72, data=3D<optimized out>, size=3D2, attrs=3Dattrs@ent=
ry=3D...)
    at memory.c:1496
#12 0x000000000042afbc in flatview_write_continue
    (fv=3Dfv@entry=3D0x7ffdd36ef5c0, addr=3Daddr@entry=3D4228186184, attrs=
=3D..., buf=3Dbuf@entry=3D0x7ffff66c7028 <incomplete sequence \311>, len=3D=
len@entry=3D2, addr1=3D<optimized out>, l=3D<optimized out>, mr=3D0x7ffff0a=
307a0) at exec.c:3279
#13 0x000000000042b1d6 in flatview_write
    (fv=3D0x7ffdd36ef5c0, addr=3Daddr@entry=3D4228186184, attrs=3Dattrs@ent=
ry=3D..., buf=3Dbuf@entry=3D0x7ffff66c7028 <incomplete sequence \311>, len=
=3Dlen@entry=3D2)
    at exec.c:3318
#14 0x000000000042e2a6 in address_space_write
    (as=3D0xfc5080 <address_space_memory>, addr=3D4228186184, attrs=3D..., =
buf=3Dbuf@entry=3D0x7ffff66c7028 <incomplete sequence \311>, len=3D2)
    at exec.c:3408
#15 0x000000000042e33a in address_space_rw (as=3D<optimized out>, addr=3D<o=
ptimized out>, attrs=3D..., =

    attrs@entry=3D..., buf=3Dbuf@entry=3D0x7ffff66c7028 <incomplete sequenc=
e \311>, len=3D<optimized out>, is_write=3D<optimized out>) at exec.c:3419
#16 0x00000000004ac3c6 in kvm_cpu_exec (cpu=3Dcpu@entry=3D0x7ffff0a81140) a=
t accel/kvm/kvm-all.c:2034
#17 0x00000000004812ae in qemu_kvm_cpu_thread_fn (arg=3D0x7ffff0a81140) at =
cpus.c:1281
#18 0x00000000004812ae in qemu_kvm_cpu_thread_fn (arg=3Darg@entry=3D0x7ffff=
0a81140) at cpus.c:1254
#19 0x000000000089d0eb in qemu_thread_start (args=3D<optimized out>) at uti=
l/qemu-thread-posix.c:502
#20 0x00007ffff549319c in start_thread () at /lib64/libpthread.so.0
#21 0x00007ffff53ba4af in clone () at /lib64/libc.so.6


After some poking around, I think there's something overwriting dev->driver=
 so this switch(dev->driver) statement falls through to abort(): https://gi=
t.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Daudio/audio_template.h;h=3D1232bb54db=
0e7073e60e3ccb72c1ed72cf5e3831;hb=3D131b9a05705636086699df15d4a6d328bb2585e=
8#l304


Here's why I think so:

$ export QEMU_AUDIO_DRV=3Dpa
$ gdb /usr/bin/qemu-system-x86_64
(gdb) b qpa_audio_init
Breakpoint 1 at 0x79bcb0: file audio/paaudio.c, line 831.
(gdb) b audio_get_pdo_in
Breakpoint 2 at 0x5ce320: file audio/audio_template.h, line 304.
(gdb) run -enable-kvm -cpu Nehalem -machine q35 -device intel-iommu -name W=
orkstation -smp 4 -m 8G -soundhw hda -rtc base=3Dlocaltime -drive file=3Dwo=
rkstation-disk0.qcow2,if=3Dvirtio,format=3Dqcow2 -drive file=3Dworkstation-=
disk1.qcow2,if=3Dvirtio,format=3Dqcow2 -net nic,model=3Dvirtio,macaddr=3Daa=
:bb:cc:dd:ee:ff -net tap,ifname=3Dtap42 -monitor telnet:127.0.0.1:7043,serv=
er,nowait -pidfile workstation.pid -vga qxl -global qxl-vga.vgamem_mb=3D64 =
-device usb-ehci,id=3Dehci -device usb-host,vendorid=3D0x1390,productid=3D0=
x5454,bus=3Dehci.0 -device usb-host,vendorid=3D0x054c,bus=3Dehci.0 -device =
usb-tablet -device nec-usb-xhci,id=3Dxhci -device usb-host,vendorid=3D0x10c=
4,productid=3D0x888e,bus=3Dxhci.0

Thread 1 "qemu-system-x86" hit Breakpoint 1, qpa_audio_init (dev=3D0x7ffff1=
61b6a0) at audio/paaudio.c:831
(gdb) p (*dev)->driver
$1 =3D AUDIODEV_DRIVER_PA
(gdb) p/d AUDIODEV_DRIVER_PA
$2 =3D 5
(gdb) cont
Continuing.
[Thread 0x7ffff09ff700 (LWP 4078) exited]
audio: warning: Using timer based audio emulation
Thread 1 "qemu-system-x86" hit Breakpoint 2, audio_get_pdo_in (dev=3D0x7fff=
f161b6a0) at audio/audio_template.h:304
(gdb) p (*dev)->driver
$3 =3D AUDIODEV_DRIVER_PA
(gdb) cont
Continuing.

Thread 1 "qemu-system-x86" hit Breakpoint 2, audio_get_pdo_in (dev=3D0x7fff=
f161b6a0) at audio/audio_template.h:304
(gdb) p (*dev)->driver
$4 =3D AUDIODEV_DRIVER_PA
(gdb) cont
Continuing.

Thread 1 "qemu-system-x86" hit Breakpoint 2, audio_get_pdo_in (dev=3D0x7fff=
f161b6a0) at audio/audio_template.h:304
(gdb) p (*dev)->driver
$5 =3D AUDIODEV_DRIVER_PA
(gdb) cont
Continuing.
[New Thread 0x7ffff09ff700 (LWP 4483)]
[New Thread 0x7ffddcdff700 (LWP 4489)]
[New Thread 0x7ffddbdff700 (LWP 4490)]
[New Thread 0x7ffddb1ff700 (LWP 4491)]
[New Thread 0x7ffdd2dff700 (LWP 4494)]
[New Thread 0x7ffdd25fe700 (LWP 4495)]
[New Thread 0x7ffdd1dfd700 (LWP 4497)]
[New Thread 0x7ffdda5ff700 (LWP 4500)]
[New Thread 0x7ffdcedff700 (LWP 4501)]
qemu-system-x86_64: warning: guest updated active QH
[Switching to Thread 0x7fffef7ff700 (LWP 4097)]

Thread 4 "qemu-system-x86" hit Breakpoint 2, audio_get_pdo_in (dev=3D0x7fff=
f161b6a0) at audio/audio_template.h:304
(gdb) p (*dev)->driver
$6 =3D 176


For what it's worth, guest is Fedora 29, host is a Slackware system with qe=
mu compiled (manually) with these options:

CFLAGS=3D"-O2 -fPIC" \
CXXFLAGS=3D"-O2 -fPIC" \
./configure \
  --prefix=3D/usr --libdir=3D/usr/lib64 --sysconfdir=3D/etc --localstatedir=
=3D/var \
  --enable-gtk \
  --enable-system \
  --enable-kvm \
  --enable-virtfs \
  --enable-sdl \
  --enable-gnutls \
  --enable-curses \
  --enable-virtfs \
  --enable-curl \
  --enable-linux-aio \
  --enable-vhost-net \
  --enable-spice \
  --enable-libusb \
  --enable-usb-redir \
  --enable-lzo \
  --enable-bzip2 \
  --enable-libssh2 \
  --enable-numa \
  --enable-jemalloc \
  --enable-opengl \
  --audio-drv-list=3Dalsa,oss,sdl,pa \
  --enable-vnc --enable-vnc-sasl --enable-vnc-png --enable-vnc-jpeg \
  --target-list=3Di386-softmmu,x86_64-softmmu,i386-linux-user,x86_64-linux-=
user,arm-softmmu,arm-linux-user,armeb-linux-user,sparc64-softmmu,sparc-soft=
mmu,sparc32plus-linux-user,sparc64-linux-user \
  --enable-debug --extra-cflags=3D"-g3" --extra-ldflags=3D"-g3" --disable-s=
trip --disable-pie  # For debugging only

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1835466

Title:
  qemu 4.0.0 abort()s in audio_get_pdo_in (poisoned drv->driver?)

Status in QEMU:
  New

Bug description:
  After upgrading qemu from 3.0.0 to 4.0.0 (compiled from release
  tarball), I'm seeing a (reproducible) crash related to audio
  subsystem.

  I recompiled qemu with debugging options and got it to crash under
  gdb:

  Thread 6 "qemu-system-x86" received signal SIGABRT, Aborted.
  0x00007ffff52e420b in raise () from /lib64/libc.so.6
  (gdb) bt
  #0  0x00007ffff52e420b in raise () at /lib64/libc.so.6
  #1  0x00007ffff52c6524 in abort () at /lib64/libc.so.6
  #2  0x000000000041ec33 in audio_get_pdo_in (dev=3D<optimized out>) at aud=
io/audio_template.h:328
  #3  0x00000000005d0123 in AUD_open_in
      (card=3D0x7ffdde98dbc8, sw=3D0x7ffff17444e0, name=3D0x999d80 "adc", c=
allback_opaque=3Dcallback_opaque@entry=3D0x7ffdde98fd58, callback_fn=3D0x61=
0940 <hda_audio_input_cb>, as=3Das@entry=3D0x7ffdde98fd84) at audio/audio_t=
emplate.h:434
  #4  0x000000000060fe2e in hda_audio_setup (st=3D0x7ffdde98fd58) at hw/aud=
io/hda-codec.c:490
  #5  0x000000000061051b in hda_audio_command (hda=3D0x7ffdde98db40, nid=3D=
4, data=3D<optimized out>) at hw/audio/hda-codec.c:590
  #6  0x000000000060ea20 in intel_hda_send_command (d=3Dd@entry=3D0x7ffff0a=
2fc00, verb=3Dverb@entry=3D4341777) at hw/audio/intel-hda.c:301
  #7  0x000000000060ebbe in intel_hda_corb_run (d=3D<optimized out>) at hw/=
audio/intel-hda.c:336
  #8  0x000000000060ebbe in intel_hda_corb_run (d=3D0x7ffff0a2fc00) at hw/a=
udio/intel-hda.c:305
  #9  0x0000000000495b99 in memory_region_write_accessor
      (mr=3Dmr@entry=3D0x7ffff0a307a0, addr=3D72, value=3Dvalue@entry=3D0x7=
fffeddfe568, size=3Dsize@entry=3D2, shift=3D<optimized out>, mask=3Dmask@en=
try=3D65535, attrs=3D...)
      at memory.c:502
  #10 0x000000000049448e in access_with_adjusted_size
      (addr=3Daddr@entry=3D72, value=3Dvalue@entry=3D0x7fffeddfe568, size=
=3Dsize@entry=3D2, access_size_min=3D<optimized out>, access_size_max=3D<op=
timized out>, access_fn=3Daccess_fn@entry=3D0x495b10 <memory_region_write_a=
ccessor>, mr=3D0x7ffff0a307a0, attrs=3D...) at memory.c:568
  #11 0x00000000004974f3 in memory_region_dispatch_write (mr=3Dmr@entry=3D0=
x7ffff0a307a0, addr=3D72, data=3D<optimized out>, size=3D2, attrs=3Dattrs@e=
ntry=3D...)
      at memory.c:1496
  #12 0x000000000042afbc in flatview_write_continue
      (fv=3Dfv@entry=3D0x7ffdd36ef5c0, addr=3Daddr@entry=3D4228186184, attr=
s=3D..., buf=3Dbuf@entry=3D0x7ffff66c7028 <incomplete sequence \311>, len=
=3Dlen@entry=3D2, addr1=3D<optimized out>, l=3D<optimized out>, mr=3D0x7fff=
f0a307a0) at exec.c:3279
  #13 0x000000000042b1d6 in flatview_write
      (fv=3D0x7ffdd36ef5c0, addr=3Daddr@entry=3D4228186184, attrs=3Dattrs@e=
ntry=3D..., buf=3Dbuf@entry=3D0x7ffff66c7028 <incomplete sequence \311>, le=
n=3Dlen@entry=3D2)
      at exec.c:3318
  #14 0x000000000042e2a6 in address_space_write
      (as=3D0xfc5080 <address_space_memory>, addr=3D4228186184, attrs=3D...=
, buf=3Dbuf@entry=3D0x7ffff66c7028 <incomplete sequence \311>, len=3D2)
      at exec.c:3408
  #15 0x000000000042e33a in address_space_rw (as=3D<optimized out>, addr=3D=
<optimized out>, attrs=3D..., =

      attrs@entry=3D..., buf=3Dbuf@entry=3D0x7ffff66c7028 <incomplete seque=
nce \311>, len=3D<optimized out>, is_write=3D<optimized out>) at exec.c:3419
  #16 0x00000000004ac3c6 in kvm_cpu_exec (cpu=3Dcpu@entry=3D0x7ffff0a81140)=
 at accel/kvm/kvm-all.c:2034
  #17 0x00000000004812ae in qemu_kvm_cpu_thread_fn (arg=3D0x7ffff0a81140) a=
t cpus.c:1281
  #18 0x00000000004812ae in qemu_kvm_cpu_thread_fn (arg=3Darg@entry=3D0x7ff=
ff0a81140) at cpus.c:1254
  #19 0x000000000089d0eb in qemu_thread_start (args=3D<optimized out>) at u=
til/qemu-thread-posix.c:502
  #20 0x00007ffff549319c in start_thread () at /lib64/libpthread.so.0
  #21 0x00007ffff53ba4af in clone () at /lib64/libc.so.6

  =

  After some poking around, I think there's something overwriting dev->driv=
er so this switch(dev->driver) statement falls through to abort(): https://=
git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Daudio/audio_template.h;h=3D1232bb54=
db0e7073e60e3ccb72c1ed72cf5e3831;hb=3D131b9a05705636086699df15d4a6d328bb258=
5e8#l304

  =

  Here's why I think so:

  $ export QEMU_AUDIO_DRV=3Dpa
  $ gdb /usr/bin/qemu-system-x86_64
  (gdb) b qpa_audio_init
  Breakpoint 1 at 0x79bcb0: file audio/paaudio.c, line 831.
  (gdb) b audio_get_pdo_in
  Breakpoint 2 at 0x5ce320: file audio/audio_template.h, line 304.
  (gdb) run -enable-kvm -cpu Nehalem -machine q35 -device intel-iommu -name=
 Workstation -smp 4 -m 8G -soundhw hda -rtc base=3Dlocaltime -drive file=3D=
workstation-disk0.qcow2,if=3Dvirtio,format=3Dqcow2 -drive file=3Dworkstatio=
n-disk1.qcow2,if=3Dvirtio,format=3Dqcow2 -net nic,model=3Dvirtio,macaddr=3D=
aa:bb:cc:dd:ee:ff -net tap,ifname=3Dtap42 -monitor telnet:127.0.0.1:7043,se=
rver,nowait -pidfile workstation.pid -vga qxl -global qxl-vga.vgamem_mb=3D6=
4 -device usb-ehci,id=3Dehci -device usb-host,vendorid=3D0x1390,productid=
=3D0x5454,bus=3Dehci.0 -device usb-host,vendorid=3D0x054c,bus=3Dehci.0 -dev=
ice usb-tablet -device nec-usb-xhci,id=3Dxhci -device usb-host,vendorid=3D0=
x10c4,productid=3D0x888e,bus=3Dxhci.0

  Thread 1 "qemu-system-x86" hit Breakpoint 1, qpa_audio_init (dev=3D0x7fff=
f161b6a0) at audio/paaudio.c:831
  (gdb) p (*dev)->driver
  $1 =3D AUDIODEV_DRIVER_PA
  (gdb) p/d AUDIODEV_DRIVER_PA
  $2 =3D 5
  (gdb) cont
  Continuing.
  [Thread 0x7ffff09ff700 (LWP 4078) exited]
  audio: warning: Using timer based audio emulation
  Thread 1 "qemu-system-x86" hit Breakpoint 2, audio_get_pdo_in (dev=3D0x7f=
fff161b6a0) at audio/audio_template.h:304
  (gdb) p (*dev)->driver
  $3 =3D AUDIODEV_DRIVER_PA
  (gdb) cont
  Continuing.

  Thread 1 "qemu-system-x86" hit Breakpoint 2, audio_get_pdo_in (dev=3D0x7f=
fff161b6a0) at audio/audio_template.h:304
  (gdb) p (*dev)->driver
  $4 =3D AUDIODEV_DRIVER_PA
  (gdb) cont
  Continuing.

  Thread 1 "qemu-system-x86" hit Breakpoint 2, audio_get_pdo_in (dev=3D0x7f=
fff161b6a0) at audio/audio_template.h:304
  (gdb) p (*dev)->driver
  $5 =3D AUDIODEV_DRIVER_PA
  (gdb) cont
  Continuing.
  [New Thread 0x7ffff09ff700 (LWP 4483)]
  [New Thread 0x7ffddcdff700 (LWP 4489)]
  [New Thread 0x7ffddbdff700 (LWP 4490)]
  [New Thread 0x7ffddb1ff700 (LWP 4491)]
  [New Thread 0x7ffdd2dff700 (LWP 4494)]
  [New Thread 0x7ffdd25fe700 (LWP 4495)]
  [New Thread 0x7ffdd1dfd700 (LWP 4497)]
  [New Thread 0x7ffdda5ff700 (LWP 4500)]
  [New Thread 0x7ffdcedff700 (LWP 4501)]
  qemu-system-x86_64: warning: guest updated active QH
  [Switching to Thread 0x7fffef7ff700 (LWP 4097)]

  Thread 4 "qemu-system-x86" hit Breakpoint 2, audio_get_pdo_in (dev=3D0x7f=
fff161b6a0) at audio/audio_template.h:304
  (gdb) p (*dev)->driver
  $6 =3D 176

  =

  For what it's worth, guest is Fedora 29, host is a Slackware system with =
qemu compiled (manually) with these options:

  CFLAGS=3D"-O2 -fPIC" \
  CXXFLAGS=3D"-O2 -fPIC" \
  ./configure \
    --prefix=3D/usr --libdir=3D/usr/lib64 --sysconfdir=3D/etc --localstated=
ir=3D/var \
    --enable-gtk \
    --enable-system \
    --enable-kvm \
    --enable-virtfs \
    --enable-sdl \
    --enable-gnutls \
    --enable-curses \
    --enable-virtfs \
    --enable-curl \
    --enable-linux-aio \
    --enable-vhost-net \
    --enable-spice \
    --enable-libusb \
    --enable-usb-redir \
    --enable-lzo \
    --enable-bzip2 \
    --enable-libssh2 \
    --enable-numa \
    --enable-jemalloc \
    --enable-opengl \
    --audio-drv-list=3Dalsa,oss,sdl,pa \
    --enable-vnc --enable-vnc-sasl --enable-vnc-png --enable-vnc-jpeg \
    --target-list=3Di386-softmmu,x86_64-softmmu,i386-linux-user,x86_64-linu=
x-user,arm-softmmu,arm-linux-user,armeb-linux-user,sparc64-softmmu,sparc-so=
ftmmu,sparc32plus-linux-user,sparc64-linux-user \
    --enable-debug --extra-cflags=3D"-g3" --extra-ldflags=3D"-g3" --disable=
-strip --disable-pie  # For debugging only

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1835466/+subscriptions

