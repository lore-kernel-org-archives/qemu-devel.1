Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D286C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 15:58:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB5FA206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 15:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fygIBSJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB5FA206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj37h-0000SY-2w
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 11:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jj34d-0003mx-8J
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 11:55:31 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37657)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jj34b-0005E3-3A
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 11:55:30 -0400
Received: by mail-wm1-x344.google.com with SMTP id y20so2304675wmi.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 08:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K5O4iBO+Gb4CYP2dkK+QNloWbTQMSg+bPZS/dhOJAdk=;
 b=fygIBSJif8rAz2tfkD2LV5/qVawnF4VGcqNjenqgnS/2a7qqPnbdIo5OBvKTPVUdrx
 n/iPYFLHqbEkVnNO/foyYEccEnlZWyHrkS6EJtfqp9Ens/4wgfev2sami2BQCFj6eJzm
 VSkWeUeCDRVirJXPq4nE0NmkKu/fVj4IVKk1A9aajLghfiPlnjd+PNA9x2iSgJ0WRXRz
 zeIvoY/FkLi/Fmszloz1ReKBAqYMOplPVc92I75CVoVZu04P2tNDYMx/2F2vzFEaySe2
 UcQLg4eg7uI9iKlH2RUxB4Q5o6a2m4lcSm7dz7oLwSB6tT8LXnxTfb1dS2vNKHRjFUjf
 9KIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K5O4iBO+Gb4CYP2dkK+QNloWbTQMSg+bPZS/dhOJAdk=;
 b=kHV3x10jW8Rj1qHBNRLLXLwlGk7uuujFCPkdJyUXwZHY/HRUn1+z+VBLL8+dedovNz
 45o5gqOnoAmucMp9igmDn+RpLYbjVly9Km04L0WvnvJzvjWL2vVHgTmN51ygvZ2VQJxK
 oNJqpT2S/kKZIwS5w1g0gLG9rBT59XBBPKdjlWUe1K+JSRpkEFPY4ArpoKk9iQC98l7b
 wlUDzGbnmKkR7zCy9YiBTFJGiKa7t+Sla8CquYX53aQ41IV275hzRAw8T39Xg8zwDc5u
 sf8mq5zsrdeWjzd+us6+lgagFgZM/S8fgVuasWrwIqEiQMaMNUADYTTw6hi/cZZ939An
 p7oQ==
X-Gm-Message-State: AOAM531A6TJAt15MEFFnh7ZBmqzzX4ENUYSbRjNE50XFiwmrwW4fsPHm
 GeDkFGaJoy46goOtxTYybCZKxsAiOUE=
X-Google-Smtp-Source: ABdhPJwWEQcuBbKrM/5m0J8DW22Nsjvfy5FUKPZK1/uj2SmLgOUJ6oARcavZcYO9xqczuv8bjmMquA==
X-Received: by 2002:a1c:5411:: with SMTP id i17mr3982718wmb.137.1591804519629; 
 Wed, 10 Jun 2020 08:55:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o8sm182467wmb.20.2020.06.10.08.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 08:55:18 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 62D901FF91;
 Wed, 10 Jun 2020 16:55:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 5/6] plugins: add API to return a name for a IO device
Date: Wed, 10 Jun 2020 16:55:08 +0100
Message-Id: <20200610155509.12850-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200610155509.12850-1-alex.bennee@linaro.org>
References: <20200610155509.12850-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: robert.foley@linaro.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org, Clement Deschamps <clement.deschamps@greensocs.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This may well end up being anonymous but it should always be unique.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
[r-b provisional given change to g_intern_string]
Reviewed-by: Clement Deschamps <clement.deschamps@greensocs.com>
Reviewed-by: Emilio G. Cota <cota@braap.org>

---
v3
  - return a non-freeable const g_intern_string()
  - checkpatch cleanups
---
 include/qemu/qemu-plugin.h |  6 ++++++
 plugins/api.c              | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index bab8b0d4b3a..c98c18d6b05 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -335,6 +335,12 @@ struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
 bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr);
 uint64_t qemu_plugin_hwaddr_device_offset(const struct qemu_plugin_hwaddr *haddr);
 
+/*
+ * Returns a string representing the device. The string is valid for
+ * the lifetime of the plugin.
+ */
+const char *qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *h);
+
 typedef void
 (*qemu_plugin_vcpu_mem_cb_t)(unsigned int vcpu_index,
                              qemu_plugin_meminfo_t info, uint64_t vaddr,
diff --git a/plugins/api.c b/plugins/api.c
index bbdc5a4eb46..4304e63f0cf 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -303,6 +303,26 @@ uint64_t qemu_plugin_hwaddr_device_offset(const struct qemu_plugin_hwaddr *haddr
     return 0;
 }
 
+const char *qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *h)
+{
+#ifdef CONFIG_SOFTMMU
+    if (h && h->is_io) {
+        MemoryRegionSection *mrs = h->v.io.section;
+        if (!mrs->mr->name) {
+            unsigned long maddr = 0xffffffff & (uintptr_t) mrs->mr;
+            g_autofree char *temp = g_strdup_printf("anon%08lx", maddr);
+            return g_intern_string(temp);
+        } else {
+            return g_intern_string(mrs->mr->name);
+        }
+    } else {
+        return g_intern_string("RAM");
+    }
+#else
+    return g_intern_string("Invalid");
+#endif
+}
+
 /*
  * Queries to the number and potential maximum number of vCPUs there
  * will be. This helps the plugin dimension per-vcpu arrays.
-- 
2.20.1


