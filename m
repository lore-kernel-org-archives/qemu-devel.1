Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349A3C282DA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:57:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F10302084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXnKWIxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10302084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45131 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDt7c-0000fB-7U
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 11:57:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDt5u-00085o-Qc
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDt5t-0004ht-JG
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:30 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:45225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hDt5t-0004a3-2t
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:29 -0400
Received: by mail-wr1-x436.google.com with SMTP id s15so21535056wra.12
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=LysOdumLJ0HHNb4iRzo747jgyjnNQN4WQpGaMoS1fmY=;
	b=GXnKWIxu9MJslfKJSFgXTpkjwz5zAsOMi79hJIl6nt6vWs4veb8HmsBvvoHL2bmB4p
	sMksGTSxO3lCyC/dBqveQ/3weSa9VrOHwRvJhZPVeKoFEUpXzOXpIrNQOJ5dobzyoZLp
	5i1EHstLQB8uzHbUZaEvv/NFnbMksYvz3CHf/huD//DstnfrCKICZGV/QbxGM1I3MfQ7
	sGVUxDdbo8ncZ+GLoibjtR0VQza6pT0b1yo71s8z+I4epk9K6aSLm8tvNgJ1wQepz1Ui
	NTmg1ad/1NzJ/L1ifc4murDf+7OMBGPQm7KztZb1Sk3MT3t6ee4x3LuO6kwbBP71VUlX
	Vluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references;
	bh=LysOdumLJ0HHNb4iRzo747jgyjnNQN4WQpGaMoS1fmY=;
	b=GEolJ+6jIZ5VuzMAKuGVtv1o43G5BMpf2w+PhkVwdMgvCBkKlj6nOIxUjVCqxzhl1b
	1yigB+7Qp8lVc1ZxI6hZHerpTWJX2LUI2dgxUmmQ1px/Y5m5sH2t5PUKvQm4qPIY3URa
	VEpkMeMdhxLlOOBUUdGUyLfJs1R+g7CNWrXZ+3cBP1Y6gTQnFiqToLmniXrJSMThBcI4
	iJWpj5w6LpFxoAKHAV+llhW3Sduiv+Ko6NohRQTof8x7ptU4xDa7i1TtRf2s/B0rnRAI
	iBEHyGX78tJuSkVC5GwK7KqlVQzmW6QuY/mpAtjUEay6TajhYX5yuDzIECLxcyt4Gv7k
	1r7g==
X-Gm-Message-State: APjAAAXnkJmGBeKoYr5ryMXZSw+GGnUAK816oj6rFXAUUBdw9Psdsoq6
	xM4FLT5QdUzKJoGhKeTwt21TK2P5
X-Google-Smtp-Source: APXvYqxvF1Buzu5MU5jy92nkbGus1cMJf8rRm1gBrzApByqphlc9aggvxKYtTm0l3eNpc0TYOJFQeg==
X-Received: by 2002:adf:ffc2:: with SMTP id x2mr24381513wrs.86.1554825321861; 
	Tue, 09 Apr 2019 08:55:21 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	g84sm23117586wmf.25.2019.04.09.08.55.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 08:55:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 17:55:15 +0200
Message-Id: <1554825316-33288-5-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554825316-33288-1-git-send-email-pbonzini@redhat.com>
References: <1554825316-33288-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Message-ID: <20190409155515.9pCSKKwylUqS2etR8MyyxuMLLgY95JrSfkKp_DOuSO0@z>

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



