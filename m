Received: from eggs.gnu.org ([2001:4830:134:3::10]:35280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cH9Zh-0003T7-Pe
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 08:26:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cH9Zd-0002e8-TI
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 08:26:25 -0500
Received: from indium.canonical.com ([91.189.90.7]:33475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cH9Zd-0002e2-Nh
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 08:26:21 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cH9Zb-00081e-Tk
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 13:26:20 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 366732E81A5
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 13:26:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Dec 2016 13:07:59 -0000
From: Ziyue Yang <1603734@bugs.launchpad.net>
Reply-To: Bug 1603734 <1603734@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160717083810.15994.59203.malonedeb@gac.canonical.com>
Message-Id: <20161214130759.21082.78535.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1603734] Re: Hang in fsqrt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Bug fixed showed by https://github.com/unicorn-engine/unicorn/pull/609
and the test case shows no problem on the most recent release. =


** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1603734

Title:
  Hang in fsqrt

Status in QEMU:
  Fix Released

Bug description:
  At least qemu-i368 and qemu-x86_64 hang in floatx80_sqrt in versions
  2.6.0 and git (2.6.50) for some input values, likely due to an
  infinite loop at fpu/softfloat.c:6569.

  Steps to reproduce:
  1) Compile attached code: gcc -o test test.c -lm
  2) `qemu-i368 test` and `qemu-x86_64 test` will hang at 100% cpu

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1603734/+subscriptions
