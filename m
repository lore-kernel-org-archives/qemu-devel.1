Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F31C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:40:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8217223A6C
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q0aae6Y/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8217223A6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6zEN-0004ya-Ps
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 12:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6zCo-00030o-Fz
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 12:38:54 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6zCm-0006Nm-Rm
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 12:38:54 -0400
Received: by mail-pg1-x542.google.com with SMTP id 128so5978633pgd.5
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 09:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=prxXYpsbQ4iXO9C0JgcLsKT0yklnyu64rFTxXlR5v4g=;
 b=q0aae6Y/AQrV72qpxt74vS2aXvJ/85YEHfzMo7gMXqjmBb2wtrvZnQMKXiOQxZbBeQ
 7uw/MoAeg18fgcWKiS/V9fjcX+0xZm9mmGwo17UT5/1t1Mw1JMAmhShi2fxYNDN9OGz9
 sn/9TP/Zcen2rS49iiUpes8ssBskTwbNI4aNn/G31g7SoyURTifVAsJpXIA3Hr1O1DAb
 Jv781uwNvJ3RdlnIqdeZxLy+Pfhn7IqcSHpfMPaMr2Mbs8h4qb2nYrTc4HpiRVgRVjR9
 GDqKRt4G82nxJnLM/VSMF6xKEXcMxmOxrT4uTJYXq/HL32iqv0voNi9qwf3aYsK1jpxs
 9pyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=prxXYpsbQ4iXO9C0JgcLsKT0yklnyu64rFTxXlR5v4g=;
 b=epIppV8trpoJ+AY5CJhdcG8YQoncIv20+ybt1/jT0mcK4fkbawlWRzCWn0j72w9adp
 fqh5oJV7cyY3/EIfnZ3QVDHwPtV2akp/tKsXnowJ2xoFThHvl9153J9PVeXtKjdWtTJ4
 YyDdn+2J/pkSRKpMLbJz+fsGe78OdH5pDFI1Mp7IO4n4h/m+3kpALq7zUlDFYBbwXXxn
 hO4+BA2R/TteqJDQGVploShy9lum4/pXS/0YX0AhwonXXEAyAvaeylLAqKmRIjWOgvdw
 GQdWLetba6Z31YW+Tnai7811YkmHO5QRpU4k5sb4vFHURjZn2A5cLjrEhISechMw0bIg
 gPSw==
X-Gm-Message-State: AOAM532rYlAlAX4RpW7tr4sT/m7TC+VqIo2KTxHLGznufAM/dNPaeXRc
 YGzn2t7GgXFk2zmbUg7yfYvaDAdz7QzUhQ==
X-Google-Smtp-Source: ABdhPJxY+tFn0hIYbjFqJONJQq0hYNVfHozx+s3/Gs0lZ9xCWdVKRSaCVVi3ns4pvn9OS7SkZiirLQ==
X-Received: by 2002:a63:6744:: with SMTP id b65mr3062787pgc.42.1597441185658; 
 Fri, 14 Aug 2020 14:39:45 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q83sm10417249pfc.31.2020.08.14.14.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 14:39:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/3] target/arm: Use object_property_add_bool for "sve"
 property
Date: Fri, 14 Aug 2020 14:39:38 -0700
Message-Id: <20200814213938.369628-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814213938.369628-1-richard.henderson@linaro.org>
References: <20200814213938.369628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
Cc: mark.rutland@arm.com, peter.maydell@linaro.org, drjones@redhat.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The interface for object_property_add_bool is simpler,
making the code easier to understand.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu64.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 0227862d39..cce0da0b90 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -488,6 +488,12 @@ static void cpu_max_set_sve_max_vq(Object *obj, Visitor *v, const char *name,
     cpu->sve_max_vq = max_vq;
 }
 
+/*
+ * Note that cpu_arm_get/set_sve_vq cannot use the simpler
+ * object_property_add_bool interface because they make use
+ * of the contents of "name" to determine which bit on which
+ * to operate.
+ */
 static void cpu_arm_get_sve_vq(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
@@ -529,26 +535,17 @@ static void cpu_arm_set_sve_vq(Object *obj, Visitor *v, const char *name,
     set_bit(vq - 1, cpu->sve_vq_init);
 }
 
-static void cpu_arm_get_sve(Object *obj, Visitor *v, const char *name,
-                            void *opaque, Error **errp)
+static bool cpu_arm_get_sve(Object *obj, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
-    bool value = cpu_isar_feature(aa64_sve, cpu);
-
-    visit_type_bool(v, name, &value, errp);
+    return cpu_isar_feature(aa64_sve, cpu);
 }
 
-static void cpu_arm_set_sve(Object *obj, Visitor *v, const char *name,
-                            void *opaque, Error **errp)
+static void cpu_arm_set_sve(Object *obj, bool value, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
-    bool value;
     uint64_t t;
 
-    if (!visit_type_bool(v, name, &value, errp)) {
-        return;
-    }
-
     if (value && kvm_enabled() && !kvm_arm_sve_supported()) {
         error_setg(errp, "'sve' feature not supported by KVM on this host");
         return;
@@ -563,8 +560,7 @@ void aarch64_add_sve_properties(Object *obj)
 {
     uint32_t vq;
 
-    object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
-                        cpu_arm_set_sve, NULL, NULL);
+    object_property_add_bool(obj, "sve", cpu_arm_get_sve, cpu_arm_set_sve);
 
     for (vq = 1; vq <= ARM_MAX_VQ; ++vq) {
         char name[8];
-- 
2.25.1


