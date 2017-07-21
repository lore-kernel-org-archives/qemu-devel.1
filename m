Received: from eggs.gnu.org ([2001:4830:134:3::10]:39763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYZAv-0004wD-P1
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYZAr-0001dZ-0Y
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:45:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:52101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dYZAq-0001cy-Ql
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:45:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dYZAo-00042k-UG
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 14:44:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BDF3C2E8081
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 14:44:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Jul 2017 14:32:11 -0000
From: Thomas Huth <1334397@bugs.launchpad.net>
Reply-To: Bug 1334397 <1334397@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140625183928.7492.77861.malonedeb@chaenomeles.canonical.com>
Message-Id: <150064753143.24716.2146801201799545317.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1334397] Re: cmos RTC alarms no longer wake
 system from suspend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I assume this has been fixed in v2.1.0 or newer, like the "Fix
committed" state indicates, so closing as "Fix released" now. In case
there still something left to do here, feel free to re-open it.

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1334397

Title:
  cmos RTC alarms no longer wake system from suspend

Status in QEMU:
  Fix Released

Bug description:
  Running QEMU emulator version 2.0.0 (Debian 2.0.0+dfsg-2ubuntu1.1),
  booting Linux kernels with qemu-system-x86_64 and qemu-system-i386, I
  no longer see the system resume from suspend when an RTC alarm is set.

  My simple test application can be found here:
  https://github.com/johnstultz-work/timetests/blob/master/alarmtimer-suspe=
nd.c

  Previously this worked w/ QEMU 1.5  (bascially up until I upgraded
  from Ubuntu 13.10 to Ubuntu 14.04, which came with 2.0).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1334397/+subscriptions
