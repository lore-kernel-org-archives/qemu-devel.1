Received: from eggs.gnu.org ([2001:4830:134:3::10]:54518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fmfuH-00009k-8d
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 09:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fmfuC-0007e9-HQ
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 09:50:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:54426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fmfuC-0007da-9z
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 09:50:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fmfuA-0004G6-EJ
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 13:50:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6B5A62E80CE
	for <qemu-devel@nongnu.org>; Mon,  6 Aug 2018 13:50:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Aug 2018 13:40:12 -0000
From: Ra Cohen <1785308@bugs.launchpad.net>
Reply-To: Bug 1785308 <1785308@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153332397534.32176.3210060625384706087.malonedeb@gac.canonical.com>
Message-Id: <153356281223.3404.418291500984064144.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1785308] Re: 0x8 exception encountered but not
 handled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi David,
    The OS is hitting something undefined. It's built on exploiting the x86=
 architecture to run computations of the MMU rather than the CPU: https://g=
ithub.com/jbangert/trapcc
I've tried it on the 3 most recent versions of QEMU for Windows. I'll give =
it a go with KVM and tcg and get back to you although I'm not hopeful.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1785308

Title:
  0x8 exception encountered but not handled

Status in QEMU:
  Incomplete

Bug description:
  Present in all QEMU versions.

  OS is triple page faulting and crashing rather than handling the
  expected double page fault properly. The same OS works in Bochs so I
  know its not the problem.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1785308/+subscriptions
