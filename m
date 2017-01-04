Received: from eggs.gnu.org ([2001:4830:134:3::10]:33722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cOdDy-0004S1-6D
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cOdDw-0004tL-Dm
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:30:54 -0500
Received: from indium.canonical.com ([91.189.90.7]:60587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cOdDw-0004sD-7q
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:30:52 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cOdDu-0002S0-Kt
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 04:30:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1AA7B2E80D2
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 04:30:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Jan 2017 04:17:40 -0000
From: Launchpad Bug Tracker <612297@bugs.launchpad.net>
Reply-To: Bug 612297 <612297@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100801164711.20463.98993.malonedeb@soybean.canonical.com>
Message-Id: <20170104041741.27545.3997.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 612297] Re: qemu-kvm fails to detect mouse while
 Windows 95 setup
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
https://bugs.launchpad.net/bugs/612297

Title:
  qemu-kvm fails to detect mouse while Windows 95 setup

Status in QEMU:
  Expired

Bug description:
  CPU: AMD Phenom II X4 945
  KVM-Version: qemu-kvm-0.12.4+dfsg (Debian package)
  Kernel: linux-2.6.26.8-rt16
  arch: x86_64
  Guest: Windows 95 B

  I'm trying to install Windows 95 B on qemu-kvm with this options:

  kvm /var/mmn/vm/Win95/Win95.img -name "Windows 95" -M pc-0.12 -m 512M
  -rtc base=3Dlocaltime -k de -soundhw sb16 -vga cirrus -net
  user,hostname=3Dw95vm -net nic,model=3Dne2k_pci -boot a -fda
  /var/mmn/vm/floppy/win95B_Drive-D-boot.img -cdrom
  /var/mmn/vm/CD/win95-setup.iso -no-acpi -no-kvm -usb

  I've also tried some other option, but always the same: no ps/2 mouse
  detection. And usb mouse is not supported by Windows 95 B while setup
  process. This is only possible later by installing the extension
  usbsupp.exe after the system setup.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/612297/+subscriptions
