Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2130C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 14:12:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB17206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 14:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB17206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43324 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYWeR-0006gr-C8
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 10:12:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hYWd0-0005l8-87
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:11:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hYWcu-00041l-9G
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:10:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:46008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hYWct-0003zP-VM
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:10:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hYWcs-0002aI-4H
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 14:10:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1E9E72E8055
	for <qemu-devel@nongnu.org>; Wed,  5 Jun 2019 14:10:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Jun 2019 13:58:55 -0000
From: =?utf-8?b?6LSe6LS15p2O?= <1831750@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: lizhengui
X-Launchpad-Bug-Reporter: =?utf-8?b?6LSe6LS15p2OIChsaXpoZW5ndWkp?=
X-Launchpad-Bug-Modifier: =?utf-8?b?6LSe6LS15p2OIChsaXpoZW5ndWkp?=
Message-Id: <155974313583.12691.6701565983030170702.malonedeb@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18968";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 424c6808930aaffecd3807828db7dcf8ccccb41b
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1831750] [NEW] virtual machine cpu soft lockup
 when qemu attach disk
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1831750 <1831750@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hi,  I found a problem that virtual machine cpu soft lockup when I
attach a disk to the vm in the case that

backend storage network has a large delay or IO pressure is too large.

1) The disk xml which I attached is:

    <disk type=3D'block' device=3D'lun' rawio=3D'yes'>
      <driver name=3D'qemu' type=3D'raw' cache=3D'none' io=3D'native'/>
      <source dev=3D'/dev/mapper/360022a11000c1e0a0787c23a000001cb'/>
      <backingStore/>
      <target dev=3D'sdb' bus=3D'scsi'/>
      <alias name=3D'scsi0-0-1-0'/>
      <address type=3D'drive' controller=3D'0' bus=3D'0' target=3D'1' unit=
=3D'0'/>
    </disk>

2) The bt of qemu main thread:

#0 0x0000ffff9d78402c in pread64 () from /lib64/libpthread.so.0
#1 0x0000aaaace3357d8 in pread64 (__offset=3D0, __nbytes=3D4096, __buf=3D0x=
aaaad47a5200, __fd=3D202) at /usr/include/bits/unistd.h:99
#2 raw_is_io_aligned (fd=3Dfd@entry=3D202, buf=3Dbuf@entry=3D0xaaaad47a5200=
, len=3Dlen@entry=3D4096) at block/raw_posix.c:294
#3 0x0000aaaace33597c in raw_probe_alignment (bs=3Dbs@entry=3D0xaaaad32ea92=
0, fd=3D202, errp=3Derrp@entry=3D0xfffffef7a330) at block/raw_posix.c:349
#4 0x0000aaaace335a48 in raw_refresh_limits (bs=3D0xaaaad32ea920, errp=3D0x=
fffffef7a330) at block/raw_posix.c:811
#5 0x0000aaaace3404b0 in bdrv_refresh_limits (bs=3D0xaaaad32ea920, errp=3D0=
xfffffef7a330, errp@entry=3D0xfffffef7a360) at block/io.c:122
#6 0x0000aaaace340504 in bdrv_refresh_limits (bs=3Dbs@entry=3D0xaaaad09ce80=
0, errp=3Derrp@entry=3D0xfffffef7a3b0) at block/io.c:97
#7 0x0000aaaace2eb9f0 in bdrv_open_common (bs=3Dbs@entry=3D0xaaaad09ce800, =
file=3Dfile@entry=3D0xaaaad0e89800, options=3D<optimized out>, errp=3Derrp@=
entry=3D0xfffffef7a450)
at block.c:1194
#8 0x0000aaaace2eedec in bdrv_open_inherit (filename=3D<optimized out>, fil=
ename@entry=3D0xaaaad25f92d0 "/dev/mapper/36384c4f100630193359db7a80000011d=
",
reference=3Dreference@entry=3D0x0, options=3D<optimized out>, options@entry=
=3D0xaaaad3d0f4b0, flags=3D<optimized out>, flags@entry=3D128, parent=3Dpar=
ent@entry=3D0x0,
child_role=3Dchild_role@entry=3D0x0, errp=3Derrp@entry=3D0xfffffef7a710) at=
 block.c:1895
