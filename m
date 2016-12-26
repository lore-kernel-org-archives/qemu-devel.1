Received: from eggs.gnu.org ([2001:4830:134:3::10]:42360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cLN0h-0008MK-5O
	for qemu-devel@nongnu.org; Sun, 25 Dec 2016 23:35:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cLN0e-0006BT-2d
	for qemu-devel@nongnu.org; Sun, 25 Dec 2016 23:35:43 -0500
Received: from indium.canonical.com ([91.189.90.7]:52049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cLN0d-0006Ak-Qi
	for qemu-devel@nongnu.org; Sun, 25 Dec 2016 23:35:39 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cLN0b-00006H-BM
	for <qemu-devel@nongnu.org>; Mon, 26 Dec 2016 04:35:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 37CB12E80CB
	for <qemu-devel@nongnu.org>; Mon, 26 Dec 2016 04:35:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Dec 2016 04:17:21 -0000
From: Launchpad Bug Tracker <710234@bugs.launchpad.net>
Reply-To: Bug 710234 <710234@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110130163813.31693.20879.malonedeb@wampee.canonical.com>
Message-Id: <20161226041721.31686.952.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 710234] Re: Qemu segfaults at start regardles if
 i suply an image or not
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
https://bugs.launchpad.net/bugs/710234

Title:
  Qemu segfaults at start regardles if i suply an image or not

Status in QEMU:
  Expired

Bug description:
  I have tried both with latest development (git clone
  git://git.qemu.org/qemu.git ran around 12:00 2011-01-30) and with
  qemu-0.13.0. Since i have not written c-code in the last years, and
  never really ran a debugger under Linux this will bug report will be a
  bit sketchy.

  When starting qemu, either just qemu or with an image it segfaults.
  The Qemu window flashes by and then i get the segfault message (qemu
  -nographic still segfaults so i guess it is not really graphics
  related).   When starting qemu with a garbled command line it returns
  an error and exits normally how ever.

  uname -a
  Linux LIX 2.6.33.4-smp #2 SMP Wed May 12 22:47:36 CDT 2010 i686 AMD Pheno=
m(tm) II X4 810 Processor AuthenticAMD GNU/Linux

  I have tried recompiling with --disable-kvm since i run a 32 bit OS on
  a 64 bit CPU, but to no avail.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/710234/+subscriptions
