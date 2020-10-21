Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072A2C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:11:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42C0F2080A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iOOsWz4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C0F2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVHeI-00045s-A5
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVHbX-0001GK-Me
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:08:51 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36408)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVHbW-0002Ld-10
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:08:51 -0400
Received: by mail-wr1-x443.google.com with SMTP id x7so3989643wrl.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CyvDw91uubSGIdWIAdTAsQ1zQNyBZvn96J6X4iAVYZo=;
 b=iOOsWz4muHdq+9UTi/DY6hcSsALgBLFID2N73Ws8Jqwk6XPrlSABek/nfGokwcp/Re
 tQjynHJ52/bFnP1J/s9ayCyayMa33sdqfrqLyD3n/NZc8POFI+PbYhfV+UF+GJTmnZaI
 065mYLzHakY1SBH79N8wKKeKGJGi7ZfTlWDEaeykD1ZcPPV+150A+Mv6D94VVCrQ+87i
 JbFS5lVqjckoYEqPeHkUXOMWZpcqnAqjjpueMU9SAxlackwhViKH+lxZh8Wu38GzNODl
 dkO1tBaHX2sjfakQexSSLqs/9sfa/189msgvllE9PylH70iWN4D1EnQ3HW0hcxMk0Zx2
 +yBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CyvDw91uubSGIdWIAdTAsQ1zQNyBZvn96J6X4iAVYZo=;
 b=m5zX6s1JTFi5tDiMaaImSuM29S4MYReFugiigcLXKlaQe2QZO+Em6PaagRVYU7g+ha
 R/mikx1ZIldo4Bs9J9I9gjbgvTyzAufCDU1TrLwzTXSJOvcPNWp+kyV3cxAs6EiyXxT3
 I+xpHnbh9nOWphsXVdgntkUtfrJLWGC3oq2aDaZSbxbDmDyXXR0DxptJl6/+9zvjmJ75
 NzXPs2do7J3iD4llfBMh+3UsSY+wCxYByhD3NPrkYvS2vq6MayXPxsqp3K9nQ3XDHA8K
 qpo4jfygqA8Mq4vBQkJAOUGzeVMzrIhf7Zzl92P+gEHVj+3/gKEBm1CR4aCJKSpX/1hk
 F7FA==
X-Gm-Message-State: AOAM532zGQ+KXx7BNZFo0q8+fEJ4HI7UvA2M5ThrvRpkasY3WPG2EEAr
 BB1vnEnuyH4qjhU7yLwsWRzv1g==
X-Google-Smtp-Source: ABdhPJzCyINSx06oSWvexoa4erYmkWn7TtK8+YLDzD/kXskCVCeZNBwoDTvH3kLBl4nE4CvfLUVIug==
X-Received: by 2002:adf:a501:: with SMTP id i1mr5761378wrb.162.1603300128603; 
 Wed, 21 Oct 2020 10:08:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 10sm4470901wmn.9.2020.10.21.10.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:08:44 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 34F7F1FF8F;
 Wed, 21 Oct 2020 18:08:43 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 3/4] device_tree: add qemu_fdt_setprop_string_array helper
Date: Wed, 21 Oct 2020 18:08:41 +0100
Message-Id: <20201021170842.25762-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201021170842.25762-1-alex.bennee@linaro.org>
References: <20201021170842.25762-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: julien@xen.org, masami.hiramatsu@linaro.org, andre.przywara@arm.com,
 stefano.stabellini@linaro.org, takahiro.akashi@linaro.org,
 Alistair Francis <alistair.francis@wdc.com>,
 David Gibson <david@gibson.dropbear.id.au>, stefano.stabellini@xilinx.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A string array in device tree is simply a series of \0 terminated
strings next to each other. As libfdt doesn't support that directly
we need to build it ourselves.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/sysemu/device_tree.h | 17 +++++++++++++++++
 softmmu/device_tree.c        | 26 ++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/sysemu/device_tree.h b/include/sysemu/device_tree.h
index 982c89345f..8a2fe55622 100644
--- a/include/sysemu/device_tree.h
+++ b/include/sysemu/device_tree.h
@@ -70,6 +70,23 @@ int qemu_fdt_setprop_u64(void *fdt, const char *node_path,
                          const char *property, uint64_t val);
 int qemu_fdt_setprop_string(void *fdt, const char *node_path,
                             const char *property, const char *string);
+
+/**
+ * qemu_fdt_setprop_string_array: set a string array property
+ *
+ * @fdt: pointer to the dt blob
+ * @name: node name
+ * @prop: property array
+ * @array: pointer to an array of string pointers
+ * @len: length of array
+ *
+ * assigns a string array to a property. This function converts and
+ * array of strings to a sequential string with \0 separators before
+ * setting the property.
+ */
+int qemu_fdt_setprop_string_array(void *fdt, const char *node_path,
+                                  const char *prop, char **array, int len);
+
 int qemu_fdt_setprop_phandle(void *fdt, const char *node_path,
                              const char *property,
                              const char *target_node_path);
diff --git a/softmmu/device_tree.c b/softmmu/device_tree.c
index b335dae707..a19873316a 100644
--- a/softmmu/device_tree.c
+++ b/softmmu/device_tree.c
@@ -21,6 +21,7 @@
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/bswap.h"
+#include "qemu/cutils.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/sysemu.h"
 #include "hw/loader.h"
@@ -397,6 +398,31 @@ int qemu_fdt_setprop_string(void *fdt, const char *node_path,
     return r;
 }
 
+/*
+ * libfdt doesn't allow us to add string arrays directly but they are
+ * test a series of null terminated strings with a length. We build
+ * the string up here so we can calculate the final length.
+ */
+int qemu_fdt_setprop_string_array(void *fdt, const char *node_path, const char *prop,
+                                  char **array, int len)
+{
+    int ret, i, total_len = 0;
+    char *str, *p;
+    for (i = 0; i < len; i++) {
+        total_len += strlen(array[i]) + 1;
+    }
+    p = str = g_malloc0(total_len);
+    for (i = 0; i < len; i++) {
+        int len = strlen(array[i]) + 1;
+        pstrcpy(p, len, array[i]);
+        p += len;
+    }
+
+    ret = qemu_fdt_setprop(fdt, node_path, prop, str, total_len);
+    g_free(str);
+    return ret;
+}
+
 const void *qemu_fdt_getprop(void *fdt, const char *node_path,
                              const char *property, int *lenp, Error **errp)
 {
-- 
2.20.1


