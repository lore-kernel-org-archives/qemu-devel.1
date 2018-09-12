Received: from eggs.gnu.org ([2001:4830:134:3::10]:43882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <claudio.fontana@gliwa.com>) id 1g00D7-00049o-JI
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:09:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <claudio.fontana@gliwa.com>) id 1g005i-0007sO-CY
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:01:48 -0400
Received: from s30320.gliwa.com ([148.251.52.238]:37102 helo=mail.gliwa.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <claudio.fontana@gliwa.com>)
	id 1g005i-0007qY-5z
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:01:38 -0400
From: Claudio <claudio.fontana@gliwa.com>
Message-ID: <905c68e0-531a-d915-4033-474bda42a643@gliwa.com>
Date: Wed, 12 Sep 2018 10:01:34 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] virtio-net sporadic error with QNX 7.0 guest:
 virtio-net ctrl missing headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org

Hello Michael, Jason and all,

I am currently using latest mainline QEMU on x86_64 to run a QNX 7 guest.

QNX 7 is not free software anymore unfortunately, with the
the last open source versions in the 6.x range.

I am using the official virtio-net guest driver from QNX 7.

During initialization I sporadically get this error message:

$ qemu-system-x86_64 -machine pc,accel=kvm,kernel_irqchip=on -smp 2 -m 2048 -display none -nodefconfig -nodefaults -chardev stdio,mux=on,id=char0 -serial chardev:char0 -monitor none -mon chardev=char0,mode=readline -netdev user,id=user0,hostfwd=udp::9004-:9004 -device virtio-net,netdev=user0 qnx.img

virtio-net ctrl missing headers

and following that my host->guest UDP port forwarding does not work, that is,
the qemu process shows up as listening on the interface, but no packets appear in the guest.

This error during initialization does not appear every time I launch QEMU.
It appears to be more or less random.

Whenever the error does not appear, the interface works as expected, and port forwarding works.

Latest commit is 

19b599f7664b ("Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-08-27-v2'")

Thanks a lot for any advice!

Ciao,

Claudio
