Received: from eggs.gnu.org ([2001:4830:134:3::10]:38206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fQfmo-0000YS-Ig
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 17:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fQfmk-0007QN-Iu
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 17:16:06 -0400
Received: from indium.canonical.com ([91.189.90.7]:52812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fQfmk-0007Pl-Cl
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 17:16:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fQfmh-0005bV-VS
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 21:16:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E0AD12E88D8
	for <qemu-devel@nongnu.org>; Wed,  6 Jun 2018 21:15:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Jun 2018 21:07:32 -0000
From: Jacob Bang <julemand101@archlinux.dk>
Reply-To: Bug 1775366 <1775366@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152827602795.25960.11192717382861692470.malonedeb@wampee.canonical.com>
Message-Id: <152831925237.24753.7046504788711493357.malone@gac.canonical.com>
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

I see you point. Just close this issue.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1775366

Title:
   [Feature request] qemu-ga - Allow unexpected parameter

Status in QEMU:
  New

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
