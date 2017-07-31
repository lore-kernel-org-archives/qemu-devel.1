Received: from eggs.gnu.org ([2001:4830:134:3::10]:35233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dc5K6-0000X6-2y
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 03:41:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dc5K3-0005Im-0R
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 03:41:06 -0400
Received: from indium.canonical.com ([91.189.90.7]:52116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dc5K2-0005Hw-Px
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 03:41:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dc5Jz-00040W-Cd
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 07:40:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 029742E80D4
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 07:40:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Jul 2017 07:34:39 -0000
From: Dean Yu <1707587@bugs.launchpad.net>
Reply-To: Bug 1707587 <1707587@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150148647956.21168.8991936268778990991.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1707587] [NEW] Read certificate from USB key
 failed
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

QEMU release version: qemu-2.9.0
VM operation system: win7 32bit

I have an usb key which can be redirected and recognized in VM. However,
it is failed to get the certificate when using the official application
for this usb key. What's more, the whole app is stalled untill this usb
key detached from VM.

As I researched, this usb key uses interrupt transfers when application
trying to read certificate from it. Problem is that some certificate
data abandoned by "usbredir_stop_interrupt_receiving" and
"usbredir_stop_ep". The two functions use "usbredir_free_bufpq" to clear
the buffered usb packets, even the certificate remain in the bufpq.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1707587

Title:
  Read certificate from USB key failed

Status in QEMU:
  New

Bug description:
  QEMU release version: qemu-2.9.0
  VM operation system: win7 32bit

  I have an usb key which can be redirected and recognized in VM.
  However, it is failed to get the certificate when using the official
  application for this usb key. What's more, the whole app is stalled
  untill this usb key detached from VM.

  As I researched, this usb key uses interrupt transfers when
  application trying to read certificate from it. Problem is that some
  certificate data abandoned by "usbredir_stop_interrupt_receiving" and
  "usbredir_stop_ep". The two functions use "usbredir_free_bufpq" to
  clear the buffered usb packets, even the certificate remain in the
  bufpq.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1707587/+subscriptions
