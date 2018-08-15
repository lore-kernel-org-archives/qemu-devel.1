Received: from eggs.gnu.org ([2001:4830:134:3::10]:56367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpqH6-0006gv-Us
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:31:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpqGi-0004ly-1U
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:31:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:49888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fpqGg-0004j5-TI
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:30:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fpqGf-0005Rp-Pq
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 07:30:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AA3722E851D
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 07:30:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Aug 2018 07:25:12 -0000
From: Thomas Huth <1772086@bugs.launchpad.net>
Reply-To: Bug 1772086 <1772086@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152666797097.2555.6897470014572103765.malonedeb@gac.canonical.com>
Message-Id: <153431791322.27075.4771158624282661187.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1772086] Re: malformed serial data being sent
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

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1772086

Title:
  malformed serial data being sent from guest

Status in QEMU:
  Fix Released

Bug description:
  When sending data through serial from guest each time 0x0A byte is
  sent 0x0D is sent before it. For example, when sending {0x29, 0x0A} on
  the other end I receive {0x29, 0x0D, 0x0A}.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1772086/+subscriptions
