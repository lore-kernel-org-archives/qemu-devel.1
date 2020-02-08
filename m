Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11ABDC35242
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 17:01:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D629221741
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 17:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoQKtWoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D629221741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0TU6-0004UM-0y
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 12:01:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TQ3-0006Ai-M7
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:57:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TQ2-0001rC-L8
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:57:23 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36334)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TQ2-0001qj-ED; Sat, 08 Feb 2020 11:57:22 -0500
Received: by mail-wr1-x444.google.com with SMTP id z3so2499116wru.3;
 Sat, 08 Feb 2020 08:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tBZ23XKKuSqArucqlyayxcsuhsU98/F9gBo+Gwfs7bo=;
 b=PoQKtWoUv1myiD7jWyloDmog+kYtVbshUzEDQGkXkHFdwrekpbk+S8VvaFSW1GKRZn
 Bn8FgG7mffZLRI0vYm7l3K/yD5qr2SJfwPZFOjr6xXzE+pIdOiHTXuEBuUBlipcSJKQG
 THDQounAseD470THW98a7QFumEHJ2bPM4mA6LuHkb8Xt0NGBxMUWUmw2XZRpWo5Ha3BN
 OttN537+akQZXoYnXL/8Perl+B1mD21VnkRsksR3gLua7Jt27Tau1HVeyH847kBPcnZ5
 7rPW6nMPJSNrkmhJ193JQcyH2c8ZeLZ2RLzZHyqPB0rcMXZXmm6p0mtv24+LMZl9pxJR
 GVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=tBZ23XKKuSqArucqlyayxcsuhsU98/F9gBo+Gwfs7bo=;
 b=sUosk3aiC2ghHkePwwFwb23/gpaRXgM9me9nZzbrCtIWNQndxg/3ChO1hQFP5HP1ON
 sBeXS4Ds6Q6w8/aFlJbfDGslTYicCYdsGGv/H3ytpCtFtnv8PZunCctdadfs7jtfXgsQ
 +hz0XIrsKAJQxcnyOfoJg7JXESINabmL6UQcmpKN2WioN0vkGUSLF359UsSMDtBYMZfE
 0UZMZ7nBHGNX6wQD/JMdLdiLX8YbsZijfw/kNdMSCtKmsIKHxqBl/duq/UKfvsI2z3LM
 AUTIE8QMUShq12WiIVcz6MWV1S/ouKJm45uH/E4WY3/SRNi/FLcY3RjzNUf0vYJGQlHu
 TUjw==
X-Gm-Message-State: APjAAAW9Jhy74175zd2/qkyey0QW7PjBGBP3FNI7DlxvsN8oCOdsKDQa
 8UsWBw7obt2gv9LS/PjqEmsW+Tjx
X-Google-Smtp-Source: APXvYqzKc1on8oHTGytTRUCsr/FF8hDacvDc68HQhT2CiTTWjap/DlPbj2hFJ5h+Sc1LAsDVcsnOfw==
X-Received: by 2002:adf:8b59:: with SMTP id v25mr6336731wra.419.1581181041280; 
 Sat, 08 Feb 2020 08:57:21 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a5sm7872763wmb.37.2020.02.08.08.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 08:57:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/13] hw/arm/raspi: Extract the board model from the board
 revision
Date: Sat,  8 Feb 2020 17:56:43 +0100
Message-Id: <20200208165645.15657-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200208165645.15657-1-f4bug@amsat.org>
References: <20200208165645.15657-1-f4bug@amsat.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The board revision encode the model type. Add a helper
to extract the model, and use it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index f0dcffbc2e..0537fc0a2d 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -101,6 +101,20 @@ static const char *board_soc_type(uint32_t board_rev)
     return soc_types[proc_id];
 }
 
+static const char *board_type(uint32_t board_rev)
+{
+    static const char *types[] = {
+        "A", "B", "A+", "B+", "2B", "Alpha", "CM1", NULL, "3B", "Zero",
+        "CM3", NULL, "Zero W", "3B+", "3A+", NULL, "CM3+", "4B",
+    };
+    assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
+    int bt = FIELD_EX32(board_rev, REV_CODE, TYPE);
+    if (bt >= ARRAY_SIZE(types) || !types[bt]) {
+        return "Unknown";
+    }
+    return types[bt];
+}
+
 static void write_smpboot(ARMCPU *cpu, const struct arm_boot_info *info)
 {
     static const uint32_t smpboot[] = {
@@ -287,7 +301,7 @@ static void raspi2_machine_class_init(ObjectClass *oc, void *data)
     uint32_t board_rev = (uint32_t)(uintptr_t)data;
 
     rmc->board_rev = board_rev;
-    mc->desc = "Raspberry Pi 2B";
+    mc->desc = g_strdup_printf("Raspberry Pi %s", board_type(board_rev));
     mc->init = raspi_machine_init;
     mc->block_default_type = IF_SD;
     mc->no_parallel = 1;
@@ -308,7 +322,7 @@ static void raspi3_machine_class_init(ObjectClass *oc, void *data)
     uint32_t board_rev = (uint32_t)(uintptr_t)data;
 
     rmc->board_rev = board_rev;
-    mc->desc = "Raspberry Pi 3B";
+    mc->desc = g_strdup_printf("Raspberry Pi %s", board_type(board_rev));
     mc->init = raspi_machine_init;
     mc->block_default_type = IF_SD;
     mc->no_parallel = 1;
-- 
2.21.1


