Received: from eggs.gnu.org ([2001:4830:134:3::10]:60312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e4juh-00048G-MZ
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e4jue-0002oc-I4
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:41:19 -0400
Received: from indium.canonical.com ([91.189.90.7]:47654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e4jue-0002mW-C6
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:41:16 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e4jub-0004By-Es
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 08:41:13 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 676FB2E80C8
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 08:41:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Oct 2017 08:29:40 -0000
From: Daniel Berrange <1724477@bugs.launchpad.net>
Reply-To: Bug 1724477 <1724477@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150831284620.1599.14269987525342877867.malonedeb@soybean.canonical.com>
Message-Id: <150831538082.17029.16413334604227714653.malone@gac.canonical.com>
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

Note that we tightened up the websocket server impl to validate HTTP
requests more strictly. One key change is that the websockets path is
required to be empty, while noVNC will default to appending a path - so
make sure you change noVNC to have an empty path. Also until GIT master
yesterday, there was a bug that prevented it working if the client
requested keep-alive, which I see noVNC now does. So if you try git
master today, it ought to work.

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
