Received: from eggs.gnu.org ([2001:4830:134:3::10]:41656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dL7ka-0002C5-4x
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:50:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dL7kZ-0005Sr-Ba
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:50:20 -0400
MIME-Version: 1.0
From: Sam <batmanustc@gmail.com>
Date: Wed, 14 Jun 2017 20:50:17 +0800
Message-ID: <CAOE=1Z2LPTNOekrzN2HhekmT8BZDunxf18nOS-6=1oAzPWeR-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] how qemu waste such long time?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-discuss@nongnu.org

Hi all,

I'm running `QEMU_CMD ...` to create a vm. And I enable all events.

For qemu and ovs-dpdk(ovs-2.4.9 with dpdk-2.2.0) environment, when I add
'-chardev
socket,id=char-n-ddc979cd,path=/usr/local/var/run/openvswitch/n-ddc979cd,server'
option, I got a very long time to start vm, detail log is:

30012@1497443246.678304:object_dynamic_cast_assert
> qemu:memory-region->qemu:memory-region (/home/hu
> anghuai/cloud/contrib/qemu-2.6.0/memory.c:1076:memory_region_initfn)
> 30012@1497443256.274866:object_dynamic_cast_assert
> qio-channel-socket->qio-channel-socket (io/chann
> el-socket.c:389:qio_channel_socket_init)


I don't know what's qemu doing in this 10 second, does anyone know this?

Thank you~
