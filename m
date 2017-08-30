Received: from eggs.gnu.org ([2001:4830:134:3::10]:36980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn6cF-00078U-4S
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:17:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn6cC-00067I-0Y
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:17:23 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34615)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dn6cB-000673-Pi
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:17:19 -0400
Received: by mail-wm0-x241.google.com with SMTP id l19so2462658wmi.1
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 10:17:19 -0700 (PDT)
Date: Wed, 30 Aug 2017 18:17:17 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170830171717.GD24565@stefanha-x1.localdomain>
References: <7c9b2e44-ad64-99e0-cff6-87c669618b00@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c9b2e44-ad64-99e0-cff6-87c669618b00@profihost.ag>
Subject: Re: [Qemu-devel] virtio: network: lost tcp/ip packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Fri, Aug 18, 2017 at 04:40:36PM +0200, Stefan Priebe - Profihost AG wrote:
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

Have you tcpdumped the tap interfaces on the host?
