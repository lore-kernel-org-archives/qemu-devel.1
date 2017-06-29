Received: from eggs.gnu.org ([2001:4830:134:3::10]:57088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1dQXIJ-000621-6m
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1dQXII-0000cB-FS
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:07:31 -0400
Received: from mail-it0-x22b.google.com ([2607:f8b0:4001:c0b::22b]:38286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a175818323@gmail.com>)
	id 1dQXII-0000bA-9P
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:07:30 -0400
Received: by mail-it0-x22b.google.com with SMTP id k192so4921220ith.1
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 04:07:28 -0700 (PDT)
MIME-Version: 1.0
From: Bob Chen <a175818323@gmail.com>
Date: Thu, 29 Jun 2017 19:07:27 +0800
Message-ID: <CAMxP3BQvfPpAp2GZP+A995t1oozZucv1wqYdgHAreC_-Ne3A9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Questions about GPU passthrough + multiple PCIE
 switches on host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi folks,

I have 8 GPU cards needed to passthrough to 1 vm.

These cards are placed at 2 PCIE switches on host server, in case there
might be bandwidth limit within a single bus.

So what is the correct QEMU bus parameter if I want to achieve the best
performance. The QEMU's pcie.0/1 parameter could really reflect to the
actual physical device?



Thanks,
Bob
