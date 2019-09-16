Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58565C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:28:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25368206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbUlwGO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25368206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9svF-0001kl-T7
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53855)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sDC-0006gY-EI
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sDA-0007ZP-1l
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:41 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:54519)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1i9sD7-0007YJ-V8
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:38 -0400
Received: by mail-wm1-x335.google.com with SMTP id p7so60637wmp.4
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=KiFCZUVAPnnWNqhg3WDsyPWMV8xe1NmN4cPuEbcJmC4=;
 b=BbUlwGO+gso8YZDbG4T+MReP3mREKgRl1mYeC45zamXl+voad8SeFVwmMlZDYQeQRF
 8tRt5iW+6pZOYAjs7wXyNmlzUwpmm3XgSiaLBeircu9bzQsVQc37ogAXfaOdZalYFhzb
 +e80/3a3AiIJkAePRLLN6sCZ64pc95ENY7b0ZLkdNX5ullcDwVBHiNsLln+LLaM63Uq7
 YlXZb77GIHFCGbU8x1fHgkC7lwqEfgwdpJwzzlz3Gbn+QUiN8aGINU3pkxMA3jEfnOUD
 uyYGMnRHNXPKv2hV1Q9pnHTn3pfMjW3ewUaH6VBYU5xNNYsA9fUJdk/mWnB0srWvBxKx
 R8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=KiFCZUVAPnnWNqhg3WDsyPWMV8xe1NmN4cPuEbcJmC4=;
 b=XwwgoGbf1Vdoa2ESMIe74d+Apru3zjPWoXN0FpipE2JQiwEbHftAUiUIEIcgxzqZrz
 wTfms09sKdURWvN9GtGmNjOOBqQm7LOiJ4e7a1aD1sW2YTHchKQKakr1IrZBHwgB5V5K
 wzxBqM2YVCjzRMmVi3VmEQYRXKZ9fYL5nCCEVIoUh44zd/hOuNJEyu6et5NT6YZReg1d
 Yko4pyo4TZT6oVY3zdydKpp50YNo2o9x1zxpYoBpCHrUSYljNEu4Wu5knCuzzM2KgFcy
 iNfpYLlTz3JJVv/KGVlcPZ0Ix43oyRpoeh4ynvCGA6FHqVgJHe8nNpSSA/j6Ig20iiyX
 PMbg==
X-Gm-Message-State: APjAAAV0Ro8VfjmyaHtO3iXlyLGWS1iuyxl2UDLBi/5h96ioHlRb1q6d
 9HIQW+ONnJe4ERjmjZalNMXMP1u3
X-Google-Smtp-Source: APXvYqwpFtieHmWoMHoSEI4NxDvLoh0fZ7yPel91NweI9mQBSi8HUzJUxwfChB3t2DMfZDUJRqAfQA==
X-Received: by 2002:a1c:2302:: with SMTP id j2mr47813wmj.174.1568644955495;
 Mon, 16 Sep 2019 07:42:35 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id i14sm17024298wra.78.2019.09.16.07.42.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Sep 2019 07:42:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 16:42:02 +0200
Message-Id: <1568644929-9124-23-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
References: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
Subject: [Qemu-devel] [PULL 22/29] hw/i386/pc: Replace PCMachineState
 argument with MachineState in fw_cfg_arch_create
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the previous commit we removed the last access to PCMachineState.
Replace it with a generic MachineState argument and use it to retrieve
the CPUArchIdList.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5b3f615..8d2e600 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -936,15 +936,15 @@ static void pc_build_smbios(PCMachineState *pcms)
     }
 }
 
-static FWCfgState *fw_cfg_arch_create(PCMachineState *pcms,
-                                      const CPUArchIdList *cpus,
+static FWCfgState *fw_cfg_arch_create(MachineState *ms,
                                       uint16_t boot_cpus,
                                       uint16_t apic_id_limit)
 {
     FWCfgState *fw_cfg;
     uint64_t *numa_fw_cfg;
     int i;
-    MachineState *ms = MACHINE(pcms);
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    const CPUArchIdList *cpus = mc->possible_cpu_arch_ids(ms);
     int nb_numa_nodes = ms->numa_state->num_nodes;
 
     fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4,
@@ -1869,7 +1869,7 @@ void pc_memory_init(PCMachineState *pcms,
                                         option_rom_mr,
                                         1);
 
-    fw_cfg = fw_cfg_arch_create(pcms, mc->possible_cpu_arch_ids(machine),
+    fw_cfg = fw_cfg_arch_create(machine,
                                 pcms->boot_cpus, pcms->apic_id_limit);
 
     rom_set_fw(fw_cfg);
-- 
1.8.3.1



