Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B492C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 02:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D6342084E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 02:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhpeazKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6342084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54236 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he9C8-0000up-Bf
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 22:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41340)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8a7-0006gg-9y
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:43:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8a3-0006ea-9S
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:43:11 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55714)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1he8a2-0006RK-Mw
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:43:06 -0400
Received: by mail-wm1-x344.google.com with SMTP id a15so4783910wmj.5
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 18:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9dmj/U5AqjA5GQ9gcpPTO1P5uO7lsSOgQoq/OntyvQ4=;
 b=UhpeazKfzrv0Oo30MZ+UlRD5RxP0q3utR4XmGArav6zQ76aAETorp1TMOE1Badz9C/
 9H8U9Ozp1FZTxo3mkD3k1KdQv9LIhs2DBasxxTUlVNoKmORFti5WadUIFKVnhNWeztPR
 lwgCifWn2ZfmfLvclOthzocrEBdurIggoN/GVWm+nY5DE//MuSft3l5EDzJcC04q1A9j
 RMu5tWlQklqghTxOvwV9iRU5i+c3sqFf9jbopc0ZzRkhUUoGuO3RdJX9Y06Fy7E+qZdt
 NIjPiufPTldkY1ZwvakftJNZ6vpBLUpI5IudBs5qWy0NTwBkVK9s9tJIt+N99Wb9bAT7
 YX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=9dmj/U5AqjA5GQ9gcpPTO1P5uO7lsSOgQoq/OntyvQ4=;
 b=QR+UiAOyTWrUchUb5RUnVT7B42UZQ3OhSVz1VUL/sxXCgAWHVVqtmZ8BuI/AVQQb/Y
 j1D3ST8XFQv9c/nMMWC7uBkHWYDO61tLyz9hTvvIoUhFatMhssRY1GFbvE+VGDApAduO
 8cXgCfnBNRpveMcz4vohRjtirjY6r5SLMiQeuWr/VCrkjDbpK4izy7RjoapWak5wLN9n
 jkQm2FLf9B2WPKriNt3azn0sSPR40fulMveQgtLH0qraNAM8/Rq4FIGN1euCHCnnh4e8
 NDOHGRfcYRa59H6EqeCmTG/TrCplv4yPsehvy43tL9GscI2Nm2X2gX9ytBgjD7y0CAj/
 xi4w==
X-Gm-Message-State: APjAAAUqZaCKrwiASh1z9P0TJxSXJaSkPgIFdfw5c0+nifxl1yQvjpiU
 AlEn8AyXexPyAnwmwCziq2cSO0mH
X-Google-Smtp-Source: APXvYqyEkiUKM71dbd5hrobmZ0DZgqUqg9/6QlFhLQ7NvCsol24y7hY6hAvkj7Mt9qC1yoG9ZAkNPg==
X-Received: by 2002:a05:600c:389:: with SMTP id
 w9mr1423182wmd.139.1561081377719; 
 Thu, 20 Jun 2019 18:42:57 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id d1sm1123125wru.41.2019.06.20.18.42.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 18:42:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 03:42:30 +0200
Message-Id: <1561081350-3723-26-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
References: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PULL 25/25] hw: Nuke hw_compat_4_0_1 and
 pc_compat_4_0_1
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
Cc: Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Commit c87759ce876a fixed a regression affecting pc-q35 machines by
introducing a new pc-q35-4.0.1 machine version to be used instead
of pc-q35-4.0. The only purpose was to revert the default behaviour
of not using split irqchip, but the change also introduced the usual
hw_compat and pc_compat bits, and wired them for pc-q35 only.

This raises questions when it comes to add new compat properties for
4.0* machine versions of any architecture. Where to add them ? In
4.0, 4.0.1 or both ? Error prone. Another possibility would be to teach
all other architectures about 4.0.1. This solution isn't satisfying,
especially since this is a pc-q35 specific issue.

It turns out that the split irqchip default is handled in the machine
option function and doesn't involve compat lists at all.

