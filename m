Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90C4C3F2C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 01:21:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FA7C24690
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 01:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA7C24690
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40313 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7ULL-0000QV-Ob
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 20:21:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <colin.xu@intel.com>) id 1j7UKp-0008Pp-Ck
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 20:21:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <colin.xu@intel.com>) id 1j7UKo-0000Tm-A5
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 20:20:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:46102)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <colin.xu@intel.com>)
 id 1j7UKl-0000QY-IM; Thu, 27 Feb 2020 20:20:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Feb 2020 17:20:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; d="scan'208";a="232074795"
Received: from unknown (HELO coxu-arch-shz.sh.intel.com) ([10.239.160.37])
 by orsmga008.jf.intel.com with ESMTP; 27 Feb 2020 17:20:48 -0800
From: Colin Xu <colin.xu@intel.com>
To: qemu-devel@nongnu.org,
	philmd@redhat.com,
	pbonzini@redhat.com
Subject: [PATCH V2] MAINTAINERS: Add entry for Guest X86 HAXM CPUs
Date: Fri, 28 Feb 2020 09:20:46 +0800
Message-Id: <20200228012046.6629-1-colin.xu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
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
Cc: qemu-trivial@nongnu.org, hang.yuan@intel.com, colin.xu@intel.com,
 wenchao.wang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

HAXM covers below files:
include/sysemu/hax.h
target/i386/hax-*

V2: Add HAXM github page for wiki and issue tracking.

Cc: Wenchao Wang <wenchao.wang@intel.com>
Cc: Hang Yuan <hang.yuan@intel.com>
Reviewed-by: Hang Yuan <hang.yuan@intel.com>
Signed-off-by: Colin Xu <colin.xu@intel.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index df1786db3207..c45f1421eab5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -435,6 +435,17 @@ F: include/hw/block/dataplane/xen*
 F: include/hw/xen/
 F: include/sysemu/xen-mapcache.h
 
+Guest CPU Cores (HAXM)
+---------------------
+X86 HAXM CPUs
+M: Wenchao Wang <wenchao.wang@intel.com>
+M: Colin Xu <colin.xu@intel.com>
+L: haxm-team@intel.com
+W: https://github.com/intel/haxm/issues
+S: Maintained
+F: include/sysemu/hax.h
+F: target/i386/hax-*
+
 Hosts
 -----
 LINUX
-- 
2.25.1


