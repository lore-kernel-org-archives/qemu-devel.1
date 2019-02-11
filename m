Received: from eggs.gnu.org ([209.51.188.92]:59043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>) id 1gtBpM-0000Xd-SB
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:40:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>) id 1gtBpK-0007l3-34
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:40:51 -0500
Received: from forwardcorp1g.cmail.yandex.net ([2a02:6b8:0:1465::fd]:46586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <antonkuchin@yandex-team.ru>)
	id 1gtBpJ-0007it-RQ
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:40:50 -0500
From: Anton Kuchin <antonkuchin@yandex-team.ru>
Message-ID: <e6c30bdd-6cd0-ee9b-9fdf-cc8eaa54f7cc@yandex-team.ru>
Date: Mon, 11 Feb 2019 16:40:44 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [Qemu-devel] Is IOThread for virtio-net a good idea?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, mst@redhat.com

As far as I can see currently IOThread offloading is used only for block 
devices and all others are emulated by main thread.

I expect that network devices can also benefit from processing in 
separate thread but I couldn't find any recent work in this direction. 
I'm going to implement a PoC but I want to ask if you know any previous 
attempts and do you know why it can be a total waste of time. Are there 
fundamental obstacles that prevent network emulation handling in IOThread?
