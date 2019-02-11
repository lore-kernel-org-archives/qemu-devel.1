Received: from eggs.gnu.org ([209.51.188.92]:35577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gtA74-0006z9-GY
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:51:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gtA70-0006bn-AJ
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:51:02 -0500
Received: from indium.canonical.com ([91.189.90.7]:56004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gtA6y-0006T2-CR
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:50:58 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gtA6g-00006w-Bu
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 11:50:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 586F72E8050
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 11:50:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Feb 2019 11:37:54 -0000
From: Guillaume Gardet <1815445@bugs.launchpad.net>
Reply-To: Bug 1815445 <1815445@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154988507422.19358.16245527010669752237.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1815445] [NEW] change and eject commands are not
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

Public bug reported:

>From qemu monitor, 'change' and 'eject' commands are not working on a CD ov=
erlay.
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

** Affects: qemu
     Importance: Undecided
         Status: New

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
