Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA25EC43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 09:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CE5020679
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 09:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE5020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44107 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJxZK-00053t-Hm
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 05:54:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hJxXl-00043x-Ia
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hJxOC-0001GC-UM
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:43:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:25745)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1hJxOC-00016Z-Mr
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:43:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	26 Apr 2019 02:43:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,397,1549958400"; d="scan'208";a="152549538"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
	by FMSMGA003.fm.intel.com with ESMTP; 26 Apr 2019 02:43:18 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	qemu-dev <qemu-devel@nongnu.org>
Date: Fri, 26 Apr 2019 17:39:20 +0800
Message-Id: <20190426093920.5616-1-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.GIT
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.126
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Add qemu-options* to related field
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
Cc: Zhang Chen <chen.zhang@intel.com>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426093920.i2Iqf8ddU_Tc1AKV8sW8AXtDRtI12kPCne0wLh0b3n4@z>

From: Zhang Chen <chen.zhang@intel.com>

No one to maintain qemu-options related file, add it to Markus's
Command line option argument parsing field.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 23db6f8408..acc3b32f88 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1800,6 +1800,7 @@ F: tests/test-keyval.c
 F: tests/test-qemu-opts.c
 F: util/keyval.c
 F: util/qemu-option.c
+F: qemu-options*
 
 Coverity model
 M: Markus Armbruster <armbru@redhat.com>
-- 
2.17.GIT


