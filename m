Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D24AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 03:04:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D066C2072D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 03:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D066C2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvXj7-0006JM-2m
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 23:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jingqi.liu@intel.com>)
 id 1jvXiJ-0005sl-8Y
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 23:04:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:57654)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jingqi.liu@intel.com>)
 id 1jvXiF-0002IF-Nt
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 23:04:06 -0400
IronPort-SDR: csKXbnlj2h68VNTbLoq6HAFRN9v4VwzJ6hI9ESWCtfycrnR6eSuAQGlksybKL2r4MDgA/sx9Bf
 abX9B4DR329g==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="167188310"
X-IronPort-AV: E=Sophos;i="5.75,353,1589266800"; d="scan'208";a="167188310"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 20:03:55 -0700
IronPort-SDR: l7O7RkvVKhGqwshis85+z6XV2ygcmUdpMnCm3wnzB5dyGwB/EUoj8Y2n7QHmfB14HGxWHif1+q
 Mdlv71Py7vMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,353,1589266800"; d="scan'208";a="308099192"
Received: from dazhang1-mobile.sh.intel.com ([10.239.48.70])
 by fmsmga004.fm.intel.com with ESMTP; 14 Jul 2020 20:03:51 -0700
From: Jingqi Liu <jingqi.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] docs/nvdimm: add 'pmem=on' for the device dax backend file
Date: Wed, 15 Jul 2020 10:54:29 +0800
Message-Id: <20200715025429.28657-1-jingqi.liu@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.88; envelope-from=jingqi.liu@intel.com;
 helo=mga01.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 23:03:56
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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


