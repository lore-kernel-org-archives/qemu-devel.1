Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9C9C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 09:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBEDE2068E
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 09:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBEDE2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJCfs-00042W-Ti
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 05:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kJCcy-0000Ex-G9
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 05:24:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:42395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kJCcv-0004Px-9M
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 05:24:23 -0400
IronPort-SDR: t7kgBNAN0EF6OE+HEZUgS6tD25FINZceC43STbD4CaSJbekzjiT8KX7lYq5r0dvTwJPy2ddjBV
 uBSw5wnjxkUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="244733388"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; d="scan'208";a="244733388"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2020 02:24:16 -0700
IronPort-SDR: Gzj36Tfc27pgsJjAg6qps2pEJC9thjg43j/a0maHr0Zdu48c/H5iksrtJ6zAFXwbTZdGpGqVgf
 qdSfexOUBLoQ==
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; d="scan'208";a="484130678"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2020 02:24:14 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>,
	qemu-dev <qemu-devel@nongnu.org>
Subject: [PATCH 1/4] net/colo-compare.c: Fix compare_timeout format issue
Date: Fri, 18 Sep 2020 17:22:00 +0800
Message-Id: <20200918092203.20384-2-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918092203.20384-1-chen.zhang@intel.com>
References: <20200918092203.20384-1-chen.zhang@intel.com>
Received-SPF: pass client-ip=192.55.52.43; envelope-from=chen.zhang@intel.com;
 helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 05:24:15
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, FROM_ADDR_WS=2.999,
 FROM_WSP_TRAIL=1, HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Zhang Chen <chen.zhang@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

This parameter need compare with the return of qemu_clock_get_ms(),
it is uinit64_t. So we need fix this issue here.

Reported-by: Derek Su <dereksu@qnap.com>
Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 net/colo-compare.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 3a45d64175..7cba573dae 100644
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
@@ -1081,9 +1081,9 @@ static void compare_get_timeout(Object *obj, Visitor *v,
                                 Error **errp)
 {
     CompareState *s = COLO_COMPARE(obj);
-    uint32_t value = s->compare_timeout;
+    uint64_t value = s->compare_timeout;
 
-    visit_type_uint32(v, name, &value, errp);
+    visit_type_uint64(v, name, &value, errp);
 }
 
 static void compare_set_timeout(Object *obj, Visitor *v,
@@ -1146,9 +1146,9 @@ static void set_max_queue_size(Object *obj, Visitor *v,
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
@@ -1396,7 +1396,7 @@ static void colo_compare_init(Object *obj)
     object_property_add_str(obj, "notify_dev",
                             compare_get_notify_dev, compare_set_notify_dev);
 
-    object_property_add(obj, "compare_timeout", "uint32",
+    object_property_add(obj, "compare_timeout", "uint64",
                         compare_get_timeout,
                         compare_set_timeout, NULL, NULL);
 
-- 
2.17.1


