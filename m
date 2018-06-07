Received: from eggs.gnu.org ([2001:4830:134:3::10]:43726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fQsLu-0004yT-Au
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fQsLr-0004PF-8Y
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:41:10 -0400
Received: from indium.canonical.com ([91.189.90.7]:36108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fQsLr-0004OR-1V
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:41:07 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fQsLp-00033R-Jh
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 10:41:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8724B2E88D2
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 10:41:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Jun 2018 10:28:35 -0000
From: Daniel Berrange <1775366@bugs.launchpad.net>
Reply-To: Bug 1775366 <1775366@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152827602795.25960.11192717382861692470.malonedeb@wampee.canonical.com>
Message-Id: <152836731508.24903.11927103162357903967.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1775366] Re: [Feature request] qemu-ga - Allow
 unexpected parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

BTW, if you have any friendly contact with the your hosting provider,
please encourage them to contribute any enhancements they have back to
QEMU. It is highly desirable to *NOT* have hosting providers needing a
fork of qemu-ga, as that ruins ability to run standard disk images, as
you've found.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1775366

Title:
   [Feature request] qemu-ga - Allow unexpected parameter

Status in QEMU:
  Won't Fix

Bug description:
  It whould be nice if the qemu-ga allowed received messages to contain
  fields which is not part of the spec. In my example I have a host
  which sends the following request:

  {"execute":"guest-exec","arguments":{"path":"prl_nettool","capture-
  output":true,"execute-in-shell":false,"arg":[...]}}

  Right now this request is rejected with the following error:

  {"error": {"class": "GenericError", "desc": "Parameter 'execute-in-
  shell' is unexpected"}}

  My situation is the hosting provider I use does have some customized
  solution which sends some extra arguments. I have manually patched my
  qemu-ga so it accepts the "execute-in-shell" parameter but I don't
  think this should be necessary.

  Instead of "Error" it should just be a "warning" returned to the user
  of qemu-ga but the call should still be executed.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1775366/+subscriptions
