Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81C9C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:25:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70DDF20883
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1PR5WWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DDF20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45823 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDtYW-0005s9-MZ
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 12:25:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDtWm-0004ab-LB
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:23:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDtWl-0003W8-Nm
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:23:16 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:41959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hDtWl-0003V7-Hm
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:23:15 -0400
Received: by mail-wr1-x434.google.com with SMTP id r4so21688793wrq.8
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 09:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=LysOdumLJ0HHNb4iRzo747jgyjnNQN4WQpGaMoS1fmY=;
	b=q1PR5WWBv8OLoh06HepGijXB8D6ndEM9VI5wyqQXRv5lACPrp+nzf+GS7GxVRZYMBW
	cUctwDzrle8moIfpYpfdN/fGN7Flb3HerRthTol8UOn4exmkcmILvMsQIC8EqK2niIs9
	ozF6shIf66RAvFyqIW36YkxT5AgiOKrzpDucBfPqUWXW96cWkCJb1xpc1cri+ocVIQX9
	C8ox1NtEZGZ39E+osWS2gKUkequk8Y5S1E6J+nbhyGggqhPKzdsb28qq+oIWdc6PbVdX
	CG5A0knY59YoKq37pKchMkKxDAmNwe5wBIpjB9BSx35VbJHoeWoLk+CjBnQbRLCwASuz
	tDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references;
	bh=LysOdumLJ0HHNb4iRzo747jgyjnNQN4WQpGaMoS1fmY=;
	b=TJoQ7SdYtOlm5XGcgPTEB636yfD5t2f/GzdUSs1YTTNztNUdOy37F53aGVhOkHnIMW
	oSG8kcH94Kdsx95B/T4Y6w3VjK45/7J5pLVObSLCVsIHE0An8F1QNPSWxUSi7LbGAB0f
	yRhAOHtJX4DG8V3F/RY9H6bTqn2yrwlH8VDie/heJKkGWsESeVucjEqDM0l9AbkggQhR
	9P7D4jk3jze82sNvFJmw9+DXyDY5eZpfwJjvPrcXVpIqr2ovlwY2H6wBygHDxdTmdU8B
	RP1CihUg4/anCBBeoNtnQ77T2Khq5EJM7QEIX/XA+lX31vu0u3VXsTpXBGpjBq1UHU4E
	SzPw==
X-Gm-Message-State: APjAAAXy9GrwjmLquXCSMVtq3blLFx/EtVA7us9fO+wMa6t4XBd/JAxs
	EZMSPExjXJ4cjr1hXyMq5WKvqc7U
X-Google-Smtp-Source: APXvYqxOb8iQMDW3OeuKs8lgMVluOzllPnZx0Ew6Hvd6baE4zdLvEqiqnMOcSALFuGNkRflcA4UA3Q==
X-Received: by 2002:adf:f1ce:: with SMTP id z14mr23524050wro.152.1554826994262;
	Tue, 09 Apr 2019 09:23:14 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	e1sm59579736wrw.66.2019.04.09.09.23.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 09:23:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 18:23:05 +0200
Message-Id: <1554826986-37164-5-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554826986-37164-1-git-send-email-pbonzini@redhat.com>
References: <1554826986-37164-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::434
Subject: [Qemu-devel] [PULL 4/5] hw/i386/pc: Fix crash when hot-plugging
 nvdimm on older machine types
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409162305.2pJDEbkwQwWpNq1ozpzHvl2bCJCYfY4QzavA59X5W5I@z>

From: Thomas Huth <thuth@redhat.com>

QEMU currently crashes when you try to hot-plug an "nvdimm" device
on older machine types:

$ qemu-system-x86_64 -monitor stdio -M pc-1.1
QEMU 3.1.92 monitor - type 'help' for more information
(qemu) device_add nvdimm,id=nvdimmn1
qemu-system-x86_64: /home/thuth/devel/qemu/util/error.c:57: error_setv:
 Assertion `*errp == ((void *)0)' failed.
Aborted (core dumped)

The call to hotplug_handler_pre_plug() in pc_memory_pre_plug() has been
added recently before the check whether nvdimm is enabled. It should
be done after the check. And while we're at it, also check the errp
after the hotplug_handler_pre_plug(), otherwise errors are silently
ignored here.

Fixes: 9040e6dfa8c3fed87695a3de555d2c775727bb51
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190407092314.11066-1-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 6077d27..f2c15bf 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2078,6 +2078,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     const MachineState *ms = MACHINE(hotplug_dev);
     const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
     const uint64_t legacy_align = TARGET_PAGE_SIZE;
+    Error *local_err = NULL;
 
     /*
      * When -no-acpi is used with Q35 machine type, no ACPI is built,
@@ -2090,13 +2091,17 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    hotplug_handler_pre_plug(pcms->acpi_dev, dev, errp);
-
     if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
         error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
         return;
     }
 
+    hotplug_handler_pre_plug(pcms->acpi_dev, dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev),
                      pcmc->enforce_aligned_dimm ? NULL : &legacy_align, errp);
 }
-- 
1.8.3.1



