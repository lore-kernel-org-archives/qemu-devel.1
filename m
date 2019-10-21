Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08971CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 22:21:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B77E22086D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 22:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77E22086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=weiser.dinsnail.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMg3O-0007Ct-Uj
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 18:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iMg2j-0006nT-01
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 18:20:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iMg2e-0004nS-Lw
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 18:20:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:39778)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iMg2d-0004n4-A4
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 18:20:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iMg2b-0002N3-Ip
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 22:20:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8C25A2E8048
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 22:20:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Oct 2019 22:11:19 -0000
From: Michael Weiser <michael@weiser.dinsnail.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dgilbert-h kwolf-redhat lersek michael-weiser
 psyhomb sej7278
X-Launchpad-Bug-Reporter: Michael Weiser (michael-weiser)
X-Launchpad-Bug-Modifier: Michael Weiser (michael-weiser)
References: <157005622285.15919.12087374175062502233.malonedeb@gac.canonical.com>
Message-Id: <157169587930.9561.1245750937881107682.malone@soybean.canonical.com>
Subject: [Bug 1846427] Re: 4.1.0: qcow2 corruption on savevm/quit/loadvm cycle
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="186023fa645d8be19d403a76064f0643f510db2f";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 57575c14927dcd4f7a0e44b6fc7a9a387b55310e
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1846427 <1846427@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> After reading some related code, I have more questions than before, but
> let's see... As more qcow2 code was merged since, I would suggest that
> we debug the problem on commit 69f4750 (the bisection result) rather
> than on anything newer.

Okay, for all of the following I did a fresh compile of qemu 69f4750 and
ran all commands in this version.

