Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99866C43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:53:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A82215A4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A82215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQTXz-00012M-0r
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 06:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1kQTW1-0007e3-Ve
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:51:18 -0400
Received: from mgwkm02.jp.fujitsu.com ([202.219.69.169]:10262)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1kQTVy-0008Qz-Uj
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:51:16 -0400
Received: from kw-mxq.gw.nic.fujitsu.com (unknown [192.168.231.130]) by
 mgwkm02.jp.fujitsu.com with smtp
 id 464f_21e1_c4962a1f_5c83_46bb_b24d_06a39e2f99bf;
 Thu, 08 Oct 2020 19:51:03 +0900
Received: from g01jpfmpwkw03.exch.g01.fujitsu.local
 (g01jpfmpwkw03.exch.g01.fujitsu.local [10.0.193.57])
 by kw-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id 7273CAC00AB
 for <qemu-devel@nongnu.org>; Thu,  8 Oct 2020 19:51:02 +0900 (JST)
Received: from G01JPEXCHKW14.g01.fujitsu.local
 (G01JPEXCHKW14.g01.fujitsu.local [10.0.194.53])
 by g01jpfmpwkw03.exch.g01.fujitsu.local (Postfix) with ESMTP id AACC7BD64A6;
 Thu,  8 Oct 2020 19:51:01 +0900 (JST)
Received: from luna3.soft.fujitsu.com (10.124.196.199) by
 G01JPEXCHKW14.g01.fujitsu.local (10.0.194.53) with Microsoft SMTP Server id
 14.3.487.0; Thu, 8 Oct 2020 19:51:01 +0900
From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
To: <qemu-devel@nongnu.org>, <virtio-fs@redhat.com>
Subject: [PATCH] virtiofsd: passthrough_ll: set FUSE_LOG_INFO as default
 log_level
Date: Thu, 8 Oct 2020 20:01:48 +0900
Message-ID: <20201008110148.2757734-1-misono.tomohiro@jp.fujitsu.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
Received-SPF: pass client-ip=202.219.69.169;
 envelope-from=misono.tomohiro@fujitsu.com; helo=mgwkm02.jp.fujitsu.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 06:51:05
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just noticed that although help message says default log level is INFO,
it is actually 0 (EMRGE) and no mesage will be shown when error occurs.
It's better to follow help message.

Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
---
 tools/virtiofsd/passthrough_ll.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index 0b229ebd57..4ff9f1b688 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -2888,12 +2888,11 @@ int main(int argc, char *argv[])
         goto err_out1;
     }
 
-    /*
-     * log_level is 0 if not configured via cmd options (0 is LOG_EMERG,
-     * and we don't use this log level).
-     */
     if (opts.log_level != 0) {
         current_log_level = opts.log_level;
+    } else {
+        /* default log level is INFO */
+        current_log_level = FUSE_LOG_INFO;
     }
     lo.debug = opts.debug;
     if (lo.debug) {
-- 
2.25.4


