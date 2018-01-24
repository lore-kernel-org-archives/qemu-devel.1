Received: from eggs.gnu.org ([2001:4830:134:3::10]:33165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eeJtU-0003C7-Os
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 07:11:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eeJtP-0004gL-Qk
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 07:11:08 -0500
Received: from indium.canonical.com ([91.189.90.7]:43484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eeJtP-0004fc-KZ
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 07:11:03 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eeJtO-0004yA-0p
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 12:11:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 043F32E854F
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 12:11:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jan 2018 11:56:06 -0000
From: jamiedo2nn <1724477@bugs.launchpad.net>
Reply-To: Bug 1724477 <1724477@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150831284620.1599.14269987525342877867.malonedeb@soybean.canonical.com>
Message-Id: <151679496722.20532.11240110621553262985.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1724477] Re: Build-in websocket broken since
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

** Description changed:

  Since upgrading to 2.9.0, the qemu's build-in websocket was no longer
  available.
  =

  Host: Ubuntu 16.04 LTS
  Command-line: /bin/qemu-system-x86_64 -enable-kvm -vnc 0.0.0.0:8,websocket
  =

  I have tested the following qemu versions:
  =

  master      Fail
  2.10.1      Fail
  2.9.1       Fail
  2.9.0       Fail
  2.9.0-rc3   Fail
  2.9.0-rc0   Fail
  =

  2.8.1.1     Pass
  2.7.1       Pass
- 2.6.2       Pass
+ 2.6.2       Pass1

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1724477

Title:
  Build-in websocket broken since v2.9.0-rc0

Status in QEMU:
  Fix Released

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
  2.6.2       Pass1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1724477/+subscriptions
