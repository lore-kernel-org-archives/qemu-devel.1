Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627CCC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:58:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E97B222C2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6L7/sDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E97B222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Yqo-0004L5-A4
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:58:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkL-0000NC-Eg
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkH-00069H-Iq
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:29 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:40399)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkH-00060c-B9
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:25 -0500
Received: by mail-wr1-x42b.google.com with SMTP id t3so14350413wru.7
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=flYtEk0ax7P9nTpGQ0D7EhA/r6SXi2jRP9wzLPqR8FM=;
 b=T6L7/sDrCIcCrNuFbPL5MIl6gCH4nUgDl4xh5wX3IHj48v3gHll1vdY04SWR9pInwG
 /26jj65ZHBNZcvnnzz6mzw8wPQaYUadRH9iyS4a2NHu9kuTIT8u6kcEcf4s6GzcDFa+F
 BpL7TbaipLG/on0pseqK2VXEarkEFFjVktGZyRGIITs/4lY5ivpce0LmROn7WdWKn4P0
 4WJBJZO75zHlvC7jOAVjBbjr5DODeIIFJFmcwZ7L9hYZFlRIc5FyYMCxFAWjE4blnYJW
 19NtL5z946m/oNSzA/UdxvTOZBT7wBKE+2vn9CwKp6Rfx7f9gtlsjybh313/vbNaswZs
 xx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=flYtEk0ax7P9nTpGQ0D7EhA/r6SXi2jRP9wzLPqR8FM=;
 b=e4TSDzxj9X9Ls67/uUriAyJyMxU3wyFiiEfpkDYLl0Lg1Yu0z9Fhnc3IabNYaKBpKU
 CGmbEQmW9cfryWFZjDJo4U6+0im/q6bG5nn4Sz5RGaYtc/fur/U2XuyMhdXXYvieGDcP
 LEVp8CuqHpRfB7mNZmGNcVpDM7g0NzldEx9hX7EJ7Y8YAVcVUHidTOrL1vmihku1RICp
 wSv4RBfjRVSJaQGpGKFKeymAFI2mGqfLkJU2GH5GTaBLp1c+UF3a8k8kkmCNu0tl1vS8
 wZ3d595yzLG69sfnD73PA/4fV2cH19yU6aggwvmjv4rFnWu8b7f3RJTqcuDy8G8jQ4Lo
 Gfdw==
X-Gm-Message-State: APjAAAV+MigV2ozxnajGqpe0cWnDejBJXd16WFeB8q+yeM2ugTslSCZ5
 r+bZ1zHPBpy60HbiAktjeHhae1dT
X-Google-Smtp-Source: APXvYqzvKgGS6w0C9g825XN+EneuTXzvMiBtfHdSTFzQUEZ23Vno4nxGmL3SlVlYsdZysWHzn4rxag==
X-Received: by 2002:adf:f3cd:: with SMTP id g13mr74401436wrp.54.1582631482431; 
 Tue, 25 Feb 2020 03:51:22 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 017/136] arm/integratorcp: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:07 +0100
Message-Id: <1582631466-13880-17-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-18-imammedo@redhat.com>
---
 hw/arm/integratorcp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 0cd94d9..cc845b8 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -585,7 +585,6 @@ static void integratorcp_init(MachineState *machine)
     Object *cpuobj;
     ARMCPU *cpu;
     MemoryRegion *address_space_mem = get_system_memory();
-    MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *ram_alias = g_new(MemoryRegion, 1);
     qemu_irq pic[32];
     DeviceState *dev, *sic, *icp;
@@ -605,14 +604,13 @@ static void integratorcp_init(MachineState *machine)
 
     cpu = ARM_CPU(cpuobj);
 
-    memory_region_allocate_system_memory(ram, NULL, "integrator.ram",
-                                         ram_size);
     /* ??? On a real system the first 1Mb is mapped as SSRAM or boot flash.  */
     /* ??? RAM should repeat to fill physical memory space.  */
     /* SDRAM at address zero*/
-    memory_region_add_subregion(address_space_mem, 0, ram);
+    memory_region_add_subregion(address_space_mem, 0, machine->ram);
     /* And again at address 0x80000000 */
-    memory_region_init_alias(ram_alias, NULL, "ram.alias", ram, 0, ram_size);
+    memory_region_init_alias(ram_alias, NULL, "ram.alias", machine->ram,
+                             0, ram_size);
     memory_region_add_subregion(address_space_mem, 0x80000000, ram_alias);
 
     dev = qdev_create(NULL, TYPE_INTEGRATOR_CM);
@@ -660,6 +658,7 @@ static void integratorcp_machine_init(MachineClass *mc)
     mc->init = integratorcp_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
+    mc->default_ram_id = "integrator.ram";
 }
 
 DEFINE_MACHINE("integratorcp", integratorcp_machine_init)
-- 
1.8.3.1



