Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F1DC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 07:05:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82DED2073E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 07:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82DED2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCeNg-0002d6-OD
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 03:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jCeN6-0001pQ-2b
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 03:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1jCeN4-0001md-7C
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 03:04:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:5758)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1jCeN3-0001dR-V5
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 03:04:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Mar 2020 00:04:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,547,1574150400"; d="scan'208";a="278121860"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by fmsmga002.fm.intel.com with ESMTP; 13 Mar 2020 00:04:31 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Laurent Vivier <laurent@vivier.eu>,
	qemu-dev <qemu-devel@nongnu.org>
Subject: [PATCH] configure: Fix configure error.
Date: Fri, 13 Mar 2020 14:55:25 +0800
Message-Id: <20200313065525.31722-1-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
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
Cc: Zhang Chen <chen.zhang@intel.com>, Juan Quintela <quintela@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

When run the ./configure will always get this error:
Unknown option --exist

It caused by this patch:
commit 3a67848134d0c07da49033f9ed08bf0ddeec0c6d
Author: Juan Quintela <quintela@redhat.com>
Date:   Tue Dec 17 21:15:24 2019 +0100

    configure: Enable test and libs for zstd

    Add it to several build systems to make testing good.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 3c7470096f..305591f7e0 100755
--- a/configure
+++ b/configure
@@ -2475,7 +2475,7 @@ fi
 # zstd check
 
 if test "$zstd" != "no" ; then
-    if $pkg_config --exist libzstd ; then
+    if $pkg_config --exists libzstd ; then
         zstd_cflags="$($pkg_config --cflags libzstd)"
         zstd_libs="$($pkg_config --libs libzstd)"
         LIBS="$zstd_libs $LIBS"
-- 
2.17.1


