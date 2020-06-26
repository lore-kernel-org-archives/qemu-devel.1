Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA636C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:24:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A1E20773
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DyYW4V0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A1E20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqDg-0002Uo-Na
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq3j-0001nX-Hg
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:31 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:45067)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq3h-0006Ar-Qu
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:31 -0400
Received: by mail-wr1-x430.google.com with SMTP id s10so9821636wrw.12
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=acP3Sx4OGOgiAbreBwnSKlVu9vGjvqCv6xOFJh6nkmA=;
 b=DyYW4V0N7Rs19CAsNBze9ru/0AxHimeYSIXEkvBK6WH8PJ/+L1x4b7EPs7NSVGhbNI
 e+YKG3uNKxLC7ay37ssKVSN62NNq+vyX7aViRjCvuDKCu4Gk5TBuJK9nc7uBBET4PS1E
 saTNuuKgp/UnVSdLKLQ7HfMYh7z3lxmtV/8cM4d2KxzXw3LHRTxXWtAwcKkcHcmQ9nU2
 jN/jPZqXc8VJwVuL5twYIady742o5e7ezQjcm5SRjZszDaaMBwvVu80GzftVXBa60HTj
 QhVUXbzJAHRLGRG066F4b+usmWUybYW/8QyVjCu9Jb5oNb8Q3nrsWpv5xUewhsSZjOlQ
 xIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=acP3Sx4OGOgiAbreBwnSKlVu9vGjvqCv6xOFJh6nkmA=;
 b=KlJUsr2gM0eLpTDYDbRueUp0puAobuZOLnv4s4rmQFcEj2aowJew4C7MJCMJuvDOYS
 6fe6ypdYEAWUkUAzFzIZTnypVM7uJOjVM+3R2bpKhD6zc1Z1aEt1cxDjSiFUieqwgcVj
 +eohKyArfwhZiBfPg6/VtmVvLy/qQbxQ+FVz+JGy3NggLiyZ0TxkJgrpMpe0ZWhUExoL
 SPv/vg8cNneI6RPAulxJXgUVIpnTJI6a/5UBwJHcd+40H0KGeROJyBt7P4PPYNcE6OvR
 b/Bl1XzjGl/pW5iT0sXG4l5ywmQvR1PujsEQFO+cDmTiH152Qu8Z0V/7DvRqYeUxSQhi
 J1Og==
X-Gm-Message-State: AOAM530QQN309Vvs4hX0vUlJjML9GxN8B975ixXV6KZWGlrenxU2tjDL
 mF3hDr7xCNfF1Qp3FTFY8KIV3vwx2aLBag==
X-Google-Smtp-Source: ABdhPJxGXe7yGCiyniGBRQadKbMYMNdWDp2UwCSn5foHC8Xdjj2cL9wklYtDh9DF9mbF2botcCJpcg==
X-Received: by 2002:adf:c404:: with SMTP id v4mr4126758wrf.85.1593184468148;
 Fri, 26 Jun 2020 08:14:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.14.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:14:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/57] hw/arm/aspeed: Remove extraneous MemoryRegion object
 owner
Date: Fri, 26 Jun 2020 16:13:28 +0100
Message-Id: <20200626151424.30117-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
Message-id: 20200623072132.2868-2-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 863757e1f03..167fd5ed1c7 100644
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
2.20.1


