Received: from eggs.gnu.org ([2001:4830:134:3::10]:40170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gD13G-00012M-Ac
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 01:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gD13C-00021i-By
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 01:40:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:40730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gD13A-0001uL-Ik
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 01:40:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gD138-000151-AT
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 05:40:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4C95A2E80C7
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 05:40:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Oct 2018 05:31:14 -0000
From: Thomas Huth <1798434@bugs.launchpad.net>
Reply-To: Bug 1798434 <1798434@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153980046834.15506.5857548093711799323.malonedeb@gac.canonical.com>
Message-Id: <153984067458.15792.17465627827895757998.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1798434] Re: [Feature Request] Automatic device
 configuration discovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Right, and since QEMU also only supports a limited set of devices, there
is no chance that you can mirror an arbitrary host this way. But if you
want to convert a host into a VM and do not care whether each and every
detail can be mirrored, have a look at http://libguestfs.org/virt-
p2v.1.html - that's likely the best solution so far.

** Changed in: qemu
       Status: New =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1798434

Title:
  [Feature Request] Automatic device configuration discovery

Status in QEMU:
  Won't Fix

Bug description:
  Would it be possible to have a script that enumerates the device tree
  of a Linux host and generates a qemu command line that would recreate
  it under emulation? The user would have to customize the arguments
  (for instance to point to disk image files), but it would take a lot
  of the guesswork out.

  Similarly, there could be information that can be gleaned from the
  kernel build config that would help with configuration.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1798434/+subscriptions
