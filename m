Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F04C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 01:13:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 484262074B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 01:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484262074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0x82-0005Eg-GW
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 21:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jingqi.liu@intel.com>)
 id 1k0x7U-0004pB-Dk
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 21:12:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:15476)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jingqi.liu@intel.com>)
 id 1k0x7R-0007vL-Lh
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 21:12:27 -0400
IronPort-SDR: Xn41st3Lb3tBigGy5iv+cqK0yC16w6ycD8EU9Or5V0RhlYjNNZCABjLvM52UxPQG2TOachgdEV
 R7b4uuR7ZuKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="139055715"
X-IronPort-AV: E=Sophos;i="5.75,412,1589266800"; d="scan'208";a="139055715"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2020 18:12:20 -0700
IronPort-SDR: 51dGuBhdgg+xbxDmYkcmeWFTyEoO6TkqCGO2jXDPrTbnnq9wOovf9d4772n3GCKrH/tQZmRmro
 6u7pgaNEwegw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,412,1589266800"; d="scan'208";a="313233873"
Received: from dazhang1-mobile.sh.intel.com ([10.239.48.70])
 by fmsmga004.fm.intel.com with ESMTP; 29 Jul 2020 18:12:18 -0700
From: Jingqi Liu <jingqi.liu@intel.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] docs/nvdimm: add 'pmem=on' for the device dax backend file
Date: Thu, 30 Jul 2020 09:02:06 +0800
Message-Id: <20200730010206.47051-1-jingqi.liu@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=jingqi.liu@intel.com; helo=mga18.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 21:12:20
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
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
Cc: Jingqi Liu <jingqi.liu@intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At the end of live migration, QEMU uses msync() to flush the data to
the backend storage. When the backend file is a character device dax,
the pages explicitly avoid the page cache. It will return failure from msync().
The following warning is output.

    "warning: qemu_ram_msync: failed to sync memory range“

So we add 'pmem=on' to avoid calling msync(), use the QEMU command line:

    -object memory-backend-file,id=mem1,pmem=on,mem-path=/dev/dax0.0,size=4G

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
---
 docs/nvdimm.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
index c2c6e441b3..31048aff5e 100644
--- a/docs/nvdimm.txt
+++ b/docs/nvdimm.txt
@@ -243,6 +243,13 @@ use the QEMU command line:
 
     -object memory-backend-file,id=nv_mem,mem-path=/XXX/yyy,size=4G,pmem=on
 
+At the end of live migration, QEMU uses msync() to flush the data to the
+backend storage. When the backend file is a character device dax, the pages
+explicitly avoid the page cache. It will return failure from msync().
+So we add 'pmem=on' to avoid calling msync(), use the QEMU command line:
+
+    -object memory-backend-file,id=mem1,pmem=on,mem-path=/dev/dax0.0,size=4G
+
 References
 ----------
 
-- 
2.17.1


