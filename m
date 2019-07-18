Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953F7C76186
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 03:43:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 615AA2077C
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 03:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HF3QKDCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615AA2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnxKO-0001uK-3v
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 23:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40195)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hnxJb-00078f-L8
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 23:42:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hnxJa-0007Qr-Fv
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 23:42:43 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:41089)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hnxJY-0007Mk-3q; Wed, 17 Jul 2019 23:42:40 -0400
Received: by mail-pg1-x541.google.com with SMTP id x15so1841527pgg.8;
 Wed, 17 Jul 2019 20:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PDlLMZstZVKdiOJqMedz4Ol5SqFOrr0PZJpTHrA1bAg=;
 b=HF3QKDCHfUvlX5NcYvzIOQ1fZ5BbRh1NajFoQg02VMsMofy7ROIOF9Q6Xmwguc45+3
 thxnA9fRmWCgOuL/MIGZcokqA7aESi2egWXdV6bIGfxDZlM1Lc3AztS0tIwAOjuqk21r
 r0yC1m8VySmGJoBNDwh3NSRbl1fUnKIydUIL1tL8Pz6i6Bx2AzSbOtg8XvRkE+ItrsrG
 g31Ef6ArNXbZAx6bKjr1acwnQqo7dzQL2qxixOTTHsU0gWiluJHQXvw9djroqP1uhPKe
 ruLW7IVPUrRhSi/sSiJ1tK9C8RNMpOpZt9zWAEGwZBLml8YQT6fUOQVyZMyM88j1p+Bv
 dkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PDlLMZstZVKdiOJqMedz4Ol5SqFOrr0PZJpTHrA1bAg=;
 b=Gko3q4idlRnDV4rNitoPe2i2sa7c+r31gYqSgrKZOx1dUkhte1xRF+xcUeF1qkNw7Q
 vaZo4/VnRJ3N8K+JvN0OxiEb5CSBHLoMskU+LZw6uUfDSpHpxmV711D8EMoqhr+0cyHG
 TgxygxvP/EQ/IjhxGxJKniUE5Ncbg/TgpXXPga7N3lOU5CMT+5yhUsBlLy9VQ4zfm+va
 PwJsBzABfi9eb8G+zmbG3T4l3pthc13QaLon2iPGc9XOuqt7tQQIgRV2Gn7+zuBtFPoK
 EAgeBj5jEN0iZJEbxMI7jCD3ZjpQ5H0tInZ6oLaS4PjItepZR+id+TpRmmp72wloF96Q
 r2Mg==
X-Gm-Message-State: APjAAAWuzx4nc0YAWOsVX5Ksa0zyLBQk6q9MBo9l/H5T8EusbyRqYOkv
 mBuGWYX3+Gynw5SapeFKGWA=
X-Google-Smtp-Source: APXvYqwMYFGakmieXPW9TN782wz1g/0sv8BjAYBRSUBlusi9/MUvQrv7grIkxZU1ELSlDcycmHy6YQ==
X-Received: by 2002:a63:101b:: with SMTP id f27mr43571084pgl.291.1563421358980; 
 Wed, 17 Jul 2019 20:42:38 -0700 (PDT)
Received: from bobo.local0.net ([203.220.8.141])
 by smtp.gmail.com with ESMTPSA id b3sm38787612pfp.65.2019.07.17.20.42.35
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 20:42:38 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 18 Jul 2019 13:42:13 +1000
Message-Id: <20190718034214.14948-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190718034214.14948-1-npiggin@gmail.com>
References: <20190718034214.14948-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v6 3/4] spapr: Implement H_CONFER
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
Cc: Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This does not do directed yielding and is not quite as strict as PAPR
specifies in terms of precise dispatch behaviour. This generally will
mean suboptimal performance, rather than guest misbehaviour. Linux
does not rely on exact dispatch behaviour.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Changes since v5:
- Cleanups

Changes since v4:
- Style, added justification comments, spelling.
- Fixed trying to dereference spapr_cpu for a -1 target.

 hw/ppc/spapr_hcall.c | 67 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 098b3dda22..7c659dc75c 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1069,6 +1069,72 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return H_SUCCESS;
 }
 
+static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           target_ulong opcode, target_ulong *args)
+{
+    target_long target = args[0];
+    uint32_t dispatch = args[1];
+    CPUState *cs = CPU(cpu);
+    SpaprCpuState *spapr_cpu;
+
+    /*
+     * -1 means confer to all other CPUs without dispatch counter check,
+     *  otherwise it's a targeted confer.
+     */
+    if (target != -1) {
+        PowerPCCPU *target_cpu = spapr_find_cpu(target);
+        uint32_t target_dispatch;
+
+        if (!target_cpu) {
+            return H_PARAMETER;
+        }
+
+        spapr_cpu = spapr_cpu_state(target_cpu);
+
+        /*
+         * target == self is a special case, we wait until prodded, without
+         * dispatch counter check.
+         */
+        if (cpu == target_cpu) {
+            if (spapr_cpu->prod) {
+                spapr_cpu->prod = false;
+
+                return H_SUCCESS;
+            }
+
+            cs->halted = 1;
+            cs->exception_index = EXCP_HALTED;
+            cs->exit_request = 1;
+
+            return H_SUCCESS;
+        }
+
+        if (!spapr_cpu->vpa_addr || ((dispatch & 1) == 0)) {
+            return H_SUCCESS;
+        }
+
+        target_dispatch = ldl_be_phys(cs->as,
+                                  spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER);
+        if (target_dispatch != dispatch) {
+            return H_SUCCESS;
+        }
+
+        /*
+         * The targeted confer does not do anything special beyond yielding
+         * the current vCPU, but even this should be better than nothing.
+         * At least for single-threaded tcg, it gives the target a chance to
+         * run before we run again. Multi-threaded tcg does not really do
+         * anything with EXCP_YIELD yet.
+         */
+    }
+
+    cs->exception_index = EXCP_YIELD;
+    cs->exit_request = 1;
+    cpu_loop_exit(cs);
+
+    return H_SUCCESS;
+}
+
 static target_ulong h_prod(PowerPCCPU *cpu, SpaprMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
@@ -1912,6 +1978,7 @@ static void hypercall_register_types(void)
     /* hcall-splpar */
     spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
     spapr_register_hypercall(H_CEDE, h_cede);
+    spapr_register_hypercall(H_CONFER, h_confer);
     spapr_register_hypercall(H_PROD, h_prod);
 
     spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
-- 
2.20.1


