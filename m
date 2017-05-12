Received: from eggs.gnu.org ([2001:4830:134:3::10]:37647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d95ji-00074W-QK
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d95jf-0001wh-Ja
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:15:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:36177)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d95jf-0001vu-Ch
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:15:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d95jc-0006sp-VT
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 08:15:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EB0DB2E807D
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 08:15:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 May 2017 08:08:13 -0000
From: js yu <1690322@bugs.launchpad.net>
Reply-To: Bug 1690322 <1690322@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <149457649433.9287.5920128335975841083.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1690322] [NEW] errors which can't backing storage
 for guest RAM with -mem-path
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

I found it can't backup the guest RAM when i run simple ram test code
with

errors which can't backing storage for guest RAM with integratorcp, the
commander is:

qemu-system-arm -M integratorcp -m 1 -semihosting -nographic -mem-path
mem.txt -kernel build/emu_ram_test.elf

i wrote the patter "0x55" to all of the rest of RAM in my test, after
run my test code, it just generate the 1048576 Bytes file, i split these
file into 2kB, most of split file is black, some of them just display
\00 after open with gedit.

i don't know whether my commander is incorrect, anyone can confirm it
for me? i just want to write the guest RAM and read it from host during
the guest code is running. but my guest just has simple os without file
system and network. so i want to try with this backend RAM ways.

thanks.
js

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: integratorcp qemu-system-arm

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1690322

Title:
  errors which can't backing storage for guest RAM with -mem-path

Status in QEMU:
  New

Bug description:
  I found it can't backup the guest RAM when i run simple ram test code
  with

  errors which can't backing storage for guest RAM with integratorcp,
  the commander is:

  qemu-system-arm -M integratorcp -m 1 -semihosting -nographic -mem-path
  mem.txt -kernel build/emu_ram_test.elf

  i wrote the patter "0x55" to all of the rest of RAM in my test, after
  run my test code, it just generate the 1048576 Bytes file, i split
  these file into 2kB, most of split file is black, some of them just
  display \00 after open with gedit.

  i don't know whether my commander is incorrect, anyone can confirm it
  for me? i just want to write the guest RAM and read it from host
  during the guest code is running. but my guest just has simple os
  without file system and network. so i want to try with this backend
  RAM ways.

  thanks.
  js

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1690322/+subscriptions
