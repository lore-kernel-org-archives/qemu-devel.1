Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C12BC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:39:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFFE7218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECO2J68M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFE7218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54399 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZV1-0005I5-2L
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:39:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl7-0001NA-34
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl1-00005T-Hu
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:15 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:52812)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Yl1-0008Qt-9U
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:11 -0500
Received: by mail-wm1-x333.google.com with SMTP id p9so2681378wmc.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Kib73P+27/DO7Bga5aS2deQLPVXvr2G5OCCqFQFfdfM=;
 b=ECO2J68MzsJh2dV8YZUTLx8dhf2Q5rOAT6Gjfxkg2Swtsw/5o5zQvRRCbkKITq+Pf5
 EgypzqM4BFTpzRb4gL89ctyx+69KGzX+OlRdzLzlMfBMAH+wXpKCiLHzmggwsZibAOnp
 ooapOqbd/iB/qgMhCPuN2da2q1YSwZA7x1mmuZlkC6nlXsjkKrfOBRIGfVff42wcA6Fd
 1gmUd49EXwKnyrbY/e+Xn8E/g9qLgtPgSgdIn2leyrfxBgEFWRnAFSJDWyLuGM53HZLO
 YfTiv40E4O2yf3SgxK/9ybprx2JYMBbi4Nst0l7oqnCIS8+nSqK4QbJgC7ugrmQFLf7y
 ACWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Kib73P+27/DO7Bga5aS2deQLPVXvr2G5OCCqFQFfdfM=;
 b=bIWd2Y+laJU6ld8QuLbEnJBXTt4L/rWYhIOcWtzcjMazdG/ZvC4eMRkxil2ugyi/Ir
 2tzru/ftyI7mMqKNlh4o5HmMPGDkx5QGnqzPxGde/VgfYMLlMMgoDFK0N0HVfYqsYNaS
 TVynf7cdAwvNFfLJs8OTz4aeWx4gVS69RUwfWACvzVNfxRkfOTUZj4cSNdY6tgxsNvH2
 giiXcThcccvUbfcf1RQxnjHuYDN+mg2gFG6n+nWoGPHtwpVoGUHEmEWky/OIrDj5x3vn
 SSGwJFgJuAtje2ypI9hizkT5FsE8i9u7NtNRwcb7BF2/kfNPo9s3jmhRpplrN8okht6j
 +5Eg==
X-Gm-Message-State: APjAAAUuUOkUCt8JR1u/+wv/w59QMdgWAajfvlSq3bJ828G6DCPozMk0
 6MRAWQd+gP8OU6m+X3Sxk8e23qou
X-Google-Smtp-Source: APXvYqx2+7bJLEn1b2H7nwk+Wvzz6VFglQtcMSliKgSHf8wdgJ1cHhJY3fixBlAVj9SO6py/JyFmsQ==
X-Received: by 2002:a05:600c:214a:: with SMTP id
 v10mr5112816wml.182.1582631529920; 
 Tue, 25 Feb 2020 03:52:09 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 069/136] sparc/leon3: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:59 +0100
Message-Id: <1582631466-13880-69-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

memory_region_allocate_system_memory() API is going away, so
replace it with memdev allocated MemoryRegion. The later is
initialized by generic code, so board only needs to opt in
to memdev scheme by providing
  MachineClass::default_ram_id
and using MachineState::ram instead of manually initializing
RAM memory region.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-70-imammedo@redhat.com>
---
 hw/sparc/leon3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index f5a087d..5fa58aa 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -189,7 +189,6 @@ static void leon3_generic_hw_init(MachineState *machine)
     SPARCCPU *cpu;
     CPUSPARCState   *env;
     MemoryRegion *address_space_mem = get_system_memory();
-    MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *prom = g_new(MemoryRegion, 1);
     int         ret;
     char       *filename;
@@ -251,8 +250,8 @@ static void leon3_generic_hw_init(MachineState *machine)
         exit(1);
     }
 
-    memory_region_allocate_system_memory(ram, NULL, "leon3.ram", ram_size);
-    memory_region_add_subregion(address_space_mem, LEON3_RAM_OFFSET, ram);
+    memory_region_add_subregion(address_space_mem, LEON3_RAM_OFFSET,
+                                machine->ram);
 
     /* Allocate BIOS */
     prom_size = 8 * MiB;
@@ -358,6 +357,7 @@ static void leon3_generic_machine_init(MachineClass *mc)
     mc->desc = "Leon-3 generic";
     mc->init = leon3_generic_hw_init;
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("LEON3");
+    mc->default_ram_id = "leon3.ram";
 }
 
 DEFINE_MACHINE("leon3_generic", leon3_generic_machine_init)
-- 
1.8.3.1