> First of all: Michael, you didn't specify explicitly how your images
> were created, but can I assume that the test image is not preallocated
> (in contrast to Laszlo's)?

Actually these were converted from vmdk files using qemu-img and
previously VMware Fusion VMs. To avoid any suspicion as to what that
may have brought with it in breakage I just created a fresh image using
this command:

$ bin/qemu-bisect/bin/qemu-img create -f qcow2 qtest.qcow2 20G
Formatting 'qtest.qcow2', fmt=3Dqcow2 size=3D21474836480 cluster_size=3D655=
36 lazy_refcounts=3Doff refcount_bits=3D16
$ bin/qemu-bisect/bin/qemu-img info qtest.qcow2
image: qtest.qcow2
file format: qcow2
virtual size: 20 GiB (21474836480 bytes)
disk size: 196 KiB
cluster_size: 65536
Format specific information:
    compat: 1.1
    lazy refcounts: false
    refcount bits: 16
    corrupt: false
$ ls -la qtest.qcow2
-rw-r--r-- 1 m m 196928 Oct 21 22:43 qtest.qcow2
$ du -sk qtest.qcow2
196     qtest.qcow2

So I guess that means its not preallocated.

Then I installed a minimal Debian buster into it by just entering
default values:

$ bin/qemu-bisect/bin/qemu-system-x86_64 -machine pc-q35-3.1,accel=3Dkvm
-m 4096 -chardev stdio,id=3Dcharmonitor -mon chardev=3Dcharmonitor -drive
file=3Dqtest.qcow2,id=3Dd -cdrom Downloads/mini.iso

After that the image reported:

$ bin/qemu-bisect/bin/qemu-img check qtest.qcow2
No errors were found on the image.
26443/327680 =3D 8.07% allocated, 17.10% fragmented, 0.00% compressed clust=
ers
Image end offset: 1734148096

Then I prepared it for the automatic reproducer by running the following
command in it and saving that running state as snapshot foo using savevm:

$ while true ; do dd if=3D/dev/zero of=3Dt bs=3D1024k count=3D4000 ; done

Then I ran the reproducer using this command:

$ while true ; do (echo loadvm foo ; echo c ; sleep 10 ; echo stop ;
echo savevm foo ; echo quit ) |  bin/qemu-bisect/bin/qemu-system-x86_64
-machine pc-q35-3.1,accel=3Dkvm -m 4096 -chardev stdio,id=3Dcharmonitor -mon
chardev=3Dcharmonitor -drive file=3Dqtest.qcow2,id=3Dd -display none -S ; d=
one

It took nine iterations for the image to corrupt. After that qemu-img
reads:

$ bin/qemu-bisect/bin/qemu-img check qtest.qcow2 2>&1 | sed -e s,Leaked.*,L=
eaked, | uniq
Leaked
ERROR cluster 163840 refcount=3D3 reference=3D4
ERROR cluster 163841 refcount=3D3 reference=3D4
ERROR cluster 163848 refcount=3D1 reference=3D2
ERROR cluster 163850 refcount=3D1 reference=3D2
ERROR cluster 163921 refcount=3D1 reference=3D2
ERROR cluster 163957 refcount=3D3 reference=3D4
ERROR cluster 163958 refcount=3D3 reference=3D4
Leaked
ERROR cluster 163962 refcount=3D1 reference=3D2
Leaked
ERROR cluster 163968 refcount=3D1 reference=3D2
Leaked
ERROR cluster 163974 refcount=3D1 reference=3D2
Leaked

10 errors were found on the image.
Data may be corrupted, or further writes to the image may corrupt it.

129130 leaked clusters were found on the image.
This means waste of disk space, but no harm to data.
253326/327680 =3D 77.31% allocated, 1.77% fragmented, 0.00% compressed clus=
ters
Image end offset: 18906611712

> Another caller I see in the code, but didn't get run in my guest, is
> qcow2_co_pwrite_zeroes(). This is not discard, but maybe the discard
> mount option does cause a write_zeroes call (WRITE SAME in SCSI)
> sometimes? But then, your reproducer seems to use AHCI and I can't see
> a write_zeroes call in the AHCI or IDE device emulation.

In above test I had not knowingly configured any discard in the guest.
Neither /etc/fstab nor /proc/mounts contained the discard option. The
image also did not shrink when deleting files. Nor did it shrink when
explicitly calling fstrim / for that matter - presumably because because
unmap on discard is disabled by default.

So I'd postulate that discard does at most play an aggravating role here
but is not necessary for the problem to occur.

> I think it might be worth a try reproducing with the
> handle_alloc_space() call commented out. If that doesn't fix/hide the
> bug,

I commented out the call to handle_alloc_space() in
block/qcow2.c:qcow2_co_pwritev() and that certainly hid the bug. The
reproducer ran for quarter of an hour without any corruption. The image
was fine after that:

$ bin/qemu-bisect/bin/qemu-img check qtest.qcow2
No errors were found on the image.
253376/327680 =3D 77.32% allocated, 2.00% fragmented, 0.00% compressed clus=
ters
Image end offset: 16909860864

Commenting handle_alloc_space() back in, recompiling, reinstalling and
rerunning the reproducer took a single iteration to violently corrupt
the image.

So I guess it's safe to say that the bug occurs in the
handle_alloc_space() codepath.

This quick corruption made me think that maybe the level of
preallocation has something to do with it. So I filled up all disk space
in the guest by writing zeroes to a file using dd. This yielded a
preallocation above 80%:

No errors were found on the image.
266793/327680 =3D 81.42% allocated, 3.92% fragmented, 0.00% compressed clus=
ters
Image end offset: 21343764480

Running the reproducer again the image took five iterations to corrupt.
I'd call that inconclusive.

> Michael, would you like to give it a try and figure out in which code path
> qcow2_detect_metadata_preallocation() is even called in your reproducer

After letting the VM run for about ten seconds with gdb attached a
breakpoint on qcow2_detect_metadata_preallocation triggers and I get
this backtrace:

(gdb) bt
#0  0x0000555555d22bfd in qcow2_detect_metadata_preallocation (bs=3D0x55555=
67c69e0) at block/qcow2-refcount.c:3449
#1  0x0000555555d124b8 in qcow2_co_block_status
    (bs=3D0x5555567c69e0, want_zero=3Dfalse, offset=3D2148532224, count=3D4=
096, pnum=3D0x7ffee0ae2b28, map=3D0x7ffee0ae28a0, file=3D0x7ffee0ae28a8) at=
 block/qcow2.c:1899
#2  0x0000555555d6124a in bdrv_co_block_status (bs=3D0x5555567c69e0, want_z=
ero=3Dfalse, offset=3D2148532224, bytes=3D4096, pnum=3D0x7ffee0ae2b28, map=
=3D0x0, file=3D0x0)
    at block/io.c:2081
