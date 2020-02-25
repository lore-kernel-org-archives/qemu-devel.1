Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1ABC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:16:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BD4F21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNLp6eS3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD4F21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6a4t-0003J7-Lr
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:16:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yzz-0003DH-VU
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yzy-0003Ms-Vd
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:39 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:46336)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Yzy-0003MM-P5
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:38 -0500
Received: by mail-wr1-x432.google.com with SMTP id j7so1906279wrp.13
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dcLy5F+/WldaZ+BIqvhIoR393wJnSMLL9Pg/oXsg+tA=;
 b=pNLp6eS3k7pGWp99rFpo9hNT0iqOumOH+6uDyxMxptRSV0eV+HIQBSZb0Q3J+XeaLQ
 VYMkhO9GCwDV9eTIcdba/4LPTSVtpetjT3j2Tr8SSvH1WP6Ftz6yzfh8pmQQSSHFCm26
 LEXoz4FhNUb2hKbZIpGRIjXHRPZVMIuIySd/UvFDlGiyRl/S2fbGr7lsovkzy5wscKLY
 aZgnkRkMPIZn1acmgyo1kjPd47rWXa/Tc5UG2P6TLLZfWjM8aVT8+3fnjaAkUVEGtVmV
 GLVZNjR27vr5hgBiNGWDN+Ne6y7HxKkkDRkpexndglJbIF08mQ7uRRDHfw5HFwz2xekJ
 wtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dcLy5F+/WldaZ+BIqvhIoR393wJnSMLL9Pg/oXsg+tA=;
 b=NHaTnaenTc7VZgXRU7dPmi9gwkEHRWfDUIXxshM3w+xkYaGBzsYaHWHUXedVbdn7G4
 AfMCSmEFNv7pOtT5da7YJ0BCiphBf95RkKYXAaeX3OwhNkLz4n87qXutscW56ZSSxpIX
 bdWyHKG8TvXyYm6fo0/3aXAaqpCgosM2jZVd5UCL0P7I7XMBSa4zGoPSgk8NO1LXPPR1
 RDFbA8kxGjc7w//6Pb//JVDH9zX1OGVOFPtd9N8OOspHrOAqKcJ4PEBYBKJERlROjCu/
 sLyJDm+uo1ICVFzhwWzg7q1P+ibgMpjTzpSDaQqvGpVP9+ZMSL9FVKpX9Mbc1rhROpsl
 j2kg==
X-Gm-Message-State: APjAAAUCdXTPPGlMRZV4f8WFky7TmJGPJwVLyH0VFL4tMC38TjvcIl0c
 78cK2HLZWMzLKJckasRltgB12HET
X-Google-Smtp-Source: APXvYqzrGWfkv8vJVkpEaz1TYGjAO0U77tJx0BQxfSRUn6FJIDjnC5LBCChz/zONjMi7jD4HbFTPRA==
X-Received: by 2002:adf:fe0a:: with SMTP id n10mr11204107wrr.229.1582632457538; 
 Tue, 25 Feb 2020 04:07:37 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h13sm22709423wrw.54.2020.02.25.04.07.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:07:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 104/136] hw/display: Use memory_region_init_rom() with
 read-only regions
Date: Tue, 25 Feb 2020 13:07:02 +0100
Message-Id: <1582632454-16491-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200224205533.23798-7-philmd@redhat.com>
Supersedes: <20200221173049.18134-1-philmd@redhat.com>
---
 hw/display/cg3.c | 5 ++---
 hw/display/tcx.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index 4fb67c6..a1ede10 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -287,9 +287,8 @@ static void cg3_initfn(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     CG3State *s = CG3(obj);
 
-    memory_region_init_ram_nomigrate(&s->rom, obj, "cg3.prom", FCODE_MAX_ROM_SIZE,
-                           &error_fatal);
-    memory_region_set_readonly(&s->rom, true);
+    memory_region_init_rom_nomigrate(&s->rom, obj, "cg3.prom",
+                                     FCODE_MAX_ROM_SIZE, &error_fatal);
     sysbus_init_mmio(sbd, &s->rom);
 
     memory_region_init_io(&s->reg, obj, &cg3_reg_ops, s, "cg3.reg",
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index ca458f9..76de16e 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -755,9 +755,8 @@ static void tcx_initfn(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     TCXState *s = TCX(obj);
 
-    memory_region_init_ram_nomigrate(&s->rom, obj, "tcx.prom", FCODE_MAX_ROM_SIZE,
-                           &error_fatal);
-    memory_region_set_readonly(&s->rom, true);
+    memory_region_init_rom_nomigrate(&s->rom, obj, "tcx.prom",
+                                     FCODE_MAX_ROM_SIZE, &error_fatal);
     sysbus_init_mmio(sbd, &s->rom);
 
     /* 2/STIP : Stippler */
-- 
1.8.3.1



