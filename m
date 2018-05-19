Received: from eggs.gnu.org ([2001:4830:134:3::10]:49427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fJuvM-00004y-9G
	for qemu-devel@nongnu.org; Sat, 19 May 2018 02:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fJuvH-0001wC-1F
	for qemu-devel@nongnu.org; Sat, 19 May 2018 02:01:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:40348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fJuvG-0001vy-Qz
	for qemu-devel@nongnu.org; Sat, 19 May 2018 02:00:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fJuvF-00025a-QB
	for <qemu-devel@nongnu.org>; Sat, 19 May 2018 06:00:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 930952E8F3B
	for <qemu-devel@nongnu.org>; Sat, 19 May 2018 06:00:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 May 2018 05:55:13 -0000
From: Thomas Huth <1772086@bugs.launchpad.net>
Reply-To: Bug 1772086 <1772086@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152666797097.2555.6897470014572103765.malonedeb@gac.canonical.com>
Message-Id: <152670931346.16077.4734219283634645843.malone@wampee.canonical.com>
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

It's even older than 6 years, see:
https://lists.nongnu.org/archive/html/qemu-devel/2006-06/msg00196.html
and:
https://bugs.launchpad.net/qemu/+bug/1407813
https://bugs.launchpad.net/qemu/+bug/1715296

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1772086

Title:
  malformed serial data being sent from guest

Status in QEMU:
  New

Bug description:
  When sending data through serial from guest each time 0x0A byte is
  sent 0x0D is sent before it. For example, when sending {0x29, 0x0A} on
  the other end I receive {0x29, 0x0D, 0x0A}.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1772086/+subscriptions
