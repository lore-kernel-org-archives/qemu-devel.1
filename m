Received: from eggs.gnu.org ([2001:4830:134:3::10]:34204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fEV66-0004TE-AM
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fEV63-0007L8-5v
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:25:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:58604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fEV62-0007J3-Vg
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:25:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fEV61-00015M-Ho
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 07:25:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 826CA2E80C7
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 07:25:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 May 2018 07:15:23 -0000
From: Jakub Jermar <1769067@bugs.launchpad.net>
Reply-To: Bug 1769067 <1769067@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152541812417.6750.13037728534674633876.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1769067] [NEW] virtio-net ignores the absence of
 the VIRTIO_NET_F_CTRL_VQ feature bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

When negotiating virtio-net feature bits, the device ignores the absence
of the VIRTIO_NET_F_CTRL_VQ bit in driver feature bits and provides
three virtqueues, including the control virtqueue, even though the
driver is expecting only the receive and transmit virtqueues. Looking
into the source code, it appears it always assumes the presence of the
control virtqueue, violating thus the VIRTIO version 1.0 specification.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: virtio virtio-net

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1769067

Title:
  virtio-net ignores the absence of the VIRTIO_NET_F_CTRL_VQ feature bit

Status in QEMU:
  New

Bug description:
  When negotiating virtio-net feature bits, the device ignores the
  absence of the VIRTIO_NET_F_CTRL_VQ bit in driver feature bits and
  provides three virtqueues, including the control virtqueue, even
  though the driver is expecting only the receive and transmit
  virtqueues. Looking into the source code, it appears it always assumes
  the presence of the control virtqueue, violating thus the VIRTIO
  version 1.0 specification.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1769067/+subscriptions
