Received: from eggs.gnu.org ([2001:4830:134:3::10]:58704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cbOO4-0006L1-Nj
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 04:18:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cbOO0-0005kt-Jk
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 04:18:04 -0500
Received: from indium.canonical.com ([91.189.90.7]:42571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cbOO0-0005kX-Do
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 04:18:00 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cbONx-00040q-LP
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 09:17:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 975892E80C7
	for <qemu-devel@nongnu.org>; Wed,  8 Feb 2017 09:17:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Feb 2017 08:59:31 -0000
From: Thomas Huth <639651@bugs.launchpad.net>
Reply-To: Bug 639651 <639651@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100915151259.29737.65112.malonedeb@potassium.ubuntu.com>
Message-Id: <20170208085931.29689.16198.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 639651] Re: DRIVER_IRQL_NOT_LESS_OR_EQUAL booting
 WIndows XP with Synaptics driver installed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hmm, I'm not aware of a way to disable the PS2 mouse in QEMU yet.
Looking at your other related bug
(https://bugs.launchpad.net/qemu/+bug/813546), I think you might need to
discuss that patch on the qemu-devel mailing list.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/639651

Title:
  DRIVER_IRQL_NOT_LESS_OR_EQUAL booting WIndows XP with Synaptics driver
  installed

Status in QEMU:
  Incomplete
Status in Debian:
  New

Bug description:
  Positng the issue here since I did not get any reply on the ML.

  I was trying to update some windows XP (SP3) images in kvm.

  It worked fine several times but last time I added mass storage
  drivers to sysprep and now on the second boot after reseal (the first
  is mini-setup) I get a BSOD with message
  DRIVER_IRQL_NOT_LESS_OR_EQUAL. =


  It turns out that the error is unrelated to storage drivers. It is
  triggered by Synaptics driver installing for the PS2 mouse in kvm
  (which does not happen in VirtualBox or on real hardware).

  The image is originally created on hardware with MP acpi (not
  virtualization).

  qemu-kvm                  0.12.5+dfsg-2

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/639651/+subscriptions
