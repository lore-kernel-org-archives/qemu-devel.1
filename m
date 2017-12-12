Received: from eggs.gnu.org ([2001:4830:134:3::10]:41191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eOlGw-0002jB-41
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:11:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eOlGq-0001Im-0L
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:11:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eOlGp-0001Gu-Pr
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:10:55 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 12 Dec 2017 14:10:40 +0000
Message-Id: <20171212141044.2582-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v6 0/4] Convert hw backends to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, "Daniel P. Berrange" <berrange@redhat.com>

This is a followup to

  v1: https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02047.html
  v2: https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02471.html
  v3: https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02517.html
  v4: https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02708.html
  v5: https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg02950.html

This new series contains just the patches for converting the hardware
backends to use keycodemapdb.

The main benefit is adding various missing key mappings that were previously
accidentally left out

Daniel P. Berrange (4):
  hw: convert virtio-input-hid device to keycodemapdb
  hw: convert ps2 device to keycodemapdb
  hw: convert the escc device to keycodemapdb
  hw: convert XenInput keyboard to keycodemapdb

 Makefile                    |   5 +
 hw/char/escc.c              | 126 +-------------
 hw/display/xenfb.c          | 138 ++++-----------
 hw/input/ps2.c              | 406 +-------------------------------------------
 hw/input/virtio-input-hid.c | 136 +--------------
 include/ui/input.h          |  15 ++
 ui/input-keymap.c           |   5 +
 7 files changed, 79 insertions(+), 752 deletions(-)

-- 
2.14.3
