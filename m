Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663BAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3191E2073E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3191E2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3eBD-0007p3-Vm
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1k3dfh-00027r-Bb
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 07:02:53 -0400
Received: from mgwym02.jp.fujitsu.com ([211.128.242.41]:57109)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1k3dfc-0001dk-SO
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 07:02:52 -0400
Received: from yt-mxauth.gw.nic.fujitsu.com (unknown [192.168.229.68]) by
 mgwym02.jp.fujitsu.com with smtp
 id 6f58_3687_cd414405_856c_4d70_8b74_62aa8e587821;
 Thu, 06 Aug 2020 20:02:35 +0900
Received: from g01jpfmpwyt03.exch.g01.fujitsu.local
 (g01jpfmpwyt03.exch.g01.fujitsu.local [10.128.193.57])
 by yt-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id 73CD9AC00CE
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 20:02:34 +0900 (JST)
Received: from g01jpexchyt33.g01.fujitsu.local (unknown [10.128.193.4])
 by g01jpfmpwyt03.exch.g01.fujitsu.local (Postfix) with ESMTP id AC6E646E7E7;
 Thu,  6 Aug 2020 20:02:33 +0900 (JST)
Received: from luna3.soft.fujitsu.com (10.124.196.199) by
 g01jpexchyt33.g01.fujitsu.local (10.128.193.36) with Microsoft SMTP Server id
 14.3.487.0; Thu, 6 Aug 2020 20:02:33 +0900
From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
To: <virtio-fs@redhat.com>
Subject: [PATCH] virtiofsd: Cleanup norace option description
Date: Thu, 6 Aug 2020 20:11:29 +0900
Message-ID: <20200806111129.22055-1-misono.tomohiro@jp.fujitsu.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
Received-SPF: pass client-ip=211.128.242.41;
 envelope-from=misono.tomohiro@fujitsu.com; helo=mgwym02.jp.fujitsu.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 07:02:41
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cleanup norace option as the feature was removed by below commit:

Fixes: 93bb3d8d4cda("virtiofsd: remove symlink fallbacks")
Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
---
 docs/tools/virtiofsd.rst | 3 ---
 tools/virtiofsd/helper.c | 2 --
 2 files changed, 5 deletions(-)

diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
index 824e713491..58666a4495 100644
--- a/docs/tools/virtiofsd.rst
+++ b/docs/tools/virtiofsd.rst
@@ -63,9 +63,6 @@ Options
     Print only log messages matching LEVEL or more severe.  LEVEL is one of
     ``err``, ``warn``, ``info``, or ``debug``.  The default is ``info``.
 
-  * norace -
-    Disable racy fallback.  The default is false.
-
   * posix_lock|no_posix_lock -
     Enable/disable remote POSIX locks.  The default is ``posix_lock``.
 
diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 2e4cdb4f49..4ded1d588a 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -159,8 +159,6 @@ void fuse_cmdline_help(void)
            "    -o max_idle_threads        the maximum number of idle worker "
            "threads\n"
            "                               allowed (default: 10)\n"
-           "    -o norace                  disable racy fallback\n"
-           "                               default: false\n"
            "    -o posix_lock|no_posix_lock\n"
            "                               enable/disable remote posix lock\n"
            "                               default: posix_lock\n"
-- 
2.21.3


