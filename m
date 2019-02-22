Received: from eggs.gnu.org ([209.51.188.92]:56324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gxF2u-0002dw-ET
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 12:55:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gxF2t-0003qD-Iz
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 12:55:36 -0500
Received: from indium.canonical.com ([91.189.90.7]:60284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gxF2t-0003pJ-Cq
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 12:55:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gxF2r-0007JH-TU
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 17:55:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DD4032E8024
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 17:55:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 Feb 2019 17:48:59 -0000
From: John Snow <1815445@bugs.launchpad.net>
Reply-To: Bug 1815445 <1815445@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154988507422.19358.16245527010669752237.malonedeb@soybean.canonical.com>
Message-Id: <155085773921.22622.9642437297688951203.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1815445] Re: change and eject commands are not
 working on an overlay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Can you please provide your QEMU version, command line, and any QMP/HMP
commands you issued, and the expected/desired effect?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1815445

Title:
  change and eject commands are not working on an overlay

Status in QEMU:
  New

Bug description:
  From qemu monitor, 'change' and 'eject' commands are not working on a CD =
overlay.
  'info block' returns:
    cd0-overlay0: /home/guillaume/test/cd0-overlay0 (qcow2)
      Attached to:      cd0-device
      Removable device: not locked, tray closed
      Cache mode:       writeback, ignore flushes
      Backing file:     /home/guillaume/test.iso (chain depth: 1)

  But 'eject cd0-overlay0' returns:
    Device 'cd0-overlay0' not found
  I also tried 'cd0-device' and 'cd0'.

  Same problem with 'change' command.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1815445/+subscriptions
