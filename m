Received: from eggs.gnu.org ([209.51.188.92]:38261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gm2f2-0007fM-Ql
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gm2f1-0000rQ-J9
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:28:40 -0500
Received: from indium.canonical.com ([91.189.90.7]:46290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gm2f1-0000bp-Bf
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:28:39 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gm1I3-00083o-TJ
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 19:00:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DB8AA2E80CC
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 19:00:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Jan 2019 18:54:57 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1809291 <1809291@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154532874183.18487.10011391612831676105.malonedeb@gac.canonical.com>
Message-Id: <154818329795.2122.4903377997232518928.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1809291] Re: ARM PL181 (mmc for Security Digital
 Card) not working in Ubuntu 18.10 (CMD 2,
 3 timeout). The SDC driver worked fine in Ubuntu 18.04 and earlier versions
 but not in Ubuntu 18.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi -- could you please either provide a guest binary to reproduce with,
or a complete set of sources to build to produce the test binary?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1809291

Title:
  ARM PL181 (mmc for Security Digital Card) not working in Ubuntu 18.10
  (CMD 2,3 timeout).  The SDC driver worked fine in Ubuntu 18.04 and
  earlier versions but not in Ubuntu 18.10

Status in QEMU:
  New

Bug description:
  ARM PL181 MMC card no longer working in qemu-system-arm in Ubuntu 18.10
  The MMC driver code worked fine in Ubuntu 15.10 to 18.04.
  The command to run qemu-system-arm is

      qemu-system-arm -M versatilepb -m 256M -sd sdimage -kernel t.bin
  -serial mon:stdio

  During SDC initialization, SDC commands 2, 3, 9, 13, 7, 16 all timeout, =

  which cause subsequent read/write commands 17/24 to fail also.

  Tried both ARM versatilepb and realview-pb-a8, realview-pbx-a9 boards:
  all the same.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1809291/+subscriptions
