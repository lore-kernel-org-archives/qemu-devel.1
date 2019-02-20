Received: from eggs.gnu.org ([209.51.188.92]:56379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gwUm4-0006Jh-K1
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:31:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gwUm3-0000fG-Jw
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:31:08 -0500
Received: from indium.canonical.com ([91.189.90.7]:59248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gwUm3-000807-B6
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:31:07 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gwUlf-0006pt-Tz
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 16:30:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D85812E8054
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 16:30:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Feb 2019 16:24:15 -0000
From: Andrii Yaurov <1816805@bugs.launchpad.net>
Reply-To: Bug 1816805 <1816805@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <155067985595.12116.1229580080440735698.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1816805] [NEW] Cannot create cdrom device with
 open tray and cache option
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

When trying to create cdrom device with open tray and either of "cache"
or "discard" options specified, I get the following error:

qemu-system-x86_64: -drive if=3Dnone,id=3Ddrive-
ide0-0-0,readonly=3Don,cache=3Dwriteback,discard=3Dunmap,throttling.iops-
total=3D900: Must specify either driver or file

This bug essentially forbids live migration of VMs with open cdrom
trays.

I was able to find the same bug at RedHat:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1338638

The bug was encountered in versions 2.5 and 2.11.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1816805

Title:
  Cannot create cdrom device with open tray and cache option

Status in QEMU:
  New

Bug description:
  When trying to create cdrom device with open tray and either of
  "cache" or "discard" options specified, I get the following error:

  qemu-system-x86_64: -drive if=3Dnone,id=3Ddrive-
  ide0-0-0,readonly=3Don,cache=3Dwriteback,discard=3Dunmap,throttling.iops-
  total=3D900: Must specify either driver or file

  This bug essentially forbids live migration of VMs with open cdrom
  trays.

  I was able to find the same bug at RedHat:
  https://bugzilla.redhat.com/show_bug.cgi?id=3D1338638

  The bug was encountered in versions 2.5 and 2.11.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1816805/+subscriptions
