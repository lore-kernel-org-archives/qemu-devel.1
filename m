Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E0BC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:25:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2618214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sf7JM9PU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2618214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9ssO-0006VZ-AS
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sD8-0006fM-1y
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sD6-0007YE-3N
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:37 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:53562)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1i9sD5-0007Xc-NT
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:36 -0400
Received: by mail-wm1-x329.google.com with SMTP id i16so67873wmd.3
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D4qmsiElKCvJ7YmXi8gkY9T9VEadqIQ5nlKcIn2oRS4=;
 b=sf7JM9PUZZ1w+Ggbi4daGN6FkFUNmKLHiQx/7jRT//W+PlamOjDQTjmB6r9OGGgajH
 M2ux7xQ6qqc8oL3H1qnKUeFA0CiqmqsIk0nsOGrfO+qWpAt6MvPqmbChZLOwq7rNG1dP
 k2ehW55oQAN6aYoGhJsKhuude9dwNxZA+mEs+vqmAHd1DBBzqRvwbQtbdrhepM2Cmldz
 B04qFcIyD33wxSqyGCFv7o3fiy2Gpfgqp85SbKpdexHYnyvvWnoM/ovqioUivMSg/0rv
 l3Bz1lAHgcj0qaYdiuNgMu3P/pDd6bNwdaNBikoYqnw9MnxEEWoTIXImWzML3YBD9FRR
 lSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=D4qmsiElKCvJ7YmXi8gkY9T9VEadqIQ5nlKcIn2oRS4=;
 b=NYIyjDtmwXs9waFW6aDFHO8U1dDsdM3riUFZoFmgB+XWjWvfrEhMwyOTb3hK/b+Ol6
 aKbiiif6XaNpvs7G4tL7g1Fg0+Z7tKWG+zTBx2osRQlwRLDxv7AlT9wMYd8MjXiB/r5P
 sa3Y304EpVkX9EtbpYldOhygvf3+HSgxJLmBoPGTkjTnksqlNQDcYtVUxpAiu5LIu4Vy
 ffIVhHXdjqigqnhSTGZlueUAKkBMVTtUsY94JKTPPLEGUJS3D7cwAWkn1/1xTBcIkvFr
 59t+3cf8emUsfoznwc6+135+0MLpZN13XltfTmVcQW4QhF0NZDh9BYkodzGSUB1vI8sr
 DzmA==
X-Gm-Message-State: APjAAAU4vu5WlruksrQ7DXExQqu//YJWOLve1otxOyNFAUKFUj2JM5D1
 Ra+WG1PBhPvdq9s8HMVVnwXHbCHe
X-Google-Smtp-Source: APXvYqx6Qv/0rlijM6rtXNuBgAqCYagOYVjLNHEOnKVUsYA88YIn2eQSi6hiJcJpld6OIryyttpTqg==
X-Received: by 2002:a1c:c104:: with SMTP id r4mr74546wmf.64.1568644954351;
 Mon, 16 Sep 2019 07:42:34 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id i14sm17024298wra.78.2019.09.16.07.42.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Sep 2019 07:42:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 16:42:01 +0200
Message-Id: <1568644929-9124-22-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
References: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
Subject: [Qemu-devel] [PULL 21/29] hw/i386/pc: Pass the CPUArchIdList array
 by argument
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

Pass the CPUArchIdList array by argument, this will
allow us to remove the PCMachineState argument later.

Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190818225414.22590-8-philmd@redhat.com>
---
 hw/i386/pc.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c0e9d83..5b3f615 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -937,14 +937,13 @@ static void pc_build_smbios(PCMachineState *pcms)
 }
 
 static FWCfgState *fw_cfg_arch_create(PCMachineState *pcms,
+                                      const CPUArchIdList *cpus,
                                       uint16_t boot_cpus,
                                       uint16_t apic_id_limit)
 {
     FWCfgState *fw_cfg;
     uint64_t *numa_fw_cfg;
     int i;
-    const CPUArchIdList *cpus;
-    MachineClass *mc = MACHINE_GET_CLASS(pcms);
     MachineState *ms = MACHINE(pcms);
     int nb_numa_nodes = ms->numa_state->num_nodes;
 
@@ -964,7 +963,7 @@ static FWCfgState *fw_cfg_arch_create(PCMachineState *pcms,
      * So for compatibility reasons with old BIOSes we are stuck with
      * "etc/max-cpus" actually being apic_id_limit
      */
-    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)pcms->apic_id_limit);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, apic_id_limit);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
     fw_cfg_add_bytes(fw_cfg, FW_CFG_ACPI_TABLES,
                      acpi_tables, acpi_tables_len);
@@ -980,20 +979,19 @@ static FWCfgState *fw_cfg_arch_create(PCMachineState *pcms,
      * of nodes, one word for each VCPU->node and one word for each node to
      * hold the amount of memory.
      */
-    numa_fw_cfg = g_new0(uint64_t, 1 + pcms->apic_id_limit + nb_numa_nodes);
+    numa_fw_cfg = g_new0(uint64_t, 1 + apic_id_limit + nb_numa_nodes);
     numa_fw_cfg[0] = cpu_to_le64(nb_numa_nodes);
-    cpus = mc->possible_cpu_arch_ids(MACHINE(pcms));
     for (i = 0; i < cpus->len; i++) {
         unsigned int apic_id = cpus->cpus[i].arch_id;
-        assert(apic_id < pcms->apic_id_limit);
+        assert(apic_id < apic_id_limit);
         numa_fw_cfg[apic_id + 1] = cpu_to_le64(cpus->cpus[i].props.node_id);
     }
     for (i = 0; i < nb_numa_nodes; i++) {
-        numa_fw_cfg[pcms->apic_id_limit + 1 + i] =
+        numa_fw_cfg[apic_id_limit + 1 + i] =
             cpu_to_le64(ms->numa_state->nodes[i].node_mem);
     }
     fw_cfg_add_bytes(fw_cfg, FW_CFG_NUMA, numa_fw_cfg,
-                     (1 + pcms->apic_id_limit + nb_numa_nodes) *
+                     (1 + apic_id_limit + nb_numa_nodes) *
                      sizeof(*numa_fw_cfg));
 
     return fw_cfg;
@@ -1775,6 +1773,7 @@ void pc_memory_init(PCMachineState *pcms,
     MemoryRegion *ram_below_4g, *ram_above_4g;
     FWCfgState *fw_cfg;
     MachineState *machine = MACHINE(pcms);
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
 
     assert(machine->ram_size == pcms->below_4g_mem_size +
@@ -1808,7 +1807,6 @@ void pc_memory_init(PCMachineState *pcms,
     if (!pcmc->has_reserved_memory &&
         (machine->ram_slots ||
          (machine->maxram_size > machine->ram_size))) {
-        MachineClass *mc = MACHINE_GET_CLASS(machine);
 
         error_report("\"-memory 'slots|maxmem'\" is not supported by: %s",
                      mc->name);
@@ -1871,7 +1869,8 @@ void pc_memory_init(PCMachineState *pcms,
                                         option_rom_mr,
                                         1);
 
-    fw_cfg = fw_cfg_arch_create(pcms, pcms->boot_cpus, pcms->apic_id_limit);
+    fw_cfg = fw_cfg_arch_create(pcms, mc->possible_cpu_arch_ids(machine),
+                                pcms->boot_cpus, pcms->apic_id_limit);
 
     rom_set_fw(fw_cfg);
 
-- 
1.8.3.1



