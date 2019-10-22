Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCD8CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 23:01:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3FBF20700
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 23:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FBF20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=weiser.dinsnail.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iN39y-0005LB-Vi
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 19:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iN397-0004nx-9e
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 19:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iN395-0003vb-7D
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 19:00:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:47934)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iN395-0003uF-0s
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 19:00:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iN393-00030c-Ar
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 23:00:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 4F8CF2E80C0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 23:00:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Oct 2019 22:47:28 -0000
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
Message-Id: <157178444824.19048.3845514982635724694.malone@gac.canonical.com>
Subject: [Bug 1846427] Re: 4.1.0: qcow2 corruption on savevm/quit/loadvm cycle
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="186023fa645d8be19d403a76064f0643f510db2f";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: db1bca1eb8e083693424c76d0300a8a4b3753cdb
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

> I tried to reproduce the problem locally, on the same commit, with the
> steps you described, but I wasn't lucky. I tried keeping the image on my
> home directory (XFS), on tmpfs, and finally on a newly created ext4
> filesystem on a spare LVM volume, but the image just wouldn't break even
> after letting the loop run for a quite a while.

That's certainly an important data point. Is it possible that we're
talking about some kind of miscompilation here, maybe because gcc-9.2.0
is just that tiny bit too spanking current?

> So as the next step I would like to test my theory that the problem
> isn't bdrv_co_block_status() returning a different value after the
> commit, but that qcow2_detect_metadata_preallocation() even runs. I
> think the easiest way to do this would be modifying handle_alloc_space()
> so that it performs the checks, but skips its optimisation regardless of
> the is_zero_cow() return value:

>         if (!is_zero_cow(bs, m) || true) {
>             continue;
>         }

I made the change and the problem went away.

Then, extrapolating the jest of your methodology :), I went ahead and
disabled only bdrv_co_pwrite_zeroes() by placing a continue in front of
it but let qcow2_pre_write_overlap_check() execute and the problem
reappeared. I certainly did not expect that to happen because the
function name ends in _check(), suggesting read-only access. And it's
not even touched by the commit.

This had me so rattled that I revalidated that the problem does indeed
not occur with the commit before. And it does not. I left it running for
about half an hour without problems.

After some more tests I finally figured out that even with -g and no -O
gcc is smart enough to optimize out (!is_zero_cow() || true) and that
corruption only happens if is_zero_cow() is actually called. Corruption
also does not occur if I make is_zero_cow() or is_unallocated() return 0
always.

So my first guess was that is_unallocated() sometimes returns false
positives, making is_zero_cow() report false positives which is not
caught by qcow2_pre_write_overlap_check() and causes
bdrv_co_pwrite_zeroes() to zero out actual data. That seemed a bit
convoluted to me.

But then I realized that corruption still occurs if the rest of
handle_alloc_space() is disabled like so:

--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2185,9 +2185,8 @@ static int handle_alloc_space(BlockDriverState *bs, Q=
CowL2Meta *l2meta)
             continue;
         }
 =

