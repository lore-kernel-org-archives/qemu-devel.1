Received: from eggs.gnu.org ([2001:4830:134:3::10]:38681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fQs2A-0007eQ-55
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fQs27-0000bS-0L
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:20:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:58580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fQs26-0000YT-PE
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:20:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fQs24-0008Qn-GM
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 10:20:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7A77E2E88DA
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 10:20:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Jun 2018 10:14:46 -0000
From: Thomas Huth <1775366@bugs.launchpad.net>
Reply-To: Bug 1775366 <1775366@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152827602795.25960.11192717382861692470.malonedeb@wampee.canonical.com>
Message-Id: <152836648689.32066.12539262907090961748.malone@soybean.canonical.com>
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

I agree with John, accepting commands that have not fully been
understood is just too dangerous. So closing this as Won't-Fix.

** Changed in: qemu
       Status: New =3D> Won't Fix

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
