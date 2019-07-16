Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A1AC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 04:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF1D220880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 04:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWnCoy/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1D220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnFWQ-0004BE-Vs
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 00:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39208)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <joel.stan@gmail.com>) id 1hnFWG-0003j3-HR
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 00:56:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1hnFWE-0005wZ-HD
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 00:56:52 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40606)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1hnFWA-0005jT-Tp; Tue, 16 Jul 2019 00:56:47 -0400
Received: by mail-pg1-x544.google.com with SMTP id w10so8790358pgj.7;
 Mon, 15 Jul 2019 21:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=84EdYxFDMFqQ8NYPswNkXpi54sRKOo94ARjpEEadd+w=;
 b=mWnCoy/jcaqKDU/GC3iglKAt5tKeZuyLuU+wzOGz1RuSTiw3PJDKZ4tmAqY544PKNf
 bvyTelgxSyEwYQdeLKiTdjhoLNMGhpgt8xQ1VY0LWcK4EWAFsZ1HkdK2BJywSSZ5V1/H
 rO/HPQzu30DR2pPn34lPoSibOSlar42BDJhvAvQvMMAx+w3tHDis6KZgPKUXa6u39oHR
 /KQcjKRM+ECAQPsLsRhvizIwK6L3dvZV9/9YmNHp1zOJVkw16hdiwKckCZU32Hh8Bb6O
 lkqFlh8qjirBJ1nqvUDqOxaI8Gksp6gOisrroxTZJyWuMa8OFZDuUV1V4AOhKFYfKPXl
 ywfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=84EdYxFDMFqQ8NYPswNkXpi54sRKOo94ARjpEEadd+w=;
 b=LLi5arvFAoo+XEAki9kH0pxtCrME+9IxL53c6+Z5R0QtRfTxDMp33Y/oNHdgz60DgZ
 JtHAUVUviJYAi5bei5P/S+LtFY9c3PGofea4H5FKJR4kLirO+PsTI2Hg1YCGEbM8gp1V
 5ajD0LA6OwDccpqhfL4TaHi4gYFX7Fd5vi5l09L4KrnBcghG97IYdmLDcvIqhKIFHZXA
 lOWgXQOjQMoBB2mbu8SUsrHj3rX0lKMWuoUZEp1SiezJWwSxowxWV1BhLt81XmS1Gr33
 43frtliLcNe9OqbWWcx0qVGdff6CEXR52JuAVwy9EXTMIWaBBtK91Pr7f7+7X1AMYBkm
 gOQg==
X-Gm-Message-State: APjAAAUt5ZLoc6QHm0xVcE4i0PpAU5OjYDg0XTjkBM8dD1p/K4PUC8yX
 xs7sBoKAAw103dexJOMxrwM=
X-Google-Smtp-Source: APXvYqy49xD3NLzvE0Gy8u4A4NBMcJj1Byhd5Oijw5gQcRQoeElTVJXjqkCaIv7ts22NSIoJvlDylw==
X-Received: by 2002:a17:90a:7d04:: with SMTP id
 g4mr33890745pjl.41.1563253002902; 
 Mon, 15 Jul 2019 21:56:42 -0700 (PDT)
Received: from voyager.ibm.com ([36.255.48.244])
 by smtp.gmail.com with ESMTPSA id o14sm39201167pfh.153.2019.07.15.21.56.40
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 15 Jul 2019 21:56:42 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 16 Jul 2019 14:26:33 +0930
Message-Id: <20190716045633.15319-1-joel@jms.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH] ppc/pnv: Warn when using -initrd and low ram
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When booting with the default amount of RAM the powernv machine will
load the initrd above the top of RAM and cause the Linux kernel to crash
when it attempts to access the initrd:

  Linux/PowerPC load:
  Finalizing device tree... flat tree at 0x202770c0
  [    0.070476] nvram: Failed to find or create lnx,oops-log partition, err -28
  [    0.073270] nvram: Failed to initialize oops partition!
  [    0.156302] BUG: Unable to handle kernel data access at 0xc000000060000000
  [    0.158009] Faulting instruction address: 0xc000000001002e5c
  cpu 0x0: Vector: 300 (Data Access) at [c00000003d1e3870]
      pc: c000000001002e5c: unpack_to_rootfs+0xdc/0x2f0
      lr: c000000001002df4: unpack_to_rootfs+0x74/0x2f0
      sp: c00000003d1e3b00
     msr: 9000000002009033
     dar: c000000060000000
   dsisr: 40000000
    current = 0xc00000003d1c0000
    paca    = 0xc000000001320000	 irqmask: 0x03	 irq_happened: 0x01
      pid   = 1, comm = swapper/0
  Linux version 5.2.0-10292-g040e2e618374 (joel@voyager) (gcc version 8.3.0 (Debian 8.3.0-2)) #1 SMP Tue Jul 16 13:50:32 ACST 2019
  enter ? for help
  [c00000003d1e3bb0] c000000001003c90 populate_rootfs+0x84/0x1dc
  [c00000003d1e3c40] c00000000000f494 do_one_initcall+0x88/0x1d0
  [c00000003d1e3d10] c000000001000fc4 kernel_init_freeable+0x24c/0x250
  [c00000003d1e3db0] c00000000000f7a0 kernel_init+0x1c/0x150
  [c00000003d1e3e20] c00000000000b8a4 ret_from_kernel_thread+0x5c/0x78

Provide a helpful message for users so they don't go reporting bugs to
kernel developers.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
We could solve this in other ways, such as warn when loading the initrd
outside of RAM, or load it within the known boundaries or RAM, but after
hitting this myself I wanted to start the discussion.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/ppc/pnv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index bd4531c82260..bbd596ab9eca 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -649,6 +649,13 @@ static void pnv_init(MachineState *machine)
 
     /* load initrd */
     if (machine->initrd_filename) {
+        if (machine->ram_size <= (1.5 * GiB)) {
+            /* INITRD_LOAD_ADDR is at 1.5GB, so we require at least that much RAM
+             * when specifying the initrd on the command line */
+            warn_report("initrd load requires > %ld MB of RAM",
+                    INITRD_LOAD_ADDR / MiB);
+        }
+
         pnv->initrd_base = INITRD_LOAD_ADDR;
         pnv->initrd_size = load_image_targphys(machine->initrd_filename,
                                   pnv->initrd_base, INITRD_MAX_SIZE);
-- 
2.20.1


