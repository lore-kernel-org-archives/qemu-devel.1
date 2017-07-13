Received: from eggs.gnu.org ([2001:4830:134:3::10]:38505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dViGO-0007cO-3M
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dViGL-0004N2-1M
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:50:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:47942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dViGK-0004Lg-RC
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:50:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dViGI-0003JD-TZ
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 17:50:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DBE492E80D6
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 17:50:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Jul 2017 17:43:04 -0000
From: Michal Suchanek <hramrach@gmail.com>
Reply-To: Bug 1704186 <1704186@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <149996778424.24106.6587352102068087563.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1704186] [NEW] no option for handling ^C in stdio
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

There is no way to tell qemu to handle (or not) ^C on standard input.

This makes using serial console on stdio needlessly annoying and
difficult.

The code is there - depending on how you set up the console it may
handle the signal or not.

That's completely backwards. The behavior should be the same regardless
of how you set up console *and* there should be a separate option for
handling ^C.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1704186

Title:
  no option for handling ^C in stdio

Status in QEMU:
  New

Bug description:
  There is no way to tell qemu to handle (or not) ^C on standard input.

  This makes using serial console on stdio needlessly annoying and
  difficult.

  The code is there - depending on how you set up the console it may
  handle the signal or not.

  That's completely backwards. The behavior should be the same
  regardless of how you set up console *and* there should be a separate
  option for handling ^C.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1704186/+subscriptions
