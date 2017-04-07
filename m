Received: from eggs.gnu.org ([2001:4830:134:3::10]:50515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwUW3-0003Vr-MR
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwUW2-0000Wq-Ph
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:05:31 -0400
Received: from indium.canonical.com ([91.189.90.7]:43302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cwUW2-0000WP-IP
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:05:30 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cwUW1-0003Ou-4m
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 14:05:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D882C2E80CC
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 14:05:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Apr 2017 13:50:51 -0000
From: Thomas Huth <1067119@bugs.launchpad.net>
Reply-To: Bug 1067119 <1067119@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121015231944.16996.69184.malonedeb@wampee.canonical.com>
Message-Id: <20170407135051.2322.4604.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1067119] Re: e1000 missing statistics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looks like these counters have been implemented here:
http://git.qemu-project.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D3b27430177498a=
1728b6

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1067119

Title:
  e1000 missing statistics

Status in QEMU:
  Fix Released

Bug description:
  The E1000 emulation is missing several counters that are used by other
  software.

  The following would be useful:
    Good bytes receive counter GORCH/GORCL
    Good bytes transmit counter GOTCH/GOTCL
  Broadcast packets sent/received
  Multicast packets sent/received.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1067119/+subscriptions
