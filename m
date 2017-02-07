Received: from eggs.gnu.org ([2001:4830:134:3::10]:48007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cbFIl-0002Lb-0G
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:36:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cbFIh-0007sV-Rt
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:35:59 -0500
Received: from indium.canonical.com ([91.189.90.7]:36128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cbFIh-0007s3-LJ
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:35:55 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cbFIf-0002Yf-EN
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 23:35:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 26AC72E8196
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 23:35:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Feb 2017 23:22:26 -0000
From: Max Reitz <1662468@bugs.launchpad.net>
Reply-To: Bug 1662468 <1662468@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170207100302.3995.67911.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170207232226.5557.42629.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1662468] Re: [feature request] qemu-img convert
 should respond to control-T like dd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

That should be simple enough to implement considering we have this
behavior already on SIGUSR1. Unfortunately, I wouldn't be able to test
it because Linux apparently doesn't implement SIGINFO...

Max


PS: By the way, thanks for the information. I didn't know about SIGINFO at =
all. Well, now I have mapped Ctrl-T to SIGUSR1 in my terminal emulator so I=
 don't have to feel quite as inferior...

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1662468

Title:
  [feature request] qemu-img convert should respond to control-T like dd

Status in QEMU:
  New

Bug description:
  Since qemu-img convert is a long-running operation, it would be nice
  if it reported progress in response to control-T (SIGINFO) to show
  progress information, much like dd, fsck, dump, cp, etc.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1662468/+subscriptions
