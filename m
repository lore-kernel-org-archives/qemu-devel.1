Received: from eggs.gnu.org ([2001:4830:134:3::10]:47845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1cEbW4-0005GF-0t
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 07:40:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1cEbW0-0000T1-Bt
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 07:40:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fziglio@redhat.com>) id 1cEbW0-0000Sl-66
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 07:40:04 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5EB1C4DD6F
	for <qemu-devel@nongnu.org>; Wed,  7 Dec 2016 12:40:03 +0000 (UTC)
From: Frediano Ziglio <fziglio@redhat.com>
Date: Wed,  7 Dec 2016 12:39:59 +0000
Message-Id: <20161207123959.4565-1-fziglio@redhat.com>
Subject: [Qemu-devel] [PATCH] usb: Fix typo in documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Frediano Ziglio <fziglio@redhat.com>

Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
---
 docs/usb-storage.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/usb-storage.txt b/docs/usb-storage.txt
index fbc1f2e..551af6f 100644
--- a/docs/usb-storage.txt
+++ b/docs/usb-storage.txt
@@ -34,7 +34,7 @@ with tree logical units:
 Number three emulates the classic bulk-only transport protocol too.
 It's called "usb-bot".  It shares most code with "usb-storage", and
 the guest will not be able to see the difference.  The qemu command
-line interface is simliar to usb-uas though, i.e. no automatic scsi
+line interface is similar to usb-uas though, i.e. no automatic scsi
 disk creation.  It also features support for up to 16 LUNs.  The LUN
 numbers must be continuous, i.e. for three devices you must use 0+1+2.
 The 0+1+5 numbering from the "usb-uas" example isn't going to work
-- 
2.9.3
