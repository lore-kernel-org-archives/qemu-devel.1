Received: from eggs.gnu.org ([2001:4830:134:3::10]:41873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e4jHx-00070X-1m
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e4jHs-0003pP-79
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:01:17 -0400
Received: from indium.canonical.com ([91.189.90.7]:35410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e4jHs-0003p6-14
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:01:12 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e4jHp-0000ry-SW
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 08:01:10 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9624C2E80D6
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 08:01:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Oct 2017 07:47:26 -0000
From: Raghav Sinha <1724477@bugs.launchpad.net>
Reply-To: Bug 1724477 <1724477@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150831284620.1599.14269987525342877867.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1724477] [NEW] Build-in websocket broken since
 v2.9.0-rc0
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

Since upgrading to 2.9.0, the qemu's build-in websocket was no longer
available.

Host: Ubuntu 16.04 LTS
Command-line: /bin/qemu-system-x86_64 -enable-kvm -vnc 0.0.0.0:8,websocket

I have tested the following qemu versions:

master      Fail
2.10.1      Fail
2.9.1       Fail
2.9.0       Fail
2.9.0-rc3   Fail
2.9.0-rc0   Fail

2.8.1.1     Pass
2.7.1       Pass
2.6.2       Pass

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "PrintScreen.png"
   https://bugs.launchpad.net/bugs/1724477/+attachment/4974561/+files/Print=
Screen.png

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1724477

Title:
  Build-in websocket broken since v2.9.0-rc0

Status in QEMU:
  New

Bug description:
  Since upgrading to 2.9.0, the qemu's build-in websocket was no longer
  available.

  Host: Ubuntu 16.04 LTS
  Command-line: /bin/qemu-system-x86_64 -enable-kvm -vnc 0.0.0.0:8,websocket

  I have tested the following qemu versions:

  master      Fail
  2.10.1      Fail
  2.9.1       Fail
  2.9.0       Fail
  2.9.0-rc3   Fail
  2.9.0-rc0   Fail

  2.8.1.1     Pass
  2.7.1       Pass
  2.6.2       Pass

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1724477/+subscriptions
