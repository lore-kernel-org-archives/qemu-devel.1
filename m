Received: from eggs.gnu.org ([2001:4830:134:3::10]:58663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fQUU7-0002PB-QV
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 05:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fQUU3-00028a-QU
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 05:12:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:54642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fQUU3-00027q-Hr
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 05:11:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fQUU1-0002s2-J4
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 09:11:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8CD3B2E8031
	for <qemu-devel@nongnu.org>; Wed,  6 Jun 2018 09:11:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Jun 2018 08:56:17 -0000
From: Thomas Huth <1155677@bugs.launchpad.net>
Reply-To: Bug 1155677 <1155677@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130315161014.18447.2377.malonedeb@gac.canonical.com>
Message-Id: <152827537860.24511.15361239217575166385.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1155677] Re: snapshot=on fails with non
 file-based storage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Incomplete =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1155677

Title:
  snapshot=3Don fails with non file-based storage

Status in QEMU:
  Won't Fix

Bug description:
  The snapshot=3Don option doesn't work with an nbd block device:

  /usr/bin/qemu-system-x86_64 \
  [...]
      -device virtio-scsi-pci,id=3Dscsi \
      -drive file=3Dnbd:localhost:61930,snapshot=3Don,format=3Draw,id=3Dhd0=
,if=3Dnone \
      -device scsi-hd,drive=3Dhd0 \
  [...]

  gives the error:

  qemu-system-x86_64: -drive
  file=3Dnbd:localhost:61930,snapshot=3Don,format=3Draw,id=3Dhd0,if=3Dnone:=
 could
  not open disk image nbd:localhost:61930: No such file or directory

  If you remove the snapshot=3Don flag, it works (although that of course
  means that the block device is writable which we don't want).

  Previously reported here:

    http://permalink.gmane.org/gmane.comp.emulators.qemu/148390

  and I can confirm this still happens in qemu 1.4.0.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1155677/+subscriptions
