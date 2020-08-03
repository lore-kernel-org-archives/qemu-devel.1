Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76610C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 00:46:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46BD4206E9
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 00:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BD4206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2OcU-0006gq-O4
	for qemu-devel@archiver.kernel.org; Sun, 02 Aug 2020 20:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jingqi.liu@intel.com>)
 id 1k2Oby-0006G6-PJ
 for qemu-devel@nongnu.org; Sun, 02 Aug 2020 20:45:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:15390)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jingqi.liu@intel.com>)
 id 1k2Obw-00041b-71
 for qemu-devel@nongnu.org; Sun, 02 Aug 2020 20:45:54 -0400
IronPort-SDR: /gmwIgVSV7v4mbxF42H+0uhxIAqaJGVkLjpbvSSmWKTmtL9P4/8roIZYRnSDRq+8Ya1ANyjB6/
 lPJE7BfLQyhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="149832162"
X-IronPort-AV: E=Sophos;i="5.75,428,1589266800"; d="scan'208";a="149832162"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2020 17:45:45 -0700
IronPort-SDR: 5SZlPvyqIg5XmlzmqmIzRUJwpslYd9NEvlmpEQnaFVc36RVrS61PsKQvup44XV6a3Z2Cu3dgrw
 gz2hTA6KbB+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,428,1589266800"; d="scan'208";a="273778277"
Received: from dazhang1-mobile.sh.intel.com ([10.239.48.70])
 by fmsmga007.fm.intel.com with ESMTP; 02 Aug 2020 17:45:43 -0700
From: Jingqi Liu <jingqi.liu@intel.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] docs/nvdimm: add 'pmem=on' for the device dax backend file
Date: Mon,  3 Aug 2020 08:35:18 +0800
Message-Id: <20200803003518.88891-1-jingqi.liu@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.93; envelope-from=jingqi.liu@intel.com;
 helo=mga11.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/02 20:45:45
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
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


