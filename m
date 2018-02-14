Received: from eggs.gnu.org ([2001:4830:134:3::10]:53551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rwhite@pobox.com>) id 1elqlB-00005n-Up
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 01:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rwhite@pobox.com>) id 1elql8-0005LG-TQ
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 01:41:42 -0500
Received: from resqmta-po-06v.sys.comcast.net
	([2001:558:fe16:19:96:114:154:165]:36042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rwhite@pobox.com>) id 1elql8-0005Jr-Gq
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 01:41:38 -0500
From: Robert White <rwhite@pobox.com>
Message-ID: <2cb899c7-a4eb-0e5e-735c-8e15cd410231@pobox.com>
Date: Wed, 14 Feb 2018 06:41:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] bus= and host= documentation missing virtio-net-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I need to hook up a net device via virtio-net-pci such as 03:10.1 and
there is documentation for addr=10.1 but there is no information on how
to provide the 03 part. There's clearly a bus= item but nothing seems to
work.

I've tried bus=3 bus=03 bus=pcie.3 and a good number of other things.

The sub argument has been accepted but it can't find whatever I said.
