Received: from eggs.gnu.org ([2001:4830:134:3::10]:47217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuzibode@126.com>) id 1fTJEu-0007ty-OC
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 23:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuzibode@126.com>) id 1fTJEq-000671-Oc
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 23:48:00 -0400
Received: from m50-112.126.com ([123.125.50.112]:42040)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuzibode@126.com>) id 1fTJEq-000668-1A
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 23:47:56 -0400
Date: Thu, 14 Jun 2018 11:47:44 +0800
From: Bo YU <yuzibode@126.com>
Message-ID: <20180614034744.dcato6eemcrr3drq@debian.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Subject: [Qemu-devel] Error: virtio_net: Too few free TX rings available.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yuzibode@126.com

Hello,
A am newbie to qemu.
I am using qemu now:
qemu-io --version
qemu-io version 2.12.50 (v2.12.0-1296-g2ab09bf2f9-dirty)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

I have to talk about using qemu with libvirt recently libvirt deadlocked
when libvirt fetching qemu capabilities.Under Michal Privoznik help, i
restart my VM.

The reason which cause recompile  qume from version 2.8 is:
i want to modify some features:

Fowllowing the instrustions:

http://cilium.readthedocs.io/en/latest/bpf/#bpftool

$ clang -O2 -Wall -target bpf -c xdp-example.c -o xdp-example.o

I get the error:

# sudo /sbin/ip link set dev ens3 xdp obj xdp_2.o
Error: virtio_net: Too few free TX rings available.
# sudo dmesg
virtio_net virtio0 ens3: request 4 queues but max is 1


And i type: sudo ethtool -g ens3
Ring parameters for ens3:
Pre-set maximums:
RX: 256
RX Mini:0
RX Jumbo:0
TX:256
Current hardware settings:
RX:256
RX Mini:0
RX Jumbo:0
TX:256

sudo ethtool -G ens3 rx 512
Cannot set device ring parameters: Operation not supported


I have trace the mail-list:
https://bugzilla.redhat.com/show_bug.cgi?id=1301548
and there:
https://groups.google.com/forum/#!topic/snabb-devel/ng78LbcaFgII
I remeber there is a patch for qemu for modfing paramertes in
hw/virtio-net.c,sorry, i can't find the patch.

If i modify the rx_queue_max by hand to 1024, Is it ok?

Thank you in advance!
