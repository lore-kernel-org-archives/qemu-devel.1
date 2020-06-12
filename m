Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D27C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 19:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6868F20792
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 19:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d4eEGV7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6868F20792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjp6p-00017i-Nq
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 15:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjoxO-0000u4-KY
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 15:03:14 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41816)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjoxC-0006tL-Da
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 15:03:12 -0400
Received: by mail-wr1-x443.google.com with SMTP id j10so10809066wrw.8
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 12:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P8SWRQjM/hyOQzCww/NtPUfXAjDnTeW6mt1PLc5HvvU=;
 b=d4eEGV7bcMlhiVx8vuNQOsPDaXZKjqzivKKDK7+hv6LPH8PqIV23FKTzycZ0Ik9hl5
 G61VZr5zSql7sBHcFx9neOxHbWVZe2KvQ/8V4qrGYD1OCciY9TlCg7zq7L0zm9R9YyWr
 h7kPVvZiA7XJem4+QZhkfMHcK8/78oVoB+zEdgteAVje/SbIO4simACoFr4y1IzIOqg3
 Ks4RKIk1ARPFwSaAgMDbNvBcbxPY8Ybb7TnpbzlOMYDakqDKOTQidejcYN0He0tN7EIO
 gD5LQi0d+j3wgsC/de6lH1ZfomON8M+SReSETDcfiNwLU6Qqtb9SQ39Fkq+V0VElX0EF
 +iLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P8SWRQjM/hyOQzCww/NtPUfXAjDnTeW6mt1PLc5HvvU=;
 b=GUMSdLFcYPyjv84BlUUxuhm5WIqPlumngriPljUe2ztjhAd4lu6Su7hY8yKUuM8AfK
 gOmxkF+jv3iCDLSzN3TEbFhMswUgaGg5CZGDsPqhVMzrKdhjgNx/Fkr7q6rlNaz/fbZi
 KMr39hnm1GdTkt2Ks8wEOBMnRW4BmUd4UxAtqzoET1wulsmCED/bVhWgTTAytPf8HRuY
 r/8xaqehus9R0IaqHPaP4fhm4E0+mlGovqn2z+AYFW6cQ8d6NCqAVck3+sYWahH7RRmB
 F8DNyKlHdX8NwA9ql2xzSu3p3MpJuAxRcGg3x455GIUolozy2zImcoolJ5jv1LT0f19e
 +o3A==
X-Gm-Message-State: AOAM531QmHH9Otwuut5I6YW6suZBnNlQSmkzt2vyD2QUoEcS0lh4j6Dk
 bpGz5LrEqORY1nJSM55qFLK56w==
X-Google-Smtp-Source: ABdhPJx3HUHvkomFSiWJWl50PF2vdUVOgkZHWU3Yw4gJ2Ep4s1gVzxqXTvsS+UqeT4gW4N1MCIgw/w==
X-Received: by 2002:a5d:4385:: with SMTP id i5mr16069155wrq.420.1591988572195; 
 Fri, 12 Jun 2020 12:02:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s8sm11086125wrm.96.2020.06.12.12.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 12:02:46 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3B1041FF93;
 Fri, 12 Jun 2020 20:02:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 07/18] cputlb: destroy CPUTLB with tlb_destroy
Date: Fri, 12 Jun 2020 20:02:26 +0100
Message-Id: <20200612190237.30436-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200612190237.30436-1-alex.bennee@linaro.org>
References: <20200612190237.30436-1-alex.bennee@linaro.org>
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
Cc: fam@euphon.net, berrange@redhat.com, Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, aurelien@aurel32.net,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

I was after adding qemu_spin_destroy calls, but while at
it I noticed that we are leaking some memory.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200609200738.445-5-robert.foley@linaro.org>
---
 include/exec/exec-all.h |  8 ++++++++
 accel/tcg/cputlb.c      | 15 +++++++++++++++
 exec.c                  |  1 +
 3 files changed, 24 insertions(+)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 8792bea07ab..3cf88272df9 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -124,6 +124,11 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
  * @cpu: CPU whose TLB should be initialized
  */
 void tlb_init(CPUState *cpu);
+/**
+ * tlb_destroy - destroy a CPU's TLB
+ * @cpu: CPU whose TLB should be destroyed
+ */
+void tlb_destroy(CPUState *cpu);
 /**
  * tlb_flush_page:
  * @cpu: CPU whose TLB should be flushed
@@ -284,6 +289,9 @@ void tlb_set_page(CPUState *cpu, target_ulong vaddr,
 static inline void tlb_init(CPUState *cpu)
 {
 }
+static inline void tlb_destroy(CPUState *cpu)
+{
+}
 static inline void tlb_flush_page(CPUState *cpu, target_ulong addr)
 {
 }
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index eb2cf9de5e6..1e815357c70 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -270,6 +270,21 @@ void tlb_init(CPUState *cpu)
     }
 }
 
+void tlb_destroy(CPUState *cpu)
+{
+    CPUArchState *env = cpu->env_ptr;
+    int i;
+
+    qemu_spin_destroy(&env_tlb(env)->c.lock);
+    for (i = 0; i < NB_MMU_MODES; i++) {
+        CPUTLBDesc *desc = &env_tlb(env)->d[i];
+        CPUTLBDescFast *fast = &env_tlb(env)->f[i];
+
+        g_free(fast->table);
+        g_free(desc->iotlb);
+    }
+}
+
 /* flush_all_helper: run fn across all cpus
  *
  * If the wait flag is set then the src cpu's helper will be queued as
diff --git a/exec.c b/exec.c
index a0bf9d61c87..6d7c312c910 100644
--- a/exec.c
+++ b/exec.c
@@ -892,6 +892,7 @@ void cpu_exec_unrealizefn(CPUState *cpu)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
 
+    tlb_destroy(cpu);
     cpu_list_remove(cpu);
 
     if (cc->vmsd != NULL) {
-- 
2.20.1


