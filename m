Received: from eggs.gnu.org ([2001:4830:134:3::10]:43836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1djt2R-0000MD-0f
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 16:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1djt2N-0000sL-Sc
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 16:11:06 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:27942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s.priebe@profihost.ag>)
	id 1djt2N-0000jS-Jr
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 16:11:03 -0400
From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
References: <7c9b2e44-ad64-99e0-cff6-87c669618b00@profihost.ag>
Message-ID: <971cf2f8-3408-dc42-f0cb-0f2df42f8a8c@profihost.ag>
Date: Mon, 21 Aug 2017 22:10:54 +0200
MIME-Version: 1.0
In-Reply-To: <7c9b2e44-ad64-99e0-cff6-87c669618b00@profihost.ag>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] virtio: network: lost tcp/ip packets
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

does nobody have an idea?

Greets,
Stefam

Am 18.08.2017 um 16:40 schrieb Stefan Priebe - Profihost AG:
> Hello,
> 
> i've a problem with two VMs running on the SAME host machine using qemu
> 2.7.1 or 2.9.0 and vhost_net + virtio.
> 
> Sometimes TCP packets going from machine a to machine b are simply lost.
> I see them in VM A using tcpdump going out but they never come in on
> machine B. Both machines have iptables and stuff turned off.
> 
> On the host both VMs network interfaces are connected to the same bridge.
> 
> Any ideas? May be a known bug?
> 
> Host and Guest Kernel is an OpenSuSE 42.3 kernel based on vanilla 4.4.82.
> 
> Thanks!
> 
> Greets,
> Stefan
> 
