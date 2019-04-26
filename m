Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B4BC43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 00:39:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3E992084F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 00:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E992084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37181 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJott-0001Z6-Vm
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 20:39:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJosQ-0000hz-MB
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 20:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJosP-0007i0-IN
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 20:38:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:16691)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hJosP-0007fU-AS
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 20:38:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Apr 2019 17:38:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,395,1549958400"; d="scan'208";a="340872213"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga005.fm.intel.com with ESMTP; 25 Apr 2019 17:38:02 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 08:36:52 +0800
Message-Id: <20190426003652.32633-3-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190426003652.32633-1-richardw.yang@linux.intel.com>
References: <20190426003652.32633-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.20
Subject: [Qemu-devel] [PATCH v15 2/2] docs: Added MAP_SYNC documentation
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pagupta@redhat.com, xiaoguangrong.eric@gmail.com, mst@redhat.com,
	yi.z.zhang@linux.intel.com, yu.c.zhang@linux.intel.com,
	richardw.yang@linux.intel.com, stefanha@redhat.com,
	imammedo@redhat.com, pbonzini@redhat.com,
	dan.j.williams@intel.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426003652.2UeFFpOnODv-s6G6WY18x9WyYA4J4eYbOzASEreg8lA@z>

From: Zhang Yi <yi.z.zhang@linux.intel.com>

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Pankaj Gupta <pagupta@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/nvdimm.txt | 22 +++++++++++++++++++---
 qemu-options.hx |  5 +++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
index 7231c2d78f..b531cacd35 100644
--- a/docs/nvdimm.txt
+++ b/docs/nvdimm.txt
@@ -144,9 +144,25 @@ Guest Data Persistence
 ----------------------
 
 Though QEMU supports multiple types of vNVDIMM backends on Linux,
-currently the only one that can guarantee the guest write persistence
-is the device DAX on the real NVDIMM device (e.g., /dev/dax0.0), to
-which all guest access do not involve any host-side kernel cache.
+the only backend that can guarantee the guest write persistence is:
+
+A. DAX device (e.g., /dev/dax0.0, ) or
+B. DAX file(mounted with dax option)
+
+When using B (A file supporting direct mapping of persistent memory)
+as a backend, write persistence is guaranteed if the host kernel has
+support for the MAP_SYNC flag in the mmap system call (available
+since Linux 4.15 and on certain distro kernels) and additionally
+both 'pmem' and 'share' flags are set to 'on' on the backend.
+
+If these conditions are not satisfied i.e. if either 'pmem' or 'share'
+are not set, if the backend file does not support DAX or if MAP_SYNC
+is not supported by the host kernel, write persistence is not
+guaranteed after a system crash. For compatibility reasons, these
+conditions are ignored if not satisfied. Currently, no way is
+provided to test for them.
+For more details, please reference mmap(2) man page:
+http://man7.org/linux/man-pages/man2/mmap.2.html.
 
 When using other types of backends, it's suggested to set 'unarmed'
 option of '-device nvdimm' to 'on', which sets the unarmed flag of the
diff --git a/qemu-options.hx b/qemu-options.hx
index 08749a3391..bdc74c0620 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4233,6 +4233,11 @@ using the SNIA NVM programming model (e.g. Intel NVDIMM).
 If @option{pmem} is set to 'on', QEMU will take necessary operations to
 guarantee the persistence of its own writes to @option{mem-path}
 (e.g. in vNVDIMM label emulation and live migration).
+Also, we will map the backend-file with MAP_SYNC flag, which ensures the
+file metadata is in sync for @option{mem-path} in case of host crash
+or a power failure. MAP_SYNC requires support from both the host kernel
+(since Linux kernel 4.15) and the filesystem of @option{mem-path} mounted
+with DAX option.
 
 @item -object memory-backend-ram,id=@var{id},merge=@var{on|off},dump=@var{on|off},share=@var{on|off},prealloc=@var{on|off},size=@var{size},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave}
 
-- 
2.19.1