#3  0x0000555555d6166d in bdrv_co_block_status_above
    (bs=3D0x5555567c69e0, base=3D0x0, want_zero=3Dfalse, offset=3D214853222=
4, bytes=3D4096, pnum=3D0x7ffee0ae2b28, map=3D0x0, file=3D0x0) at block/io.=
c:2190
#4  0x0000555555d61753 in bdrv_block_status_above_co_entry (opaque=3D0x7ffe=
e0ae2a10) at block/io.c:2220
#5  0x0000555555d6187e in bdrv_common_block_status_above
    (bs=3D0x5555567c69e0, base=3D0x0, want_zero=3Dfalse, offset=3D214853222=
4, bytes=3D4096, pnum=3D0x7ffee0ae2b28, map=3D0x0, file=3D0x0) at block/io.=
c:2255
#6  0x0000555555d61ae9 in bdrv_is_allocated (bs=3D0x5555567c69e0, offset=3D=
2148532224, bytes=3D4096, pnum=3D0x7ffee0ae2b28) at block/io.c:2285
#7  0x0000555555d61b7b in bdrv_is_allocated_above (top=3D0x5555567c69e0, ba=
se=3D0x0, offset=3D2148532224, bytes=3D4096, pnum=3D0x7ffee0ae2b80) at bloc=
k/io.c:2323
#8  0x0000555555d12d48 in is_unallocated (bs=3D0x5555567c69e0, offset=3D214=
8532224, bytes=3D4096) at block/qcow2.c:2151
#9  0x0000555555d12dbc in is_zero_cow (bs=3D0x5555567c69e0, m=3D0x555556ed0=
520) at block/qcow2.c:2162
#10 0x0000555555d12e9c in handle_alloc_space (bs=3D0x5555567c69e0, l2meta=
=3D0x555556ed0520) at block/qcow2.c:2188
#11 0x0000555555d13310 in qcow2_co_pwritev (bs=3D0x5555567c69e0, offset=3D2=
148536320, bytes=3D61440, qiov=3D0x7fffe83507a0, flags=3D0) at block/qcow2.=
c:2301
#12 0x0000555555d5e6c4 in bdrv_driver_pwritev (bs=3D0x5555567c69e0, offset=
=3D2148536320, bytes=3D61440, qiov=3D0x7fffe83507a0, flags=3D0) at block/io=
.c:1043
#13 0x0000555555d6013a in bdrv_aligned_pwritev
    (child=3D0x55555675cf80, req=3D0x7ffee0ae2e50, offset=3D2148536320, byt=
es=3D61440, align=3D1, qiov=3D0x7fffe83507a0, flags=3D0) at block/io.c:1670
#14 0x0000555555d60d66 in bdrv_co_pwritev (child=3D0x55555675cf80, offset=
=3D2148536320, bytes=3D61440, qiov=3D0x7fffe83507a0, flags=3D0) at block/io=
.c:1897
#15 0x0000555555d47cb6 in blk_co_pwritev (blk=3D0x5555567c6730, offset=3D21=
48536320, bytes=3D61440, qiov=3D0x7fffe83507a0, flags=3D0) at block/block-b=
ackend.c:1183
#16 0x0000555555d48499 in blk_aio_write_entry (opaque=3D0x7fffe8350820) at =
block/block-backend.c:1382
#17 0x0000555555e3ff80 in coroutine_trampoline (i0=3D-402575600, i1=3D32767=
) at util/coroutine-ucontext.c:116
#18 0x00007ffff5fc61a0 in  () at /lib64/libc.so.6
#19 0x00007ffff17c5920 in  ()
#20 0x0000000000000000 in  ()

A savevm command does not trigger the breakpoint.

Hope this helps in narrowing down the culprit.
-- =

Michael

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1846427

Title:
  4.1.0: qcow2 corruption on savevm/quit/loadvm cycle

Status in QEMU:
  New

Bug description:
  I'm seeing massive corruption of qcow2 images with qemu 4.1.0 and git
  master as of 7f21573c822805a8e6be379d9bcf3ad9effef3dc after a few
  savevm/quit/loadvm cycles. I've narrowed it down to the following
  reproducer (further notes below):

  # qemu-img check debian.qcow2
  No errors were found on the image.
  251601/327680 =3D 76.78% allocated, 1.63% fragmented, 0.00% compressed cl=
usters
  Image end offset: 18340446208
  # bin/qemu/bin/qemu-system-x86_64 -machine pc-q35-4.0.1,accel=3Dkvm -m 40=
96 -chardev stdio,id=3Dcharmonitor -mon chardev=3Dcharmonitor -drive file=
=3Ddebian.qcow2,id=3Dd -S
  qemu-system-x86_64: warning: dbind: Couldn't register with accessibility =
