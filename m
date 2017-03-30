Received: from eggs.gnu.org ([2001:4830:134:3::10]:35038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ctUO1-0004VR-NA
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 03:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ctUNv-0002Wv-LH
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 03:20:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:34869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ctUNv-0002V4-F6
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 03:20:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ctUNu-0007Ll-Jy
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 07:20:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 89FCB2E80C3
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 07:20:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Mar 2017 07:14:36 -0000
From: dE <de.techno@gmail.com>
Reply-To: Bug 1677492 <1677492@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170330071437.1125.65090.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1677492] [NEW] block_set_io_throttle complaints
 Need exactly one of 'device' and 'id'
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

All of sudden, after a qemu update, block_set_io_throttle does not work
anymore.

Full command to QEMU monitor --

(qemu) block_set_io_throttle db 0 0 0 0 0 0
Need exactly one of 'device' and 'id'

The help text still point to the same old syntax, which no longer works.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1677492

Title:
  block_set_io_throttle complaints Need exactly one of 'device' and 'id'

Status in QEMU:
  New

Bug description:
  All of sudden, after a qemu update, block_set_io_throttle does not
  work anymore.

  Full command to QEMU monitor --

  (qemu) block_set_io_throttle db 0 0 0 0 0 0
  Need exactly one of 'device' and 'id'

  The help text still point to the same old syntax, which no longer
  works.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1677492/+subscriptions
