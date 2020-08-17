Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E45C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 11:02:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B08D20885
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 11:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B08D20885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=winhong.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7cud-0003Os-UA
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 07:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yili@winhong.com>)
 id 1k7ctp-0002qi-IG; Mon, 17 Aug 2020 07:01:57 -0400
Received: from regular1.263xmail.com ([211.150.70.200]:37122)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yili@winhong.com>)
 id 1k7ctj-0004Sc-2w; Mon, 17 Aug 2020 07:01:56 -0400
Received: from localhost (unknown [192.168.167.69])
 by regular1.263xmail.com (Postfix) with ESMTP id CCFFD1193;
 Mon, 17 Aug 2020 19:01:37 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from localhost.localdomain (unknown [14.18.236.70])
 by smtp.263.net (postfix) whith ESMTP id
 P32155T139859895248640S1597662090441127_; 
 Mon, 17 Aug 2020 19:01:36 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <65a94dbb6bc6e37e6e31b68c4b36d351>
X-RL-SENDER: yili@winhong.com
X-SENDER: yili@winhong.com
X-LOGIN-NAME: yili@winhong.com
X-FST-TO: qemu-block@nongnu.org
X-SENDER-IP: 14.18.236.70
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From: Yi Li <yili@winhong.com>
To: qemu-block@nongnu.org
Subject: [PATCH] qemu-img: Explicit number replaced by a constant
Date: Mon, 17 Aug 2020 19:01:13 +0800
Message-Id: <20200817110113.1552683-1-yili@winhong.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.150.70.200; envelope-from=yili@winhong.com;
 helo=regular1.263xmail.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 07:01:39
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, yilikernel@gmail.com, qemu-devel@nongnu.org,
 yili@winhong.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yi Li <yili@winhong.com>
---
 qemu-img.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 5308773811..a0fbc2757c 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1181,7 +1181,7 @@ static int64_t find_nonzero(const uint8_t *buf, int64_t n)
 }
 
 /*
- * Returns true iff the first sector pointed to by 'buf' contains at least
+ * Returns true if the first sector pointed to by 'buf' contains at least
  * a non-NUL byte.
  *
  * 'pnum' is set to the number of sectors (including and immediately following
@@ -1200,10 +1200,10 @@ static int is_allocated_sectors(const uint8_t *buf, int n, int *pnum,
         *pnum = 0;
         return 0;
     }
-    is_zero = buffer_is_zero(buf, 512);
+    is_zero = buffer_is_zero(buf, BDRV_SECTOR_SIZE);
     for(i = 1; i < n; i++) {
-        buf += 512;
-        if (is_zero != buffer_is_zero(buf, 512)) {
+        buf += BDRV_SECTOR_SIZE;
+        if (is_zero != buffer_is_zero(buf, BDRV_SECTOR_SIZE)) {
             break;
         }
     }
@@ -2489,8 +2489,8 @@ static int img_convert(int argc, char **argv)
             }
         }
 
-        qemu_opt_set_number(opts, BLOCK_OPT_SIZE, s.total_sectors * 512,
-                            &error_abort);
+        qemu_opt_set_number(opts, BLOCK_OPT_SIZE,
+                            s.total_sectors * BDRV_SECTOR_SIZE, &error_abort);
         ret = add_old_style_options(out_fmt, opts, out_baseimg, NULL);
         if (ret < 0) {
             goto out;
-- 
2.25.3