Drop all the 4.0.1 compat lists and use the 4.0 ones instead in the 4.0.1
machine option function.

Move the compat props that were added to the 4.0.1 since c87759ce876a to
4.0.

Even if only hw_compat_4_0_1 had an impact on other architectures,
drop pc_compat_4_0_1 as well for consistency.

Fixes: c87759ce876a "q35: Revert to kernel irqchip"
Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <156051774276.244890.8660277280145466396.stgit@bahia.lan>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/machine.c    |  5 +----
 hw/i386/pc.c         |  3 ---
 hw/i386/pc_q35.c     | 12 ++++++++----
 include/hw/boards.h  |  3 ---
 include/hw/i386/pc.h |  3 ---
 5 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 84ebb8d..ea5a01a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -24,16 +24,13 @@
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
 
-GlobalProperty hw_compat_4_0_1[] = {
+GlobalProperty hw_compat_4_0[] = {
     { "VGA",            "edid", "false" },
     { "secondary-vga",  "edid", "false" },
     { "bochs-display",  "edid", "false" },
     { "virtio-vga",     "edid", "false" },
     { "virtio-gpu-pci", "edid", "false" },
 };
-const size_t hw_compat_4_0_1_len = G_N_ELEMENTS(hw_compat_4_0_1);
-
-GlobalProperty hw_compat_4_0[] = {};
 const size_t hw_compat_4_0_len = G_N_ELEMENTS(hw_compat_4_0);
 
 GlobalProperty hw_compat_3_1[] = {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e41192b..e96360b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -111,9 +111,6 @@ struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
 /* Physical Address of PVH entry point read from kernel ELF NOTE */
 static size_t pvh_start_addr;
 
-GlobalProperty pc_compat_4_0_1[] = {};
-const size_t pc_compat_4_0_1_len = G_N_ELEMENTS(pc_compat_4_0_1);
-
 GlobalProperty pc_compat_4_0[] = {};
 const size_t pc_compat_4_0_len = G_N_ELEMENTS(pc_compat_4_0);
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index dcddc64..57232ae 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -378,8 +378,13 @@ static void pc_q35_4_0_1_machine_options(MachineClass *m)
 {
     pc_q35_4_1_machine_options(m);
     m->alias = NULL;
-    compat_props_add(m->compat_props, hw_compat_4_0_1, hw_compat_4_0_1_len);
-    compat_props_add(m->compat_props, pc_compat_4_0_1, pc_compat_4_0_1_len);
+    /*
+     * This is the default machine for the 4.0-stable branch. It is basically
+     * a 4.0 that doesn't use split irqchip by default. It MUST hence apply the
+     * 4.0 compat props.
+     */
+    compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
+    compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
 }
 
 DEFINE_Q35_MACHINE(v4_0_1, "pc-q35-4.0.1", NULL,
@@ -390,8 +395,7 @@ static void pc_q35_4_0_machine_options(MachineClass *m)
     pc_q35_4_0_1_machine_options(m);
     m->default_kernel_irqchip_split = true;
     m->alias = NULL;
-    compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
-    compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
+    /* Compat props are applied by the 4.0.1 machine */
 }
 
 DEFINE_Q35_MACHINE(v4_0, "pc-q35-4.0", NULL,
diff --git a/include/hw/boards.h b/include/hw/boards.h
index b7362af..eaa050a 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -293,9 +293,6 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
 
-extern GlobalProperty hw_compat_4_0_1[];
-extern const size_t hw_compat_4_0_1_len;
-
 extern GlobalProperty hw_compat_4_0[];
 extern const size_t hw_compat_4_0_len;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index a7d0b87..c54cc54 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -293,9 +293,6 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
 int e820_get_num_entries(void);
 bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
-extern GlobalProperty pc_compat_4_0_1[];
-extern const size_t pc_compat_4_0_1_len;
-
 extern GlobalProperty pc_compat_4_0[];
 extern const size_t pc_compat_4_0_len;
 
-- 
1.8.3.1


