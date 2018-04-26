Received: from eggs.gnu.org ([2001:4830:134:3::10]:58135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fBaCS-0001xH-I8
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 02:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fBaCP-0004Lp-8G
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 02:16:12 -0400
Received: from indium.canonical.com ([91.189.90.7]:60586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fBaCP-0004LU-2N
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 02:16:09 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fBaCN-0000a2-HO
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 06:16:07 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 641EA2E80C8
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 06:16:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Apr 2018 06:03:56 -0000
From: Thomas Huth <1735576@bugs.launchpad.net>
Reply-To: Bug 1735576 <1735576@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151208334189.10571.827872595239738257.malonedeb@soybean.canonical.com>
Message-Id: <152472263668.22033.3323166989226897864.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1735576] Re: Support more than 4G memory for
 guest with Intel HAXM acceleration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fix has been included here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D7a5235c9e679c58be4

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1735576

Title:
  Support more than 4G memory for guest with Intel HAXM acceleration

Status in QEMU:
  Fix Released

Bug description:
  setup:

  host: windows 7 professional 64bit
  guest: centos 7
  qemu 2.10.92
  haxm 6.2.1

  issue: when assign 4096M or more memory to the guest, I got following err=
or message:
  E:\qemuvm\vm-svr>qemu-system-x86_64 -accel hax -hda centos-1.vdi -m 4096
  HAX is working and emulator runs in fast virt mode.
  Failed to allocate 0 memory
  hax_transaction_commit: Failed mapping @0x0000000000000000+0xc0000000 fla=
gs 00
  hax_transaction_commit: Failed mapping @0x0000000100000000+0x40000000 fla=
gs 00
  VCPU shutdown request
  VCPU shutdown request
  if I change memory to 4095M, guest VM boot up without issue

  E:\qemuvm\vm-svr>qemu-system-x86_64 -accel hax -hda centos-1.vdi -m 4095
  HAX is working and emulator runs in fast virt mode.

  =

  This is known limitation, I already raised a request on HAXM github site =
for fix this: https://github.com/intel/haxm/issues/13, and it got accepted =
will be fixed in next haxm release; however it seems there is also qemu sid=
e work (according to haxm dev), so I raise this for qemu side fix;

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1735576/+subscriptions
