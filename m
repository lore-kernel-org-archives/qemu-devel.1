Received: from eggs.gnu.org ([2001:4830:134:3::10]:39622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fbR9A-0002Bo-0w
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fbR96-0001tH-5z
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:51:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:48966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fbR95-0001rs-Uq
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:51:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fbR92-0007qA-LG
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 13:51:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 12F0D2E81D3
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 13:51:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Jul 2018 13:38:45 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1738771 <1738771@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151359763741.17869.16981904276472670605.malonedeb@soybean.canonical.com>
Message-Id: <153088432560.30182.6743537825495070325.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1738771] Re: qemu user does not provide AT_SECURE
 auxiliary vector entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

A patch to add AT_SECURE went in and was released in QEMU 2.12.


** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1738771

Title:
  qemu user does not provide AT_SECURE auxiliary vector entry

Status in QEMU:
  Fix Released

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
