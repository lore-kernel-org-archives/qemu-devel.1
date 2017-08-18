Received: from eggs.gnu.org ([2001:4830:134:3::10]:32889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1diiS7-0004Tp-KP
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1diiS4-0001dN-HQ
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:40:47 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:38076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s.priebe@profihost.ag>)
	id 1diiS4-0001cQ-6Q
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:40:44 -0400
From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <7c9b2e44-ad64-99e0-cff6-87c669618b00@profihost.ag>
Date: Fri, 18 Aug 2017 16:40:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] virtio: network: lost tcp/ip packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Hello,

i've a problem with two VMs running on the SAME host machine using qemu
2.7.1 or 2.9.0 and vhost_net + virtio.

Sometimes TCP packets going from machine a to machine b are simply lost.
I see them in VM A using tcpdump going out but they never come in on
machine B. Both machines have iptables and stuff turned off.

On the host both VMs network interfaces are connected to the same bridge.

Any ideas? May be a known bug?

Host and Guest Kernel is an OpenSuSE 42.3 kernel based on vanilla 4.4.82.

Thanks!

Greets,
Stefan
