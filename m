Received: from eggs.gnu.org ([2001:4830:134:3::10]:34789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dE3Sq-0002cg-2t
	for qemu-devel@nongnu.org; Thu, 25 May 2017 20:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dE3Sm-0006n2-VY
	for qemu-devel@nongnu.org; Thu, 25 May 2017 20:50:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:47808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dE3Sm-0006mK-Q2
	for qemu-devel@nongnu.org; Thu, 25 May 2017 20:50:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dE3Sk-00012o-OB
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 00:50:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AE9182E80D7
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 00:50:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 May 2017 00:44:25 -0000
From: Paul Goyette <1693649@bugs.launchpad.net>
Reply-To: Bug 1693649 <1693649@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <149575946555.18286.18117412791023512529.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1693649] [NEW] x86 pause misbehaves with -cpu
 haswell
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

Using qemu-2.9.0

When booting NetBSD using '-cpu haswell -smp 4', the system fails to
initialize the additional CPUs.  It appears as though the "application
processor" enters routine x86_pause() but never returns.

x86_pause() is simply two assembler instructions: 'pause; ret;'

Replacing the routine with 'nop; nop; ret;' allows the system to
proceed, of course without the benefit of the pause instruction on spin-
loops!

Additionally, booting with '-cpu phenom -smp 4' also works, although the
system does seem confused about the type of CPU being used.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1693649

Title:
  x86 pause misbehaves with -cpu haswell

Status in QEMU:
  New

Bug description:
  Using qemu-2.9.0

  When booting NetBSD using '-cpu haswell -smp 4', the system fails to
  initialize the additional CPUs.  It appears as though the "application
  processor" enters routine x86_pause() but never returns.

  x86_pause() is simply two assembler instructions: 'pause; ret;'

  Replacing the routine with 'nop; nop; ret;' allows the system to
  proceed, of course without the benefit of the pause instruction on
  spin-loops!

  Additionally, booting with '-cpu phenom -smp 4' also works, although
  the system does seem confused about the type of CPU being used.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1693649/+subscriptions
