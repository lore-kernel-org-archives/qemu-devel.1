Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DD5C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:35:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FCF220702
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDYdY5YU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FCF220702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izW56-0006pk-4g
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:35:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVov-0001b2-7a
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:19:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVou-00056g-6k
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:19:05 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43344)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVou-00055m-1G; Wed, 05 Feb 2020 20:19:04 -0500
Received: by mail-wr1-x442.google.com with SMTP id z9so5099072wrs.10;
 Wed, 05 Feb 2020 17:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7XPvv6jxd1oIoIhXDZTxZc8ANlESxt/CQMBwAqbZerI=;
 b=rDYdY5YU4skruCOuQJPEeYO2xrpqHD4ZasTyqGE/A1C3HT4xpWPqU0KTn+sxuyVwJk
 Du9ZvGiKs6Np/JptP5r2rcJiXlIpINVPp4HtHUkvsZakBfVPx28DBeeggCYv9HmbkQ8k
 MpKbIPLijGl95wA9SxgvQPP+8VYKFpvujqjpTTIoxSQL1Hkqe+j6jvgJBJNydr+DJnUm
 p7BrUb258ZmRQhEj8fClvcVeXIV7lOpYYjC578khTJ2PgGh5trewrB8WDH3aJ4SS9kPz
 hljmmweDkjkrt9l5pb4J6RwHi/Jmz4vEc4TH/OLAtIPYm0lrNouavwDPMEKTry3dLZAG
 8AmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7XPvv6jxd1oIoIhXDZTxZc8ANlESxt/CQMBwAqbZerI=;
 b=TDAKsbInk3bXrgCKUe0/CcHTkqu8xRkXHvyRi4ZMZI58oO1VCaW3KZtvR+IbveEAcw
 Mk4ccRLohI4BGsNeUF4lV76Jfai9qLrzPjLbihB6WmT99fwiVmC94s8PY/hRxDYgfaUS
 E9/oIZeEBCQwFVKqnGmfZ5LioK+gZBC+Ot3DIVXK1V9FAJ93ySqLLLn6fVaUzY8no5Sb
 dt1jyusFgAFaO3DXmP2v7NCLoa8BEt9x7lr6isoxggIkiKqaqUUS4aGmxla6AVeJeQAV
 McBHhy7WpgjCcPmjrf2SSeqnLmHx9j+BELXPCC0fJMAAfazK/xUdRmM5uPDPZH+ocNBY
 8oIQ==
X-Gm-Message-State: APjAAAWbQ0S22QFq7feHWziovelOeOK5jJVagyJIincwBwrY8oQs1Plz
 CLDCFHqbi3iEjugNciVfrv+z3p//
X-Google-Smtp-Source: APXvYqycPJexQ273or3yEIOqRHZozGJWCWlUcs2WMEsyfftDCaQMEom004YHVUaLJ+AdOd7L1hQ0+g==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr368672wrq.176.1580951942849;
 Wed, 05 Feb 2020 17:19:02 -0800 (PST)
Received: from localhost.localdomain (2.red-95-127-156.staticip.rima-tde.net.
 [95.127.156.2])
 by smtp.gmail.com with ESMTPSA id w13sm2053526wru.38.2020.02.05.17.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 17:19:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [NOTFORMERGE PATCH v2 30/30] hw/arm/raspi: Add the Raspberry Pi 4
Date: Thu,  6 Feb 2020 02:17:56 +0100
Message-Id: <20200206011756.2413-31-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200206011756.2413-1-f4bug@amsat.org>
References: <20200206011756.2413-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 47cc250883..8a0309933b 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -88,7 +88,7 @@ static int board_version(uint32_t board_rev)
 static const char *board_soc_type(uint32_t board_rev)
 {
     static const char *soc_types[] = {
-        TYPE_BCM2835, TYPE_BCM2836, TYPE_BCM2837,
+        TYPE_BCM2835, TYPE_BCM2836, TYPE_BCM2837, TYPE_BCM2838,
     };
     int proc_id = board_processor_id(board_rev);
 
@@ -103,7 +103,7 @@ static const char *board_soc_type(uint32_t board_rev)
 static int cores_count(uint32_t board_rev)
 {
     static const int soc_cores_count[] = {
-        1, BCM283X_NCPUS, BCM283X_NCPUS,
+        1, BCM283X_NCPUS, BCM283X_NCPUS, BCM283X_NCPUS,
     };
     int proc_id = board_processor_id(board_rev);
 
@@ -350,6 +350,11 @@ static const TypeInfo raspi_machine_types[] = {
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi_machine_class_init,
         .class_data     = (void *)0xa02082,
+    }, {
+        .name           = MACHINE_TYPE_NAME("raspi4"),
+        .parent         = TYPE_RASPI_MACHINE,
+        .class_init     = raspi_machine_class_init,
+        .class_data     = (void *)0xa03111,
 #endif
     }, {
         .name           = TYPE_RASPI_MACHINE,
-- 
2.21.1


