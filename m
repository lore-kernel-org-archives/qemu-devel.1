Received: from eggs.gnu.org ([2001:4830:134:3::10]:53107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <procmem@riseup.net>) id 1flQm7-0003vT-86
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 23:29:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <procmem@riseup.net>) id 1flQm3-0004rX-Ai
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 23:29:11 -0400
Received: from mx1.riseup.net ([198.252.153.129]:54865)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <procmem@riseup.net>) id 1flQm3-0004pf-3r
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 23:29:07 -0400
From: procmem <procmem@riseup.net>
Message-ID: <afa0ad62-80f5-f90b-f9b5-660dcc3e01dc@riseup.net>
Date: Fri, 3 Aug 2018 03:28:53 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Efficacy of jitterentropy RNG on qemu-kvm Guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, whonix-devel@whonix.org

Hello. I'm a distro maintainer and was wondering about the efficacy of
entropy daemons like haveged and jitterentropyd in qemu-kvm. One of the
authors of haveged [0] pointed out if the hardware cycles counter is
emulated and deterministic, and thus predictible. He therefore does not
recommend using HAVEGE on those systems. Is this the case with KVM's
counters?

PS. I will be setting VM CPU settings to host-passthrough.

Bonus: Also if anyone knows the answer to this question about Xen please
let me know because its the other main platform we support and they
don't have the luxury of virtio-rng in PVH mode.

Thanks.

[0]
https://github.com/BetterCrypto/Applied-Crypto-Hardening/commit/cf7cef7a870c1b77089b1bd6209ded6525b5a4e0#commitcomment-23006392
