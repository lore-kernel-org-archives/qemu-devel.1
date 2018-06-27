Received: from eggs.gnu.org ([2001:4830:134:3::10]:56844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fYIoQ-0002UB-CI
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 18:21:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fYIoN-0002Kz-6E
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 18:21:18 -0400
Received: from indium.canonical.com ([91.189.90.7]:54268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fYIoN-0002IN-0J
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 18:21:15 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fYIoK-0002rl-76
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 22:21:12 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 331762E81E9
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 22:21:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Jun 2018 22:14:44 -0000
From: Daniel Berrange <1778966@bugs.launchpad.net>
Reply-To: Bug 1778966 <1778966@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153012207304.7182.2374266143525192096.malonedeb@soybean.canonical.com>
Message-Id: <153013768417.29876.14363594690735983243.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1778966] Re: Windows 1803 and later crashes on KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This sounds like the same problem we're investigating in Fedora/RHEL
land affecting guests with EPYC CPU, or host-passthrough from an EPYC
family 17h host.  Workaround should be to use "-cpu Opteron_G5" for now

https://bugzilla.redhat.com/show_bug.cgi?id=3D1592276
https://bugzilla.redhat.com/show_bug.cgi?id=3D1593190

Looks like windows is tickling an undocumented MSR and we're trying to
find out what this MSR is supposed todo and thus how to handle it in
KVM/QEMU

** Bug watch added: Red Hat Bugzilla #1592276
   https://bugzilla.redhat.com/show_bug.cgi?id=3D1592276

** Bug watch added: Red Hat Bugzilla #1593190
   https://bugzilla.redhat.com/show_bug.cgi?id=3D1593190

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1778966

Title:
  Windows 1803 and later crashes on KVM

Status in QEMU:
  New

Bug description:
  For a bionic host, using the current public kvm modules, KVM is not
  capable of booting a WindowsInsider or msdn Windows 1803 Windows
  Server iso. In snstalling from an ISO from a started windows 2016
  guest results in an unbootable and unrepairable guest.

  The hardware is a threadripper 1920x with 32GB of main memory, disk
  mydigital BPX SSD and WD based 4 column RAID 5 via mdadm.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1778966/+subscriptions
