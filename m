Received: from eggs.gnu.org ([2001:4830:134:3::10]:44974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gMC99-0007sW-US
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 08:20:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gMC92-0002w1-Dd
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 08:20:53 -0500
Received: from indium.canonical.com ([91.189.90.7]:41880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gMC92-0002ic-6i
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 08:20:48 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gMC8q-0004W9-5z
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 13:20:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1773B2E80C8
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 13:20:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Nov 2018 13:11:23 -0000
From: Chen Zhang <1802915@bugs.launchpad.net>
Reply-To: Bug 1802915 <1802915@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154202828346.10437.1411488850787353605.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1802915] [NEW] GTK display refresh rate is
 throttled
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

Guest OS running with GL enabled GTK display shows a reduced refresh
rate, e.g. moving cursor around with iGVT-g DMA Buf.

It seems that a default refresh interval GUI_REFRESH_INTERVAL_DEFAULT
(30ms) is defined in include/ui/console.h, throttling the display
refresh rate at 33Hz.

To correct this throttle issue, a shorter interval should be applied to
display change listener or the default value should be used.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: gtk ui

** Attachment added: "slow motion of a throttled windows guest"
   https://bugs.launchpad.net/bugs/1802915/+attachment/5211842/+files/guest=
.mov

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1802915

Title:
  GTK display refresh rate is throttled

Status in QEMU:
  New

Bug description:
  Guest OS running with GL enabled GTK display shows a reduced refresh
  rate, e.g. moving cursor around with iGVT-g DMA Buf.

  It seems that a default refresh interval GUI_REFRESH_INTERVAL_DEFAULT
  (30ms) is defined in include/ui/console.h, throttling the display
  refresh rate at 33Hz.

  To correct this throttle issue, a shorter interval should be applied
  to display change listener or the default value should be used.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1802915/+subscriptions
