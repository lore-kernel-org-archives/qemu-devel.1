Received: from eggs.gnu.org ([2001:4830:134:3::10]:54074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTNRv-0003k6-RR
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 01:40:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTNRr-0007E6-Sb
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 01:40:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:34265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTNRr-0007Dw-MX
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 01:40:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTNRq-0002uJ-JC
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 06:40:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7463D2E80AF
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 06:40:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jan 2017 06:34:35 -0000
From: Richard Jones <rjones@redhat.com>
Reply-To: Bug 1657010 <1657010@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170117063435.21322.40478.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1657010] [NEW] RFE: Please implement -cpu best or
 a CPU fallback option
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

QEMU should implement a -cpu best option or some other way to make this
work:

qemu -M pc,accel=3Dkvm:tcg -cpu best

qemu -M pc,accel=3Dkvm:tcg -cpu host:qemu64

See also:

https://bugzilla.redhat.com/show_bug.cgi?id=3D1277744#c6

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1657010

Title:
  RFE: Please implement -cpu best or a CPU fallback option

Status in QEMU:
  New

Bug description:
  QEMU should implement a -cpu best option or some other way to make
  this work:

  qemu -M pc,accel=3Dkvm:tcg -cpu best

  qemu -M pc,accel=3Dkvm:tcg -cpu host:qemu64

  See also:

  https://bugzilla.redhat.com/show_bug.cgi?id=3D1277744#c6

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1657010/+subscriptions
