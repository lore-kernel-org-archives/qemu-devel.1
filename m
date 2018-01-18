Received: from eggs.gnu.org ([2001:4830:134:3::10]:59210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ecByV-0002yu-6E
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:19:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ecByR-00033G-Mc
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:19:31 -0500
Received: from indium.canonical.com ([91.189.90.7]:50118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ecByR-00031s-El
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:19:27 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ecByQ-0008Ha-5c
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 15:19:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1E4A72E8550
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 15:19:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jan 2018 15:10:10 -0000
From: Thomas Huth <1449687@bugs.launchpad.net>
Reply-To: Bug 1449687 <1449687@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150428180718.24323.78355.malonedeb@wampee.canonical.com>
Message-Id: <151628821044.4895.224822670967455523.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1449687] Re: block migration of qcow2 VMs copies
 all empty space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Well, if you had a closer look at the BZs that you've quoted, especially
BZ 1219541, you should have seen that this problem apparently has been
solved in upstream QEMU version 2.9 or 2.10. So it's really just about
the backlevel version 2.5 that you're using. I'm re-assigning this
ticket to the Ubuntu package, maybe they can fix it for you.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1449687

Title:
  block migration of qcow2 VMs copies all empty space

Status in qemu package in Ubuntu:
  New

Bug description:
  I'm running openstack 2012.1 'icehouse' which, ultimately, calls down
  into qemu-system-x86 2.0.0+dfsg-2ubuntu1.10.

  I primed the process by copying all necessary base images onto the
  destination host.  Nonetheless, post-migration instances are much
  larger than the original image; the copy duplicated all the empty
  space that ought to have remained copy-on-write.

To manage notifications about this bug go to:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1449687/+subscriptions
