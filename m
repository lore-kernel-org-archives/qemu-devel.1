Received: from eggs.gnu.org ([2001:4830:134:3::10]:40512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fVWPC-0003W9-8I
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 02:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fVWP9-0004v5-1W
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 02:15:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:48260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fVWP8-0004uQ-R1
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 02:15:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fVWP7-0000aK-QA
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 06:15:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C46792E80C8
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 06:15:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Jun 2018 05:59:14 -0000
From: RTOS Pharos <1777777@bugs.launchpad.net>
Reply-To: Bug 1777777 <1777777@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152947435461.1911.16896504402050089205.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1777777] [NEW] arm9 clock pending (SP804)
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

Hello all,

I'm using the versatilepb board and the timer Interrupt Mask Status
register (offset 0x14 of the SP804) does not seem to be working properly
on the latest qemu-2.12. I tried on the 2.5 (i believe this is the
mainstream version that comes with Linux) and it works perfectly.

What happens is that the pending bit does not seem to be set in some
scenarios. In my case, I see the timer value decreasing to 0 and then
being reset to the reload value and neither does the interrupt is
triggered nor the pending bit is set.

I believe this is a matter of timing since in the "long" run the system
eventually catches up (after a few microseconds).

Thank you

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1777777

Title:
  arm9 clock pending (SP804)

Status in QEMU:
  New

Bug description:
  Hello all,

  I'm using the versatilepb board and the timer Interrupt Mask Status
  register (offset 0x14 of the SP804) does not seem to be working
  properly on the latest qemu-2.12. I tried on the 2.5 (i believe this
  is the mainstream version that comes with Linux) and it works
  perfectly.

  What happens is that the pending bit does not seem to be set in some
  scenarios. In my case, I see the timer value decreasing to 0 and then
  being reset to the reload value and neither does the interrupt is
  triggered nor the pending bit is set.

  I believe this is a matter of timing since in the "long" run the
  system eventually catches up (after a few microseconds).

  Thank you

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1777777/+subscriptions
