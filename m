Received: from eggs.gnu.org ([2001:4830:134:3::10]:39038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePseO-0000t7-Kh
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:15:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePseM-00036j-7v
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:15:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:53364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ePseM-00035q-0U
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:15:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ePseJ-0003i6-OE
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:15:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4AEBE2E80EB
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:15:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2017 16:06:42 -0000
From: Thomas Huth <1677492@bugs.launchpad.net>
Reply-To: Bug 1677492 <1677492@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170330071437.1125.65090.malonedeb@gac.canonical.com>
Message-Id: <151335400351.19497.6035412627573684203.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1677492] Re: block_set_io_throttle complaints
 Need exactly one of 'device' and 'id'
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
https://bugs.launchpad.net/bugs/1677492

Title:
  block_set_io_throttle complaints Need exactly one of 'device' and 'id'

Status in QEMU:
  Fix Released

Bug description:
  All of sudden, after a qemu update, block_set_io_throttle does not
  work anymore.

  Full command to QEMU monitor --

  (qemu) block_set_io_throttle db 0 0 0 0 0 0
  Need exactly one of 'device' and 'id'

  The help text still point to the same old syntax, which no longer
  works.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1677492/+subscriptions
