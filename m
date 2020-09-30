Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D614DC47426
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:08:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496EF2074A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="dgiZWHYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496EF2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZ1w-0006Xb-AW
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kNYyj-0003Bb-Ag
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:04:53 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44208)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kNYyf-0005Cn-Te
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:04:51 -0400
Received: by mail-pl1-x642.google.com with SMTP id j7so735528plk.11
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 03:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qkISPEvs2HSa1jdrSv5pc1AMksIAz5SfeO1sHOXjAF0=;
 b=dgiZWHYfH5Wa0+J5rsouL75Ha+UUEweanMxD4/8AenU67hSnUZ6B48yYLpen9twyM3
 WhYiZjkemGPqj/AVWSXDawXJ1f5ps2JNkppwMHlGPxatifDXmaXA27hi5IRAQFsnQjhm
 AIJrzymeF6BRGF+o3LO0QpOtdlCI+xQIrsmym7lJSOehho1I9IpDU9T6iEGZM1PmdKsV
 oT8YkdKDPrm/oetIxvzIv4hY+XVEX7gphXebgKQtPb1lUcPbRoroc7O7n3SpkCC1IRYk
 9mnk9CISOHsETod50aiAEYkzuuR/snzgcramVpJNMb+Dc/Bk58BKFjXOXLRRtf7YwmMR
 wc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qkISPEvs2HSa1jdrSv5pc1AMksIAz5SfeO1sHOXjAF0=;
 b=OshJKK/Jho78oiw7INehZ4forYpWiuAxvLEQDUxogXQbSWTz3kPAPaXxEPxlh56ih9
 BPNn2Jp44lDJrRm1lYkDMnvsQfXKZsqCRFdvOPA59akD8hr3IbPITnSbU5AV0aMIqhRK
 6bsHwaC3ZVudhh5PIe+APpqc3vZNhrDWAsNf8yYk0NAjNZSAVFokhdERArFy1upi+oy6
 9UVIGq08juX9jEaz2cyiM2KuNOSdOyMOe8PqPxs/rz5i/ZxchALZu555QiimwmcjpjA/
 J08EuMXlVqv5qG5Q8jxitkyapZZyi3g4h50vmZxQr7gvCqVXhXXpETN3tPRsbq57oV/T
 /9/A==
X-Gm-Message-State: AOAM530qfiQczXm4pwL7OpAhIYoTRMp3kFWdayczcSBm9cv5fP39OiS3
 /3p/TP5cjkfk9RZ659gZEpu6JA==
X-Google-Smtp-Source: ABdhPJxFjGJkaaLHaFpSoKkaYz/e5Rdh8dA9LeyVmXYAbzJM8hE2XRFkuetcfIh/hvNM+aDiTrRfFA==
X-Received: by 2002:a17:90a:2dcd:: with SMTP id
 q13mr1799447pjm.202.1601460288737; 
 Wed, 30 Sep 2020 03:04:48 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
 by smtp.gmail.com with ESMTPSA id c185sm1884230pfb.123.2020.09.30.03.04.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Sep 2020 03:04:48 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: pbonzini@redhat.com,
	peter.maydell@linaro.org
Subject: [PATCH v3 1/3] target-i386: seperate MCIP & MCE_MASK error reason
Date: Wed, 30 Sep 2020 18:04:38 +0800
Message-Id: <20200930100440.1060708-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200930100440.1060708-1-pizhenwei@bytedance.com>
References: <20200930100440.1060708-1-pizhenwei@bytedance.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org, zhenwei pi <pizhenwei@bytedance.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Previously we can only get a simple string "Triple fault" in qemu
log. Add detailed message for the two reasons to describe why qemu
has to reset the guest.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 target/i386/helper.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index 70be53e2c3..17e1684ff9 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -857,6 +857,8 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *cenv = &cpu->env;
     uint64_t *banks = cenv->mce_banks + 4 * params->bank;
+    g_autofree char *msg = NULL;
+    bool need_reset = false;
 
     cpu_synchronize_state(cs);
 
@@ -894,16 +896,25 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
             return;
         }
 
-        if ((cenv->mcg_status & MCG_STATUS_MCIP) ||
-            !(cenv->cr[4] & CR4_MCE_MASK)) {
-            monitor_printf(params->mon,
-                           "CPU %d: Previous MCE still in progress, raising"
-                           " triple fault\n",
-                           cs->cpu_index);
-            qemu_log_mask(CPU_LOG_RESET, "Triple fault\n");
+        if (cenv->mcg_status & MCG_STATUS_MCIP) {
+            need_reset = true;
+            msg = g_strdup_printf("CPU %d: Previous MCE still in progress, "
+                                  "raising triple fault", cs->cpu_index);
+        }
+
+        if (!(cenv->cr[4] & CR4_MCE_MASK)) {
+            need_reset = true;
+            msg = g_strdup_printf("CPU %d: MCE capability is not enabled, "
+                                  "raising triple fault", cs->cpu_index);
+        }
+
+        if (need_reset) {
+            monitor_printf(params->mon, "%s", msg);
+            qemu_log_mask(CPU_LOG_RESET, "%s\n", msg);
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             return;
         }
+
         if (banks[1] & MCI_STATUS_VAL) {
             params->status |= MCI_STATUS_OVER;
         }
-- 
2.11.0