#9 0x0000aaaace2ef510 in bdrv_open (filename=3Dfilename@entry=3D0xaaaad25f9=
2d0 "/dev/mapper/36384c4f100630193359db7a80000011d", reference=3Dreference@=
entry=3D0x0,
options=3Doptions@entry=3D0xaaaad3d0f4b0, flags=3Dflags@entry=3D128, errp=
=3Derrp@entry=3D0xfffffef7a710) at block.c:1979
#10 0x0000aaaace331ef0 in blk_new_open (filename=3Dfilename@entry=3D0xaaaad=
25f92d0 "/dev/mapper/36384c4f100630193359db7a80000011d", reference=3Drefere=
nce@entry=3D0x0,
options=3Doptions@entry=3D0xaaaad3d0f4b0, flags=3D128, errp=3Derrp@entry=3D=
0xfffffef7a710) at block/block_backend.c:213
#11 0x0000aaaace0da1f4 in blockdev_init (file=3Dfile@entry=3D0xaaaad25f92d0=
 "/dev/mapper/36384c4f100630193359db7a80000011d", bs_opts=3Dbs_opts@entry=
=3D0xaaaad3d0f4b0,
errp=3Derrp@entry=3D0xfffffef7a710) at blockdev.c:603
#12 0x0000aaaace0dc478 in drive_new (all_opts=3Dall_opts@entry=3D0xaaaad4dc=
31d0, block_default_type=3D<optimized out>) at blockdev.c:1116
#13 0x0000aaaace0e3ee0 in add_init_drive (
optstr=3Doptstr@entry=3D0xaaaad0872ec0 "file=3D/dev/mapper/36384c4f10063019=
3359db7a80000011d,format=3Draw,if=3Dnone,id=3Ddrive-scsi0-0-0-3,cache=3Dnon=
e,aio=3Dnative")
at device_hotplug.c:46
#14 0x0000aaaace0e3f78 in hmp_drive_add (mon=3D0xfffffef7a810, qdict=3D0xaa=
aad0c8f000) at device_hotplug.c:67
#15 0x0000aaaacdf7d688 in handle_hmp_command (mon=3D0xfffffef7a810, cmdline=
=3D<optimized out>) at /usr/src/debug/qemu-kvm-2.8.1/monitor.c:3199
#16 0x0000aaaacdf7d778 in qmp_human_monitor_command (
command_line=3D0xaaaacfc8e3c0 "drive_add dummy file=3D/dev/mapper/36384c4f1=
00630193359db7a80000011d,format=3Draw,if=3Dnone,id=3Ddrive-scsi0-0-0-3,cach=
e=3Dnone,aio=3Dnative",
has_cpu_index=3Dfalse, cpu_index=3D0, errp=3Derrp@entry=3D0xfffffef7a968) a=
t /usr/src/debug/qemu-kvm-2.8.1/monitor.c:660
#17 0x0000aaaace0fdb30 in qmp_marshal_human_monitor_command (args=3D<optimi=
zed out>, ret=3D0xfffffef7a9e0, errp=3D0xfffffef7a9d8) at qmp-marshal.c:2223
#18 0x0000aaaace3b6ad0 in do_qmp_dispatch (request=3D<optimized out>, errp=
=3D0xfffffef7aa20, errp@entry=3D0xfffffef7aa40) at qapi/qmp_dispatch.c:115
#19 0x0000aaaace3b6d58 in qmp_dispatch (request=3D<optimized out>) at qapi/=
qmp_dispatch.c:142
#20 0x0000aaaacdf79398 in handle_qmp_command (parser=3D<optimized out>, tok=
ens=3D<optimized out>) at /usr/src/debug/qemu-kvm-2.8.1/monitor.c:4010
#21 0x0000aaaace3bd6c0 in json_message_process_token (lexer=3D0xaaaacf834c8=
0, input=3D<optimized out>, type=3DJSON_RCURLY, x=3D214, y=3D274) at qobjec=
t/json_streamer.c:105
#22 0x0000aaaace3f3d4c in json_lexer_feed_char (lexer=3Dlexer@entry=3D0xaaa=
acf834c80, ch=3D<optimized out>, flush=3Dflush@entry=3Dfalse) at qobject/js=
on_lexer.c:319
#23 0x0000aaaace3f3e6c in json_lexer_feed (lexer=3D0xaaaacf834c80, buffer=
=3D<optimized out>, size=3D<optimized out>) at qobject/json_lexer.c:369
#24 0x0000aaaacdf77c64 in monitor_qmp_read (opaque=3D<optimized out>, buf=
=3D<optimized out>, size=3D<optimized out>) at /usr/src/debug/qemu-kvm-2.8.=
1/monitor.c:4040
#25 0x0000aaaace0eab18 in tcp_chr_read (chan=3D<optimized out>, cond=3D<opt=
imized out>, opaque=3D0xaaaacf90b280) at qemu_char.c:3260
#26 0x0000ffff9dadf200 in g_main_context_dispatch () from /lib64/libglib-2.=
0.so.0
#27 0x0000aaaace3c4a00 in glib_pollfds_poll () at util/main_loop.c:230
--Type <RET> for more, q to quit, c to continue without paging--
#28 0x0000aaaace3c4a88 in os_host_main_loop_wait (timeout=3D<optimized out>=
) at util/main_loop.c:278
#29 0x0000aaaace3c4bf0 in main_loop_wait (nonblocking=3D<optimized out>) at=
 util/main_loop.c:534
