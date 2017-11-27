Received: from eggs.gnu.org ([2001:4830:134:3::10]:59054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dennis.Chen@arm.com>) id 1eJDNN-0007XQ-2g
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 01:58:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Dennis.Chen@arm.com>) id 1eJDNI-0006vv-47
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 01:58:45 -0500
Received: from mail-db5eur01on0057.outbound.protection.outlook.com
	([104.47.2.57]:31200
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Dennis.Chen@arm.com>) id 1eJDNH-0006t8-Ix
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 01:58:40 -0500
Date: Mon, 27 Nov 2017 14:58:29 +0800
From: Dennis Chen <dennis.chen@arm.com>
Message-ID: <20171127065828.GA23555@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Subject: [Qemu-devel] Question about RNG virtio device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dennis.chen@arm.com, nd@arm.com

Hello QEMU developers,

We all know that there is a virtio-rng device can be para-virtualised from
the host to guest in case of a real RNG HW exists in the host, my question
is:
Can we get some performance gain to use the 'virtio-rng' device if there isn't
a real RNG HW in host, in this case, what's the default back-end of the virtio
-rng device?
For my scenario, I don't want to use a virtio-rng device if the host doesn't have
a RNG HW, because the guest will get a fake RNG HW with virtio-rng device (/sys/
devices/virtual/misc/hw_random/rng_current), which is not expected. But if 
virtio-rng is not used, I don't know how the guest get the entropy from the host,
the most concern is performance. IOW, what's the difference between virtio-rng used
and not if there isn't a RNG HW in host?

Thanks!
