Received: from eggs.gnu.org ([2001:4830:134:3::10]:59759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eizai-0000Xw-MC
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:31:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eizac-0007GF-JX
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:31:04 -0500
Received: from indium.canonical.com ([91.189.90.7]:55318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eizac-0007FV-CM
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:30:58 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eizaZ-0004j0-FK
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 09:30:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 991842E80DC
	for <qemu-devel@nongnu.org>; Tue,  6 Feb 2018 09:30:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Feb 2018 09:17:01 -0000
From: cee1 <fykcee1@gmail.com>
Reply-To: Bug 1746943 <1746943@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151756277928.2993.6454939775938128745.malonedeb@gac.canonical.com>
Message-Id: <151790862205.9778.17235662165735383155.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1746943] Re: qemu-aarch64-static: qemu: uncaught
 target signal 11 for ps/top cmd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I tried psproc-ng from
https://launchpad.net/ubuntu/+source/procps/2:3.3.12-1ubuntu2/+build/104528=
12

No SEGV, I guess it may be a CRASH-PATH which is triggered in this
specific scenario

I've did update in redhat bugzilla #1541252, and wait for confirming
above.

BTW, "uncaught target signal 11" makes it hard to figure out "how this
SEGV happened"

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1746943

Title:
  qemu-aarch64-static: qemu: uncaught target signal 11 for ps/top cmd

Status in QEMU:
  New

Bug description:
  In a docker container created from an aarch64 image, injects qemu-aarch64=
-static (in /usr/bin)
    run ps/top cmd  inside this container

    reports "qemu: uncaught target signal 11 (Segmentation fault)"

  Tried qemu-aarch64-static from fedora 27 / ubuntu artful / debian
  unstable (i.e. qemu version 2.10 - 2.11)

  The aarch64 dock image is fedora 27(and with qemu-aarch64-static
  Fedora 27), hence I opened a related bug here
  https://bugzilla.redhat.com/show_bug.cgi?id=3D1541252

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1746943/+subscriptions
