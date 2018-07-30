Received: from eggs.gnu.org ([2001:4830:134:3::10]:38002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fkDBC-0008Gy-Ag
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 14:46:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fkDB7-0002D0-BP
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 14:46:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:52320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fkDB7-0002CX-4V
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 14:45:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fkDB4-0008V2-6N
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 18:45:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B5CD32E80D1
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 18:45:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Jul 2018 18:38:48 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1777777 <1777777@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152947435461.1911.16896504402050089205.malonedeb@chaenomeles.canonical.com>
Message-Id: <153297592885.3867.6958781175423605727.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1777777] Re: arm9 clock pending (SP804)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Sorry, I should have been clearer. Please can you provide a test case
binary and QEMU command line that reproduces the problem (including what
the expected output is and what the actual output is)?

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
