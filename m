Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DEDC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:05:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E783721532
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QtqWXwkH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E783721532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfFU-00053E-4U
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDf-0002q1-Og
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:39 -0400
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:41385)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDd-0008Rp-0R
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:39 -0400
Received: by mail-qv1-xf42.google.com with SMTP id er17so1755317qvb.8
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=38XOeCAg8eirTLUPmY4XSVCYcrFE+9q7Dk1aEtr2HSc=;
 b=QtqWXwkH/gGVezhhKpEW7oEkU6PGrLgNCGeRarDoft3Nbw73bQO9gWAlCHjQ+tnSjA
 gGEElf8eJJuOkr8OBu+CYGdCWGpmcXKHZ38H6o5bCRwVcoguXDME9xVmDK83DIodCZo/
 LF2uHOF2Dfkqs18U9flgZVn36PuvcEV01wNFSb7E5kdN7QRg6QmH35K1NB2hfqClGP7p
 0rdGigepcWmzigRNdNFz8SjNz8+xQsdCV96rf7yfr3BFRVDFx5i/yj27gtIGVzGqE/+n
 rMWG4T6+OA87VReCwXhhn19Wtkh0szfEOjH3DRH2OirA6etWTxzq7H/U5NLbmUfJ/VBA
 q/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=38XOeCAg8eirTLUPmY4XSVCYcrFE+9q7Dk1aEtr2HSc=;
 b=f9ILX8p+mTeRd+IwEcqfKKjW7Nymmvus3o2B3QRykG8YzP0qJbRIDu8Id7EL8GLqtw
 GNanjWra8xBygxqOysw0HD8U7iKzVsmzfvtg48Kc/9drmANwgw+H3XoK9LhAo2sudwGk
 NxA39C3FugkC3zlI+dbkyuKM20a+1VOuKMk2ximSZc7yFD1cP4223B4TezhYsjyTN8q4
 EjK7di8UWMoEB//jdvS5gMr1BXFXkXcWiwPYeJsVqSfgru5qqlGsASp1UXYnr02UtHBH
 IZIUpBPpWahmcY1zdbfvtGlsZ7nhXqPU+0og4onIAWlqnXKnIBBugEc82QaPfTbANUvS
 btEg==
X-Gm-Message-State: AOAM5307tvVwUYbl3GcXtX+UQnZM9zF54KONGlQcWnUP9xDl0PDnkzG+
 wB9dKG/EYLQUazBJ4scmgW2p4Od3WlwARA==
X-Google-Smtp-Source: ABdhPJwZlIMrHZxJo0qhbmrYDlw/V3NmWSFzOk8LXyu3rGbQDG9YxOSMZq8xcQQT0k58bAYW1IV7dg==
X-Received: by 2002:ad4:590d:: with SMTP id ez13mr555335qvb.177.1592427815933; 
 Wed, 17 Jun 2020 14:03:35 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:03:35 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 14/73] cpu: define cpu_halted helpers
Date: Wed, 17 Jun 2020 17:01:32 -0400
Message-Id: <20200617210231.4393-15-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f42;
 envelope-from=robert.foley@linaro.org; helo=mail-qv1-xf42.google.com
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
Cc: robert.foley@linaro.org, cota@braap.org, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Eduardo Habkost <ehabkost@redhat.com>
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
index 9d25fc25a2..92069ebc59 100644
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


