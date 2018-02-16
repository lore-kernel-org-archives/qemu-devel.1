Received: from eggs.gnu.org ([2001:4830:134:3::10]:39380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1emWU7-0000ZZ-Tw
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 22:14:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1emWU3-0000XN-Tz
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 22:14:51 -0500
Received: from indium.canonical.com ([91.189.90.7]:58414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1emWU3-0000WL-Nm
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 22:14:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1emWU2-0001uC-Q7
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 03:14:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BD8CC2E80C9
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 03:14:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Feb 2018 03:01:43 -0000
From: Matthew Stapleton <matthew4196@gmail.com>
Reply-To: Bug 1331334 <1331334@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140618065216.24164.95192.malonedeb@chaenomeles.canonical.com>
Message-Id: <151875010398.407.15752957494081465183.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1331334] Re: driftfix=none and migration on Win7
 guest causes time to go 10 times as fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I am unable to reproduce this with qemu 2.11.0

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1331334

Title:
  driftfix=3Dnone and migration on Win7 guest causes time to go 10 times
  as fast

Status in QEMU:
  Incomplete

Bug description:
  With -rtc base=3Dlocaltime,clock=3Dhost,driftfix=3Dnone on a Win7 guest,
  stopping it with migration and then starting it again about 1 hour
  later makes the guest time go 10 times as fast as real time until
  Windows is rebooted.  I have tried qith qemu-2.0.0 and the problem
  still exists there.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1331334/+subscriptions
