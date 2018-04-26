Received: from eggs.gnu.org ([2001:4830:134:3::10]:50228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fBZKj-0002BG-66
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 01:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fBZKi-0003JW-7O
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 01:20:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:47232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fBZKi-0003IJ-26
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 01:20:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fBZKg-0001MJ-3y
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 05:20:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0292F2E80D7
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 05:20:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Apr 2018 05:12:58 -0000
From: Thomas Huth <1756927@bugs.launchpad.net>
Reply-To: Bug 1756927 <1756927@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152147650577.14987.10547442810122600910.malonedeb@chaenomeles.canonical.com>
Message-Id: <152471957910.6859.8789504488575323072.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1756927] Re: ARMv7 LPAE: IFSR doesn't have the
 LPAE bit in case of BKPT
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
https://bugs.launchpad.net/bugs/1756927

Title:
  ARMv7 LPAE: IFSR doesn't have the LPAE bit in case of BKPT

Status in QEMU:
  Fix Released

Bug description:
  When a user application triggers a 'bkpt' instruction while LPAE is
  used, the bit [9] of IFSR is not correctly set during the prefetch
  abort exception.

  You'll find attached a minimal example to reproduce the issue (just run '=
make all').
  The output I get is:

  supervisor
  user
  prefetch
  short-descriptor

  The last entry should read 'long-descriptor'.

  =

  Qemu revision: 48ae1f60d8c9a770e6da64407984d84e25253c69
  Ubuntu verison: 16.04 LTS
  Cross Compiler: gcc linaro 6.3.1-2017.02-x86_64_arm-eabi

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1756927/+subscriptions
