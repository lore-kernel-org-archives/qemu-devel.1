Received: from eggs.gnu.org ([2001:4830:134:3::10]:56631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eLLut-0005ds-OY
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 23:30:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eLLup-0007PA-Q3
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 23:30:11 -0500
Received: from indium.canonical.com ([91.189.90.7]:45124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eLLup-0007Oi-JD
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 23:30:07 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eLLuk-0002nO-Hh
	for <qemu-devel@nongnu.org>; Sun, 03 Dec 2017 04:30:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1488A2E818D
	for <qemu-devel@nongnu.org>; Sun,  3 Dec 2017 04:29:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 Dec 2017 04:17:21 -0000
From: Launchpad Bug Tracker <1321684@bugs.launchpad.net>
Reply-To: Bug 1321684 <1321684@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140521095526.18906.33297.malonedeb@wampee.canonical.com>
Message-Id: <151227464173.17805.10803693513478356807.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1321684] Re: block_stream command stalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1321684

Title:
  block_stream command stalls

Status in QEMU:
  Expired

Bug description:
  block_stream command stalls near finishing.
  I tried 1.7.1, 2.0.0 and the master versions. All of them stalled.
  But the 1.1.2 could finish the job.

  Here is how to reproduce it:

  $ sudo $QEMU \
  -enable-kvm  -cpu qemu64  -m 1024  \
  -monitor stdio \
  -drive file=3D./i1,if=3Dnone,id=3Ddrive_0,cache=3Dnone,aio=3Dnative -devi=
ce virtio-blk-pci,drive=3Ddrive_0,bus=3Dpci.0,addr=3D0x5 \

  QEMU 2.0.50 monitor - type 'help' for more information
  (qemu) VNC server running on `127.0.0.1:5900'
  (qemu) snapshot_blkdev drive_0 s1
  Formatting 's1', fmt=3Dqcow2 size=3D26843545600 backing_file=3D'./i1' bac=
king_fmt=3D'qcow2' encryption=3Doff cluster_size=3D65536 lazy_refcounts=3Do=
ff =

  (qemu) block_stream drive_0 =

  (qemu) info block-jobs =

  Streaming device drive_0: Completed 400818176 of 26843545600 bytes, speed=
 limit 0 bytes/s
  (qemu) info block-jobs =

  Streaming device drive_0: Completed 904396800 of 26843545600 bytes, speed=
 limit 0 bytes/s
  (qemu) info block-jobs =

  Streaming device drive_0: Completed 23401070592 of 26843545600 bytes, spe=
ed limit 0 bytes/s
  (qemu) info block-jobs =

  Streaming device drive_0: Completed 26513768448 of 26843545600 bytes, spe=
ed limit 0 bytes/s
  (qemu) main-loop: WARNING: I/O thread spun for 1000 iterations
  info block-jobs =

  Streaming device drive_0: Completed 26841513984 of 26843545600 bytes, spe=
ed limit 0 bytes/s
  (qemu) info block-jobs =

  Streaming device drive_0: Completed 26841513984 of 26843545600 bytes, spe=
ed limit 0 bytes/s
  (qemu) info block-jobs =

  Streaming device drive_0: Completed 26841513984 of 26843545600 bytes, spe=
ed limit 0 bytes/s

  #### here, the progress stopped at 26841513984 ####

  =

  $ qemu-img info i1 =

  image: i1
  file format: qcow2
  virtual size: 25G (26843545600 bytes)
  disk size: 1.0G
  cluster_size: 2097152
  Format specific information:
      compat: 1.1
      lazy refcounts: false

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1321684/+subscriptions
