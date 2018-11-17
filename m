Received: from eggs.gnu.org ([2001:4830:134:3::10]:46132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gNsFd-0006fy-JT
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 23:30:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gNsFY-0001YQ-Ln
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 23:30:33 -0500
Received: from indium.canonical.com ([91.189.90.7]:43802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gNsFY-0001YA-Eq
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 23:30:28 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gNsFW-0008PX-Uk
	for <qemu-devel@nongnu.org>; Sat, 17 Nov 2018 04:30:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DC4482E8053
	for <qemu-devel@nongnu.org>; Sat, 17 Nov 2018 04:30:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Nov 2018 04:17:17 -0000
From: Launchpad Bug Tracker <1502095@bugs.launchpad.net>
Reply-To: Bug 1502095 <1502095@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20151002110410.1688.87018.malonedeb@wampee.canonical.com>
Message-Id: <154242823900.23408.14055285525303037437.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] =?utf-8?q?=5BBug_1502095=5D_Re=3A_Sporadic_input_/_o?=
 =?utf-8?q?utput_error_=E2=80=94_x86-64_linux_guest?=
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
https://bugs.launchpad.net/bugs/1502095

Title:
  Sporadic input / output error =E2=80=94 x86-64 linux guest

Status in QEMU:
  Expired

Bug description:
  ** Setup: **

  =E2=86=92 Host
  =C2=A0=C2=A0=C2=A0=C2=A0Qemu version 2.4.0.1
  =C2=A0=C2=A0=C2=A0=C2=A0Linux: 4.1.1 (Debian 8.2, GCC 4.9.2, x86_64)
  =C2=A0=C2=A0=C2=A0=C2=A0filesystem ext3 and ext4
  =C2=A0=C2=A0=C2=A0=C2=A0one single host machine

  =E2=86=92 Guests (3 VMs)
  =C2=A0=C2=A0=C2=A0=C2=A0architecture x86_64, Linux 3.16.0-4-amd64 (Debian=
 7.6)
  =C2=A0=C2=A0=C2=A0=C2=A0virtual disk qcow2, uncompressed
  =C2=A0=C2=A0=C2=A0=C2=A0guests filesystem ext3
  =C2=A0=C2=A0=C2=A0=C2=A0virtual disks size:  VM1: 3GB,  VM2: 5GB,  VM3: 2=
50GB

  =E2=86=92 Network
  =C2=A0=C2=A0=C2=A0=C2=A0bridge (br0) and tap interfaces.

  ** Command line **

  For all 3 VMs, the command line is similar to the following. Only RAM
  size and ID ("109") are changed.

  =C2=A0=C2=A0=C2=A0=C2=A0/usr/local/bin/qemu-system-x86_64 -hda /media/rai=
d1/qemu-109 -m 8G -smp 4 -enable-kvm \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-netdev bridge,id=3Dbr109=
 -device virtio-net-pci,netdev=3Dbr109,id=3Dnic0,mac=3D00:00:00:00:01:09 \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-k it -daemonize

  ** Problem **

  Sporadic, unexplained input output error.
  When I try to SSH to one of the instances, most of the times everything j=
ust works fine. Some other times, the SSH connection can be established, bu=
t as I interact with the guest via SSH (ls, cd, top) the guest reports "inp=
ut / output error" on the SSH console. Sometimes, the SSH daemon on the gue=
st answers "/bin/bash input output error". Sometimes the SSH client answers=
 that the connection has been dropped by the host.

  When this happens, the web services I run on the VMs are and remain unrea=
chable, the VMs themselves are and remain unreachable/unusable via SSH as d=
escribed, and after killing the relative qemu processes and restarting the =
VMs, no recent logs are registered on /var/logs on the guests, arguably sin=
ce the time of the crash.
  The crash is not triggered by SSH, I just find SSH to be nonfunctional af=
ter I spot my web services offline.

  This only happens to one VM at a time, independently. The other VMs
  appear to run fine when one VM encounters the problem.

  I wish instructions to further debug this.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1502095/+subscriptions
