Received: from eggs.gnu.org ([2001:4830:134:3::10]:48700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eQsrQ-00033t-Ma
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:41:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eQsrL-0002An-M7
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:41:28 -0500
Received: from 16.mo1.mail-out.ovh.net ([178.33.104.224]:57303)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eQsrL-00025o-FM
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:41:23 -0500
Received: from player691.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 4FB82B26DD
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 11:41:19 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 18 Dec 2017 11:41:08 +0100
Message-ID: <151359366858.6820.6567549632253797169.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 0/2] 9pfs: Correctly handle cancelled
 requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Stefano Stabellini <sstabellini@kernel.org>, keno@juliacomputing.com

Hi,

As discussed during the v2 review [*], this series changes the transport
API so that it is now possible to discard a reply to the guest, and adapts
Keno's patch accordingly.

[*] https://patchwork.kernel.org/patch/10091517/

--
Greg

---

Greg Kurz (1):
      9pfs: allow PDU to complete without sending a reply

Keno Fischer (1):
      9pfs: Correctly handle cancelled requests


 hw/9pfs/9p.c               |   27 ++++++++++++++++++++++-----
 hw/9pfs/9p.h               |    2 +-
 hw/9pfs/trace-events       |    1 +
 hw/9pfs/virtio-9p-device.c |   11 +++++++----
 hw/9pfs/xen-9p-backend.c   |   14 ++++++++------
 5 files changed, 39 insertions(+), 16 deletions(-)
