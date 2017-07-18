Received: from eggs.gnu.org ([2001:4830:134:3::10]:35864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dXVz9-0004xh-U4
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:08:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dXVz4-00026Y-DS
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:08:35 -0400
Received: from ivanoab5.miniserver.com ([78.31.111.25]:42360
	helo=www.kot-begemot.co.uk)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1dXVz4-000260-7Q
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:08:30 -0400
From: anton.ivanov@cambridgegreys.com
Date: Tue, 18 Jul 2017 18:08:16 +0100
Message-Id: <20170718170819.28494-1-anton.ivanov@cambridgegreys.com>
Subject: [Qemu-devel] Unified Socket Driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com

Hi Jason, hi list,

Following is the unified socket transport patch split into parts
to make it more digestible.

Part 1 is a rewrite of the L2TPv3 driver to isolate the common
portions. 

The remaining 2 patches are additional transports 

In all cases the transports are switchless - they allow to connect
VM to a host, VM or a remote network device without involving any
switches in-between. They can be used with a switch too.

My longer term goal is to try to map RX and TX to either virtio
or some other mechanism which allows me to grab a multi-packet
event on TX so I can implement sendmmsg. I will try that in a
future patch.

It should be possible to migrate the UDP half of the existing
socket driver to this infrastructure. Unfortunately, it does
not apply to TCP, so only half of the driver can be migrated.

A.
