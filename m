Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74767C2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:53:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FF5520692
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvbBrLyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF5520692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNlTR-0005kk-Cn
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 18:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlEU-0007tj-9B
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlES-00039U-4w
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:37:42 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33148)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlER-00038t-Ua; Sun, 12 Apr 2020 18:37:40 -0400
Received: by mail-wr1-x444.google.com with SMTP id a25so8559991wrd.0;
 Sun, 12 Apr 2020 15:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Y8TMNAxjLNSnTnU3+gPKyE2L5mZZ/LKhb2zY67/m5zA=;
 b=MvbBrLyCvTZ/70lcVY/q6ms0rvsDExeGsXFbBqzdolKTlhTT6i0SvOU+QFnk8TlqP9
 vzObHMw67W76UOMpDd4eS6nXQqotcUwTNzCnjxF4H2IFvnEAWiR2iKfYkbdhf2cy+xNn
 y2fPzYUFmdpGNQ2wY+PhEuaJhLTv0zRzj/QalgIDh/in59It8/CD1StdgaNrx+PUOS0X
 5XrmbxAxlt27m3oET3BbCeclEjW/qu1xy6Tqom+saQp03iNXJPl7HqZdibrz6lZpnCC6
 x2ZPbbnpe8IVl/t+mt/pQBiDmGW0aq2QZX28nV9P7uhAoLuo+Z691eRZK4jkbq3E82FW
 rfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Y8TMNAxjLNSnTnU3+gPKyE2L5mZZ/LKhb2zY67/m5zA=;
 b=jtbH5t6/FS46Eu+dSNBTWDlFC86jW91HXjSlz9YcjJhUOf5gcGk6LYMoGKjsVUtlHD
 HIAJoyqNpu5BNU2kYRxoLUGWLqon6nAwHfZC95ffr93HQpiRX0Hpr4n2st9fF0WTUH2Q
 c4+qqLGlW+odehJ+aoWwiDND4oFl1BW93Fz2TOc4tVYmoQC/MBDUkzd/sywamt0FEMJz
 kzmXAlrHZcveNIL6AUCyyOC9+keaYoNtLA1fzC7EXqxp/Wv/n5ZKeZbzoyAVlHqxO3u6
 rZQQKCtgLQzILYXcw+VM2MO+tTakO7q0+SkMiTPetA3vs0s7dcAojiKpCmSMmasRjPAf
 k9xA==
X-Gm-Message-State: AGi0PuZb4VaHvv3Q5zSsauq1ajLVg9aT64WKh09cUz/R77GsISSCZONh
 vZqc2sC+Gw8LaH9d3tJjQBnnUuIbTTuOTA==
X-Google-Smtp-Source: APiQypLciWgZ1RglVtEmrha9Cp5muhPhK+QnDF/3m6tgDPz4KlgtF4oYxSEcUAdA5pyuOK8twCySnQ==
X-Received: by 2002:adf:dd07:: with SMTP id a7mr2653756wrm.349.1586731058777; 
 Sun, 12 Apr 2020 15:37:38 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id d13sm12563559wrv.34.2020.04.12.15.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 15:37:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 22/24] hw/riscv/sifive_u: Store MemoryRegion in
 SiFiveUSoCState
Date: Mon, 13 Apr 2020 00:36:17 +0200
Message-Id: <20200412223619.11284-23-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200412223619.11284-1-f4bug@amsat.org>
References: <20200412223619.11284-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Wen Congyang <wencongyang2@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coccinelle reported:

  $ spatch ... --timeout 60 --sp-file \
    scripts/coccinelle/simplify-init-realize-error_propagate.cocci
  HANDLING: ./hw/riscv/sifive_u.c
  >>> possible moves from riscv_sifive_u_soc_init() to riscv_sifive_u_soc_realize() in ./hw/riscv/sifive_u.c:473

While reviewing we notice storing the MemoryRegion in the device
state, we'll be able to later automatically simplify the error
propagation calls.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/riscv/sifive_u.h |  2 ++
 hw/riscv/sifive_u.c         | 10 ++++------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 82667b5746..254c6a64f8 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -42,6 +42,8 @@ typedef struct SiFiveUSoCState {
     SiFiveUPRCIState prci;
     SiFiveUOTPState otp;
     CadenceGEMState gem;
+    MemoryRegion mask_rom;
+    MemoryRegion l2lim_mem;
 } SiFiveUSoCState;
 
 #define TYPE_RISCV_U_MACHINE MACHINE_TYPE_NAME("sifive_u")
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 754af19eef..96177c1977 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -478,8 +478,6 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     SiFiveUSoCState *s = RISCV_U_SOC(dev);
     const struct MemmapEntry *memmap = sifive_u_memmap;
     MemoryRegion *system_memory = get_system_memory();
-    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
-    MemoryRegion *l2lim_mem = g_new(MemoryRegion, 1);
     qemu_irq plic_gpios[SIFIVE_U_PLIC_NUM_SOURCES];
     char *plic_hart_config;
     size_t plic_hart_config_len;
@@ -503,10 +501,10 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
                              &error_abort);
 
     /* boot rom */
-    memory_region_init_rom(mask_rom, OBJECT(dev), "riscv.sifive.u.mrom",
+    memory_region_init_rom(&s->mask_rom, OBJECT(dev), "riscv.sifive.u.mrom",
                            memmap[SIFIVE_U_MROM].size, &error_fatal);
     memory_region_add_subregion(system_memory, memmap[SIFIVE_U_MROM].base,
-                                mask_rom);
+                                &s->mask_rom);
 
     /*
      * Add L2-LIM at reset size.
@@ -517,10 +515,10 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
      * leave it enabled all the time. This won't break anything, but will be
      * too generous to misbehaving guests.
      */
-    memory_region_init_ram(l2lim_mem, NULL, "riscv.sifive.u.l2lim",
+    memory_region_init_ram(&s->l2lim_mem, NULL, "riscv.sifive.u.l2lim",
                            memmap[SIFIVE_U_L2LIM].size, &error_fatal);
     memory_region_add_subregion(system_memory, memmap[SIFIVE_U_L2LIM].base,
-                                l2lim_mem);
+                                &s->l2lim_mem);
 
     /* create PLIC hart topology configuration string */
     plic_hart_config_len = (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1) *
-- 
2.21.1


