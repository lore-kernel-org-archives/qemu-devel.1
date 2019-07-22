Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39820C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 05:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B42621BE6
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 05:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmwsNEYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B42621BE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpQkE-0001ED-9y
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 01:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41854)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hpQjv-0008UW-3g
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 01:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hpQju-0004a6-4l
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 01:19:59 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:39394)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hpQjt-0004ZO-Vg; Mon, 22 Jul 2019 01:19:58 -0400
Received: by mail-pf1-x443.google.com with SMTP id f17so12803734pfn.6;
 Sun, 21 Jul 2019 22:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xdbP7WX22fhUZ3ihdslkK8f8fz4KZ3GwbwHPAjoISxk=;
 b=bmwsNEYXyufPHDSZhycRupI4XMS6XojW5e7Jpal8v1vRyqkQRUMdAWW+dFoWF6EliP
 nwQGiW8fxFV45x2x4NVD6kTvZs5BpMlvPLu76CXgLTYD6lX3lg1iX1XlgwFpa299y0Hg
 +RPqIoLx1Ahy6wQPoMAwC9V/Z+MPg/hu9jqCzGbJvHtRwZKQ7jS96fofqs1xbkXGLFCs
 Mbn4y52zFTva/W8I72EpITqslToFbiQkRQnv31qnjS9wT0itB3R195fQvlWMW3VPh1j3
 xGaQXQnnaelzdN1zfBO/3al9xi4/Tu1VEThTnGQnYpb9jTqZAFijT3P4kBqOoPeBE0ph
 AcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xdbP7WX22fhUZ3ihdslkK8f8fz4KZ3GwbwHPAjoISxk=;
 b=m/dYYOshP1r0QnjxCcniTp+ji/YQSzGHX7NBmJF0Q8J8Ldlwf3uiausnLEyjn2/dxK
 sIow6rPee/8Rsp8aNrFpO9aSchoQ8ZCNH13rv4khdn/nh2yJbKg0h2lthEqgJU3Celvk
 Jeip3+kPbC2vmjzRQtxVvwiuaFGaN20Zxrefo/UKwtzJIacXIxQIng95ECzrUeYKEzc/
 +GN5Tcieh41PzcGETLslr1tik1ibX04JAbQ7ZIU2C7QHxANmogO6RlfxHmuJf1tOJnqE
 s9VTY94IbZfPU04bqNWcR84STMd7XntqAC09rPNzjrTw5gCCTF+hPdz0Y/MuQxzS2f8p
 9Nkg==
X-Gm-Message-State: APjAAAUp/+v8sTCUBQ1asWLgLQi6bkxIDRFXFN8kMNEp5Monwqdc/M6J
 W3itU472wrVHcd5BVnoaKuAS3modEUw=
X-Google-Smtp-Source: APXvYqzOwLkwP0t7LZDhQOEz6UxHnCS3g4p27X39gyXI24m6TWGlZS2R71El8bBAIej09IDkhOyFDA==
X-Received: by 2002:a17:90a:f488:: with SMTP id
 bx8mr74463744pjb.91.1563772796605; 
 Sun, 21 Jul 2019 22:19:56 -0700 (PDT)
Received: from bobo.local0.net (193-116-123-212.tpgi.com.au. [193.116.123.212])
 by smtp.gmail.com with ESMTPSA id d129sm42741889pfc.168.2019.07.21.22.19.51
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 21 Jul 2019 22:19:56 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Jul 2019 15:19:35 +1000
Message-Id: <20190722051937.20454-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722051937.20454-1-npiggin@gmail.com>
References: <20190722051937.20454-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v2 1/3] machine: Add wakeup method to
 MachineClass
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
Cc: "Liu, Jinsong" <jinsong.liu@intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Luiz Capitulino <lcapitulino@redhat.com>,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
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
 vl.c                | 18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

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
index cefe5a3968..45ea034410 100644
--- a/vl.c
+++ b/vl.c
@@ -1556,6 +1556,22 @@ void qemu_system_reset(ShutdownCause reason)
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
+        qemu_system_reset(SHUTDOWN_CAUSE_NONE);
+    }
+}
+
 void qemu_system_guest_panicked(GuestPanicInformation *info)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "Guest crashed");
@@ -1764,7 +1780,7 @@ static bool main_loop_should_exit(void)
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


