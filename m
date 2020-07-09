Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B824C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D00E42073A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sd9PeuDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00E42073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtXML-0005cM-19
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 10:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtXIw-0000Gh-Gv
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:13:38 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtXIu-0001Kk-Q6
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:13:38 -0400
Received: by mail-wr1-x443.google.com with SMTP id r12so2513278wrj.13
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 07:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M56C/7edPLiM8JWg+URAkFUT+3dv8mHH/cx2urJlkD0=;
 b=sd9PeuDB/N/2DQ1AvxPNnCUxMyAonBgFqnNk/oHcyVkonhb7LpHeb5TNrbzSz/QXQB
 UptrUe8BVws5sjl9+4uvEaCSsVVIRSWxQBoHnrrJEvglnKY03EUrJn5aTqc6bTdOppqF
 RwaaE7zSf7lQ2Sx9jBx2/h6ZIk0vK/I2FJdOleuwF2FD4oAqP9dGauo8gkAJspTyk+im
 i05nTQBBYN23iELtbGrwnEzMz1KJjZLI+8otc3mFF0z7mHsP7/XffepxxWPMtB0ZoyxL
 Z9rVMMHP2gviEUFm5UZUNWi0GELhUDF1h5IrZ2g69i2KW8ByZWHxhQOVSXQS/d4LzB2j
 2Icw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=M56C/7edPLiM8JWg+URAkFUT+3dv8mHH/cx2urJlkD0=;
 b=LGL1dfyiJ7gr/LAIKPtx4vT9FZJ4Prnh/yOrJDN/4LJQTcon8BBrjX7M0EXTECwK63
 J9baEKrMAktMEZBnPy5Rx4dRXFeJMBTwHHmZCqMu8pmJ34Aolpr46aERPJ719eZ8D0pe
 OgtwnVdTh3nNHQkq/E1vYvrR4rF1w2btLzapnm70DpkAp8Z989p+kNzBMD8tCBaNw+GS
 TimZeF5hLU5R5IKTOxoPReROzrKSe7q2IkKFbch3wjhJHrEC7SapbZLgSldrctuMo/ed
 g0fhuVz82rhT5zsqhFC007Lcrf0BVjqBQEdlHck17CVYN0dIpBBFW+Zcme0rTiywM2R9
 +u5g==
X-Gm-Message-State: AOAM533cmE2P+91K/cH0JeecI/vLyYm/O+HnTyqH+YNr1EL58xRa4Hp+
 I712RGEb1qE8D89oUgUyLGRjLA==
X-Google-Smtp-Source: ABdhPJzTBCGgo99LSy2sI8DN0WMrVTPYHtZxUb0+zooRPOjcPPT7zaleImrROeddGniE4P0ZtZVZwg==
X-Received: by 2002:a5d:60c5:: with SMTP id x5mr29473461wrt.67.1594304015356; 
 Thu, 09 Jul 2020 07:13:35 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m10sm5738399wru.4.2020.07.09.07.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 07:13:34 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EA48A1FF92;
 Thu,  9 Jul 2020 15:13:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 06/13] plugins: add API to return a name for a IO device
Date: Thu,  9 Jul 2020 15:13:20 +0100
Message-Id: <20200709141327.14631-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200709141327.14631-1-alex.bennee@linaro.org>
References: <20200709141327.14631-1-alex.bennee@linaro.org>
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
index bab8b0d4b3af..c98c18d6b052 100644
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
index bbdc5a4eb46d..4304e63f0cf8 100644
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


