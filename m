Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8625C5B57D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 01:14:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AC4C20673
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 01:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC4C20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiTqX-0004NR-MS
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 21:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35732)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hiTpW-0003m6-Dn
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 21:13:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hiTpV-00057H-F6
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 21:13:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:30849)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hiTpV-000568-7S
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 21:13:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Jul 2019 18:12:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,445,1557212400"; d="scan'208";a="157813513"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga008.jf.intel.com with ESMTP; 02 Jul 2019 18:12:58 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Wed,  3 Jul 2019 09:12:34 +0800
Message-Id: <20190703011234.20517-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
Subject: [Qemu-devel] [PATCH] migration/postcopy: fix document of
 postcopy_send_discard_bm_ram()
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
Cc: Wei Yang <richardw.yang@linux.intel.com>, dgilbert@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 6b6712efccd3 ('ram: Split dirty bitmap by RAMBlock') changes the
parameter of postcopy_send_discard_bm_ram(), while left the document
part untouched.

This patch correct the document and fix one typo by hand.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/ram.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 246efe6939..410e0f89fe 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2763,8 +2763,7 @@ void ram_postcopy_migrated_memory_release(MigrationState *ms)
  *
  * @ms: current migration state
  * @pds: state for postcopy
- * @start: RAMBlock starting page
- * @length: RAMBlock size
+ * @block: RAMBlock to discard
  */
 static int postcopy_send_discard_bm_ram(MigrationState *ms,
                                         PostcopyDiscardState *pds,
@@ -2961,7 +2960,7 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
 }
 
 /**
- * postcopy_chuck_hostpages: discrad any partially sent host page
+ * postcopy_chuck_hostpages: discard any partially sent host page
  *
  * Utility for the outgoing postcopy code.
  *
-- 
2.19.1


