Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC156C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:22:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9AE320CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9rBDafh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9AE320CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54005 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZE8-0004SM-TQ
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:22:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl4-0001IF-7w
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykz-0008Ht-FS
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:14 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:52809)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Ykz-00084k-0r
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:09 -0500
Received: by mail-wm1-x331.google.com with SMTP id p9so2680924wmc.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xma2+4S55weDzTQ3z96ys9FOf+xrE/zxwn4CakN0mJc=;
 b=Z9rBDafhvdkikLz4WB6k2S1Kj/NoH0LGnbmP83jje5TTFaP3BOrKvQbZCKfJcrw0G0
 K4E8LhrvrWJIAIzNBKHvNoA8TaIVVz+lwFsThhKFqpC4/vbND8Nso2qUYepO+qPWdd3Q
 99FariPwdkzjOomvIKTw5snEukoPPxGQSann/2l5MuONva3hG6X3W7MCzPNISKkk0BlR
 HF8A06as7QbET8JqlD/95g6Bb4jKrQugJdDgjeo1QsLBasvCNKtGqc0erZxi55gWUHrI
 Lqn2bUIYO0LUF+dd0csR/yOSh3+3ESKuN4uFVwMtNhnRBXi/U2teXd22rF1xEwqyyi9z
 cKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=xma2+4S55weDzTQ3z96ys9FOf+xrE/zxwn4CakN0mJc=;
 b=poBWW2q9DYpk3DG7Z+i+XO15KvKy2kB1mdhRtd5TDohiptEtH3qdIYFinkjmJq0QD5
 3MqFC4oeJXiz00i5AbaH89reaCYGgY1jRD6x44piDgyax8CoKPX2z9lPJjwG9W+v3RJt
 XVUzhlNcZ8Q/B/yMUgaz2b4LyQ55AtdQMoH1Kv1gSDmY5CJGmL59grWCITUnBKk4i+k2
 ntoNXtGbHnsiLV8QDO+B8ixAZRBICQS94eOBJVZwEMIJcxyW1Qc5/wBQwDkBZZth4wCw
 nrJzbj33q51GBlRSXJtg4+/WjQ7JR+bYb4uYqbP/e8ac16hvsVLitibXaSya3Wj3UtBz
 SeTw==
X-Gm-Message-State: APjAAAUKZ65fCNvuCV7FK4JNHbHn2dPc2n0zUb+tzJXIxcmRW+Ocmbwf
 FNMqDwyrZ5Cq2lNcben7bPDn4h5w
X-Google-Smtp-Source: APXvYqy+qqiwR4wh2iLICQ4MnFC6dygqgRBRnChaOcTsIUh9sCrrL8w24BpeiuYNbXLswmqrS0qP6w==
X-Received: by 2002:a1c:9ed7:: with SMTP id h206mr4882964wme.67.1582631521240; 
 Tue, 25 Feb 2020 03:52:01 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 060/136] ppc/mac_newworld: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:50 +0100
Message-Id: <1582631466-13880-60-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200219160953.13771-61-imammedo@redhat.com>
---
 hw/ppc/mac_newworld.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 464d012..b8189bf 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -118,7 +118,7 @@ static void ppc_core99_init(MachineState *machine)
     char *filename;
     IrqLines *openpic_irqs;
     int linux_boot, i, j, k;
-    MemoryRegion *ram = g_new(MemoryRegion, 1), *bios = g_new(MemoryRegion, 1);
+    MemoryRegion *bios = g_new(MemoryRegion, 1);
     hwaddr kernel_base, initrd_base, cmdline_base = 0;
     long kernel_size, initrd_size;
     UNINHostState *uninorth_pci;
@@ -152,8 +152,7 @@ static void ppc_core99_init(MachineState *machine)
     }
 
     /* allocate RAM */
-    memory_region_allocate_system_memory(ram, NULL, "ppc_core99.ram", ram_size);
-    memory_region_add_subregion(get_system_memory(), 0, ram);
+    memory_region_add_subregion(get_system_memory(), 0, machine->ram);
 
     /* allocate and load BIOS */
     memory_region_init_ram(bios, NULL, "ppc_core99.bios", BIOS_SIZE,
@@ -586,6 +585,7 @@ static void core99_machine_class_init(ObjectClass *oc, void *data)
 #else
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("7400_v2.9");
 #endif
+    mc->default_ram_id = "ppc_core99.ram";
     mc->ignore_boot_device_suffixes = true;
     fwc->get_dev_path = core99_fw_dev_path;
 }
-- 
1.8.3.1



