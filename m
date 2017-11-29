Received: from eggs.gnu.org ([2001:4830:134:3::10]:42612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eJwMb-0001Bj-78
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 02:00:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eJwMY-0004jZ-66
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 02:00:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:52820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eJwMY-0004j9-0G
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 02:00:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eJwMW-0000Dn-Ex
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 07:00:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 493842E80D4
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 07:00:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Nov 2017 06:50:46 -0000
From: Nitin <1735082@bugs.launchpad.net>
Reply-To: Bug 1735082 <1735082@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151193824666.10852.4284580382497408043.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1735082] [NEW] NVME pass through in th eguest VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Hi Qemu Team

i am new in qemu and trying for nvme pass through ..
for that i used  below git repo for nvme =


https://github.com/famz/qemu/tree/nvme

and trying to launch the VM by below qemu command ..

/usr/local/bin/qemu-system-x86_64 -name sl7.0=E2=80=82=E2=80=82-m 1024 -obj=
ect memory-
backend-file,id=3Dmem,size=3D1G,mem-path=3D/dev/hugepages,share=3Don -nogra=
phic
-no-user-config -nodefaults -serial
mon:telnet:localhost:7704,server,nowait -monitor
mon:telnet:localhost:8804,server,nowait -numa node,memdev=3Dmem -drive
file=3D/home/qemu/qcows,format=3Dqcow2,if=3Dnone,id=3Ddisk -device ide-
hd,drive=3Ddisk,bootindex=3D0 -drive
file=3Dnvme://0000:d8:00.0,if=3Dnone,id=3Ddrive0 -device virtio-
blk,drive=3Ddrive0,id=3Dvirtio0 --enable-kvm

i am getting kernel panic and not proceed further..please help

PS:-  our guest VM version is

Scientific Linux 7.0 (Nitrogen)
Kernel 3.10.0-123.el7.x86_64 on an x86_64

Regards
Nitin

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "NVME.log"
   https://bugs.launchpad.net/bugs/1735082/+attachment/5016052/+files/NVME.=
log

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1735082

Title:
  NVME pass through in th eguest VM

Status in QEMU:
  New

Bug description:
  Hi Qemu Team

  i am new in qemu and trying for nvme pass through ..
  for that i used  below git repo for nvme =


  https://github.com/famz/qemu/tree/nvme

  and trying to launch the VM by below qemu command ..

  /usr/local/bin/qemu-system-x86_64 -name sl7.0=E2=80=82=E2=80=82-m 1024 -o=
bject memory-
  backend-file,id=3Dmem,size=3D1G,mem-path=3D/dev/hugepages,share=3Don
  -nographic -no-user-config -nodefaults -serial
  mon:telnet:localhost:7704,server,nowait -monitor
  mon:telnet:localhost:8804,server,nowait -numa node,memdev=3Dmem -drive
  file=3D/home/qemu/qcows,format=3Dqcow2,if=3Dnone,id=3Ddisk -device ide-
  hd,drive=3Ddisk,bootindex=3D0 -drive
  file=3Dnvme://0000:d8:00.0,if=3Dnone,id=3Ddrive0 -device virtio-
  blk,drive=3Ddrive0,id=3Dvirtio0 --enable-kvm

  i am getting kernel panic and not proceed further..please help

  PS:-  our guest VM version is

  Scientific Linux 7.0 (Nitrogen)
  Kernel 3.10.0-123.el7.x86_64 on an x86_64

  Regards
  Nitin

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1735082/+subscriptions
