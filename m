Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33FEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 01:37:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9DB820882
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 01:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9DB820882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=winhong.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8D2T-0007nK-UQ
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 21:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yili@winhong.com>)
 id 1k8D1v-0007IH-Tv; Tue, 18 Aug 2020 21:36:43 -0400
Received: from regular1.263xmail.com ([211.150.70.203]:57502)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yili@winhong.com>)
 id 1k8D1s-0002VH-9d; Tue, 18 Aug 2020 21:36:43 -0400
Received: from localhost (unknown [192.168.167.16])
 by regular1.263xmail.com (Postfix) with ESMTP id 6A252776;
 Wed, 19 Aug 2020 09:36:25 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from localhost.localdomain (unknown [14.18.236.70])
 by smtp.263.net (postfix) whith ESMTP id
 P25960T140259931186944S1597800969397832_; 
 Wed, 19 Aug 2020 09:36:15 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f9c31289956436cbad4286ed5704d509>
X-RL-SENDER: yili@winhong.com
X-SENDER: yili@winhong.com
X-LOGIN-NAME: yili@winhong.com
X-FST-TO: qemu-block@nongnu.org
X-SENDER-IP: 14.18.236.70
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From: Yi Li <yili@winhong.com>
To: qemu-block@nongnu.org,
	mreitz@redhat.com,
	sgarzare@redhat.com
Subject: [PATCH v2] qemu-img: Explicit number replaced by a constant
Date: Wed, 19 Aug 2020 09:36:07 +0800
Message-Id: <20200819013607.32280-1-yili@winhong.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <0107e40a-1d96-fa3d-bd15-019c004d0353@redhat.com>
References: <0107e40a-1d96-fa3d-bd15-019c004d0353@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.150.70.203; envelope-from=yili@winhong.com;
 helo=regular1.263xmail.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 21:36:27
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 yili@winhong.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yi Li <yili@winhong.com>
---
 qemu-img.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 5308773811..aa2e31c8ae 100644
--- a/qemu-img.c
+++ b/qemu-img.c
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




