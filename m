Received: from eggs.gnu.org ([2001:4830:134:3::10]:37452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dwnsd-0007Jr-G3
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:18:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dwnsT-0006qx-Dy
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:18:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dwnsT-0006q2-0i
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:18:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA00413A5D
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 11:18:08 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 26 Sep 2017 13:17:56 +0200
Message-Id: <20170926111757.3628-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/1] qemu-firmware repo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

  Hi,

Ok, we want for varios reasons separate the firmware from the main
qemu repo.  Here is my attempt to create such a repo.  For starters
only seabios has been added here.

You can find the repo with currently three patches here:
    https://www.kraxel.org/cgit/qemu-firmware/

This "series" is only patch #2 of the repo.  Havn't found a way to
convince git-format-patch to include the initial commit of a repo.
But patch #1 (the initial commit) only adds the seabios submodule,
patch #3 adds the binary blobs, so patch #2 actually is the most
interesting one.

Comments?

cheers,
  Gerd

Gerd Hoffmann (1):
  add Makefile, add configs for seabios

 Makefile             | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 configs/seabios-128k | 12 ++++++++
 configs/seabios-256k |  3 ++
 configs/vga-cirrus   |  3 ++
 configs/vga-isavga   |  3 ++
 configs/vga-qxl      |  6 ++++
 configs/vga-stdvga   |  3 ++
 configs/vga-virtio   |  6 ++++
 configs/vga-vmware   |  6 ++++
 9 files changed, 122 insertions(+)
 create mode 100644 Makefile
 create mode 100644 configs/seabios-128k
 create mode 100644 configs/seabios-256k
 create mode 100644 configs/vga-cirrus
 create mode 100644 configs/vga-isavga
 create mode 100644 configs/vga-qxl
 create mode 100644 configs/vga-stdvga
 create mode 100644 configs/vga-virtio
 create mode 100644 configs/vga-vmware

-- 
2.9.3
