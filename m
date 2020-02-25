Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB8BC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:20:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9FA12176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijvVQeiV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9FA12176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZCV-0000uk-PZ
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:20:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl3-0001G1-GA
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykz-0008Fn-8T
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:13 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:34094)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Ykx-00085Q-DD
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:08 -0500
Received: by mail-wm1-x32e.google.com with SMTP id i10so939791wmd.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mokEQf2xIZXyVf7hgVorPbcUdN09SIKwvfoY1oWCtGE=;
 b=ijvVQeiV5eZM+Ragq6cDOHnMH5NGBxCvKdsg6NrQFxXKLrrTugEGrh8eNX1v7yoicW
 NFdcTpieXP1P+UdAdaY9A0bdLkq6TJse+qZLO4JXQMlsGvmrqC/9TKt9JKrfwA9WVf0D
 Yi8HOQlZFoAIxKnybrawhcTIQP96O+Kb81YYwYsG8COsBFpRb/2/x08+S+KWTjVnAlhQ
 C2g+YXziVXhWtM0PshtKajxSmA9h9U4V+kmPDnWBUUG3Z1h25siQg00WLkpbAO7YklQc
 2uGy5Pmm4+GViw/W8SOIJwmg5IgyODVhJtXgfMYZwSb2DaGyB60S9nits/QPuY2HFPir
 eujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=mokEQf2xIZXyVf7hgVorPbcUdN09SIKwvfoY1oWCtGE=;
 b=PBxgFTsD8Rw7tVLBF4YECKVw/3GraGOEG0sl8QndUy042GdYtF6gxpxGpI3gPLWVjK
 OvhnOBkZIiMjgKoNR8bzsnM5Ke1ikLvkShK9EQnEuCHa/lJHmCbwmoM8cduAgIy5XzNd
 EkQdRX0FlMzG4KnzZkJxlUhap2HG797P8fxhWggAGokO3yfR7jp1RB20MU3GtYgBCuq4
 AGc12I6veeyk+XlptTI4+creZWO3etuKD8yM+w2V1axWx/FzWrT4iiBwHRm5qPAt5NYB
 ow0hRanoJh2CjDZEMAFztWJRr96Oj0HvHaDSa6vGrCtovozUA5oAMPL395MvIBNUKbgo
 ygAQ==
X-Gm-Message-State: APjAAAXmKvmLi+uYyVNrYNsngVMinx0w76H4j1vAHLCNeopWGPs19NUD
 daoiqC+RqV2pKwsskhHG7F4c0VOQ
X-Google-Smtp-Source: APXvYqwGUhCq7peHmsXHhjixMGoXOFOxpidRSqziplRNM0Dukn5PlZQRK6v+Sn/QdaIobZJXe0Lgxg==
X-Received: by 2002:a7b:c088:: with SMTP id r8mr4990037wmh.18.1582631522074;
 Tue, 25 Feb 2020 03:52:02 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 061/136] ppc/mac_oldworld: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:51 +0100
Message-Id: <1582631466-13880-61-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
Message-Id: <20200219160953.13771-62-imammedo@redhat.com>
---
 hw/ppc/mac_oldworld.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 7318d7e..66e434b 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -91,7 +91,6 @@ static void ppc_heathrow_init(MachineState *machine)
     CPUPPCState *env = NULL;
     char *filename;
     int linux_boot, i;
-    MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *bios = g_new(MemoryRegion, 1);
     uint32_t kernel_base, initrd_base, cmdline_base = 0;
     int32_t kernel_size, initrd_size;
@@ -127,9 +126,7 @@ static void ppc_heathrow_init(MachineState *machine)
         exit(1);
     }
 
-    memory_region_allocate_system_memory(ram, NULL, "ppc_heathrow.ram",
-                                         ram_size);
-    memory_region_add_subregion(sysmem, 0, ram);
+    memory_region_add_subregion(sysmem, 0, machine->ram);
 
     /* allocate and load BIOS */
     memory_region_init_ram(bios, NULL, "ppc_heathrow.bios", BIOS_SIZE,
@@ -446,6 +443,7 @@ static void heathrow_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("750_v3.1");
     mc->default_display = "std";
     mc->ignore_boot_device_suffixes = true;
+    mc->default_ram_id = "ppc_heathrow.ram";
     fwc->get_dev_path = heathrow_fw_dev_path;
 }
 
-- 
1.8.3.1



