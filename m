Received: from eggs.gnu.org ([2001:4830:134:3::10]:52131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fJkJc-0002Kd-Ok
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:41:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fJkJX-0004AP-S3
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:41:20 -0400
Received: from indium.canonical.com ([91.189.90.7]:39992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fJkJX-000486-LF
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:41:15 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fJkJV-000346-KE
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 18:41:13 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 423362E8F43
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 18:41:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 May 2018 18:26:10 -0000
From: Patto <1772086@bugs.launchpad.net>
Reply-To: Bug 1772086 <1772086@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152666797097.2555.6897470014572103765.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1772086] [NEW] malformed serial data being sent
 from guest
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

When sending data through serial from guest each time 0x0A byte is sent
0x0D is sent before it. For example, when sending {0x29, 0x0A} on the
other end I receive {0x29, 0x0D, 0x0A}.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: com serial

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1772086

Title:
  malformed serial data being sent from guest

Status in QEMU:
  New

Bug description:
  When sending data through serial from guest each time 0x0A byte is
  sent 0x0D is sent before it. For example, when sending {0x29, 0x0A} on
  the other end I receive {0x29, 0x0D, 0x0A}.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1772086/+subscriptions
