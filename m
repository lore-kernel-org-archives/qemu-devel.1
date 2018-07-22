Received: from eggs.gnu.org ([2001:4830:134:3::10]:50867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fh60e-0002my-P5
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 00:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fh60c-0007FQ-0i
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 00:30:16 -0400
Received: from indium.canonical.com ([91.189.90.7]:49888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fh60b-0007FJ-QO
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 00:30:13 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fh60b-0007NS-1I
	for <qemu-devel@nongnu.org>; Sun, 22 Jul 2018 04:30:13 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 065932E80C3
	for <qemu-devel@nongnu.org>; Sun, 22 Jul 2018 04:30:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Jul 2018 04:17:22 -0000
From: Launchpad Bug Tracker <1434779@bugs.launchpad.net>
Reply-To: Bug 1434779 <1434779@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150321074437.16517.74688.malonedeb@gac.canonical.com>
Message-Id: <153223304317.12964.18146271601324766099.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1434779] Re: qemu hangs on live-migration with
 storage(virtual machine: windows Server 2008 with only one disk )
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
https://bugs.launchpad.net/bugs/1434779

Title:
  qemu hangs on live-migration with storage(virtual machine: windows
  Server 2008 with only one disk )

Status in QEMU:
  Expired

Bug description:
  Hi,
  We are using =E2=80=9CWindows Server 2008=E2=80=9D with qemu-kvm-2.0.1 (l=
inux kernel:3.10.0) as a host of  a VM.
  Using drive_mirror to do  live-migration on the same host for different d=
isks
  Local disk: /sf/data/local/
  Shared disk(iscsi): /sf/other/local/    ---  the disk is busy, the IO rat=
e is  about  30MB/s
  qemu-system-x86_64 -k en-us -m 2048 -smp 2 -vnc :3100 -usbdevice tablet -=
boot c -enable-kvm -drive file=3D/sf/data/local/vm-disk-1.qcow2,if=3Dnone,i=
d=3Ddrive-ide0,cache=3Dnone,aio=3Dnative -device ide-hd,bus=3Dide.0,unit=3D=
0,drive=3Ddrive-ide0,id=3Dide0,bootindex=3D100 =


  Step 1:
  Start migration: Drive_mirror -f drive-ide0  /sf/other/local/test.qcow2

  Step 2:
  When detect the migration has completed, then send cmd: block_job_complet=
e -f drive-ide0

  Step 3:
  send cmd: info status =

  What surprised me is that the qemu monitor reports can=E2=80=99t be conne=
cted.

  Then find bellows:
  The  qemu process hangs on the mirror_run->bdrv_drain_all->aio_poll->qemu=
_poll_ns->ppoll (),
  None events were received and poll forever. I don=E2=80=99t know why the =
aio can=E2=80=99t be responsed. This case is hardly to
  be generated but it really happens sometimes . I=E2=80=99m looking forwar=
d to getting help from you .
  The stack capture snapshot:

  =

  Thanks =

  MyAngle

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1434779/+subscriptions
