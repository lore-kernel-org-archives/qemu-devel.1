Received: from eggs.gnu.org ([2001:4830:134:3::10]:42189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa0Ef-0008Nk-1q
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa0Ec-00083M-1h
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:55:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fa0Eb-00082L-9n
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:55:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 36841BDC1
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 14:55:20 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  2 Jul 2018 16:55:12 +0200
Message-Id: <20180702145513.11481-2-kraxel@redhat.com>
In-Reply-To: <20180702145513.11481-1-kraxel@redhat.com>
References: <20180702145513.11481-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] audio/hda: fix CID 1393631
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/hda-codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 9f630fa37f..2b58c3505b 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -189,7 +189,7 @@ struct HDAAudioState {
 
 static inline int64_t hda_bytes_per_second(HDAAudioStream *st)
 {
-    return 2 * st->as.nchannels * st->as.freq;
+    return 2LL * st->as.nchannels * st->as.freq;
 }
 
 static inline void hda_timer_sync_adjust(HDAAudioStream *st, int64_t target_pos)
-- 
2.9.3
