Received: from eggs.gnu.org ([2001:4830:134:3::10]:55433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <procmem@riseup.net>) id 1fKuB4-0008ML-6p
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <procmem@riseup.net>) id 1fKuB1-0006wS-3a
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:25:18 -0400
Received: from mx1.riseup.net ([198.252.153.129]:37260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <procmem@riseup.net>) id 1fKuB0-0006tu-Qu
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:25:15 -0400
From: procmem <procmem@riseup.net>
Message-ID: <40602400-cae4-e175-e7ce-10ac70ba52f5@riseup.net>
Date: Mon, 21 May 2018 23:24:43 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Virtio-net drivers immune to Nethammer?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, whonix-devel@whonix.org



Hi I'm a privacy distro maintainer investigating the implications of the
newly published nethammer attack [0] on KVM guests particularly the
virtio-net drivers. The summary of the paper is that rowhammer can be
remotely triggered by feeding susceptible* network driver crafted
traffic. This attack can do all kinds of nasty things such as modifying
SSL certs on the victim system.

* Susceptible drivers are those relying on Intel CAT, uncached memory or
the clflush instruction.

My question is, do virtio-net drivers do any of these things?

***

[0] https://arxiv.org/abs/1805.04956
