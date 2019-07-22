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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609F1C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 06:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE3C21994
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 06:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pk0VkWfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE3C21994
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpReN-0002HC-5E
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 02:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60052)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hpReC-0001n1-AJ
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 02:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hpReB-0005n3-8H
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 02:18:08 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41867)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hpReB-0005kb-0f; Mon, 22 Jul 2019 02:18:07 -0400
Received: by mail-pf1-x441.google.com with SMTP id m30so16871175pff.8;
 Sun, 21 Jul 2019 23:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SJd93XpdISMW18aM06Y+SOnvlqtv9MUrBx1dK3qol/w=;
 b=Pk0VkWfMP7NeN+QV4StQ2R78F7cn7faxdKYOih+U1JKAWYan7XXta113dccwaQbazu
 jOMxJ66LpdfMQ1RTgJ2GuKeys8en0Dl2W3YeR5RpWae5UmXNwyIJQG8JBha4rwHQEMrI
 qCK+jdzIeCtzfJWJ2drcHM7/p44z1y25oy9YGxEANO4GdlokftUP7c2tJDQacQO2MJs5
 MfWCBuHaS3LtqUUoYTK4xumi39It6JwDY633NmgSSr/tdkRt2gUnT0X/fCcZs0bafzx9
 HzaRq360P/smeo3N9ZLMFWRFfGqm7MDNQVnMf7U569ztyjhPbEVk1ynu109kc1Ck9zgu
 +XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SJd93XpdISMW18aM06Y+SOnvlqtv9MUrBx1dK3qol/w=;
 b=Rhpssk8fAEGOHAZnMf2WDgU3Ckt11gNODb+v87rTNraoIZZJeGmpiNPPVsIgr45C0n
 9hfRKkWNnbjt1qchvwp5B6p/pbEUusT8/2W3/SysV3Z20quJHOvabBzc5/iOAkhCKxXJ
 NdJJBLsykJ+KRNfH+l/+5wZZS5eyhScCIduNqIGVoE0k1RiHtU1B6mBV8tyxtvhQxfsc
 cWfesfNSD4xtbdty55akwJqSez7Omgl6bMMymi10RhhqBrHuVeYpFzg6gfxKyyUZv6VN
 Xkyrn9gm+pCOJYojwGB5abPq9lfBC6yjiwnWsoo4CGqRdpfQLJkEwBl4k4vJ0ir31CWo
 vlHA==
X-Gm-Message-State: APjAAAUXcdVbLmO21ltFs8hL6zWqU27lmW1XFTx1QD5SeZctQCZRK/db
 IFnXNh8O3hZspHvc3P7epKU3nk/HakE=
X-Google-Smtp-Source: APXvYqzlxaZd+tiG1zNhe24A8fGzNw8yJidSNL3+0fejl0Z28XRoBIrFE5jQBdOq4EQx1Sn+Lq+MQQ==
X-Received: by 2002:a63:2252:: with SMTP id t18mr70146706pgm.5.1563776285866; 
 Sun, 21 Jul 2019 23:18:05 -0700 (PDT)
Received: from bobo.local0.net (193-116-123-212.tpgi.com.au. [193.116.123.212])
 by smtp.gmail.com with ESMTPSA id 14sm57895983pfj.36.2019.07.21.23.18.00
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 21 Jul 2019 23:18:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Jul 2019 16:17:51 +1000
Message-Id: <20190722061752.22114-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v2 2/3] i386: use machine class ->wakeup method
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

Move the i386 suspend_wakeup logic out of the fallback path, and into
the new ->wakeup method.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/i386/pc.c | 8 ++++++++
 vl.c         | 2 --
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 549c437050..78c03d7f9d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2828,6 +2828,13 @@ static void pc_machine_reset(MachineState *machine)
     }
 }
 
+static void pc_machine_wakeup(MachineState *machine)
+{
+    cpu_synchronize_all_states();
+    pc_machine_reset(machine);
+    cpu_synchronize_all_post_reset();
+}
+
 static CpuInstanceProperties
 pc_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
 {
@@ -2940,6 +2947,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_IDE;
     mc->max_cpus = 255;
     mc->reset = pc_machine_reset;
+    mc->wakeup = pc_machine_wakeup;
     hc->pre_plug = pc_machine_device_pre_plug_cb;
     hc->plug = pc_machine_device_plug_cb;
     hc->unplug_request = pc_machine_device_unplug_request_cb;
diff --git a/vl.c b/vl.c
index 45ea034410..3f50dd685b 100644
--- a/vl.c
+++ b/vl.c
@@ -1567,8 +1567,6 @@ static void qemu_system_wakeup(void)
 
     if (mc && mc->wakeup) {
         mc->wakeup(current_machine);
-    } else {
-        qemu_system_reset(SHUTDOWN_CAUSE_NONE);
     }
 }
 
-- 
2.20.1


