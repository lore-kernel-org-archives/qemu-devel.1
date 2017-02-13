Received: from eggs.gnu.org ([2001:4830:134:3::10]:50905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdNB1-0005UD-9B
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 15:24:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdNAx-0004EX-V7
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 15:24:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:53020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cdNAx-0004EK-PR
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 15:24:43 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cdNAw-0001Gt-Jz
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 20:24:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8B6842E80CA
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 20:24:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Feb 2017 20:14:51 -0000
From: Thomas Huth <1004050@bugs.launchpad.net>
Reply-To: Bug 1004050 <1004050@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120524165154.10792.50215.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170213201451.29932.27099.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1004050] Re: qemu-system-ppc64 by default has
 non-working keyboard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

AFAIK an OHCI driver has been added to OpenBIOS in 2014, so marking this
bug as fixed now. If you still have issues with OpenBIOS, please report
them to the OpenBIOS project instead of the QEMU bug tracker, thanks!

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1004050

Title:
  qemu-system-ppc64 by default has non-working keyboard

Status in QEMU:
  Fix Released

Bug description:
  Compile qemu from git and do:

    ./ppc64-softmmu/qemu-system-ppc64

  (ie. no parameters).  It boots to an OpenBIOS prompt.  However the
  keyboard doesn't work.  After ~10 keypresses, qemu just says:

  usb-kbd: warning: key event queue full
  usb-kbd: warning: key event queue full
  usb-kbd: warning: key event queue full
  usb-kbd: warning: key event queue full

  There is no indication inside the guest that OpenBIOS is seeing
  keyboard events.

  Also there's no indication of what type of keyboard devices are
  available, nor what we should use.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1004050/+subscriptions