#30 0x0000aaaace0f5d08 in main_loop () at vl.c:2120
#31 0x0000aaaacdf3a770 in main (argc=3D<optimized out>, argv=3D<optimized o=
ut>, envp=3D<optimized out>) at vl.c:5017


>From the bt we can see,  when do qmp sush as drive_add,  qemu main thread l=
ocks the qemu_global_mutex  and do pread in raw_probe_alignmen. Pread is a =
synchronous operation. If backend storage network has a large delay or IO p=
ressure is too large,  the pread operation will not return for a long time,=
 which make vcpu thread can't acquire qemu_global_mutex for a long time and=
 make the vcpu thread unable to be scheduled for a long time.  So virtual m=
achine cpu soft lockup happened.


I thank  qemu main thread should not hold qemu_global_mutex for a long time=
 when do qmp that involving IO synchronous operation sush pread , ioctl, et=
c.

Do you have any solutions or good ideas about it? Thanks for your reply!

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1831750

Title:
  virtual machine cpu soft lockup when qemu attach disk

Status in QEMU:
  New

Bug description:
  Hi,  I found a problem that virtual machine cpu soft lockup when I
  attach a disk to the vm in the case that

  backend storage network has a large delay or IO pressure is too large.

  1) The disk xml which I attached is:

      <disk type=3D'block' device=3D'lun' rawio=3D'yes'>
        <driver name=3D'qemu' type=3D'raw' cache=3D'none' io=3D'native'/>
        <source dev=3D'/dev/mapper/360022a11000c1e0a0787c23a000001cb'/>
        <backingStore/>
        <target dev=3D'sdb' bus=3D'scsi'/>
        <alias name=3D'scsi0-0-1-0'/>
        <address type=3D'drive' controller=3D'0' bus=3D'0' target=3D'1' uni=
t=3D'0'/>
      </disk>

  2) The bt of qemu main thread:

  #0 0x0000ffff9d78402c in pread64 () from /lib64/libpthread.so.0
  #1 0x0000aaaace3357d8 in pread64 (__offset=3D0, __nbytes=3D4096, __buf=3D=
0xaaaad47a5200, __fd=3D202) at /usr/include/bits/unistd.h:99
  #2 raw_is_io_aligned (fd=3Dfd@entry=3D202, buf=3Dbuf@entry=3D0xaaaad47a52=
00, len=3Dlen@entry=3D4096) at block/raw_posix.c:294
  #3 0x0000aaaace33597c in raw_probe_alignment (bs=3Dbs@entry=3D0xaaaad32ea=
