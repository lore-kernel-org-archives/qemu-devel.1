Received: from eggs.gnu.org ([2001:4830:134:3::10]:47942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ddfjD-0001Yc-6q
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 12:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ddfjA-0001fL-8o
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 12:45:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:40097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ddfjA-0001eC-2F
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 12:45:32 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ddfj8-000629-2T
	for <qemu-devel@nongnu.org>; Fri, 04 Aug 2017 16:45:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D55812E80C9
	for <qemu-devel@nongnu.org>; Fri,  4 Aug 2017 16:45:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Aug 2017 16:27:54 -0000
From: Thomas Huth <1352179@bugs.launchpad.net>
Reply-To: Bug 1352179 <1352179@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140804064846.7551.44470.malonedeb@chaenomeles.canonical.com>
Message-Id: <150186407494.3590.10572757491448726771.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1352179] Re: could not open disk image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... can you still reproduce this problem with
the latest release of QEMU? how did you create the disk image?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1352179

Title:
  could not open disk image

Status in QEMU:
  Incomplete

Bug description:
  After restart the server it's show this error:

  Error starting domain: internal error process exited while connecting to =
monitor: char device redirected to /dev/pts/1
  qemu-kvm: -drive file=3D/var/lib/nova/instances/b4535ce9-54b5-4581-a906-1=
6b83bf1ba2f/disk,if=3Dnone,id=3Ddrive-virtio-disk0,format=3Dqcow2,cache=3Dn=
one: could not open disk image /var/lib/nova/instances/b4535ce9-54b5-4581-a=
906-16b83bf1ba2f/disk: No such file or directory

  the disk info show
  =C2=A0qemu-img info disk
  image: disk
  file format: qcow2
  virtual size: 100G (107374182400 bytes)
  disk size: 22G
  cluster_size: 65536
  backing file: /var/lib/nova/instances/_base/b4535ce9-54b5-4581-a906-16b83=
bf1ba2f

  but this file (backing file : /var/lib/nova/instances/_base/b4535ce9-54b5=
-4581-a906-16b83bf1ba2f) is empty.
  And all the instances can't find the disk image

  We use CentOS release 6.5 (64bit)
  kernel version : 2.6.32-431.11.2.el6.x86_64
  qemu-kvm-0.12.1.2-2.415.el6_5.10.x86_64

  virsh version
  Compiled against library: libvirt 0.10.2
  Using library: libvirt 0.10.2
  Using API: QEMU 0.10.2
  Running hypervisor: QEMU 0.12.1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1352179/+subscriptions
