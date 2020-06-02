Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE66C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:51:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 441152067B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ul2p1678"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441152067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg9CD-0001fx-2O
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 11:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jg97f-0003jI-4q
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:46:39 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37120)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jg97e-0007da-0N
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:46:38 -0400
Received: by mail-wr1-x441.google.com with SMTP id x13so3922638wrv.4
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 08:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D98gPKyXYpHfK2vdgoTLIOCcijD4DQVmE2DVfMIiR4I=;
 b=Ul2p16782znMcbsKpUw0Xm/g/AeHDL2ZSBciVmljZk8//OPHCBdPCJk8dnfLFihx06
 XODtINTxB+ww5N3Dtuh/8jUv4RxmvrXbstAVsUpELiIGNfjDYIFW9AQSOkteAEw10Y1c
 dA3YpTnWkBxU99/HzeQlDImeyyGJG8OVaPOR0orp2UqLxt5YuJvBy4kO2VgYUWkyXDTD
 VC4HANX9Uy5euDTNSBVdaSXJcR/0MZm+AAdNyEPdKDtZO74FG1CUChHAPLq2wI3wuNrc
 Jq+1IITF1y1vW4m90iDZt4Hp+8lksjqrnrPRstKfug1T+Ozwip98K4crr0vxr+B4mHTS
 4eYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D98gPKyXYpHfK2vdgoTLIOCcijD4DQVmE2DVfMIiR4I=;
 b=Hm2D5bMNFVfKI54TmKszaFBe9fr/JKHSC79X11rUzsRJmKTQMlrQ15KFT1imomxn57
 2/69NMOoDIpYHsdwy7SVCp34ZSXxP632zpcNNezFF5vSRHlwyQYHMXxWsDO6736Rylj8
 vBxTvJl6V5yOAt4w2N3D+7Ij9pKnJDgA/TrB3axmyfn5d7EdRgjZl5w/J+zWPs6UBRqo
 IJFC1QDLoHrG571ik0Rn1HaDRjrYMfGlj4s7aeEYseeB9lTQRvTev/Su1lCLTfG9SBtE
 73vRzdEBAz1wqzgmcH5Ks0fOn9WcrbaDz83NNFK+yQIauv8+wa79wahud9tFYQ2lpOzO
 DuTQ==
X-Gm-Message-State: AOAM530spmD5C4eoWXg8JibMuWZEEW1W4pqEVYP4kZh4+q58LFpp2auK
 /4PpD6l9OVSK9mg+wjfvYn8J+w==
X-Google-Smtp-Source: ABdhPJwdCD/FKV7MGBtwwb4puXuOLX3KQGY5CnARp56Juo109Rc9iXy/Hp5mpC81H6r/K0rNujFcCw==
X-Received: by 2002:adf:a50e:: with SMTP id i14mr15141142wrb.21.1591112796558; 
 Tue, 02 Jun 2020 08:46:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l17sm186818wmi.16.2020.06.02.08.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 08:46:32 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D7B241FF93;
 Tue,  2 Jun 2020 16:46:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 7/9] plugins: add API to return a name for a IO device
Date: Tue,  2 Jun 2020 16:46:22 +0100
Message-Id: <20200602154624.4460-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200602154624.4460-1-alex.bennee@linaro.org>
References: <20200602154624.4460-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 peter.puhov@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This may well end up being anonymous but it should always be unique.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/qemu-plugin.h |  5 +++++
 plugins/api.c              | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index bab8b0d4b3a..43c6a9e857f 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -335,6 +335,11 @@ struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
 bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr);
 uint64_t qemu_plugin_hwaddr_device_offset(const struct qemu_plugin_hwaddr *haddr);
 
+/*
+ * Returns a string representing the device. Plugin must free() it
+ */
+char * qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *haddr);
+
 typedef void
 (*qemu_plugin_vcpu_mem_cb_t)(unsigned int vcpu_index,
                              qemu_plugin_meminfo_t info, uint64_t vaddr,
diff --git a/plugins/api.c b/plugins/api.c
index bbdc5a4eb46..3c73de8c1c2 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -303,6 +303,24 @@ uint64_t qemu_plugin_hwaddr_device_offset(const struct qemu_plugin_hwaddr *haddr
     return 0;
 }
 
+char * qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *haddr)
+{
+#ifdef CONFIG_SOFTMMU
+    if (haddr && haddr->is_io) {
+        MemoryRegionSection *mrs = haddr->v.io.section;
+        if (!mrs->mr->name) {
+            return g_strdup_printf("anon%08lx", 0xffffffff & (uintptr_t) mrs->mr);
+        } else {
+            return g_strdup(mrs->mr->name);
+        }
+    } else {
+        return g_strdup("RAM");
+    }
+#else
+    return g_strdup("Invalid");
+#endif
+}
+
 /*
  * Queries to the number and potential maximum number of vCPUs there
  * will be. This helps the plugin dimension per-vcpu arrays.
-- 
2.20.1


