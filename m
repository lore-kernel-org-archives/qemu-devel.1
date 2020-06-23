Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BBCC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 642642072E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibDcSytH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642642072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jndGO-0001DZ-Kd
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 03:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jndFT-0007Xu-9m; Tue, 23 Jun 2020 03:21:39 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54798)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jndFR-0003E6-OU; Tue, 23 Jun 2020 03:21:39 -0400
Received: by mail-wm1-x342.google.com with SMTP id o8so199764wmh.4;
 Tue, 23 Jun 2020 00:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RMpBNhc9DgLKSQexvXdiyWq7znNYqzLKh6dEFIwERf0=;
 b=ibDcSytHesvRHcej6SkOn0MRHhZjM0DrQHKLAZ0pywqwKj6jUh04vK0uygLi2ZHgpe
 pZQMphv5aTWUpo2gdYGoURXyJzhg4HJ2ulGDgdFClvoFS/2+BIAgnbb+smkEh04rkqSf
 4phyGxd9W914t5X8RBcOr17qdOcsK2OuQC5A/y55U9U8G1odoQZ8WK/k28pd7YiT7jgB
 kZmmfBDgqXBrPp9INDHOWOnIcZPsGZbKj8/+901ZS+pZKDLf93WJ+pg+PT9/l7oSiEUA
 iO2m1ubh92MOsfwvG1kfBRieB/0dWbvkLTGQSQBBRQPDf+e2U0y4Ha8tRsyh3BkXVbc9
 2JLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=RMpBNhc9DgLKSQexvXdiyWq7znNYqzLKh6dEFIwERf0=;
 b=QTQnTT1muwcGuv3G4sV2VIMplEyvxCpxQVaBULeswnO+i90WdC3z40AmWVpr39/RYX
 3Tpuk5Vs3T1ecfcoqI0kV3chFS31+tmOvALM7pvAbSKKOmLv5HL5molpjdw9KDnKMug4
 T77xNb13PNfNyg1Pq/flyfh/ShHPW0p2RlyAfcC9X7WrYzm/xv4tfHNnYMCOMTiinDy4
 kT8Q33cGWJOhNHi8/SLQfJ/h7cCXVPE1IM0S7SnZCJloHuDdh+YRIbkvW2vH1lp9vocS
 uGu636Q0zzJU83EhUNne8t8Tz/G62HD4XWbarfDNUDVcS9WPi2FyVaLrpNKRfLPv8deK
 ZvCw==
X-Gm-Message-State: AOAM532bcrdI0YQZi1vy82knv8nzEpuJl+qrLBBXc2ZqfA0LznM0aBnh
 vj/mscJp1/m7QqZDN8SfR4pGm5zm
X-Google-Smtp-Source: ABdhPJygLfr+DKpBDsMp4dRfA2EDmkaC1b0eKKbFDSpNIFyPPSla5hx1wJUg+NiR9dwXUYIyAtyWog==
X-Received: by 2002:a1c:e914:: with SMTP id q20mr21877978wmc.145.1592896895769; 
 Tue, 23 Jun 2020 00:21:35 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x13sm21877236wre.83.2020.06.23.00.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 00:21:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] hw/arm/aspeed: Remove extraneous MemoryRegion object
 owner
Date: Tue, 23 Jun 2020 09:21:30 +0200
Message-Id: <20200623072132.2868-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200623072132.2868-1-f4bug@amsat.org>
References: <20200623072132.2868-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm confused by this code, 'bmc' is created as:

  bmc = g_new0(AspeedBoardState, 1);

Then we use it as QOM owner for different MemoryRegion objects.
But looking at memory_region_init_ram (similarly for ROM):

  void memory_region_init_ram(MemoryRegion *mr,
                              struct Object *owner,
                              const char *name,
                              uint64_t size,
                              Error **errp)
  {
      DeviceState *owner_dev;
      Error *err = NULL;

      memory_region_init_ram_nomigrate(mr, owner, name, size, &err);
      if (err) {
          error_propagate(errp, err);
          return;
      }
      /* This will assert if owner is neither NULL nor a DeviceState.
       * We only want the owner here for the purposes of defining a
       * unique name for migration. TODO: Ideally we should implement
       * a naming scheme for Objects which are not DeviceStates, in
       * which case we can relax this restriction.
       */
      owner_dev = DEVICE(owner);
      vmstate_register_ram(mr, owner_dev);
  }

The expected assertion is not triggered ('bmc' is not NULL neither
a DeviceState).

'bmc' structure is defined as:

  struct AspeedBoardState {
      AspeedSoCState soc;
      MemoryRegion ram_container;
      MemoryRegion max_ram;
  };

What happens is when using 'OBJECT(bmc)', the QOM macros cast the
memory pointed by bmc, which first member is 'soc', which is
initialized ...:

  object_initialize_child(OBJECT(machine), "soc",
                          &bmc->soc, amc->soc_name);

The 'soc' object is indeed a DeviceState, so the assertion passes.

Since this is fragile and only happens to work by luck, remove the
dangerous OBJECT(bmc) owner argument.

Note, this probably breaks migration for this machine.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/aspeed.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 0ad08a2b4c..31765792a2 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -329,12 +329,12 @@ static void aspeed_machine_init(MachineState *machine)
          * needed by the flash modules of the Aspeed machines.
          */
         if (ASPEED_MACHINE(machine)->mmio_exec) {
-            memory_region_init_alias(boot_rom, OBJECT(bmc), "aspeed.boot_rom",
+            memory_region_init_alias(boot_rom, NULL, "aspeed.boot_rom",
                                      &fl->mmio, 0, fl->size);
             memory_region_add_subregion(get_system_memory(), FIRMWARE_ADDR,
                                         boot_rom);
         } else {
-            memory_region_init_rom(boot_rom, OBJECT(bmc), "aspeed.boot_rom",
+            memory_region_init_rom(boot_rom, NULL, "aspeed.boot_rom",
                                    fl->size, &error_abort);
             memory_region_add_subregion(get_system_memory(), FIRMWARE_ADDR,
                                         boot_rom);
@@ -345,7 +345,7 @@ static void aspeed_machine_init(MachineState *machine)
     if (machine->kernel_filename && sc->num_cpus > 1) {
         /* With no u-boot we must set up a boot stub for the secondary CPU */
         MemoryRegion *smpboot = g_new(MemoryRegion, 1);
-        memory_region_init_ram(smpboot, OBJECT(bmc), "aspeed.smpboot",
+        memory_region_init_ram(smpboot, NULL, "aspeed.smpboot",
                                0x80, &error_abort);
         memory_region_add_subregion(get_system_memory(),
                                     AST_SMP_MAILBOX_BASE, smpboot);
-- 
2.21.3


