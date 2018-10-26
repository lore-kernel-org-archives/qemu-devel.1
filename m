Received: from eggs.gnu.org ([2001:4830:134:3::10]:57152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gFvio-0003W2-4d
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 02:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gFvij-00071N-Dr
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 02:35:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:51996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gFvih-0006td-I5
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 02:35:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gFviT-0004OC-F6
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 06:35:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6BD912E80C7
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 06:35:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Oct 2018 06:29:09 -0000
From: yueyihua <1800088@bugs.launchpad.net>
Reply-To: Bug 1800088 <1800088@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154053534939.13909.2595594313857584610.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1800088] [NEW] Assertion fail while usb camera
 redirect
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

This may happen during usb camera redirect. But if i move the camera
lens from left to right or up to down, this always happen. My qemu-
version is 2.10.0 and following is the error information:

2018-10-26T03:37:54.925231Z qemu-kvm: usbredirparser: error unexpected extr=
a data ep 00
qemu-kvm: hw/usb/redirect.c:1313: usbredir_chardev_read: Assertion `dev->re=
ad_buf =3D=3D ((void *)0)' failed.
2018-10-26 03:37:57.120+0000: shutting down, reason=3Dcrashed

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1800088

Title:
  Assertion fail while usb camera redirect

Status in QEMU:
  New

Bug description:
  This may happen during usb camera redirect. But if i move the camera
  lens from left to right or up to down, this always happen. My qemu-
  version is 2.10.0 and following is the error information:

  2018-10-26T03:37:54.925231Z qemu-kvm: usbredirparser: error unexpected ex=
tra data ep 00
  qemu-kvm: hw/usb/redirect.c:1313: usbredir_chardev_read: Assertion `dev->=
read_buf =3D=3D ((void *)0)' failed.
  2018-10-26 03:37:57.120+0000: shutting down, reason=3Dcrashed

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1800088/+subscriptions
