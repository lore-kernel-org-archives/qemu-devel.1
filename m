Received: from eggs.gnu.org ([2001:4830:134:3::10]:49427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eKpLI-0007bY-4w
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:43:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eKpLE-0000Tc-2n
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:43:16 -0500
Received: from indium.canonical.com ([91.189.90.7]:51948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eKpLD-0000T3-SI
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:43:12 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eKY3J-00031j-SX
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 23:15:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D5FB82E80C7
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 23:15:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Nov 2017 23:09:01 -0000
From: Hu Jun <1735576@bugs.launchpad.net>
Reply-To: Bug 1735576 <1735576@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151208334189.10571.827872595239738257.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1735576] [NEW] Support more than 4G memory for
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

Public bug reported:

setup:

host: windows 7 professional 64bit
guest: centos 7
qemu 2.10.92
haxm 6.2.1

issue: when assign 4096M or more memory to the guest, I got following error=
 message:
E:\qemuvm\vm-svr>qemu-system-x86_64 -accel hax -hda centos-1.vdi -m 4096
HAX is working and emulator runs in fast virt mode.
Failed to allocate 0 memory
hax_transaction_commit: Failed mapping @0x0000000000000000+0xc0000000 flags=
 00
hax_transaction_commit: Failed mapping @0x0000000100000000+0x40000000 flags=
 00
VCPU shutdown request
VCPU shutdown request
if I change memory to 4095M, guest VM boot up without issue

E:\qemuvm\vm-svr>qemu-system-x86_64 -accel hax -hda centos-1.vdi -m 4095
HAX is working and emulator runs in fast virt mode.


This is known limitation, I already raised a request on HAXM github site fo=
r fix this: https://github.com/intel/haxm/issues/13, and it got accepted wi=
ll be fixed in next haxm release; however it seems there is also qemu side =
work (according to haxm dev), so I raise this for qemu side fix;

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1735576

Title:
  Support more than 4G memory for guest with Intel HAXM acceleration

Status in QEMU:
  New

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
