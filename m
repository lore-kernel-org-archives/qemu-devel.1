Received: from eggs.gnu.org ([2001:4830:134:3::10]:42586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changlimin@h3c.com>) id 1e7Gr2-0000rd-PQ
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 04:16:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changlimin@h3c.com>) id 1e7Gqy-0003MC-PP
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 04:16:00 -0400
Received: from smtp.h3c.com ([60.191.123.56]:42089 helo=h3cmg01-ex.h3c.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changlimin@h3c.com>) id 1e7Gqy-0003Ie-6a
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 04:15:56 -0400
From: Changlimin <changlimin@h3c.com>
Date: Wed, 25 Oct 2017 08:15:45 +0000
Message-ID: <BC29A004BA570342A4CC0044A3845572CFCE5592@H3CMLB12-EX.srv.huawei-3com.com>
Content-Language: zh-CN
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Block format 'raw' does not support the option
 'locking' when disable image locking with option locking=off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi,
When running Oracle RAC, one image is shared between multiple vms, so I wan=
t to disable locking with option locking=3Doff, But Block format 'raw' does=
 not support the option 'locking'.
How to disable locking?

The version is git e822e81e350825dd94f41ee2538ff1432b812eb9

The command line is
-drive file=3D/var/lib/libvirt/images/r0605-share.img,format=3Draw,if=3Dnon=
e,id=3Ddrive-virtio-disk1,cache=3Ddirectsync,aio=3Dnative,locking=3Doff \
-device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0xa,drive=3Ddrive-virt=
io-disk1,id=3Dvirtio-disk1 \

The error message is
-drive file=3D/var/lib/libvirt/images/r0605-share.img,format=3Draw,if=3Dnon=
e,id=3Ddrive-virtio-disk1,cache=3Ddirectsync,aio=3Dnative,locking=3Doff: Bl=
ock format 'raw' does not support the option 'locking'

BR
Chang Limin
