Received: from eggs.gnu.org ([2001:4830:134:3::10]:41353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ej1uW-0004hR-Q4
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:59:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ej1uT-0000jW-Nn
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:59:40 -0500
Received: from indium.canonical.com ([91.189.90.7]:58054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ej1uT-0000hV-Hv
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:59:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ej1uS-0004oE-8v
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 11:59:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2E2B82E80C8
	for <qemu-devel@nongnu.org>; Tue,  6 Feb 2018 11:59:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Feb 2018 11:49:36 -0000
From: Richard Jones <rjones@redhat.com>
Reply-To: Bug 1155677 <1155677@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130315161014.18447.2377.malonedeb@gac.canonical.com>
Message-Id: <151791777668.29609.3474074671339919870.malone@chaenomeles.canonical.com>
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

Let's close this.  libguestfs doesn't use snapshot=3Don any longer.

** Changed in: qemu
       Status: In Progress =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1155677

Title:
  snapshot=3Don fails with non file-based storage

Status in QEMU:
  Incomplete

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
