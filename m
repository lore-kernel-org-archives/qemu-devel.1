Received: from eggs.gnu.org ([2001:4830:134:3::10]:44484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fSxQb-0005pv-3U
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 00:30:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fSxQa-0003d9-AP
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 00:30:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:55968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fSxQZ-0003cI-Uh
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 00:30:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fSxQZ-0001sQ-2T
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 04:30:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 11D362E8031
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 04:30:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Jun 2018 04:17:32 -0000
From: Launchpad Bug Tracker <1013241@bugs.launchpad.net>
Reply-To: Bug 1013241 <1013241@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120614155150.12135.95018.malonedeb@gac.canonical.com>
Message-Id: <152886345267.16396.12811704404432428212.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1013241] Re: qemu-system-ppc64 hanging
 occasionally in disk writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1013241

Title:
  qemu-system-ppc64 hanging occasionally in disk writes

Status in QEMU:
  Expired

Bug description:
  I found last week that qemu-system-ppc64 (from git) hangs occasionally   =
       =

  under load, and I have a reproducer for it now.  Unfortunately the       =
       =

  reproducer really takes a long time to run -- usually I can get a hang   =
       =

  in under 12 hours.                                                       =
       =

                                                                           =
       =

  Here is the reproducer case:                                             =
       =

                                                                           =
       =

    https://lists.fedoraproject.org/pipermail/ppc/2012-June/001698.html    =
       =

                                                                           =
       =

  Notes:                                                                   =
       =

                                                                           =
       =

  (1) Verified by one other person (other than me).  Happens on both       =
       =

      ppc64 and x86-64 host.                                               =
       =

                                                                           =
       =

  (2) Happens with both Fedora guest kernel 3.3.4-5.fc17.ppc64 and kernel  =
       =

      3.5.0 that I compiled myself.  The test case above contains 3.3.4-5. =
       =

                                                                           =
       =

  (3) Seems to be a problem in qemu, not the guest.  The reason I think    =
       =

      this is because I tried to capture a backtrace of the hang using     =
       =

      remote gdb, but gdb just hung when trying to connect to qemu         =
       =

      (gdb connects fine before the bug happens).                          =
       =

                                                                           =
       =

  (4) Judging by guest messages, appears to be happening when writing      =
       =

      to the disk.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1013241/+subscriptions
