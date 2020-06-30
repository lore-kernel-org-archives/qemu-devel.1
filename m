Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9E7C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:03:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CBCB206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEs0BuyE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CBCB206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqMT8-0005uG-LJ
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 16:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqMNr-0008LM-Vq; Tue, 30 Jun 2020 15:57:36 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37191)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqMNq-00045P-DE; Tue, 30 Jun 2020 15:57:35 -0400
Received: by mail-wr1-x441.google.com with SMTP id a6so21339600wrm.4;
 Tue, 30 Jun 2020 12:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nCLgw9mQp+ua1T7qd5IhM0F5v0NpMBrPaJh73a54bRE=;
 b=AEs0BuyEXZ9RJeamwrF5xxzbXzcrkKyRkUalsvgurBeAWQoxrkqvz8hIy8DlYw/MCF
 /XPuqmSk9nw18tRL3jOcTFRF1YBrScSyrlbSxbIkadbLdC6sOzX0mJqXRvEqjymudgSi
 GyGloSYJqKL8A1m+vWlAjZl4NbdJuJ0nhcqfekPZylbLQJ8BLyBsZCRFGKrrH6YUkZ4b
 VzzF9O4pCCAI9J1dICuZ3iztv6lMtUW1uELzG1g40muQhu+ZUk1OpzAtrkCqzPfASjBV
 sRU63pCLIKW8oz2dnFOFC+Q/dSjhXaMdyqcRwPGs1p+n/R70t3HbaJ20WYo0OPUa+jh2
 Y0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nCLgw9mQp+ua1T7qd5IhM0F5v0NpMBrPaJh73a54bRE=;
 b=tCK+FMlcTsdyfKga4CmOpEukNvutiLEB5wpid7gXWhRc8447rk9S+Cj82nyekZ+IDg
 JyV2P79JmvpQZolZKRoe1ylsTq823MmrYBPiPTVGVxkA/FRAF/nqMLU4YZiexdmcb2mT
 k4fst7G3X4RO84uMSn1Wf8c9OpA44YAGFo597+0x9k2SNnMv7OpIOcGmnO7c8ukkhAuM
 TNr1zZnVVcmFbR86BpeQnP3XY+12GOAc7eh/+vQS9CwU+LbzP3XbMkR51LrMkORCDucM
 ZRh7CEUN2DdiFFDdAWC+Dgcx/vg9AAcZorv1ErGQA+9DRynqiasooHy90fdmcZLV5b1Q
 L4mA==
X-Gm-Message-State: AOAM532ea7wThQQwe/4F7utf07KIQj+rq43x+gVi9s/35BSDvLRmke5d
 XvL1PeGwqNtnI1SSrMjmk0oh+1FSfLk=
X-Google-Smtp-Source: ABdhPJwXCQTVM8a4o8RulKkr4VZJe/q3S+ws33vjOgb3Fjsn7A8QuR5r8Acv6p4/8OpiigMUK17R1w==
X-Received: by 2002:adf:aad3:: with SMTP id i19mr23380514wrc.359.1593547051296; 
 Tue, 30 Jun 2020 12:57:31 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id k11sm5172979wrd.23.2020.06.30.12.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 12:57:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, Yunqiang Su <ysu@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v3 5/5] hw/mips/malta: Verify malta-strict machine uses
 correct DIMM sizes
Date: Tue, 30 Jun 2020 21:57:23 +0200
Message-Id: <20200630195723.1359-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630195723.1359-1-f4bug@amsat.org>
References: <20200630195723.1359-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-trivial@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The machine has 4 DIMM slots. Each DIMM must be a power of 2.
Add a check the total RAM is a good combination of DIMMs.

Example when asking a combination not power of 2:

  $ qemu-system-mips -M malta-strict -bios /dev/null -m 252
  qemu-system-mips: RAM size must be the combination of 4 powers of 2

Working example (as 100 = 64 + 32 + 2 + 2):

  $ qemu-system-mips -M malta-strict -monitor stdio -S -bios /dev/null -m 100
  QEMU 5.0.50 monitor - type 'help' for more information
  (qemu) info mtree
  address-space: memory
    0000000000000000-ffffffffffffffff (prio 0, i/o): system
      0000000000000000-00000000063fffff (prio 0, ram): alias mips_malta_low_preio.ram @mips_malta.ram 0000000000000000-00000000063fffff

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/malta.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index ac4a618751..17f5833a94 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -71,6 +71,8 @@
 
 #define MAX_IDE_BUS         2
 
+#define DIMM_SLOTS_COUNT    4
+
 #define TYPE_MALTA_MACHINE       MACHINE_TYPE_NAME("malta-base")
 #define MALTA_MACHINE_CLASS(klass) \
      OBJECT_CLASS_CHECK(MaltaMachineClass, (klass), TYPE_MALTA_MACHINE)
@@ -82,6 +84,7 @@ typedef struct MaltaMachineClass {
     MachineClass parent_obj;
     /* Public */
     ram_addr_t max_ramsize;
+    bool verify_dimm_sizes;
 } MaltaMachineClass;
 
 typedef struct {
@@ -1260,6 +1263,12 @@ void mips_malta_init(MachineState *machine)
     /* create CPU */
     mips_create_cpu(machine, s, &cbus_irq, &i8259_irq);
 
+    if (mmc->verify_dimm_sizes && ctpop64(ram_size) > DIMM_SLOTS_COUNT) {
+        error_report("RAM size must be the combination of %d powers of 2",
+                     DIMM_SLOTS_COUNT);
+        exit(1);
+    }
+
     /*
      * The GT-64120A north bridge accepts at most 256 MiB per SCS for
      * address decoding, so we have a maximum of 1 GiB. We deliberately
@@ -1493,6 +1502,7 @@ static void malta_machine_strict_class_init(ObjectClass *oc, void *data)
 #endif
     mc->default_ram_size = 32 * MiB;
     mmc->max_ramsize = 256 * MiB; /* 32 MByte PC100 SDRAM DIMMs x 4 slots */
+    mmc->verify_dimm_sizes = true;
 };
 
 static const TypeInfo malta_machine_types[] = {
-- 
2.21.3