-        if (!is_zero_cow(bs, m)) {
-            continue;
-        }
+        is_zero_cow(bs, m);
+        continue;
 =

         /*
          * instead of writing zero COW buffers,

So it's much more likely that is_zero_cow() has a side-effect that
somehow causes corruption later on even without handle_alloc_space()
ever calling bdrv_co_pwrite_zeroes(). That would also explain why
qcow2_pre_write_overlap_check() does not catch those false positives
overwriting metadata because there simply are none.

Putting a breakpoint on handle_alloc_space() and single stepping into
is_zero_cow() I do indeed end up in bdrv_co_block_status():

gdb) bt
#0  0x0000555555d610fd in bdrv_co_block_status (bs=3D0x5555567c69e0, want_z=
ero=3Dfalse, offset=3D5242880, bytes=3D12288, pnum=3D0x7ffedffd7b28, map=3D=
0x0, file=3D0x0)
    at block/io.c:2048
#1  0x0000555555d6167e in bdrv_co_block_status_above
    (bs=3D0x5555567c69e0, base=3D0x0, want_zero=3Dfalse, offset=3D5242880, =
bytes=3D12288, pnum=3D0x7ffedffd7b28, map=3D0x0, file=3D0x0) at block/io.c:=
2190
#2  0x0000555555d61764 in bdrv_block_status_above_co_entry (opaque=3D0x7ffe=
dffd7a10) at block/io.c:2220
#3  0x0000555555d6188f in bdrv_common_block_status_above
    (bs=3D0x5555567c69e0, base=3D0x0, want_zero=3Dfalse, offset=3D5242880, =
bytes=3D12288, pnum=3D0x7ffedffd7b28, map=3D0x0, file=3D0x0) at block/io.c:=
2255
#4  0x0000555555d61afa in bdrv_is_allocated (bs=3D0x5555567c69e0, offset=3D=
5242880, bytes=3D12288, pnum=3D0x7ffedffd7b28) at block/io.c:2285
#5  0x0000555555d61b8c in bdrv_is_allocated_above (top=3D0x5555567c69e0, ba=
se=3D0x0, offset=3D5242880, bytes=3D12288, pnum=3D0x7ffedffd7b80) at block/=
io.c:2323
#6  0x0000555555d12d48 in is_unallocated (bs=3D0x5555567c69e0, offset=3D524=
2880, bytes=3D12288) at block/qcow2.c:2151
#7  0x0000555555d12dbc in is_zero_cow (bs=3D0x5555567c69e0, m=3D0x5555569d3=
5b0) at block/qcow2.c:2162
#8  0x0000555555d12e9c in handle_alloc_space (bs=3D0x5555567c69e0, l2meta=
=3D0x5555569d35b0) at block/qcow2.c:2188
#9  0x0000555555d13321 in qcow2_co_pwritev (bs=3D0x5555567c69e0, offset=3D5=
255168, bytes=3D4096, qiov=3D0x7fffe82ec310, flags=3D0) at block/qcow2.c:23=
02
#10 0x0000555555d5e6d5 in bdrv_driver_pwritev (bs=3D0x5555567c69e0, offset=
=3D5255168, bytes=3D4096, qiov=3D0x7fffe82ec310, flags=3D0) at block/io.c:1=
043
#11 0x0000555555d6014b in bdrv_aligned_pwritev (child=3D0x55555675cf80, req=
=3D0x7ffedffd7e50, offset=3D5255168, bytes=3D4096, align=3D1, qiov=3D0x7fff=
e82ec310, flags=3D0)
    at block/io.c:1670
#12 0x0000555555d60d77 in bdrv_co_pwritev (child=3D0x55555675cf80, offset=
=3D5255168, bytes=3D4096, qiov=3D0x7fffe82ec310, flags=3D0) at block/io.c:1=
897
#13 0x0000555555d47cc7 in blk_co_pwritev (blk=3D0x5555567c6730, offset=3D52=
55168, bytes=3D4096, qiov=3D0x7fffe82ec310, flags=3D0) at block/block-backe=
nd.c:1183
#14 0x0000555555d484aa in blk_aio_write_entry (opaque=3D0x7fffe823f920) at =
block/block-backend.c:1382
#15 0x0000555555e3ff91 in coroutine_trampoline (i0=3D-399759776, i1=3D32767=
) at util/coroutine-ucontext.c:116
#16 0x00007ffff5fc61a0 in  () at /lib64/libc.so.6
#17 0x00007ffff17c5920 in  ()
#18 0x0000000000000000 in  ()

At that point it had gotten too late to even attempt to wrap my brain
around the whole BDRV_BLOCK_RECURSE logic. But I think the above gives a
strong(er|ish) connection between the change and the corruption and how
handle_alloc_space() ties into it. Let me know what else I could check
to help track this down.

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

