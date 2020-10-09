Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DFBC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED66B22258
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QxJ8VjkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED66B22258
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQw0k-0006z6-Rl
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 13:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvs4-0004am-Ri
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:07:56 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40736)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvs1-0001Je-1Q
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:07:56 -0400
Received: by mail-wr1-x444.google.com with SMTP id h5so977613wrv.7
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 10:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZdPHbQWRDkMxBC6O5/k+6hitBUPm7MDCOKjfSyNLevM=;
 b=QxJ8VjkOoFEw2blUOaL6YrmJYKFr72+rBo+ePvs8Q+7ts+IZdW24CKmosMAaP+DIzp
 13qs66HVHwI3w348BC+87IO2Q9kwrog6OuO6O2F5WwRhI3ULVNUWBcHjpD9qffBwsC2A
 GySUQP0ArfaaCZEyRP23tIxRANgrNCLF1PAKWXcLN2VdbauTMSupSJzDc68JE61dDrZ3
 XXNjrMIPWRlEMJ3wLLBoN6HElc+M2UtyVufb83/F0MGb3siQXOFUk0IQXN+4XQ5ttIVg
 Dkq3KUduwiCR14ZIr8lpZ33m+IS1tPnkYBaP6JwOdrZY3KvPM8gKR1cA16IuxlzMAdly
 zlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZdPHbQWRDkMxBC6O5/k+6hitBUPm7MDCOKjfSyNLevM=;
 b=TAPBTAG25JWh8MG0hP3VqD22tC7OV8VcD5rXmRTd0Twu2PKsQ12PFu1cllWeUZDV9p
 is3CW0jY+gZYNjUXF14yYEhZgAupo75i/UQRtIgoyUZG8bwj0i+QJmsUrsrJvTajzTu7
 siiyIzZoRaVz9PL+XLPHDB33tsaIax69YQ0kyhPunoII0Wu98YdkRPq79RYXPmEMqE+Y
 qO3uqniy3k6eU11DA3RA8xkdnvNzeGx5tALlmIErN+6KD8L/c0rfja3qzEQGUrlVA4hZ
 A6CRQq7W9EuPg7WW2qTpMNtCndM+lbfE3ZI9Rp69b14SbFn5BEaW0mczsaT5YtHFrQIv
 Zb8g==
X-Gm-Message-State: AOAM531C6k1SOF188KFt358ZC6FR7RgRawi2A0I40Z29LXaBS5JNRq4X
 9HQ8bh/ZdAaR9LWSc71vx/y0Fj5iKn/b4Q==
X-Google-Smtp-Source: ABdhPJzBTG8S2iDQv3fYepAE31HOUZQZmfqUfnAmzKqE2VuZs4KUujdBtI985biN7gAxGTvEVk0wAA==
X-Received: by 2002:a5d:5449:: with SMTP id w9mr17032286wrv.182.1602263271620; 
 Fri, 09 Oct 2020 10:07:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n9sm12345629wrq.72.2020.10.09.10.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 10:07:45 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 57A231FF8F;
 Fri,  9 Oct 2020 18:07:43 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 3/4] device_tree: add qemu_fdt_setprop_string_array helper
Date: Fri,  9 Oct 2020 18:07:41 +0100
Message-Id: <20201009170742.23695-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201009170742.23695-1-alex.bennee@linaro.org>
References: <20201009170742.23695-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
 device_tree.c                | 26 ++++++++++++++++++++++++++
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
diff --git a/device_tree.c b/device_tree.c
index b335dae707..a19873316a 100644
--- a/device_tree.c
+++ b/device_tree.c
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


