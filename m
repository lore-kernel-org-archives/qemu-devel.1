Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA12BC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 17:59:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C7A4204EA
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 17:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+8eI/C4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7A4204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfSF8-000244-UN
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 13:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfSAO-0003g9-6j; Sun, 31 May 2020 13:54:36 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36076)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfSAN-0007dS-Ei; Sun, 31 May 2020 13:54:35 -0400
Received: by mail-wm1-x344.google.com with SMTP id d128so9187218wmc.1;
 Sun, 31 May 2020 10:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RUMqPKblWHjVxZ98nIqqASbuDI8vJG3qcSLvSLKCBt8=;
 b=X+8eI/C4OhMfctTsS73+OghNMtcX/UEvdJo2GwriLZwNzWr6kcvX7lAzZaBK/UOsLR
 QNV34xFe+hb1aFe1WxT+liWxk8XdVB+xkrJxHZ4V6Zpycz6bBCoOXmNIYc1ueiVCM7OV
 GAnFaLBS4kA8vdtTQyiTgn/EFiATZUbk0tce6OPAS7bPLAWBeVE8ZonfKKTZLDYYglHS
 +9ejhU+BBCnY6Gd1X/bK1LedC75UiWzR5CZ3dE7AaTFPGduYnaSI00iEnye7fSZZ/fsn
 mi1b2v2HsfdAWhoLO/lXNPq6xJ73BR5j3KRxu1B5ImPH4JoEsBUXLWq3PUBb9TrwX6+a
 2t7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=RUMqPKblWHjVxZ98nIqqASbuDI8vJG3qcSLvSLKCBt8=;
 b=NrXDrCavVU0PtPw00P+y32HnofRpoE5VyjCSwJOnmv8yDNN6hSwfQI8VkJKgGJxoHY
 3eLBmFj4UvR4syzDNbo3SvPkkkuJaO3oOyl+cmBj8Fd2qtCJk0SuPqWaX8oX92wngWrH
 +sW5N/qk8COoShcl44DFG+MkGPcWetWXYnUzpJi3TubcbJ+3YQ5jVORz9ZYu5TLjS4Y+
 x3eP3fqO+w5FLBKYHV7kPdCah7nrwQ9gjOYHkP0Wrn864OyFue2AiKUzYJ43tToPKWxB
 uRLdGd5p06FN9OPAy+wzE/jd4yAYdxdw4r9fHaf1KS48mKWUcXkyhd4IX8vVVUf7zs2I
 hixQ==
X-Gm-Message-State: AOAM532TXkrvdyN59tiuEGrOHVIODvR9uIp0V8LBMcmE9dSx5lU72gA9
 2xkjxUa0818As1iOWbd7mgRTzBwl
X-Google-Smtp-Source: ABdhPJwCaiuZuI9J6B7vunUSeiqVjQhHpoq0Dhwc6Ep+Qgglfz6RGDoUPVR5vT5eCKikFH0pqMvm4w==
X-Received: by 2002:a1c:96c3:: with SMTP id y186mr17785194wmd.60.1590947673231; 
 Sun, 31 May 2020 10:54:33 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id z7sm17862531wrt.6.2020.05.31.10.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 10:54:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] exec/cpu-common: Do not restrict CPU to 32-bit memory
 access maximum
Date: Sun, 31 May 2020 19:54:23 +0200
Message-Id: <20200531175425.10329-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531175425.10329-1-f4bug@amsat.org>
References: <20200531175425.10329-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Most CPUs can do 64-bit operations. Update the CPUReadMemoryFunc
and CPUWriteMemoryFunc prototypes.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/exec/cpu-common.h |  4 ++--
 hw/usb/hcd-musb.c         | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index b47e5630e7..5ac766e3b6 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -43,8 +43,8 @@ extern ram_addr_t ram_size;
 
 /* memory API */
 
-typedef void CPUWriteMemoryFunc(void *opaque, hwaddr addr, uint32_t value);
-typedef uint32_t CPUReadMemoryFunc(void *opaque, hwaddr addr);
+typedef void CPUWriteMemoryFunc(void *opaque, hwaddr addr, uint64_t value);
+typedef uint64_t CPUReadMemoryFunc(void *opaque, hwaddr addr);
 
 void qemu_ram_remap(ram_addr_t addr, ram_addr_t length);
 /* This should not be used by devices.  */
diff --git a/hw/usb/hcd-musb.c b/hw/usb/hcd-musb.c
index c29fbef6fc..4063cbccf8 100644
--- a/hw/usb/hcd-musb.c
+++ b/hw/usb/hcd-musb.c
@@ -1243,7 +1243,7 @@ static void musb_ep_writeh(void *opaque, int ep, int addr, uint16_t value)
 }
 
 /* Generic control */
-static uint32_t musb_readb(void *opaque, hwaddr addr)
+static uint64_t musb_readb(void *opaque, hwaddr addr)
 {
     MUSBState *s = (MUSBState *) opaque;
     int ep, i;
@@ -1305,7 +1305,7 @@ static uint32_t musb_readb(void *opaque, hwaddr addr)
     };
 }
 
-static void musb_writeb(void *opaque, hwaddr addr, uint32_t value)
+static void musb_writeb(void *opaque, hwaddr addr, uint64_t value)
 {
     MUSBState *s = (MUSBState *) opaque;
     int ep;
@@ -1392,7 +1392,7 @@ static void musb_writeb(void *opaque, hwaddr addr, uint32_t value)
     };
 }
 
-static uint32_t musb_readh(void *opaque, hwaddr addr)
+static uint64_t musb_readh(void *opaque, hwaddr addr)
 {
     MUSBState *s = (MUSBState *) opaque;
     int ep, i;
@@ -1446,7 +1446,7 @@ static uint32_t musb_readh(void *opaque, hwaddr addr)
     };
 }
 
-static void musb_writeh(void *opaque, hwaddr addr, uint32_t value)
+static void musb_writeh(void *opaque, hwaddr addr, uint64_t value)
 {
     MUSBState *s = (MUSBState *) opaque;
     int ep;
@@ -1502,7 +1502,7 @@ static void musb_writeh(void *opaque, hwaddr addr, uint32_t value)
     };
 }
 
-static uint32_t musb_readw(void *opaque, hwaddr addr)
+static uint64_t musb_readw(void *opaque, hwaddr addr)
 {
     MUSBState *s = (MUSBState *) opaque;
     int ep;
@@ -1520,7 +1520,7 @@ static uint32_t musb_readw(void *opaque, hwaddr addr)
     };
 }
 
-static void musb_writew(void *opaque, hwaddr addr, uint32_t value)
+static void musb_writew(void *opaque, hwaddr addr, uint64_t value)
 {
     MUSBState *s = (MUSBState *) opaque;
     int ep;
-- 
2.21.3


