Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A010C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:33:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 576B120878
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576B120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSbHZ-0004Er-AA
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 03:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kSbDC-0007si-JK
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 03:28:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:54376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kSbDA-00045B-A0
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 03:28:38 -0400
IronPort-SDR: Pfdz0/L0digECfE7R1WO0jRqayXbC1Es5OnaJYp4Jkz1WyfHK7uNxVaaR8KFheaLZBGekWryWy
 CPJGtucAgkXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="250751934"
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; d="scan'208";a="250751934"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2020 00:28:33 -0700
IronPort-SDR: GHdYy1iDyK/pthHhyzj2wb8H5V7zSFCq99PokzwOb31owNu7VzSz73Ri+rmxo23qbBN1p/lJyU
 DunrOCT3Jtqg==
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; d="scan'208";a="521323057"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2020 00:28:32 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>,
	qemu-dev <qemu-devel@nongnu.org>
Subject: [PATCH 07/10] net/colo-compare.c: Fix compare_timeout format issue
Date: Wed, 14 Oct 2020 15:25:53 +0800
Message-Id: <20201014072555.12515-8-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014072555.12515-1-chen.zhang@intel.com>
References: <20201014072555.12515-1-chen.zhang@intel.com>
Received-SPF: pass client-ip=192.55.52.43; envelope-from=chen.zhang@intel.com;
 helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:28:22
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, FROM_ADDR_WS=2.999,
 FROM_WSP_TRAIL=2.199, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Zhang Chen <chen.zhang@intel.com>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

This parameter need compare with the return of qemu_clock_get_ms(),
it is uinit64_t. So we need fix this issue here.

Reported-by: Derek Su <dereksu@qnap.com>
Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 net/colo-compare.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 24c366eec0..f4814c5f09 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -120,7 +120,7 @@ struct CompareState {
     SendCo out_sendco;
     SendCo notify_sendco;
     bool vnet_hdr;
-    uint32_t compare_timeout;
+    uint64_t compare_timeout;
     uint32_t expired_scan_cycle;
 
     /*
@@ -1075,9 +1075,9 @@ static void compare_get_timeout(Object *obj, Visitor *v,
                                 Error **errp)
 {
     CompareState *s = COLO_COMPARE(obj);
-    uint32_t value = s->compare_timeout;
+    uint64_t value = s->compare_timeout;
 
-    visit_type_uint32(v, name, &value, errp);
+    visit_type_uint64(v, name, &value, errp);
 }
 
 static void compare_set_timeout(Object *obj, Visitor *v,
@@ -1140,9 +1140,9 @@ static void set_max_queue_size(Object *obj, Visitor *v,
                                Error **errp)
 {
     Error *local_err = NULL;
-    uint32_t value;
+    uint64_t value;
 
-    visit_type_uint32(v, name, &value, &local_err);
+    visit_type_uint64(v, name, &value, &local_err);
     if (local_err) {
         goto out;
     }
@@ -1390,7 +1390,7 @@ static void colo_compare_init(Object *obj)
     object_property_add_str(obj, "notify_dev",
                             compare_get_notify_dev, compare_set_notify_dev);
 
-    object_property_add(obj, "compare_timeout", "uint32",
+    object_property_add(obj, "compare_timeout", "uint64",
                         compare_get_timeout,
                         compare_set_timeout, NULL, NULL);
 
-- 
2.17.1


