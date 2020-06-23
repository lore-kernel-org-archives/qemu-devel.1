Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07901C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:24:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B9F2072E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9oXLHvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B9F2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jndI4-0003nM-2J
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 03:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jndFV-0007eL-V4; Tue, 23 Jun 2020 03:21:41 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jndFU-0003FN-Cm; Tue, 23 Jun 2020 03:21:41 -0400
Received: by mail-wm1-x341.google.com with SMTP id 22so1090837wmg.1;
 Tue, 23 Jun 2020 00:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZzgsyFKQ+0jPZU1EMlN0VKvlb6aohKF8k/McGbTdz6k=;
 b=c9oXLHvCoSj113SCvh5uXN7SSau0tvSh07arZdET1KzoCQbd2YzZhIxFT08WYYeGQV
 +OfHKjt5FDQWJ4zVBm/1jyqzxBzV1HitH/1g8UM+wbIHtOb2WnHo32t9e4dh/o60I83F
 R4lWMzoLFbEtCdwkLjle7jUa+zbjCDXsxI6Y/20vqHumm3ecc6QGEajEQy3eaxmzSPSz
 WU10r5sahqBFWlgS+6sYtEsyVMd/E9BoItLiS0yz2yqgYgMRxqLFm8CKnwg2G8MnK/fG
 TAv4sbNpsMAMwMSRV6ULP20Kh16sq12ki+giB/wlqqQsZIUYZee55ieGqyJS/wnwx8mB
 IzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ZzgsyFKQ+0jPZU1EMlN0VKvlb6aohKF8k/McGbTdz6k=;
 b=ogANjFFWBNwaq+mlVzNYxb8S/If0ws1Eb1aSKqUp5KjSWCxORTF6eTctezwIZBRqy7
 j5XjIGWexFSS1JX5Dw645WUY8t8PVsiCDnhz2NC2BATK28xxs5XjmttyizKJSxjg5ns/
 MdrrGOzxM7NB3xmF0cLJ3bIzBAD4B/qAjNVOG2BGLGCyl1KASCxs03+nb0DAORccgPwW
 BrdN2dfboPVUeVF3Unt1EvQFSq+IpoKMLsVI4XinYdauJCQHwp0ewk3qDRmTHGofSR3m
 jNfqe6VnJ3mhPViMLA3zVlsBHIuBPuAQwGiWhb9tLS2+reP/8qtokaAfMbexC5UXfOWE
 zjtg==
X-Gm-Message-State: AOAM531ckaQKyNscWaDSItGIQwWkBtPvmke3bASV/9X8Z6EzsJcBbYby
 gvuyV8QOVAILhg792vtfWDrn2BSL
X-Google-Smtp-Source: ABdhPJz/gzgzur3L68NzRoUqOPZtKRp4snJxyEVg2JF6+RXsEbp496oqKbXD7IEdxzZeleYpbszR7A==
X-Received: by 2002:a1c:9687:: with SMTP id y129mr22520132wmd.30.1592896898479; 
 Tue, 23 Jun 2020 00:21:38 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x13sm21877236wre.83.2020.06.23.00.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 00:21:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] hw/arm/aspeed: QOM'ify AspeedMachineState
Date: Tue, 23 Jun 2020 09:21:32 +0200
Message-Id: <20200623072132.2868-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200623072132.2868-1-f4bug@amsat.org>
References: <20200623072132.2868-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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

AspeedMachineState seems crippled. We use incorrectly 2
different structures to do the same thing. Merge them
altogether:
- Move AspeedMachine fields to AspeedMachineState
- AspeedMachineState is now QOM
- Remove unused AspeedMachine structure

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/arm/aspeed.h |  8 +-------
 hw/arm/aspeed.c         | 11 +++++++----
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 5114ba0bd4..09da9d9acc 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -15,13 +15,7 @@ typedef struct AspeedMachineState AspeedMachineState;
 
 #define TYPE_ASPEED_MACHINE       MACHINE_TYPE_NAME("aspeed")
 #define ASPEED_MACHINE(obj) \
-    OBJECT_CHECK(AspeedMachine, (obj), TYPE_ASPEED_MACHINE)
-
-typedef struct AspeedMachine {
-    MachineState parent_obj;
-
-    bool mmio_exec;
-} AspeedMachine;
+    OBJECT_CHECK(AspeedMachineState, (obj), TYPE_ASPEED_MACHINE)
 
 #define ASPEED_MAC0_ON   (1 << 0)
 #define ASPEED_MAC1_ON   (1 << 1)
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 680345beca..ccf127b328 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -33,9 +33,14 @@ static struct arm_boot_info aspeed_board_binfo = {
 };
 
 struct AspeedMachineState {
+    /* Private */
+    MachineState parent_obj;
+    /* Public */
+
     AspeedSoCState soc;
     MemoryRegion ram_container;
     MemoryRegion max_ram;
+    bool mmio_exec;
 };
 
 /* Palmetto hardware value: 0x120CE416 */
@@ -253,7 +258,7 @@ static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo)
 
 static void aspeed_machine_init(MachineState *machine)
 {
-    AspeedMachineState *bmc;
+    AspeedMachineState *bmc = ASPEED_MACHINE(machine);
     AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(machine);
     AspeedSoCClass *sc;
     DriveInfo *drive0 = drive_get(IF_MTD, 0, 0);
@@ -261,8 +266,6 @@ static void aspeed_machine_init(MachineState *machine)
     int i;
     NICInfo *nd = &nd_table[0];
 
-    bmc = g_new0(AspeedMachineState, 1);
-
     memory_region_init(&bmc->ram_container, NULL, "aspeed-ram-container",
                        4 * GiB);
     memory_region_add_subregion(&bmc->ram_container, 0, machine->ram);
@@ -751,7 +754,7 @@ static const TypeInfo aspeed_machine_types[] = {
     }, {
         .name          = TYPE_ASPEED_MACHINE,
         .parent        = TYPE_MACHINE,
-        .instance_size = sizeof(AspeedMachine),
+        .instance_size = sizeof(AspeedMachineState),
         .instance_init = aspeed_machine_instance_init,
         .class_size    = sizeof(AspeedMachineClass),
         .class_init    = aspeed_machine_class_init,
-- 
2.21.3


