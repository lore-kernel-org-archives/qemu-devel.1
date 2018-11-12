Received: from eggs.gnu.org ([2001:4830:134:3::10]:46868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gMCDx-00030c-C1
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 08:25:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gMCDs-00065l-12
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 08:25:53 -0500
Received: from indium.canonical.com ([91.189.90.7]:42544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gMCDq-0005z8-07
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 08:25:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gMCDg-0004wF-2O
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 13:25:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F261C2E80CB
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 13:25:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Nov 2018 13:17:14 -0000
From: Chen Zhang <1802915@bugs.launchpad.net>
Reply-To: Bug 1802915 <1802915@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154202828346.10437.1411488850787353605.malonedeb@wampee.canonical.com>
Message-Id: <154202863465.2665.5183903606856524753.malone@gac.canonical.com>
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

Slow motion clips for host/guest were uploaded as attachments.

** Attachment added: "slow motion for host os"
   https://bugs.launchpad.net/qemu/+bug/1802915/+attachment/5211843/+files/=
host.mov

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
