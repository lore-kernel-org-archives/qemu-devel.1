Received: from eggs.gnu.org ([2001:4830:134:3::10]:39000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f0saZ-0006ir-TE
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 13:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f0saY-0004Yc-FX
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 13:40:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:46028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f0saY-0004XD-5S
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 13:40:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f0saX-0003Fx-9a
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 17:40:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 466A62E80C9
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 17:40:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Mar 2018 17:30:57 -0000
From: Adam Williamson <awilliam@redhat.com>
Reply-To: Bug 1759337 <1759337@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152217185720.30131.11816005457402548159.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1759337] [NEW] 'Failed to get "write" lock' error
 when trying to run a VM with disk image file on an SMB share
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

This has been reported and discussed downstream:

https://bugzilla.redhat.com/show_bug.cgi?id=3D1484130

but doesn't seem to be getting a lot of traction there.

Basically, with qemu since at least 2.10, you cannot use a disk image on
an SMB share that's mounted with protocol version 3 (I think possibly 2
or higher). This is made much more serious because kernel 4.13 upstream
made version 3 the *default* for SMB mounts, because version 1 is
insecure and should not be used.

So basically, anyone with a recent qemu and kernel cannot use disk
images stored on an SMB share. This is a major inconvenience for me
because, well, an SMB share is exactly where I store my VM disk images,
usually: I have a big NAS drive where I keep them all, only now I can't
because of this bug, and I'm manually swapping them in and out of the
very limited space I have on my system drive (SSD).

The error you get is:

qemu-system-x86_64: -drive file=3D/share/data/isos/vms/desktop_test_1.qcow2=
,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-disk0: Failed to get "write" lo=
ck
Is another process using the image?

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1759337

Title:
  'Failed to get "write" lock' error when trying to run a VM with disk
  image file on an SMB share

Status in QEMU:
  New

Bug description:
  This has been reported and discussed downstream:

  https://bugzilla.redhat.com/show_bug.cgi?id=3D1484130

  but doesn't seem to be getting a lot of traction there.

  Basically, with qemu since at least 2.10, you cannot use a disk image
  on an SMB share that's mounted with protocol version 3 (I think
  possibly 2 or higher). This is made much more serious because kernel
  4.13 upstream made version 3 the *default* for SMB mounts, because
  version 1 is insecure and should not be used.

  So basically, anyone with a recent qemu and kernel cannot use disk
  images stored on an SMB share. This is a major inconvenience for me
  because, well, an SMB share is exactly where I store my VM disk
  images, usually: I have a big NAS drive where I keep them all, only
  now I can't because of this bug, and I'm manually swapping them in and
  out of the very limited space I have on my system drive (SSD).

  The error you get is:

  qemu-system-x86_64: -drive file=3D/share/data/isos/vms/desktop_test_1.qco=
w2,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-disk0: Failed to get "write" =
lock
  Is another process using the image?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1759337/+subscriptions