bus: Did not receive a reply. Possible causes include: the remote applicati=
on did not send a reply, the message bus security policy blocked the reply,=
 the reply timeout expired, or the network connection was broken.
  QEMU 4.1.50 monitor - type 'help' for more information
  (qemu) loadvm foo
  (qemu) c
  (qemu) qcow2_free_clusters failed: Invalid argument
  qcow2_free_clusters failed: Invalid argument
  qcow2_free_clusters failed: Invalid argument
  qcow2_free_clusters failed: Invalid argument
  quit
  [m@nargothrond:~] qemu-img check debian.qcow2
  Leaked cluster 85179 refcount=3D2 reference=3D1
  Leaked cluster 85180 refcount=3D2 reference=3D1
  ERROR cluster 266150 refcount=3D0 reference=3D2
  [...]
  ERROR OFLAG_COPIED data cluster: l2_entry=3D422840000 refcount=3D1

  9493 errors were found on the image.
  Data may be corrupted, or further writes to the image may corrupt it.

  2 leaked clusters were found on the image.
  This means waste of disk space, but no harm to data.
  259266/327680 =3D 79.12% allocated, 1.67% fragmented, 0.00% compressed cl=
usters
  Image end offset: 18340446208

  This is on a x86_64 Linux 5.3.1 Gentoo host with qemu-system-x86_64
  and accel=3Dkvm. The compiler is gcc-9.2.0 with the rest of the system
  similarly current.

  Reproduced with qemu-4.1.0 from distribution package as well as
  vanilla git checkout of tag v4.1.0 and commit
  7f21573c822805a8e6be379d9bcf3ad9effef3dc (today's master). Does not
  happen with qemu compiled from vanilla checkout of tag v4.0.0. Build
  sequence:

  ./configure --prefix=3D$HOME/bin/qemu-bisect --target-list=3Dx86_64-softm=
mu --disable-werror --disable-docs
  [...]
  CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g
  [...] (can provide full configure output if helpful)
  make -j8 install

  The kind of guest OS does not matter: seen with Debian testing 64bit,
  Windows 7 x86/x64 BIOS and Windows 7 x64 EFI.

  The virtual storage controller does not seem to matter: seen with
  VirtIO SCSI, emulated SCSI and emulated SATA AHCI.

  Caching modes (none, directsync, writeback), aio mode (threads,
  native) or discard (ignore, unmap) or detect-zeroes (off, unmap) does
  not influence occurence either.

  Having more RAM in the guest seems to increase odds of corruption:
  With 512MB to the Debian guest problem hardly occurs at all, with 4GB
  RAM it happens almost instantly.

  An automated reproducer works as follows:

  - the guest *does* mount its root fs and swap with option discard and
  my testing leaves me with the impression that file deletion rather
  than reading is causing the issue

  - foo is a snapshot of the running Debian VM which is already running
  command

  # while true ; do dd if=3D/dev/zero of=3Dfoo bs=3D10240k count=3D400 ; do=
ne

  to produce some I/O to the disk (4GB file with 4GB of RAM).

  - on the host a loop continuously resumes and saves the guest state
  and quits qemu inbetween:

  # while true ; do (echo loadvm foo ; echo c ; sleep 10 ; echo stop ;
  echo savevm foo ; echo quit ) | bin/qemu-bisect/bin/qemu-system-x86_64
  -machine pc-q35-3.1,accel=3Dkvm -m 4096 -chardev stdio,id=3Dcharmonitor
  -mon chardev=3Dcharmonitor -drive file=3Ddebian.qcow2,id=3Dd -S -display
  none ; done

  - quitting qemu inbetween saves and loads seems to be necessary for
  the problem to occur. Just continusouly in one session saving and
  loading guest state does not trigger it.

  - For me, after about 2 to 6 iterations of above loop the image is
  corrupted.

  - corruption manifests with other messages from qemu as well, e.g.:

  (qemu) loadvm foo
  Error: Device 'd' does not have the requested snapshot 'foo'

  Using above reproducer I have to the be best of my ability bisected
  the introduction of the problem to commit
  69f47505ee66afaa513305de0c1895a224e52c45 (block: avoid recursive
  block_status call if possible). qemu compiled from the commit before
  does not exhibit the issue, from that commit on it does and reverting
  the commit off of current master makes it disappear.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1846427/+subscriptions

