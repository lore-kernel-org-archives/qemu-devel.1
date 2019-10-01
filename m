Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F262C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:45:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4824121906
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6FssrIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4824121906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFISu-0006tG-VO
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 09:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFIKT-000672-My
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:36:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFIKS-0001gd-Lt
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:36:37 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38776)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFIKS-0001fU-E6
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:36:36 -0400
Received: by mail-wm1-x342.google.com with SMTP id 3so3296263wmi.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 06:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=tpNzkqUfps0EVOpJsON6N0dLvxr0SOw+FOhA9QOcvjg=;
 b=e6FssrIejDBX0NLR1YTnlI8KiYgI6QnlkBuMSBmtX7Q1QHy2FDNv9j9p0rioddWfOO
 mVcTq7J9idwU2yKcCWi6pjyh/8BKuvnFcU6kCaBIHiuIg5wh3i+Xc5VyYLIOoYh2bkc5
 XYUaTmjTd5aovlidUtQHqoKe9oaUYfVmre28e96C1VC691ZWhq8ivvPH0LpNNFdHjgPJ
 dIJYvL2xyacJiAME76ft8SwmN3ofxOc2WMxjygj+nSscbWhP5DB9vE0Fi514Zpq8paqU
 F+sofqluwulx6EuiMBV7aKcbmPHLkEdIsl7zHpm3n9wtcz9uIWeuM7w+7a45fCo0jS6B
 t0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=tpNzkqUfps0EVOpJsON6N0dLvxr0SOw+FOhA9QOcvjg=;
 b=jYLl85sDrzWneofg2P+updfZcfDJ3TXP40zCEq+kSafr9BI1Iqgr8Kld707USJ+24J
 fUbdEcKSY5Kavoa4GWRjLQ1OeV8Meju3i1OPbXJ5VDi/aylN0vttV3oT32ZGnEhrK9Wm
 lZepUbDmD8RbEdGYZhDBmU6N8UxMQlSYCM8YeSZvkgOloOZBqiIz7SAAERMpHY6YEOsf
 Cy3xq9YhopVjhhqNT4uD001tc9G5dz9nCp2CrP9z0Tu6vYZd4ZxGCva+tC0RchuUaB7C
 M83pRWOOMJnIO9/+ODkrV38qRgIvt6pxhlnDjDwar92tBnmZ62G38DTxBQTovC3+cpw0
 58HQ==
X-Gm-Message-State: APjAAAXh1hAY5IZmRnfinOube7rM4eC7vcMhBZgvdhTstptqM1B5AKCs
 G7bA0pXZtqbrDZlz1S1L+AJOpaCZ
X-Google-Smtp-Source: APXvYqxIg2uZIsI8eoULq10pSU1idgjjrU4pHfil7TIhIpgMMx6d03DxgaY7v5e1k0RmHn6q48qbYw==
X-Received: by 2002:a1c:8097:: with SMTP id b145mr3912364wmd.29.1569936994124; 
 Tue, 01 Oct 2019 06:36:34 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q192sm4424575wme.23.2019.10.01.06.36.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 01 Oct 2019 06:36:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/8] hppa: fix leak from g_strdup_printf
Date: Tue,  1 Oct 2019 15:36:24 +0200
Message-Id: <1569936988-635-5-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1569936988-635-1-git-send-email-pbonzini@redhat.com>
References: <1569936988-635-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

memory_region_init_* takes care of copying the name into memory it owns.
Free it in the caller.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/hppa/dino.c    | 1 +
 hw/hppa/machine.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index e0466ee..ab6969b 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -485,6 +485,7 @@ PCIBus *dino_init(MemoryRegion *addr_space,
         memory_region_init_alias(&s->pci_mem_alias[i], OBJECT(s),
                                  name, &s->pci_mem, addr,
                                  DINO_MEM_CHUNK_SIZE);
+        g_free(name);
     }
 
     /* Set up PCI view of memory: Bus master address space.  */
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 2736ce8..7e23675 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -78,13 +78,15 @@ static void machine_hppa_init(MachineState *machine)
 
     /* Create CPUs.  */
     for (i = 0; i < smp_cpus; i++) {
+        char *name = g_strdup_printf("cpu%ld-io-eir", i);
         cpu[i] = HPPA_CPU(cpu_create(machine->cpu_type));
 
         cpu_region = g_new(MemoryRegion, 1);
         memory_region_init_io(cpu_region, OBJECT(cpu[i]), &hppa_io_eir_ops,
-                              cpu[i], g_strdup_printf("cpu%ld-io-eir", i), 4);
+                              cpu[i], name, 4);
         memory_region_add_subregion(addr_space, CPU_HPA + i * 0x1000,
                                     cpu_region);
+        g_free(name);
     }
 
     /* Limit main memory. */
-- 
1.8.3.1



