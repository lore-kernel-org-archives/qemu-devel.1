Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28532C433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:05:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E64FF20674
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="brV9IPLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64FF20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv4hn-0001Tl-4t
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 16:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jv4gh-0008Al-0Y
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:04:31 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:36789)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jv4gf-0006J4-5z
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:04:30 -0400
Received: by mail-wr1-x432.google.com with SMTP id k6so18141908wrn.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 13:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WVJRm9yMA7V6UraKTz4oUpniy0kUGIO9MjLG/c6LBA4=;
 b=brV9IPLqyHOY39GAGvoiqQuEIULY6Qz2VDd5AMTfpE6Y2UX8M1sFYtiL7vQueonLBn
 XOzcaMlCmpE1l3nmzYzmBQJI7fjS4LXhPkpX+grlJAdRAUYXEzVgnsx+SQ9gRnzI8Pja
 yL86EcL3+h/C4sYALSzZRJtKD4QGi4YIFp2rXYUeNoHK4LCOLt+csBlOjl619Q9Q8mo4
 LRHQUFX+wUDtQQSSmyBp7iGkXvC55tu8IrHhWVtp3gBvsXP4nM6lrwYtpvRjlEgpe604
 X1aiueqArJdVvuxQ/cw/0SlCJ1insY33GyGv6+wuAIseRjmG9vhidUFQSzdB5YMsTVuh
 iyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WVJRm9yMA7V6UraKTz4oUpniy0kUGIO9MjLG/c6LBA4=;
 b=cjVcWHtRT1BdCgxJTQVpCHdKJzwBQS/3vjRyKRZNCLKOkaaCXRlUhx0Au+nhbkm3+m
 JADjC/X95EYK/SPsXDb6X6HySgxwFy5Ia7iKM2/Y+3INll58l1/gn59QrzEs314xEf0j
 CseCalwRC6z7Av94on5T+r7QJUGldYvWeChltitft65xFmsukBvHBQmEnAIpUlGOccBN
 HAXfB0rzLFKfOSorU8nCjVDBNTUE8FWu4hO8VaU9s7I0Jg3mdH7n6B8Ff6kFxWMzNLrf
 0DfGpv03nsM2EB0+256P7XNwkqfuAswlhC+Hyteti20Vh73AgfztTEmXAArOtAgdvQIK
 SlBw==
X-Gm-Message-State: AOAM533nRlJ8JmsJIFbRnTIR4wbLYrDX6rAfKrOT2d+Uy/c8Hd1Akrj9
 xXbZSde/Av7PAxZFlgmGbjcwNw==
X-Google-Smtp-Source: ABdhPJzY6nZfWP1FFWkxezxCH53BQD5c/5qRA8nyUGnouowv9rCA9JVV/YjbOgu9bDKLZf97JbfH7w==
X-Received: by 2002:adf:e482:: with SMTP id i2mr1157195wrm.75.1594670667812;
 Mon, 13 Jul 2020 13:04:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q7sm25941773wrs.27.2020.07.13.13.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 13:04:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8869F1FF99;
 Mon, 13 Jul 2020 21:04:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 10/11] plugins: add API to return a name for a IO device
Date: Mon, 13 Jul 2020 21:04:14 +0100
Message-Id: <20200713200415.26214-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713200415.26214-1-alex.bennee@linaro.org>
References: <20200713200415.26214-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org, Clement Deschamps <clement.deschamps@greensocs.com>,
 aurelien@aurel32.net
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
index bab8b0d4b3..c98c18d6b0 100644
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
index bbdc5a4eb4..4304e63f0c 100644
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


