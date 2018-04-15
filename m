Received: from eggs.gnu.org ([2001:4830:134:3::10]:36981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f7ZJs-0004E0-8y
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 00:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f7ZJq-00034U-T1
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 00:31:16 -0400
Received: from indium.canonical.com ([91.189.90.7]:49046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f7ZJq-000341-N4
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 00:31:14 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f7ZJp-0003CV-Mz
	for <qemu-devel@nongnu.org>; Sun, 15 Apr 2018 04:31:13 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AB7B72E80C8
	for <qemu-devel@nongnu.org>; Sun, 15 Apr 2018 04:31:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Apr 2018 04:17:26 -0000
From: Launchpad Bug Tracker <1376938@bugs.launchpad.net>
Reply-To: Bug 1376938 <1376938@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141002220246.17873.3872.malonedeb@chaenomeles.canonical.com>
Message-Id: <152376584673.25258.16907227584616626158.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1376938] Re: detect-zeroes=unmap fails to discard
 in some cases
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
https://bugs.launchpad.net/bugs/1376938

Title:
  detect-zeroes=3Dunmap fails to discard in some cases

Status in QEMU:
  Expired

Bug description:
  Under certain circumstances, QEMU 2.1.2 fails to discard the
  underlaying block. The command to start QEMU is:

  qemu-system-x86_64 -machine pc,accel=3Dkvm -m 2G -smp 2 -vga std -usb
  -usbdevice tablet -drive if=3Dnone,id=3Dff,aio=3Dnative,discard=3Dunmap
  ,detect-zeroes=3Dunmap,file=3D/tmp/test.qcow2 -device virtio-scsi-pci
  -device scsi-disk,drive=3Dff -cdrom
  /media/iso/archlinux-2014.06.01-dual.iso -vnc :1

  Steps to reproduce:

   0. qemu-img create -f qcow2 /tmp/test.qcow2 4G
   1. Boot in the guest (Arch Linux x86_64 with Linux 3.14.4)
   2. cat /dev/zero > /dev/sda. Observe a file of 4109M (size measured with=
 `du -m`
   3. cat /dev/zero > /dev/sda
   4. blkdiscard /dev/sda
   5. Observe that test.qcow2 grows larger than 1M (13M in my testing).

  The results are more severe when you write other kind of data in step
  2, for instance `base64 /dev/zero > /dev/sda` and then continuing with
  step 3 and 4 will result in a file of 3642M, after blkdiscard.

  It makes not much of a difference if I create an ext4 filesystem on
  top of it and use fstrim (or rm).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1376938/+subscriptions
