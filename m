Received: from eggs.gnu.org ([2001:4830:134:3::10]:53475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1clu6M-0005kt-4M
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 04:11:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1clu6I-0003Be-Ot
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 04:11:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1clu6I-0003BR-Ht
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 04:11:10 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BF290C067C1A
	for <qemu-devel@nongnu.org>; Thu,  9 Mar 2017 09:11:10 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  9 Mar 2017 10:11:00 +0100
Message-Id: <1489050661-17989-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1489050661-17989-1-git-send-email-kraxel@redhat.com>
References: <1489050661-17989-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] ohci: relax link check
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

The strict td link limit added by commit "95ed569 usb: ohci: limit the
number of link eds" causes problems with macos guests.  Lets raise the
limit.

Reported-by: Programmingkid <programmingkidx@gmail.com>
Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: John Arbuckle <programmingkidx@gmail.com>
Message-id: 1488876018-31576-1-git-send-email-kraxel@redhat.com
---
 hw/usb/hcd-ohci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index fe8406a..3ada35e 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -42,7 +42,7 @@
 
 #define OHCI_MAX_PORTS 15
 
-#define ED_LINK_LIMIT 4
+#define ED_LINK_LIMIT 32
 
 static int64_t usb_frame_time;
 static int64_t usb_bit_time;
-- 
1.8.3.1
