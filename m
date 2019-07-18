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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C1EC76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 10:40:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B82A217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 10:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="du2EdGeB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B82A217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho3qC-0004kE-Ak
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 06:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34875)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1ho3pr-0003eq-Uj
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:40:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1ho3pq-0000gf-Ro
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:40:27 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:33753)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1ho3po-0000dO-A1; Thu, 18 Jul 2019 06:40:24 -0400
Received: by mail-pf1-x42d.google.com with SMTP id g2so12443849pfq.0;
 Thu, 18 Jul 2019 03:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jeDfu5EycFvl9XFUWjClydY4i9PbIdp0Dl2n2igY378=;
 b=du2EdGeBkny+IfgWNzwqYqHutMf9z9h/WVcIjUyH/Mp5Jfz0L68EkTg86Us7OcSlRY
 +VpfdyTK7tagjno46JRE7+xxNQ6O8NcQeJDs1mDiDFGuixAzqlNq+ttlDaQkmg/uJOfD
 1tbTSsXPowJkoexkZCpnGOEvTPf9GOe6uOVxZUVU2wMUBS17SDocB7vbqtQioWAUhK4Z
 QXCZ7wzMnHZg3mHnRFQkLONMOoO/VSFPKsXW2vwUooAk/R48LJY+8zK8KXc+FYjhmKeV
 HjU7jE97aB8vYbMFfflPLL7kcarvrE63jH0n0Y37PUEIo1Z0UZ/C4YE4sDR+P9RMOO70
 yFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jeDfu5EycFvl9XFUWjClydY4i9PbIdp0Dl2n2igY378=;
 b=sv+gmoA98uDcdK5kopPddBFn7M4JFQe85gx5GtrGXvrWxOnZVg7BCPA2g4L+vPVJLe
 p/0GDumgfPhhjG5doY8b3XVc4MeRBhJzDOzL1eDCQEtHq21KOz2nBfiZhQiGBRwcRewr
 Z6HFbAWR2n4miE39bIOWCwWcVubGnZ9I+rV2zW/oHIfBi7XbKkaXPBptP9keQw6lpWQV
 H9tWk2uqiitrJQGMfapQBINatzKzZvGk5A2FPuxXuEwrp57qN6eXPT4615TsPz3SpQA9
 6012Yk+otOq3K1r41jbIcdt7lxPoXcSaJjQe4hISLhLiN1a+AmCAc/iQVd4rGr10Tfzr
 ky8g==
X-Gm-Message-State: APjAAAUEkujgPSCzb+P6dRPlqrcZxnAbYqbgWocR+carVAsBUkkJByC1
 KPjdDu81U7RVhj95jFTEqFimighY
X-Google-Smtp-Source: APXvYqwUtt17A6CS7/mLYliXRZawQAJ8FObcwBEz14TJr7/wbkmsQhHg1IETvyNszfUtMR6I/spdYw==
X-Received: by 2002:a63:9e43:: with SMTP id r3mr21865071pgo.148.1563446423094; 
 Thu, 18 Jul 2019 03:40:23 -0700 (PDT)
Received: from bobo.local0.net (61-68-63-89.tpgi.com.au. [61.68.63.89])
 by smtp.gmail.com with ESMTPSA id y10sm28243415pfm.66.2019.07.18.03.40.17
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 18 Jul 2019 03:40:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu, 18 Jul 2019 20:39:50 +1000
Message-Id: <20190718103951.10027-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190718103951.10027-1-npiggin@gmail.com>
References: <20190718103951.10027-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42d
Subject: [Qemu-devel] [PATCH 2/3] machine: Add wakeup method to MachineClass
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Luiz Capitulino <lcapitulino@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Waking from suspend is not logically a machine reset on all machines,
particularly in the paravirtualized case rather than hardware
emulated. The ppc spapr machine for example just invokes hypervisor
to suspend, and expects that call to return with the machine in the
same state (modulo some possible migration and reconfiguration
details).

Implement a machine ->wakeup method and use that if it exists.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/boards.h |  1 +
 vl.c                | 29 ++++++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index a71d1a53a5..915ac3352b 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -180,6 +180,7 @@ struct MachineClass {
 
     void (*init)(MachineState *state);
     void (*reset)(MachineState *state);
+    void (*wakeup)(MachineState *state);
     void (*hot_add_cpu)(MachineState *state, const int64_t id, Error **errp);
     int (*kvm_type)(MachineState *machine, const char *arg);
     void (*smp_parse)(MachineState *ms, QemuOpts *opts);
diff --git a/vl.c b/vl.c
index ef3c7ab8b8..b9e9943458 100644
--- a/vl.c
+++ b/vl.c
@@ -1556,6 +1556,33 @@ void qemu_system_reset(ShutdownCause reason)
     cpu_synchronize_all_post_reset();
 }
 
+/*
+ * Wake the VM after suspend.
+ */
+static void qemu_system_wakeup(void)
+{
+    MachineClass *mc;
+
+    mc = current_machine ? MACHINE_GET_CLASS(current_machine) : NULL;
+
+    if (mc && mc->wakeup) {
+        mc->wakeup(current_machine);
+    } else {
+        /*
+         * Fall back to old reset wakeup method. Platforms supporting
+         * wakeup should be converted over to use ->wakeup and this
+         * fallback code removed.
+         */
+        cpu_synchronize_all_states();
+        if (mc && mc->reset) {
+            mc->reset(current_machine);
+        } else {
+            qemu_devices_reset();
+        }
+        cpu_synchronize_all_post_reset();
+    }
+}
+
 void qemu_system_guest_panicked(GuestPanicInformation *info)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "Guest crashed");
@@ -1764,7 +1791,7 @@ static bool main_loop_should_exit(void)
     }
     if (qemu_wakeup_requested()) {
         pause_all_vcpus();
-        qemu_system_reset(SHUTDOWN_CAUSE_NONE);
+        qemu_system_wakeup();
         notifier_list_notify(&wakeup_notifiers, &wakeup_reason);
         wakeup_reason = QEMU_WAKEUP_REASON_NONE;
         resume_all_vcpus();
-- 
2.20.1


