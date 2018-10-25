Received: from eggs.gnu.org ([2001:4830:134:3::10]:50349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gFbzT-0007Zw-0g
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 05:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gFbzO-0008Uj-1E
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 05:31:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gFbzM-0008L8-CJ
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 05:31:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14D139E614
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 09:31:33 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 25 Oct 2018 10:52:53 +0200
Message-Id: <20181025085256.20522-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] RfC: add support for deprecated devices.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, Prasad J Pandit <ppandit@redhat.com>

Works simliar to machine types, by adding a deprecation_reason field
(using the same name for easy grepping).  Also deprecate two devices:
adlib and cirrus.

This is tagged as RfC because the deprecation notice is not added to
introspecction yet.

Gerd Hoffmann (3):
  qdev: add deprecation_reason to DeviceClass
  adlib: mark as insecure and deprecated.
  cirrus: mark as deprecated

 hw/audio/adlib.c            | 1 +
 hw/core/qdev.c              | 9 ++++++++-
 hw/display/cirrus_vga.c     | 2 ++
 hw/display/cirrus_vga_isa.c | 2 ++
 include/hw/qdev-core.h      | 1 +
 qdev-monitor.c              | 7 +++++++
 qemu-deprecated.texi        | 8 ++++++++
 7 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.9.3
