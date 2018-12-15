Received: from eggs.gnu.org ([2001:4830:134:3::10]:51441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gYBdD-0005Sv-SI
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 10:13:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gYBLu-0007LO-0g
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 09:55:42 -0500
Received: from indium.canonical.com ([91.189.90.7]:50408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gYBLs-00075W-54
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 09:55:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gYBLp-0000JH-SX
	for <qemu-devel@nongnu.org>; Sat, 15 Dec 2018 14:55:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B5C2A2E807C
	for <qemu-devel@nongnu.org>; Sat, 15 Dec 2018 14:55:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Dec 2018 14:50:05 -0000
From: Thomas Arouge <agentlecomputer@gmail.com>
Reply-To: Bug 1802915 <1802915@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154202828346.10437.1411488850787353605.malonedeb@wampee.canonical.com>
Message-Id: <154488540561.1570.2729750501782833146.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1802915] Re: GTK display refresh rate is throttled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Instead of changing the value, I think there should be a function that
determines the ideal "GUI_REFRESH_INTERVAL_DEFAULT" value, with the
option to override it. That way, monitor greater than 60 Hz can also
benefit.

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

  Apparently, a default refresh interval GUI_REFRESH_INTERVAL_DEFAULT
  (30ms) is defined in include/ui/console.h, throttling the display
  refresh rate at 33Hz.

  To correct this throttle issue, a shorter interval (16 or 17
  milliseconds) should be applied to display change listener or the
  default value should be modified.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1802915/+subscriptions
