Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EB8CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:39:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A61E820679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUzWGVQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61E820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNeHN-0006aV-Dq
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdio-0007LP-GD
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdij-0007ez-66
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:14 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40870)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdii-0007eZ-Js
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:09 -0400
Received: by mail-wm1-x343.google.com with SMTP id w9so1561844wmm.5
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v0QSA56OPy9BQBWnDU2EPRHFVgRB7RnoM+muLYIJbUU=;
 b=dUzWGVQGnZCdCwxr2b5IGOJE5hxvZsPNYxszBikPz0s2aEoMJV0YbTDbNIO5iaass9
 fsFiW7pzI+GMCdahEk+olYYSM2jO/5vRFGTR/5UZSbTXoa+uhIUW7vz2XmrqtqUuUUtU
 abSELmClPQF+c28jm1CUmGTo3LnLAoh6dGWDKbPMwHefe3iFERYBtWiYejAn460dc0KA
 vgFIrcBnE33Jo8LTa9SNccgTTtk3Rf3plJtDbHavTFAfDvV0PiaSVtHmDiK5hn66FFOt
 2I9TVBIUQbkvmJuoEHBQ05LCpkccyYYpzOlBM2m8nta/bqOsemmPpYaTnPIq8148aA+v
 6+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=v0QSA56OPy9BQBWnDU2EPRHFVgRB7RnoM+muLYIJbUU=;
 b=iVJ1PtixpK8q1W5ECUWmBXFWqrsQWs3nxpi79qsmPy5g8Olv7bPM8zBIOeTxharifI
 E8eEZBsGGhr6eiVapFGB86xddlAla5BGH440s+td0R4pk0Vs7826V+VzyPv4H0YKv0th
 NSHinCJB6bXl50InJkKYipdcyxhZMIn7wF+d3OQ8Wwr4x6kuL89J0fB7A8ToWcvhVOo+
 BmH5It1nr8luwgLkqrXqnhPyTgXalkfioJlp5wa6pdIATsm3GqCjimmY+zXHN0j71mPQ
 zVYJWKW/8jfVXqZvELAjqISfYJGQXPa9BYgecqm6Y4SW4d5fC5Y1Zp00CHqXHBn/C+m2
 QCCw==
X-Gm-Message-State: APjAAAVojsB14wV9g2pvpkq7jUotVRNG+xRVKrsRXXB2ZQeXsPQByaqQ
 LmDvibNNyMEsjLWF+DOT0BhtGZCZ
X-Google-Smtp-Source: APXvYqzmzQXSFXNXHxhMGtzkXCbQ0TsBATzttosZz6W1ijF9+/lY2t1PrCEBXF3vSbiXuH9r+JLBsQ==
X-Received: by 2002:a7b:ce12:: with SMTP id m18mr4876158wmc.35.1571925847244; 
 Thu, 24 Oct 2019 07:04:07 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/39] hw/i386/pc: fix code style issues on functions that will
 be moved out
Date: Thu, 24 Oct 2019 16:03:25 +0200
Message-Id: <1571925835-31930-10-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sergio Lopez <slp@redhat.com>

Fix code style issues detected by checkpatch.pl on functions that will
be moved out to x86.c.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/pc.c | 53 +++++++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 1c27223..75a97c2 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -866,7 +866,8 @@ static void handle_a20_line_change(void *opaque, int irq, int level)
     x86_cpu_set_a20(cpu, level);
 }
 
-/* Calculates initial APIC ID for a specific CPU index
+/*
+ * Calculates initial APIC ID for a specific CPU index
  *
  * Currently we need to be able to calculate the APIC ID from the CPU index
  * alone (without requiring a CPU object), as the QEMU<->Seabios interfaces have
@@ -1039,7 +1040,7 @@ static void x86_load_linux(PCMachineState *pcms,
     const char *kernel_cmdline = machine->kernel_cmdline;
 
     /* Align to 16 bytes as a paranoia measure */
-    cmdline_size = (strlen(kernel_cmdline)+16) & ~15;
+    cmdline_size = (strlen(kernel_cmdline) + 16) & ~15;
 
     /* load the kernel header */
     f = fopen(kernel_filename, "rb");