920, fd=3D202, errp=3Derrp@entry=3D0xfffffef7a330) at block/raw_posix.c:349
  #4 0x0000aaaace335a48 in raw_refresh_limits (bs=3D0xaaaad32ea920, errp=3D=
0xfffffef7a330) at block/raw_posix.c:811
  #5 0x0000aaaace3404b0 in bdrv_refresh_limits (bs=3D0xaaaad32ea920, errp=
=3D0xfffffef7a330, errp@entry=3D0xfffffef7a360) at block/io.c:122
  #6 0x0000aaaace340504 in bdrv_refresh_limits (bs=3Dbs@entry=3D0xaaaad09ce=
800, errp=3Derrp@entry=3D0xfffffef7a3b0) at block/io.c:97
  #7 0x0000aaaace2eb9f0 in bdrv_open_common (bs=3Dbs@entry=3D0xaaaad09ce800=
, file=3Dfile@entry=3D0xaaaad0e89800, options=3D<optimized out>, errp=3Derr=
p@entry=3D0xfffffef7a450)
  at block.c:1194
  #8 0x0000aaaace2eedec in bdrv_open_inherit (filename=3D<optimized out>, f=
ilename@entry=3D0xaaaad25f92d0 "/dev/mapper/36384c4f100630193359db7a8000001=
1d",
  reference=3Dreference@entry=3D0x0, options=3D<optimized out>, options@ent=
ry=3D0xaaaad3d0f4b0, flags=3D<optimized out>, flags@entry=3D128, parent=3Dp=
arent@entry=3D0x0,
  child_role=3Dchild_role@entry=3D0x0, errp=3Derrp@entry=3D0xfffffef7a710) =
at block.c:1895
  #9 0x0000aaaace2ef510 in bdrv_open (filename=3Dfilename@entry=3D0xaaaad25=
f92d0 "/dev/mapper/36384c4f100630193359db7a80000011d", reference=3Dreferenc=
e@entry=3D0x0,
  options=3Doptions@entry=3D0xaaaad3d0f4b0, flags=3Dflags@entry=3D128, errp=
=3Derrp@entry=3D0xfffffef7a710) at block.c:1979
  #10 0x0000aaaace331ef0 in blk_new_open (filename=3Dfilename@entry=3D0xaaa=
ad25f92d0 "/dev/mapper/36384c4f100630193359db7a80000011d", reference=3Drefe=
rence@entry=3D0x0,
  options=3Doptions@entry=3D0xaaaad3d0f4b0, flags=3D128, errp=3Derrp@entry=
=3D0xfffffef7a710) at block/block_backend.c:213
  #11 0x0000aaaace0da1f4 in blockdev_init (file=3Dfile@entry=3D0xaaaad25f92=
d0 "/dev/mapper/36384c4f100630193359db7a80000011d", bs_opts=3Dbs_opts@entry=
=3D0xaaaad3d0f4b0,
  errp=3Derrp@entry=3D0xfffffef7a710) at blockdev.c:603
  #12 0x0000aaaace0dc478 in drive_new (all_opts=3Dall_opts@entry=3D0xaaaad4=
dc31d0, block_default_type=3D<optimized out>) at blockdev.c:1116
  #13 0x0000aaaace0e3ee0 in add_init_drive (
  optstr=3Doptstr@entry=3D0xaaaad0872ec0 "file=3D/dev/mapper/36384c4f100630=
193359db7a80000011d,format=3Draw,if=3Dnone,id=3Ddrive-scsi0-0-0-3,cache=3Dn=
one,aio=3Dnative")
  at device_hotplug.c:46
  #14 0x0000aaaace0e3f78 in hmp_drive_add (mon=3D0xfffffef7a810, qdict=3D0x=
aaaad0c8f000) at device_hotplug.c:67
  #15 0x0000aaaacdf7d688 in handle_hmp_command (mon=3D0xfffffef7a810, cmdli=
ne=3D<optimized out>) at /usr/src/debug/qemu-kvm-2.8.1/monitor.c:3199
  #16 0x0000aaaacdf7d778 in qmp_human_monitor_command (
  command_line=3D0xaaaacfc8e3c0 "drive_add dummy file=3D/dev/mapper/36384c4=
