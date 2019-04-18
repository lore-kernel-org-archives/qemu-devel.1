Received: from eggs.gnu.org ([209.51.188.92]:45757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGzrb-0005pv-3j
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 01:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGzrZ-0002cl-UW
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 01:45:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:58050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hGzrZ-0002bM-JT
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 01:45:33 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hGzrX-0004MM-QB
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 05:45:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C05932E80C8
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 05:45:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Apr 2019 05:35:23 -0000
From: Thomas Huth <639651@bugs.launchpad.net>
Reply-To: Bug 639651 <639651@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100915151259.29737.65112.malonedeb@potassium.ubuntu.com>
Message-Id: <155556572518.14092.6096361737110370770.launchpad@wampee.canonical.com>
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

** Changed in: qemu (Debian)
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/639651

Title:
  DRIVER_IRQL_NOT_LESS_OR_EQUAL booting WIndows XP with Synaptics driver
  installed

Status in QEMU:
  Incomplete
Status in qemu package in Debian:
  Incomplete

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
