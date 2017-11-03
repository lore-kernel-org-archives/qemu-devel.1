Received: from eggs.gnu.org ([2001:4830:134:3::10]:56842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAa5s-0006k1-CT
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAa5p-0007FA-7y
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:25:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:44924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eAa5p-0007DZ-21
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:24:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eAa5m-00082D-SC
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 11:24:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D3DA02E80CB
	for <qemu-devel@nongnu.org>; Fri,  3 Nov 2017 11:24:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Nov 2017 11:09:02 -0000
From: Thomas Huth <1087411@bugs.launchpad.net>
Reply-To: Bug 1087411 <1087411@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121206195502.27824.72446.malonedeb@gac.canonical.com>
Message-Id: <150970734255.4240.4529401623812986316.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1087411] Re: pseries machine breaks in
 instalation of SLES11_SP2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1087411

Title:
  pseries machine breaks in instalation of SLES11_SP2

Status in QEMU:
  Incomplete

Bug description:
  QEMU version: 1.0, 1.1, and 1.2

  Host OS:
  Intel(R) Core(TM) i5-2520M CPU @ 2.50GH
   Linux tpad 3.2.0-23-generic #36-Ubuntu SMP Tue Apr 10 20:39:51 UTC 2012 =
x86_64 x86_64 x86_64 GNU/Linux

  SLES Media:
  SLES-11-SP2-DVD-ppc64-GM-DVD1.iso: sha256 -> 2247dd6bb495eb50860668e46f7d=
6ba004eece9909f347c8ce487fd6a5f65ee1

  Command line:
  ./ppc64-softmmu/qemu-system-ppc64 -machine type=3Dpseries,usb=3Doff -m 51=
2 -net nic,vlan=3D0 -net tap -nographic -cdrom =

  /exports/isos/SLES-11-SP2-DVD-ppc64-GM-DVD1.iso -hda /exports/sles11_sp2.=
qcow2 -monitor unix:/dev/tty1,nowait,server

  Error message (after starting instalation ~23%):
  Installation of package ./suse/ppc64/vim-base-7.2-8.15.2.ppc64.rpm failed.
  Subprocess failed. Error: RPM failed: error: %post(vim-base-7.2-8.15.2.pp=
c64.rpm)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1087411/+subscriptions
