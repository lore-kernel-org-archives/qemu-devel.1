Received: from eggs.gnu.org ([2001:4830:134:3::10]:45839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eQu1K-00007M-2D
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:55:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eQu1F-0006IR-5b
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:55:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:50296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eQu1E-0006Hi-VC
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:55:41 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eQu1C-0006Xc-RK
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 11:55:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CC5962E80D5
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 11:55:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 Dec 2017 11:47:17 -0000
From: Marco A L Barbosa <malbarbo@gmail.com>
Reply-To: Bug 1738771 <1738771@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151359763741.17869.16981904276472670605.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1738771] [NEW] qemu user does not provide
 AT_SECURE auxiliary vector entry
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

When executing an android native binary using qemu in user mode, the
program fail with the message

FATAL: kernel did not supply AT_SECURE

Android uses bionic libc.The linker requires that AT_SECURE is provided
in the auxiliary vector, but qemu does not provide the entry.

The issue can be reproduced using the commands:

mkdir -p /tmp/android/system
cd /tmp/android
curl -O https://dl.google.com/android/repository/sys-img/google_apis/sysimg=
_x86-21_r15.zip
unzip sysimg_x86-21_r15.zip
mount -o loop x86/system.img system
qemu-i386 -L /tmp/android/ system/bin/ls


I've provided a patch (https://lists.gnu.org/archive/html/qemu-devel/2017-1=
0/msg03667.html) to fix the issue, but it was not reviewed yet.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1738771

Title:
  qemu user does not provide AT_SECURE auxiliary vector entry

Status in QEMU:
  New

Bug description:
  When executing an android native binary using qemu in user mode, the
  program fail with the message

  FATAL: kernel did not supply AT_SECURE

  Android uses bionic libc.The linker requires that AT_SECURE is
  provided in the auxiliary vector, but qemu does not provide the entry.

  The issue can be reproduced using the commands:

  mkdir -p /tmp/android/system
  cd /tmp/android
  curl -O https://dl.google.com/android/repository/sys-img/google_apis/sysi=
mg_x86-21_r15.zip
  unzip sysimg_x86-21_r15.zip
  mount -o loop x86/system.img system
  qemu-i386 -L /tmp/android/ system/bin/ls

  =

  I've provided a patch (https://lists.gnu.org/archive/html/qemu-devel/2017=
-10/msg03667.html) to fix the issue, but it was not reviewed yet.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1738771/+subscriptions
