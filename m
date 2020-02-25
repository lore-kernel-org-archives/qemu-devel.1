Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEEFC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EDDC2176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgxUUrTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EDDC2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Yqg-00044i-J2
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkF-0000Et-Cr
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkB-0005iN-9t
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:23 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:43430)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkB-0005WC-0R
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:19 -0500
Received: by mail-wr1-x436.google.com with SMTP id r11so14365834wrq.10
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yl5PNR0cOcMvgjoA4myauP05KwEquyPe5Q8ftOEwUR0=;
 b=mgxUUrTmkHrgSFBBEdM/qPAiloO6y7nqTzalxGVJzhHNS65TRI6LsZgrAwgsMxNTGb
 SvCrSvnWC9rpM9/bUl8Y9p4c2fn4js/sPha4KICy6MEgcpYn81L7mQRWeRi44Ylj2QR6
 WuMAdlYE1bBFwNArwtfeFQaZ9pUlJlTREkwCaRx3lF/kMvTO+243GxuPfXhv/kYEKcoh
 NxBIOfpWopSOHyWsurN3Yv5d4fBkZMt+cWCzuUvnU9+NNeFNF5KyC6wczcOacjGrIXP5
 LN7jgGI4kZ6amzXZA6C9gkXCtfN9szJ2LWpML/zvOb7SBjtvVfCMz/1yrjortdDpl234
 Fibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=yl5PNR0cOcMvgjoA4myauP05KwEquyPe5Q8ftOEwUR0=;
 b=HS6Xg0xA9Jkl03sXk9SPmdpscdoN2tOdr7Pi9vhD+5QEz96X/KLgtldPsEyOl1k8Rq
 aukBSlwERN42GKDybGOaye9XQk0DVwevsCt53NIpclzwrUp+QBW5Ct3FKnIBegWnfYEt
 2pV7w6O3VQ26tHPKB3MFilpnzOiEkz6u/+zjlcUM86AjQoVoji624wuxIUCrS7k8jhkG
 YYiyFwf8Nts9HYJyAV/+Jr0CrlTQ22zkeuhJI/bfcQsZIoDvKF6v3gvpekCRznFlrId/
 r6ol7ezyCT1aUAFbUejN04dDKV9C3Khk+ZF9iaSu6SRk5f9r+/KyqxnDKMaELOKJRLC/
 +woQ==
X-Gm-Message-State: APjAAAUhTqEdI5T6skXnlUmVhnOVXaO0CpsGOsmCRGX2Sj1PQi9P1Uev
 D0HGLPH9EJ2Ls4qqh6VZ4doq6Hnx
X-Google-Smtp-Source: APXvYqyn5JUmjbS3/c9bQtfAMoGbjbe95qJhhNmiFVcOxZvuTDpsibwIkH1cv2pJFaUtgKL7kOMRAA==
X-Received: by 2002:a05:6000:1142:: with SMTP id
 d2mr8706578wrx.62.1582631476262; 
 Tue, 25 Feb 2020 03:51:16 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 010/136] arm/aspeed: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:00 +0100
Message-Id: <1582631466-13880-10-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Acked-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-11-imammedo@redhat.com>
---
 hw/arm/aspeed.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 805bebd..a6a2102 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -35,7 +35,6 @@ static struct arm_boot_info aspeed_board_binfo = {
 struct AspeedBoardState {
     AspeedSoCState soc;
     MemoryRegion ram_container;
-    MemoryRegion ram;
     MemoryRegion max_ram;
 };
 
@@ -197,6 +196,7 @@ static void aspeed_machine_init(MachineState *machine)
 
     memory_region_init(&bmc->ram_container, NULL, "aspeed-ram-container",
                        UINT32_MAX);
+    memory_region_add_subregion(&bmc->ram_container, 0, machine->ram);
 
     object_initialize_child(OBJECT(machine), "soc", &bmc->soc,
                             (sizeof(bmc->soc)), amc->soc_name, &error_abort,
@@ -232,8 +232,6 @@ static void aspeed_machine_init(MachineState *machine)
     object_property_set_bool(OBJECT(&bmc->soc), true, "realized",
                              &error_abort);
 
-    memory_region_allocate_system_memory(&bmc->ram, NULL, "ram", ram_size);
-    memory_region_add_subregion(&bmc->ram_container, 0, &bmc->ram);
     memory_region_add_subregion(get_system_memory(),
                                 sc->memmap[ASPEED_SDRAM],
                                 &bmc->ram_container);
@@ -436,6 +434,7 @@ static void aspeed_machine_class_init(ObjectClass *oc, void *data)
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_parallel = 1;
+    mc->default_ram_id = "ram";
 
     aspeed_machine_class_props_init(oc);
 }
-- 
1.8.3.1



