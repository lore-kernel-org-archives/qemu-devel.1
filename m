Received: from eggs.gnu.org ([2001:4830:134:3::10]:59920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8R1n-0003xg-Pc
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8R1k-0008IP-Vv
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:19:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:52134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8R1k-0008H9-PN
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:19:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8R1j-0001Rl-TZ
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 13:19:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DC5E12E80C7
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 13:19:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Oct 2017 13:04:51 -0000
From: Thomas Huth <1338957@bugs.launchpad.net>
Reply-To: Bug 1338957 <1338957@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140708091208.10184.15528.malonedeb@soybean.canonical.com>
Message-Id: <150919589194.4122.9434229492569189875.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1338957] Re: RFE: add an event to report block
 devices watermark
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Upstream here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3De2462113b2003085ad16f=
15e1

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1338957

Title:
  RFE: add an event to report block devices watermark

Status in QEMU:
  Fix Released

Bug description:
  Add an event to report if a block device usage exceeds a threshold.
  The threshold should be configurable with a monitor command. The event
  should report the affected block device. Additional useful information
  could be the offset of the highest sector , like in the query-
  blockstats output.

  Rationale for the RFE
  Managing applications, like oVirt (http://www.ovirt.org), make extensive =
use of thin-provisioned disk images.
  In order to let the guest run flawlessly and be not unnecessarily paused,=
 oVirt sets a watermark and automatically resized the image once the waterm=
ark is reached or exceeded.

  In order to detect the mark crossing, the managing application has no cho=
ice than aggressively polling the QEMU monitor
  using the query-blockstats command. This lead to unnecessary system load,=
 and is made even worse under scale: scenarios
  with hunderds of VM are becoming not unusual.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1338957/+subscriptions
