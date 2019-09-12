Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3779C5ACAE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 05:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94E8020856
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 05:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E8020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Hp4-00059w-M8
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 01:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1i8Hmt-0003TA-IO
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 01:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1i8Hmq-0002vf-K4
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 01:36:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:18593)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1i8Hmo-0002tG-NP
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 01:36:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Sep 2019 22:36:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,495,1559545200"; d="scan'208";a="186030745"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.36])
 by fmsmga007.fm.intel.com with ESMTP; 11 Sep 2019 22:36:44 -0700
From: Tao Xu <tao3.xu@intel.com>
To: imammedo@redhat.com,
	eblake@redhat.com,
	ehabkost@redhat.com
Date: Thu, 12 Sep 2019 13:36:28 +0800
Message-Id: <20190912053638.4858-2-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190912053638.4858-1-tao3.xu@intel.com>
References: <20190912053638.4858-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
Subject: [Qemu-devel] [PATCH v11 01/11] util/cutils: Add qemu_strtotime_ps()
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
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, jonathan.cameron@huawei.com, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To convert strings with time suffixes to numbers, support time unit are
"ps" for picosecond, "ns" for nanosecond, "us" for microsecond, "ms"
for millisecond or "s" for second.

Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

No changes in v11.

New patch in v10.
---
 include/qemu/cutils.h |  1 +
 util/cutils.c         | 82 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 12301340a4..0e70a807e1 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -180,5 +180,6 @@ int uleb128_decode_small(const uint8_t *in, uint32_t *n);
  * *str1 is <, == or > than *str2.
  */
 int qemu_pstrcmp0(const char **str1, const char **str2);
+int qemu_strtotime_ps(const char *nptr, const char **end, uint64_t *result);
 
 #endif
diff --git a/util/cutils.c b/util/cutils.c
index fd591cadf0..a50c15f46a 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -847,3 +847,85 @@ int qemu_pstrcmp0(const char **str1, const char **str2)
 {
     return g_strcmp0(*str1, *str2);
 }
+
+static int64_t timeunit_mul(const char *unitstr)
+{
+    if (g_strcmp0(unitstr, "ps") == 0) {
+        return 1;
+    } else if (g_strcmp0(unitstr, "ns") == 0) {
+        return 1000;
+    } else if (g_strcmp0(unitstr, "us") == 0) {
+        return 1000000;
+    } else if (g_strcmp0(unitstr, "ms") == 0) {
+        return 1000000000LL;
+    } else if (g_strcmp0(unitstr, "s") == 0) {
+        return 1000000000000LL;
+    } else {
+        return -1;
+    }
+}
+
+
+/*
+ * Convert string to time, support time unit are ps for picosecond,
+ * ns for nanosecond, us for microsecond, ms for millisecond or s for second.
+ * End pointer will be returned in *end, if not NULL. Return -ERANGE on
+ * overflow, and -EINVAL on other error.
+ */
+static int do_strtotime(const char *nptr, const char **end,
+                      const char *default_unit, uint64_t *result)
+{
+    int retval;
+    const char *endptr;
+    int mul_required = 0;
+    int64_t mul;
+    double val, integral, fraction;
+
+    retval = qemu_strtod_finite(nptr, &endptr, &val);
+    if (retval) {
+        goto out;
+    }
+    fraction = modf(val, &integral);
+    if (fraction != 0) {
+        mul_required = 1;
+    }
+
+    mul = timeunit_mul(endptr);
+
+    if (mul == 1000000000000LL) {
+        endptr++;
+    } else if (mul != -1) {
+        endptr += 2;
+    } else {
+        mul = timeunit_mul(default_unit);
+        assert(mul >= 0);
+    }
+    if (mul == 1 && mul_required) {
+        retval = -EINVAL;
+        goto out;
+    }
+    /*
+     * Values >= 0xfffffffffffffc00 overflow uint64_t after their trip
+     * through double (53 bits of precision).
+     */
+    if ((val * (double)mul >= 0xfffffffffffffc00) || val < 0) {
+        retval = -ERANGE;
+        goto out;
+    }
+    *result = val * (double)mul;
+    retval = 0;
+
+out:
+    if (end) {
+        *end = endptr;
+    } else if (*endptr) {
+        retval = -EINVAL;
+    }
+
+    return retval;
+}
+
+int qemu_strtotime_ps(const char *nptr, const char **end, uint64_t *result)
+{
+    return do_strtotime(nptr, end, "ps", result);
+}
-- 
2.20.1