@@ -1055,8 +1056,8 @@ static void x86_load_linux(PCMachineState *pcms,
 #if 0
     fprintf(stderr, "header magic: %#x\n", ldl_p(header+0x202));
 #endif
-    if (ldl_p(header+0x202) == 0x53726448) {
-        protocol = lduw_p(header+0x206);
+    if (ldl_p(header + 0x202) == 0x53726448) {
+        protocol = lduw_p(header + 0x206);
     } else {
         /*
          * This could be a multiboot kernel. If it is, let's stop treating it
@@ -1158,7 +1159,7 @@ static void x86_load_linux(PCMachineState *pcms,
 
     /* highest address for loading the initrd */
     if (protocol >= 0x20c &&
-        lduw_p(header+0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
+        lduw_p(header + 0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
         /*
          * Linux has supported initrd up to 4 GB for a very long time (2007,
          * long before XLF_CAN_BE_LOADED_ABOVE_4G which was added in 2013),
@@ -1177,7 +1178,7 @@ static void x86_load_linux(PCMachineState *pcms,
          */
         initrd_max = UINT32_MAX;
     } else if (protocol >= 0x203) {
-        initrd_max = ldl_p(header+0x22c);
+        initrd_max = ldl_p(header + 0x22c);
     } else {
         initrd_max = 0x37ffffff;
     }
@@ -1187,14 +1188,14 @@ static void x86_load_linux(PCMachineState *pcms,
     }
 
     fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_ADDR, cmdline_addr);
-    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(kernel_cmdline)+1);
+    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(kernel_cmdline) + 1);
     fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline);
 
     if (protocol >= 0x202) {
-        stl_p(header+0x228, cmdline_addr);
+        stl_p(header + 0x228, cmdline_addr);
     } else {
-        stw_p(header+0x20, 0xA33F);
-        stw_p(header+0x22, cmdline_addr-real_addr);
+        stw_p(header + 0x20, 0xA33F);
+        stw_p(header + 0x22, cmdline_addr - real_addr);
     }
 
     /* handle vga= parameter */
@@ -1212,20 +1213,22 @@ static void x86_load_linux(PCMachineState *pcms,
         } else {
             video_mode = strtol(vmode, NULL, 0);
         }
-        stw_p(header+0x1fa, video_mode);
+        stw_p(header + 0x1fa, video_mode);
     }
 
     /* loader type */
-    /* High nybble = B reserved for QEMU; low nybble is revision number.
-       If this code is substantially changed, you may want to consider
-       incrementing the revision. */
+    /*
+     * High nybble = B reserved for QEMU; low nybble is revision number.
+     * If this code is substantially changed, you may want to consider
+     * incrementing the revision.
+     */
     if (protocol >= 0x200) {
         header[0x210] = 0xB0;
     }
     /* heap */
     if (protocol >= 0x201) {
-        header[0x211] |= 0x80;	/* CAN_USE_HEAP */
-        stw_p(header+0x224, cmdline_addr-real_addr-0x200);
+        header[0x211] |= 0x80; /* CAN_USE_HEAP */
+        stw_p(header + 0x224, cmdline_addr - real_addr - 0x200);
     }
 
     /* load initrd */
@@ -1257,14 +1260,14 @@ static void x86_load_linux(PCMachineState *pcms,
             exit(1);
         }
 
-        initrd_addr = (initrd_max-initrd_size) & ~4095;
+        initrd_addr = (initrd_max - initrd_size) & ~4095;
 
         fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_addr);
         fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
         fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, initrd_data, initrd_size);
 
-        stl_p(header+0x218, initrd_addr);
-        stl_p(header+0x21c, initrd_size);
+        stl_p(header + 0x218, initrd_addr);
+        stl_p(header + 0x21c, initrd_size);
     }
 
     /* load kernel and setup */
@@ -1272,7 +1275,7 @@ static void x86_load_linux(PCMachineState *pcms,
     if (setup_size == 0) {
         setup_size = 4;
     }
-    setup_size = (setup_size+1)*512;
+    setup_size = (setup_size + 1) * 512;
     if (setup_size > kernel_size) {
         fprintf(stderr, "qemu: invalid kernel header\n");
         exit(1);
@@ -1310,7 +1313,7 @@ static void x86_load_linux(PCMachineState *pcms,
         kernel_size = setup_data_offset + sizeof(struct setup_data) + dtb_size;
         kernel = g_realloc(kernel, kernel_size);
 
-        stq_p(header+0x250, prot_addr + setup_data_offset);
+        stq_p(header + 0x250, prot_addr + setup_data_offset);
 
         setup_data = (struct setup_data *)(kernel + setup_data_offset);
         setup_data->next = 0;
@@ -1507,7 +1510,8 @@ void x86_cpus_init(PCMachineState *pcms)
 
     x86_cpu_set_default_version(pcmc->default_cpu_version);
 
-    /* Calculates the limit to CPU APIC ID values
+    /*
+     * Calculates the limit to CPU APIC ID values
      *
      * Limit for the APIC ID value, so that all
      * CPU APIC IDs are < pcms->apic_id_limit.
@@ -2712,7 +2716,7 @@ static const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
         /*
          * make sure that max_cpus hasn't changed since the first use, i.e.
          * -smp hasn't been parsed after it
-        */
+         */
         assert(ms->possible_cpus->len == max_cpus);
         return ms->possible_cpus;
     }
@@ -2725,7 +2729,8 @@ static const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
 
         ms->possible_cpus->cpus[i].type = ms->cpu_type;
         ms->possible_cpus->cpus[i].vcpus_count = 1;
-        ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(pcms, i);
+        ms->possible_cpus->cpus[i].arch_id =
+            x86_cpu_apic_id_from_index(pcms, i);
         x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
                                  pcms->smp_dies, ms->smp.cores,
                                  ms->smp.threads, &topo);
-- 
1.8.3.1



