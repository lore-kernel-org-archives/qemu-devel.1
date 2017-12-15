Received: from eggs.gnu.org ([2001:4830:134:3::10]:43035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsnz-0000Mv-5C
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:25:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsnv-0008Ch-3c
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:25:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:55944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ePsnu-0008B2-Ta
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:25:43 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ePsns-0005YH-TJ
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:25:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5D3D92E80DD
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:25:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2017 16:19:46 -0000
From: Thomas Huth <1724477@bugs.launchpad.net>
Reply-To: Bug 1724477 <1724477@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150831284620.1599.14269987525342877867.malonedeb@soybean.canonical.com>
Message-Id: <151335478719.19201.3993071609671878026.launchpad@chaenomeles.canonical.com>
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

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

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
  2.6.2       Pass

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1724477/+subscriptions
