Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00DCC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:06:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8925320CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeEU9KpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8925320CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZvM-0002xX-Hl
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:06:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0M-0003l7-T3
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0L-0003bq-N6
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:02 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51717)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Z0L-0003aW-Ey
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:01 -0500
Received: by mail-wm1-x344.google.com with SMTP id t23so2739957wmi.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0WVy/qKfZHTEAFFT6A0d/dDxv6phGfyMOW/7C/esSf8=;
 b=aeEU9KpWidLyom7mr1zx+1xuVWC+cu7q4Nl5RuLNu5oJDXvAdJd2c6Oe5xrUumXjk5
 hUD8hi4Aye9dbOfKJYQShTizFi42FwudgLwUkNDHpVP8/wUaV21z3IGHFAYH0XF2/emA
 EhsCIB3JhngLnbOKQo0poYmLG+4WxUCoZemehlI32hnMdi+K+C2Nigvr5ngyjZI1TFIs
 KjuP+ekxafg//m3OwLMRQAD6RY/vUmGxbJwBLhsp2mAjVghqwh/sEk+xF0KBSHmPVr3G
 FrkPCMEHTOu8Yl1VUhI+NN/bCZxmtT9034kfvAiBSk6JlEQhEg4TK562pvuIQveIje6P
 ZstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0WVy/qKfZHTEAFFT6A0d/dDxv6phGfyMOW/7C/esSf8=;
 b=UEBRXywj4ZuYDwGRMp4Z9QRM0YrdfAM9yopMGqjyC3eXMnIgPbtc36HM7J5ocbhHwO
 xvjYfVt4rTAiKzP1rxWkocCtgPhBpTywA34sUPAa6JVSErrAukw4HALREZUMbL0b5jFK
 tKEIX4rpkl8LAzf711SqkUvu9iUKnw+DxB6dSkGx9nrR/49ERR20ehM3y/4JlBrZJNNI
 L/n0bU7O3iKPd9CZ3HFSTnMBurVXlvNpEmvEq+UL9PwCUkVpbIcHdQraAXj8alqGa7p2
 BjbXTcGx7zUG+D+NEg6a5siy2Zc3JaegIY9Pz3Ojw9i/FBJoIBSN2NWYD0nfvWMi9Spe
 HBTQ==
X-Gm-Message-State: APjAAAVm0XHlZv7P4yLFvTCbY5heOT7bB+fsFrgZTfjJmqe4gfYuG0rW
 qRZMUkugpb/o4iYNBNlYPjVC4SOt
X-Google-Smtp-Source: APXvYqyHDHTFeS31XEGv1xzwbFHVArFlNdCycfzCFI1k8PUeZp2pmYNTsHEFTNfyNGHD2kwPdWPdxA==
X-Received: by 2002:a1c:4857:: with SMTP id v84mr5038308wma.8.1582632479200;
 Tue, 25 Feb 2020 04:07:59 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h13sm22709423wrw.54.2020.02.25.04.07.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:07:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 126/136] hw/riscv: Let devices own the MemoryRegion they create
Date: Tue, 25 Feb 2020 13:07:24 +0100
Message-Id: <1582632454-16491-24-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Avoid orphan memory regions being added in the /unattached QOM
container.

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200224205533.23798-29-philmd@redhat.com>
Supersedes: <20200221173049.18134-1-philmd@redhat.com>
---
 hw/riscv/sifive_e.c | 6 +++---
 hw/riscv/sifive_u.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 6f6360a..64eb8ce 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -145,8 +145,8 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
                             &error_abort);
 
     /* Mask ROM */
-    memory_region_init_rom(&s->mask_rom, NULL, "riscv.sifive.e.mrom",
-        memmap[SIFIVE_E_MROM].size, &error_fatal);
+    memory_region_init_rom(&s->mask_rom, OBJECT(dev), "riscv.sifive.e.mrom",
+                           memmap[SIFIVE_E_MROM].size, &error_fatal);
     memory_region_add_subregion(sys_mem,
         memmap[SIFIVE_E_MROM].base, &s->mask_rom);
 
@@ -208,7 +208,7 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
         memmap[SIFIVE_E_PWM2].base, memmap[SIFIVE_E_PWM2].size);
 
     /* Flash memory */
-    memory_region_init_rom(&s->xip_mem, NULL, "riscv.sifive.e.xip",
+    memory_region_init_rom(&s->xip_mem, OBJECT(dev), "riscv.sifive.e.xip",
                            memmap[SIFIVE_E_XIP].size, &error_fatal);
     memory_region_add_subregion(sys_mem, memmap[SIFIVE_E_XIP].base,
         &s->xip_mem);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 0e12b3c..be7d438 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -497,7 +497,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
                              &error_abort);
 
     /* boot rom */
-    memory_region_init_rom(mask_rom, NULL, "riscv.sifive.u.mrom",
+    memory_region_init_rom(mask_rom, OBJECT(dev), "riscv.sifive.u.mrom",
                            memmap[SIFIVE_U_MROM].size, &error_fatal);
     memory_region_add_subregion(system_memory, memmap[SIFIVE_U_MROM].base,
                                 mask_rom);
-- 
1.8.3.1



