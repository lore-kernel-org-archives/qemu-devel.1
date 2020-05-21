Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9772AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C6C020738
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bqhwUvOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C6C020738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboS7-0006Q9-K1
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIC-0002Gi-Ty
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:36 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:39752)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIC-0006Wn-0k
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:36 -0400
Received: by mail-qt1-x843.google.com with SMTP id l1so5985664qtp.6
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rcwZxV+jbsWTot43K/gufTjtZF8DW6GVBS8lNVigpbk=;
 b=bqhwUvOV7Cjtw6ugFb1N9dZ3EEjo9o0GTnmP6QidOuapa+BcmL0DCnJum9f52oz0KE
 BtFyPAlzdcHhALmFS7nKSn+QDnSgyR2JaFXqZvT0vcaFG1CaX8Tn1p/Wramu71uVZmKg
 l3/nRgjkfyVnkob08USuJMQt+JOHCN8n7g5EWTLIAcntCsTSjyCfkag99oeS45cIZDnm
 XJI2X2s6z8iu8bcEW9o6C1pz4qnOOqmQq0rHA/U2bbI3Z+VZCRjyIL7AO6KYV+t+ZWH+
 qgsJ6MZQCNszVrK6LJyRsJV2Z2gWRcBP5wcG9myL7kAJ/PEQvkOwbSzMsYx1//XW1JI/
 89Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rcwZxV+jbsWTot43K/gufTjtZF8DW6GVBS8lNVigpbk=;
 b=WTVTYqTC8BpIo/mz/mhlhg19dpW9vmaGst7gIG6CtG7e/S+yYPsmsI81ndBMT1pCE6
 9FMh/E/jPtr0/mfBcH3ys68QrYBhfqTAcrHBo++uvg6Gv6qboOTDEbchz0qgOjCIMb1/
 dBy6qNcIQ7whjBBLydX4mmJBV9apbVXBDt8z52SGSkvfC0UJzeJExIX+b1NscDwmoHmq
 W/hDZVb23F64pr302LkwhGNF6Pk6d1Ou7zmohpVfCt4LVUoebFTmrytnwKMQBDdJ29Tk
 rptR7cKx8L3d3Cj+XllIZrt3ypftbcCrPS3QuaheknmzypIzX8YdaAjdpBa9HAk55K7z
 H+Fg==
X-Gm-Message-State: AOAM533IftXldpUPZihygMcf4yG/VFdzVqoH/zjcIlMLHqY5RSCJU0ug
 WpN6d4jL34gjdlB+E/VA/4oJdsIDcfgtHw==
X-Google-Smtp-Source: ABdhPJw4GgFWIIizQ2ErtYhhqh+n5Ms/82xZ1xNnRzzyy9sBkzmF3x9/oGKDeh+ciVfwbH6l1yqDbw==
X-Received: by 2002:aed:3047:: with SMTP id 65mr7301769qte.277.1590079414862; 
 Thu, 21 May 2020 09:43:34 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:43:34 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 15/74] cpu: define cpu_halted helpers
Date: Thu, 21 May 2020 12:39:12 -0400
Message-Id: <20200521164011.638-16-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::843;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x843.google.com
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
Cc: richard.henderson@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

cpu->halted will soon be protected by cpu->lock.
We will use these helpers to ease the transition,
since right now cpu->halted has many direct callers.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 include/hw/core/cpu.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 2959ed1b49..820c5b0a9a 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -498,6 +498,30 @@ void cpu_mutex_destroy(CPUState *cpu);
  */
 bool no_cpu_mutex_locked(void);
 
+static inline uint32_t cpu_halted(CPUState *cpu)
+{
+    uint32_t ret;
+
+    if (cpu_mutex_locked(cpu)) {
+        return cpu->halted;
+    }
+    cpu_mutex_lock(cpu);
+    ret = cpu->halted;
+    cpu_mutex_unlock(cpu);
+    return ret;
+}
+
+static inline void cpu_halted_set(CPUState *cpu, uint32_t val)
+{
+    if (cpu_mutex_locked(cpu)) {
+        cpu->halted = val;
+        return;
+    }
+    cpu_mutex_lock(cpu);
+    cpu->halted = val;
+    cpu_mutex_unlock(cpu);
+}
+
 static inline void cpu_tb_jmp_cache_clear(CPUState *cpu)
 {
     unsigned int i;
-- 
2.17.1


