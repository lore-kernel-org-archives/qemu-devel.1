Received: from eggs.gnu.org ([2001:4830:134:3::10]:55950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fUloE-0006KF-Jm
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 00:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fUlo9-000561-6O
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 00:30:30 -0400
Received: from indium.canonical.com ([91.189.90.7]:59572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fUlo8-00054n-OM
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 00:30:24 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fUlo7-0004Uu-ST
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 04:30:23 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D44D32E80C7
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 04:30:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 Jun 2018 04:17:37 -0000
From: Launchpad Bug Tracker <1222034@bugs.launchpad.net>
Reply-To: Bug 1222034 <1222034@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130907061929.18417.73048.malonedeb@wampee.canonical.com>
Message-Id: <152929545785.23342.3880208716003635882.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1222034] Re: QEMU + SPICE + AUDIO = FAILURE
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
https://bugs.launchpad.net/bugs/1222034

Title:
  QEMU + SPICE + AUDIO =3D FAILURE

Status in QEMU:
  Expired

Bug description:
  Hello it's my first time doing this, since the major round of
  timer/block changes in August I have not been able to have audio
  working in any guest with the spice protocol.

  64 bit linux , AMD SVM, IOMMUv1  ASUS M5A99FX PRO R2.0

  Example command line:

  qemu-system-x86_64 -m 1024 -cdrom Sabayon_Linux_DAILY_x86_Xfce.iso
  -soundhw hda -vga qxl -spice port=3D5999,addr=3D0.0.0.0,disable-ticketing
  -enable-kvm -device virtio-serial-pci -device
  virtserialport,chardev=3Dspicechannel0,name=3Dcom.redhat.spice.0 -chardev
  spicevmc,id=3Dspicechannel0,name=3Dvdagent

  Any time the guest tries to access the emulated hardware it will hang
  for a very long period of time and play no audio through spice. It
  doesn't seem to matter what guest (x86_64 or x86) I run (the above is
  just one example) and it also doesn't matter what sound hardware I
  choose to emulate or which command line method I use to specify it (ie
  -soundhw doesn't work and neither does -device) or whether a vdagent
  service has been configured correctly inside the guest or not.

  This issue does not happen with the 1.6.0 release.

  If you are unable to replicate this I will go to the trouble of
  getting the race message that happens in the guest but I am assuming
  at this point that my configuration is not exotic and it should be
  very easy to see the issue.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1222034/+subscriptions
