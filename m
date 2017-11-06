Received: from eggs.gnu.org ([2001:4830:134:3::10]:33102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBn7Q-000172-5T
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:31:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBn7M-0004um-WD
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:31:36 -0500
Received: from indium.canonical.com ([91.189.90.7]:46960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eBn7M-0004u7-QW
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:31:32 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eBn7I-0007Tx-9S
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 19:31:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3339A2E81B3
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 19:31:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Nov 2017 19:19:39 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1696773 <1696773@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149693268144.10005.16353270944603688746.malonedeb@wampee.canonical.com>
Message-Id: <150999597975.9241.15387628541679548089.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1696773] Re: golang calls to exec crash user
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Tags added: arm linux-user

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1696773

Title:
  golang calls to exec crash user emulation

Status in QEMU:
  New

Bug description:
  An example program can be found here:

  https://github.com/willnewton/qemucrash

  This code starts a goroutine (thread) and calls exec repeatedly. This
  works ok natively but when run under ARM user emulation it segfaults
  (usually, there are occasionally other failures).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1696773/+subscriptions
