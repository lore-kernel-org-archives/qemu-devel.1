Received: from eggs.gnu.org ([2001:4830:134:3::10]:47672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePTz8-000327-73
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePTz4-0006uX-AH
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:55:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:50546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ePTz3-0006sP-To
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:55:34 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ePTz2-0007Bg-Sr
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 13:55:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D7AC52E80AD
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 13:55:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Dec 2017 13:45:19 -0000
From: Roman <romanzwi000@gmx.at>
Reply-To: Bug 1738202 <1738202@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151325583524.11815.276669131575779398.malonedeb@gac.canonical.com>
Message-Id: <151325912000.12251.3994858655555811879.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1738202] Re: qemu 2.11 segfaults on elf file that
 worked with qemu2.7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thanks Peter for this information!

I guess our code was tweaked to run with this options a long time ago -
so I will have to do some investigations to get it working with a valid
NVIC...

As of writing I remember having a similar issue some time ago (which I now =
found to have resulted in Bug 1636126).
Sorry for not remembering this before!

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1738202

Title:
  qemu 2.11 segfaults on elf file that worked with qemu2.7

Status in QEMU:
  Invalid

Bug description:
  running on cygwin in Windows 7

  QEMU 2.10.93 segfaults:
  $ /opt/qemu2.11/qemu-system-arm -M integratorcp -cpu cortex-m4 -semihosti=
ng -nographic -monitor null -serial null -no-reboot -kernel MFWso_Cycle_f1u=
P2_CUNIT_0.elf
  Segmentation fault

  where QEMU 2.7.0 worked:
  $ /opt/qemu2.7/qemu-system-arm -M integratorcp -cpu cortex-m4 -semihostin=
g -nographic -monitor null -serial null -no-reboot -kernel MFWso_Cycle_f1uP=
2_CUNIT_0.elf
  ------------ CUnit_MFWso_Cycle_f1 ------------

  =

       CUnit - A Unit testing framework for C - Version 2.1-0
       http://cunit.sourceforge.net/

  =

  Suite: Suite_MFWso_Cycle_f1
    Test: MFWso_Cycle_f1() ... passed
    Test: MFWso_GetPhysicalStateData() ... passed
    Test: MFWso_GetOutputData() ... passed
    Test: MFWso_GetSafeChannelOK() ... passed

  --Run Summary: Type      Total     Ran  Passed  Failed
                 suites        1       1     n/a       0
                 tests         4       4       4       0
                 asserts      54      54      54       0

  ----------------------------------------

  Omitting the -cpu parameter results (for both versions) to hang of
  qemu (no output, no end, full cpu load).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1738202/+subscriptions