f100630193359db7a80000011d,format=3Draw,if=3Dnone,id=3Ddrive-scsi0-0-0-3,ca=
che=3Dnone,aio=3Dnative",
  has_cpu_index=3Dfalse, cpu_index=3D0, errp=3Derrp@entry=3D0xfffffef7a968)=
 at /usr/src/debug/qemu-kvm-2.8.1/monitor.c:660
  #17 0x0000aaaace0fdb30 in qmp_marshal_human_monitor_command (args=3D<opti=
mized out>, ret=3D0xfffffef7a9e0, errp=3D0xfffffef7a9d8) at qmp-marshal.c:2=
223
  #18 0x0000aaaace3b6ad0 in do_qmp_dispatch (request=3D<optimized out>, err=
p=3D0xfffffef7aa20, errp@entry=3D0xfffffef7aa40) at qapi/qmp_dispatch.c:115
  #19 0x0000aaaace3b6d58 in qmp_dispatch (request=3D<optimized out>) at qap=
i/qmp_dispatch.c:142
  #20 0x0000aaaacdf79398 in handle_qmp_command (parser=3D<optimized out>, t=
okens=3D<optimized out>) at /usr/src/debug/qemu-kvm-2.8.1/monitor.c:4010
  #21 0x0000aaaace3bd6c0 in json_message_process_token (lexer=3D0xaaaacf834=
c80, input=3D<optimized out>, type=3DJSON_RCURLY, x=3D214, y=3D274) at qobj=
ect/json_streamer.c:105
  #22 0x0000aaaace3f3d4c in json_lexer_feed_char (lexer=3Dlexer@entry=3D0xa=
aaacf834c80, ch=3D<optimized out>, flush=3Dflush@entry=3Dfalse) at qobject/=
json_lexer.c:319
  #23 0x0000aaaace3f3e6c in json_lexer_feed (lexer=3D0xaaaacf834c80, buffer=
=3D<optimized out>, size=3D<optimized out>) at qobject/json_lexer.c:369
  #24 0x0000aaaacdf77c64 in monitor_qmp_read (opaque=3D<optimized out>, buf=
=3D<optimized out>, size=3D<optimized out>) at /usr/src/debug/qemu-kvm-2.8.=
1/monitor.c:4040
  #25 0x0000aaaace0eab18 in tcp_chr_read (chan=3D<optimized out>, cond=3D<o=
ptimized out>, opaque=3D0xaaaacf90b280) at qemu_char.c:3260
  #26 0x0000ffff9dadf200 in g_main_context_dispatch () from /lib64/libglib-=
2.0.so.0
  #27 0x0000aaaace3c4a00 in glib_pollfds_poll () at util/main_loop.c:230
  --Type <RET> for more, q to quit, c to continue without paging--
  #28 0x0000aaaace3c4a88 in os_host_main_loop_wait (timeout=3D<optimized ou=
t>) at util/main_loop.c:278
  #29 0x0000aaaace3c4bf0 in main_loop_wait (nonblocking=3D<optimized out>) =
at util/main_loop.c:534
  #30 0x0000aaaace0f5d08 in main_loop () at vl.c:2120
  #31 0x0000aaaacdf3a770 in main (argc=3D<optimized out>, argv=3D<optimized=
 out>, envp=3D<optimized out>) at vl.c:5017

  =

  From the bt we can see,  when do qmp sush as drive_add,  qemu main thread=
 locks the qemu_global_mutex  and do pread in raw_probe_alignmen. Pread is =
a synchronous operation. If backend storage network has a large delay or IO=
 pressure is too large,  the pread operation will not return for a long tim=
e, which make vcpu thread can't acquire qemu_global_mutex for a long time a=
nd make the vcpu thread unable to be scheduled for a long time.  So virtual=
 machine cpu soft lockup happened.

  =

  I thank  qemu main thread should not hold qemu_global_mutex for a long ti=
me when do qmp that involving IO synchronous operation sush pread , ioctl, =
etc.

  Do you have any solutions or good ideas about it? Thanks for your
  reply!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1831750/+subscriptions

