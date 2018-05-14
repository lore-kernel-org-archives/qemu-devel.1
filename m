Received: from eggs.gnu.org ([2001:4830:134:3::10]:41676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fIIPV-0000gx-Or
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fIIPS-0008A1-KS
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:41:25 -0400
Received: from indium.canonical.com ([91.189.90.7]:35988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fIIPS-00088P-Dl
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:41:22 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fIIPQ-00052X-Lt
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 18:41:20 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A49DC2E8F39
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 18:41:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 May 2018 18:30:55 -0000
From: eric hoffman <1771042@bugs.launchpad.net>
Reply-To: Bug 1771042 <1771042@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152625681679.27592.11833589256802380892.malonedeb@wampee.canonical.com>
Message-Id: <152632265597.25344.14291192100722757126.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1771042] Re: dataplane interrupt handler doesn't
 support msi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

thanks for looking at this Stefan - since I don't have any context of
exactly the kind of environmental issues like threading, the patch
posted here isn't really a suggested fix.

it does in general seem helpful if batched interrupts have the same
delivery semantics as non-deferred.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1771042

Title:
  dataplane interrupt handler doesn't support msi

Status in QEMU:
  New

Bug description:
  hw/block/dataplane/virtio-blk.c commit
  1010cadf62332017648abee0d7a3dc7f2eef9632

  in the function notify_guest_bh, the function virtio_notify_irqfd is call=
ed
  to deliver the interrupt corresponding to the vq

  however, without the dataplane, hw/block/virtio_blk_req_complete calls
  virtio_notify to deliver the interrupt (immediately). this goes though
  a slightly more involved path that calls virtio_pci_notify which includes
  a case to handle msi interrupts.

  so, msi interrupts with block devices aren't serviced when using dataplane
  batching.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1771042/+subscriptions
