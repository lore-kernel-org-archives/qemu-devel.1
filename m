Received: from eggs.gnu.org ([2001:4830:134:3::10]:54264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cpFSC-0004s3-3U
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 10:35:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cpFS8-0001BE-5P
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 10:35:36 -0400
Received: from indium.canonical.com ([91.189.90.7]:60236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cpFS8-0001Am-0Q
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 10:35:32 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cpFS6-0006D9-VA
	for <qemu-devel@nongnu.org>; Sat, 18 Mar 2017 14:35:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EAD792E808A
	for <qemu-devel@nongnu.org>; Sat, 18 Mar 2017 14:35:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Mar 2017 14:26:56 -0000
From: l3iggs <1673976@bugs.launchpad.net>
Reply-To: Bug 1673976 <1673976@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170318142657.21676.52259.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1673976] [NEW] core dump
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

I'm running a command (locale-gen) inside of an armv7h chroot mounted on
my x86_64 desktop by putting qemu-arm-static into /usr/bin/ of the
chroot file system and I get a core dump.

locale-gen
Generating locales...
=C2=A0=C2=A0en_US.UTF-8...localedef: ../sysdeps/unix/sysv/linux/spawni.c:36=
0: __spawnix: Assertion `ec >=3D 0' failed.
qemu: uncaught target signal 6 (Aborted) - core dumped
/usr/bin/locale-gen: line 41:    34 Aborted                 (core dumped) l=
ocaledef -i $input -c -f $charset -A /usr/share/locale/locale.alias $locale

I've done this same thing successfully for years, but this breakage has
appeared some time in the last 3 or so months. Possibly with the update
to qemu version 2.8.

** Affects: qemu
     Importance: Undecided
         Status: New

** Description changed:

- I'm running a command command (locale-gen) inside of an armv7h chroot
- mounted on my x86_64 desktop by putting qemu-arm-static into /usr/bin/
- of the chroot file system and I get a core dump.
+ I'm running a command (locale-gen) inside of an armv7h chroot mounted on
+ my x86_64 desktop by putting qemu-arm-static into /usr/bin/ of the
+ chroot file system and I get a core dump.
  =

  locale-gen
  Generating locales...
-   en_US.UTF-8...localedef: ../sysdeps/unix/sysv/linux/spawni.c:360: __spa=
wnix: Assertion `ec >=3D 0' failed.
+ =C2=A0=C2=A0en_US.UTF-8...localedef: ../sysdeps/unix/sysv/linux/spawni.c:=
360: __spawnix: Assertion `ec >=3D 0' failed.
  qemu: uncaught target signal 6 (Aborted) - core dumped
  /usr/bin/locale-gen: line 41:    34 Aborted                 (core dumped)=
 localedef -i $input -c -f $charset -A /usr/share/locale/locale.alias $loca=
le
  =

  I've done this same thing successfully for years, but this breakage has
  appeared some time in the last 3 or so months. Possibly with the update
  to qemu version 2.8.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1673976

Title:
  core dump

Status in QEMU:
  New

Bug description:
  I'm running a command (locale-gen) inside of an armv7h chroot mounted
  on my x86_64 desktop by putting qemu-arm-static into /usr/bin/ of the
  chroot file system and I get a core dump.

  locale-gen
  Generating locales...
  =C2=A0=C2=A0en_US.UTF-8...localedef: ../sysdeps/unix/sysv/linux/spawni.c:=
360: __spawnix: Assertion `ec >=3D 0' failed.
  qemu: uncaught target signal 6 (Aborted) - core dumped
  /usr/bin/locale-gen: line 41:    34 Aborted                 (core dumped)=
 localedef -i $input -c -f $charset -A /usr/share/locale/locale.alias $loca=
le

  I've done this same thing successfully for years, but this breakage
  has appeared some time in the last 3 or so months. Possibly with the
  update to qemu version 2.8.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1673976/+subscriptions
