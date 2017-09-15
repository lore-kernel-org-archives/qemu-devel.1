Received: from eggs.gnu.org ([2001:4830:134:3::10]:53889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dsheV-0005Sc-Bw
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dsheS-0002pL-6n
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:50:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:51804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dsheS-0002p6-0c
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:50:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dsheP-0005l0-Qe
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 03:50:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BF9F02E8488
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 03:50:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Sep 2017 03:40:58 -0000
From: Iordan Iordanov <iiordanov@gmail.com>
Reply-To: Bug 1717414 <1717414@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150544685826.29673.14944456813287969209.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1717414] [NEW] Sending certain keysyms results in
 wrong symbol input
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

I develop bVNC, an Android VNC client. I noticed that when I connect to
qemu VMs that have a VNC console, Keysyms that are usually sent over
with SHIFT modifier when connecting from a PC have wrong symbols typed
within the VM. A very short list of examples:

exclam                              33     0x0021

results in "1" typed in the VM.

at                                  64     0x0040

results in "2"

plus                                43     0x002b

results in "=3D"

asterisk                            42     0x002a

results in "8"

On Android, KEYCODEs that correspond to the above keysyms do not come
with SHIFT metastate. Therefore, the keysyms that they correspond to are
not sent over with any modifiers and must just work.

The issue was reproduced with bVNC and RealVNC viewers connecting to
many versions of qemu (Ubuntu 14.04, oVirt 3.4, oVirt 4.1, etc.). The
qemu version that comes with oVirt 4.1 is 2.6.0, commit hash
bfc766d38e1fae5767d43845c15c79ac8fa6d6af.

Sincerely,
iordan

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1717414

Title:
  Sending certain keysyms results in wrong symbol input

Status in QEMU:
  New

Bug description:
  I develop bVNC, an Android VNC client. I noticed that when I connect
  to qemu VMs that have a VNC console, Keysyms that are usually sent
  over with SHIFT modifier when connecting from a PC have wrong symbols
  typed within the VM. A very short list of examples:

  exclam                              33     0x0021

  results in "1" typed in the VM.

  at                                  64     0x0040

  results in "2"

  plus                                43     0x002b

  results in "=3D"

  asterisk                            42     0x002a

  results in "8"

  On Android, KEYCODEs that correspond to the above keysyms do not come
  with SHIFT metastate. Therefore, the keysyms that they correspond to
  are not sent over with any modifiers and must just work.

  The issue was reproduced with bVNC and RealVNC viewers connecting to
  many versions of qemu (Ubuntu 14.04, oVirt 3.4, oVirt 4.1, etc.). The
  qemu version that comes with oVirt 4.1 is 2.6.0, commit hash
  bfc766d38e1fae5767d43845c15c79ac8fa6d6af.

  Sincerely,
  iordan

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1717414/+subscriptions
