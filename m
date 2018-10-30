Received: from eggs.gnu.org ([2001:4830:134:3::10]:33465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gHPJa-0001fr-Po
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 04:23:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gHPJW-0001DO-5b
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 04:23:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gHPJV-00018X-E2
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 04:23:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E95A8830F
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 08:23:43 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 30 Oct 2018 09:23:40 +0100
Message-Id: <20181030082340.17170-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] fmops: fix off-by-one in AR_TABLE and DR_TABLE
 array size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, P J P <ppandit@redhat.com>

Fixes: CVE-2018-???
Cc: P J P <ppandit@redhat.com>
Reported-by: Wangjunqing <wangjunqing@huawei.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/fmopl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index e7e578a48e..7199afaa3c 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -72,8 +72,8 @@ typedef struct fm_opl_f {
 	/* Rhythm sention */
 	uint8_t rhythm;		/* Rhythm mode , key flag */
 	/* time tables */
-	int32_t AR_TABLE[75];	/* atttack rate tables */
-	int32_t DR_TABLE[75];	/* decay rate tables   */
+	int32_t AR_TABLE[76];	/* atttack rate tables */
+	int32_t DR_TABLE[76];	/* decay rate tables   */
 	uint32_t FN_TABLE[1024];  /* fnumber -> increment counter */
 	/* LFO */
 	int32_t *ams_table;
-- 
2.9.3
