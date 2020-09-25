Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676A4C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:35:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C77AB208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7pVWsiO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77AB208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLjCj-0007Ad-Po
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 04:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kele.hwang@gmail.com>)
 id 1kLjAf-00052B-EB
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 04:33:37 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:35522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kele.hwang@gmail.com>)
 id 1kLjAd-0002yN-Fc
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 04:33:37 -0400
Received: by mail-pg1-x533.google.com with SMTP id g29so1942753pgl.2
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 01:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=gjXR+j7GzNNm+6zWdWvO4+YL6Cz7kiHndSAXyUow//k=;
 b=H7pVWsiOrn7GWoJBnJR6yOgysdiq1bycmHGPKsOvlEJzzcDfdx+fOCjX+HsRPykCz9
 sz3AqZZhyrP4yQi+zRHhIZGuY9oz9vC7aOAfjf79z51QS7bch4VH3pzmtq14dyCTK+70
 f/u1mX2p12R/dZfojTx/9R6KMxXRURmTmmDmarkQ7dmUTKrpvHxi032B1ApEfj//opfj
 UO08IerZ7xf+AZ3UkiCtolOjbwevKyWpWwUhn8VbPu9J1VifBRbDvOzdzC2Afs8JQFsd
 nxjEmlgZ6sDEhODPWqKvD6TMr5jEvMdkDO0bFly1AeLAJ89iGi7KboFEx/HWW48IfuQL
 1Hbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=gjXR+j7GzNNm+6zWdWvO4+YL6Cz7kiHndSAXyUow//k=;
 b=UfG4WaN5MMwNAmacDktSocVpGMaVLPcAeVgCO3GEQrMFaA1r73pVcWln8VsxR7JZDc
 gJpa/hxyVDXiTYEiuON1xFb6cUUuvlyMWg0vMo0jUzQ96An6ppzxtcSQT68HoVmC88zs
 +0LtVCFiGGyAw+tG86PqQxV2lSTdObrHd+r/K6t9zXlrCXtCzPYXKNLv0XXrd2AU4mEC
 sNjd9W/tilmqtORZVH46nyqDuIoExToVOhJs2MoZBkdTrO4KvFgkx3yFduSnZ25HPu45
 favLFHDOpBUDOLiO/10IVCjLKR7IwNpdzvEWb6cPGPizOhoMgOoBWe+/C+9G+oLrBdCc
 xgjA==
X-Gm-Message-State: AOAM531yfaMKzV/9wVfi6TFp27zV+SyN1sX0RzNL7l+dhVLKjvbOgTv9
 msnoTQ49C8fJ7kEoGWff3DpI5uAK3O1Dkg==
X-Google-Smtp-Source: ABdhPJwFUbTkv0QO0iPtJCW0CKpEdXFD9SsuLpQRo0OZrA/deK6toEUTYM1zSTjV63/8bFLo8FK/tw==
X-Received: by 2002:a63:1657:: with SMTP id 23mr2724793pgw.168.1601022813499; 
 Fri, 25 Sep 2020 01:33:33 -0700 (PDT)
Received: from carbon.loongson.cn ([40.83.95.77])
 by smtp.gmail.com with ESMTPSA id h12sm1830577pfo.68.2020.09.25.01.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 01:33:32 -0700 (PDT)
From: Kele Huang <kele.hwang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/1] accel/tcg: Fix computing of is_write for MIPS
Date: Fri, 25 Sep 2020 16:33:07 +0800
Message-Id: <20200925083307.13761-1-kele.hwang@gmail.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=kele.hwang@gmail.com; helo=mail-pg1-x533.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kele Huang <kele.hwang@gmail.com>, Xu Zou <iwatchnima@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Detect all MIPS store instructions in cpu_signal_handler for all available
MIPS versions, and set is_write if encountering such store instructions.

This fixed the error while dealing with self-modified code for MIPS.

Signed-off-by: Kele Huang <kele.hwang@gmail.com>
Signed-off-by: Xu Zou <iwatchnima@gmail.com>
---
 accel/tcg/user-exec.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index bb039eb32d..c4494c93e7 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -702,6 +702,10 @@ int cpu_signal_handler(int host_signum, void *pinfo,
 
 #elif defined(__mips__)
 
+#if defined(__misp16) || defined(__mips_micromips)
+#error "Unsupported encoding"
+#endif
+
 int cpu_signal_handler(int host_signum, void *pinfo,
                        void *puc)
 {
@@ -709,9 +713,41 @@ int cpu_signal_handler(int host_signum, void *pinfo,
     ucontext_t *uc = puc;
     greg_t pc = uc->uc_mcontext.pc;
     int is_write;
+    uint32_t insn;
 
-    /* XXX: compute is_write */
+    /* Detect all store instructions at program counter. */
     is_write = 0;
+    insn = *(uint32_t *)pc;
+    switch((insn >> 26) & 077) {
+    case 050: /* SB */
+    case 051: /* SH */
+    case 052: /* SWL */
+    case 053: /* SW */
+    case 054: /* SDL */
+    case 055: /* SDR */
+    case 056: /* SWR */
+    case 070: /* SC */
+    case 071: /* SWC1 */
+    case 074: /* SCD */
+    case 075: /* SDC1 */
+    case 077: /* SD */
+#if !defined(__mips_isa_rev) || __mips_isa_rev < 6
+    case 072: /* SWC2 */
+    case 076: /* SDC2 */
+#endif
+        is_write = 1;
+        break;
+    case 023: /* COP1X */
+        /* Required in all versions of MIPS64 since 
+           MIPS64r1 and subsequent versions of MIPS32. */
+        switch (insn & 077) {
+        case 010: /* SWXC1 */
+        case 011: /* SDXC1 */
+            is_write = 1;
+        }
+        break;
+    }
+
     return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
 }
 
-- 
2.17.1


