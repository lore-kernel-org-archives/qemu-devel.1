Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6837FC32751
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 00:41:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BEE520B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 00:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BEE520B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hszAD-0003NB-6p
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 20:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47491)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hsz9n-0002vx-PG
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 20:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hsz9k-0004Fx-Og
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 20:41:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:27703)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hsz9k-0004Ec-HB
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 20:41:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Jul 2019 17:41:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,332,1559545200"; d="scan'208";a="347821709"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga005.jf.intel.com with ESMTP; 31 Jul 2019 17:41:17 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Thu,  1 Aug 2019 08:40:53 +0800
Message-Id: <20190801004053.7021-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
Subject: [Qemu-devel] [PATCH v2] docs/nvdimm: add example on persistent
 backend setup
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
Cc: pagupta@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
 xiaoguangrong.eric@gmail.com, stefanha@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Persistent backend setup requires some knowledge about nvdimm and ndctl
tool. Some users report they may struggle to gather these knowledge and
have difficulty to setup it properly.

Here we provide two examples for persistent backend and gives the link
to ndctl. By doing so, user could try it directly and do more
investigation on persistent backend setup with ndctl.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Pankaj Gupta <pagupta@redhat.com>

---
v2: rephrase the doc based on Stefan Hajnoczi's suggestion
---
 docs/nvdimm.txt | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
index b531cacd35..362e99109e 100644
--- a/docs/nvdimm.txt
+++ b/docs/nvdimm.txt
@@ -171,6 +171,35 @@ guest software that this vNVDIMM device contains a region that cannot
 accept persistent writes. In result, for example, the guest Linux
 NVDIMM driver, marks such vNVDIMM device as read-only.
 
+Backend File Setup Example
+--------------------------
+
+Here are two examples showing how to setup these persistent backends on
+linux using the tool ndctl [3].
+
+A. DAX device
+
+Use the following command to set up /dev/dax0.0 so that the entirety of
+namespace0.0 can be exposed as an emulated NVDIMM to the guest:
+
+    ndctl create-namespace -f -e namespace0.0 -m devdax
+
+The /dev/dax0.0 could be used directly in "mem-path" option.
+
+B. DAX file
+
+Individual files on a DAX host file system can be exposed as emulated
+NVDIMMS.  First an fsdax block device is created, partitioned, and then
+mounted with the "dax" mount option:
+
+    ndctl create-namespace -f -e namespace0.0 -m fsdax
+    (partition /dev/pmem0 with name pmem0p1)
+    mount -o dax /dev/pmem0p1 /mnt
+    (create or copy a disk image file with qemu-img(1), cp(1), or dd(1)
+     in /mnt)
+
+Then the new file in /mnt could be used in "mem-path" option.
+
 NVDIMM Persistence
 ------------------
 
@@ -212,3 +241,5 @@ References
     https://www.snia.org/sites/default/files/technical_work/final/NVMProgrammingModel_v1.2.pdf
 [2] Persistent Memory Development Kit (PMDK), formerly known as NVML project, home page:
     http://pmem.io/pmdk/
+[3] ndctl-create-namespace - provision or reconfigure a namespace
+    http://pmem.io/ndctl/ndctl-create-namespace.html
-- 
2.17.1


