Received: from eggs.gnu.org ([2001:4830:134:3::10]:49384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebqmU-0005kW-4i
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:41:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebqmQ-0004vK-5a
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:41:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ebqmP-0004ty-Vm
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:41:38 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05B0A4E4C5
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 16:41:37 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 17 Jan 2018 16:41:14 +0000
Message-Id: <20180117164118.8510-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v7 0/4] Convert hw backends to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

This is a followup to

  v1: https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02047.html
  v2: https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02471.html
  v3: https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02517.html
  v4: https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02708.html
  v5: https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg02950.html
  v6: https://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg01995.html

This new series contains just the patches for converting the hardware
backends to use keycodemapdb.

The main benefit is adding various missing key mappings that were previously
accidentally left out

Changed in v7:

  - Drop Xen patch as equiv already merged
  - Add patch to fix keycodemap ordering in source

Daniel P. Berrange (4):
  hw: convert ps2 device to keycodemapdb
  hw: convert the escc device to keycodemapdb
  ui: fix alphabetical ordering of keymaps
  hw: convert virtio-input-hid device to keycodemapdb

 Makefile                    |   6 +-
 hw/char/escc.c              | 126 +-------------
 hw/input/ps2.c              | 406 +-------------------------------------------
 hw/input/virtio-input-hid.c | 136 +--------------
 include/ui/input.h          |  18 +-
 ui/input-keymap.c           |   6 +-
 6 files changed, 46 insertions(+), 652 deletions(-)

-- 
2.14.3
