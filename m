Received: from eggs.gnu.org ([2001:4830:134:3::10]:59785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fQUXi-0005KD-3V
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 05:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fQUXb-0003nN-HW
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 05:15:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:54866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fQUXb-0003mz-7A
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 05:15:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fQUXZ-00032i-U9
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 09:15:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DD5962E804F
	for <qemu-devel@nongnu.org>; Wed,  6 Jun 2018 09:15:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Jun 2018 09:07:07 -0000
From: Jacob Bang <julemand101@gmail.com>
Reply-To: Bug 1775366 <1775366@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152827602795.25960.11192717382861692470.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1775366] [NEW] [Feature request] qemu-ga - Allow
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

Public bug reported:

It whould be nice if the qemu-ga allowed received messages to contain
fields which is not part of the spec. In my example I have a host which
sends the following request:

{"execute":"guest-exec","arguments":{"path":"prl_nettool","capture-
output":true,"execute-in-shell":false,"arg":[...]}}

Right now this request is rejected with the following error:

{"error": {"class": "GenericError", "desc": "Parameter 'execute-in-
shell' is unexpected"}}

My situation is the hosting provider I use does have some customized
solution which sends some extra arguments. I have manually patched my
qemu-ga so it accepts the "execute-in-shell" parameter but I don't think
this should be necessary.

Instead of "Error" it should just be a "warning" returned to the user of
qemu-ga but the call should still be executed.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: qemu-ga

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
