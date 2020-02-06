Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACDFC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:23:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44DC020661
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbRx0UVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44DC020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izVt0-0007bf-EW
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:23:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoP-0000mc-5q
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoN-0003Ae-2e
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:33 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55408)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoM-00034O-RE; Wed, 05 Feb 2020 20:18:30 -0500
Received: by mail-wm1-x341.google.com with SMTP id q9so4474243wmj.5;
 Wed, 05 Feb 2020 17:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1Sth+jzkQIFIFbQJHNGyUBHjEOjdQyCxDQru8urvXnA=;
 b=rbRx0UVNbeybfwuMXarIV7EXseTKqianAfuz/QXeBu1vm7hUPEaKky2FG03uaUkkav
 e3L7RvF0zPuoZ14+fsELDZ0a2okTb7H4hEtfzHXhYpa29RgxSuKxCB9ABdjyTYX6hyyy
 7Oydl1/RdyOjabX3GPHYPfPMSrt9/yPLbBB+PSY3mUe0wX+fgFkgJvZwFjN103mV3G0G
 qpiDPxaO/ziByk7zEMUpPQeMamnc9FU309dQcj4YgaM7Kxkb1R469EswJuTJuGg1CUmq
 1Q4R61FQ+AAdakCgMgxTre8jzwo7+gUSox+a8U/sc4L/vv6f+jo6d+QgObjDJkdcnRuJ
 Xasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=1Sth+jzkQIFIFbQJHNGyUBHjEOjdQyCxDQru8urvXnA=;
 b=ndfm/pfx7RpWll4IvpG6IBvu6mpYn9G217H6EHKrKe+3jP2c3IRC/o916yBnaDYkj8
 M8dv9xqjdVsubweXhyh0vWhYES0zgqs5+8MiMhsEEGKatVHHdK9XPiAYAhcaRYIPz5wd
 zwZm+D3GbU+hafmVnxaMzzxXENClF2T7hi66px2rOxX6so700tGauTJhEWPV32nkxOfG
 +D4Oz9BIYVLM4ptPVnwL0/yJH5yY1FtbHQhhWnMXKbwFlA6kgivGwdAtN3BCRVR0BoRT
 Pum6iL6DkRB4fFJ5//6KLWWwdLnbHt/bXy7GKaE4ucOKDd/gzElT3A/wsIYv6jlsrjNr
 3tng==
X-Gm-Message-State: APjAAAX5c5/1iUjhd1WKN7HAvbKuNhAdYqkmH1QACaiAP1Afi8hzQY8g
 5j2IYgpMYYbN5CBjiHtUIQ2N77Nb
X-Google-Smtp-Source: APXvYqwyl6ZWZkvV8uVq3fVnnMwTvogMLbMByyr7jZpj2x7rg3mAO3Mj7SudjAuTjhGmQtcLcBVrIA==
X-Received: by 2002:a1c:a78b:: with SMTP id q133mr638318wme.28.1580951907662; 
 Wed, 05 Feb 2020 17:18:27 -0800 (PST)
Received: from localhost.localdomain (2.red-95-127-156.staticip.rima-tde.net.
 [95.127.156.2])
 by smtp.gmail.com with ESMTPSA id w13sm2053526wru.38.2020.02.05.17.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 17:18:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/30] hw/arm/raspi: Extract the cores count from the board
 revision
Date: Thu,  6 Feb 2020 02:17:39 +0100
Message-Id: <20200206011756.2413-14-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200206011756.2413-1-f4bug@amsat.org>
References: <20200206011756.2413-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

The board revision encode the count of ARM cores. Add a helper
to extract the number of cores, and use it. This will be helpful
when we add the Raspi0/1 that have a single core.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 8fe07db47a..4f7e5ecfab 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -100,6 +100,21 @@ static const char *board_soc_type(uint32_t board_rev)
     return soc_types[proc_id];
 }
 
+static int cores_count(uint32_t board_rev)
+{
+    static const int soc_cores_count[] = {
+        0, BCM283X_NCPUS, BCM283X_NCPUS,
+    };
+    int proc_id = board_processor_id(board_rev);
+
+    if (proc_id >= ARRAY_SIZE(soc_cores_count) || !soc_cores_count[proc_id]) {
+        error_report("Unsupported processor id '%d' (board revision: 0x%x)",
+                     proc_id, board_rev);
+        exit(1);
+    }
+    return soc_cores_count[proc_id];
+}
+
 static const char *board_type(uint32_t board_rev)
 {
     static const char *types[] = {
@@ -306,9 +321,7 @@ static void raspi_machine_class_init(ObjectClass *oc, void *data)
     mc->no_parallel = 1;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
-    mc->max_cpus = BCM283X_NCPUS;
-    mc->min_cpus = BCM283X_NCPUS;
-    mc->default_cpus = BCM283X_NCPUS;
+    mc->default_cpus = mc->min_cpus = mc->max_cpus = cores_count(board_rev);
     mc->default_ram_size = board_ram_size(board_rev);
     if (board_version(board_rev) == 2) {
         mc->ignore_memory_transaction_failures = true;
-- 
2.21.1


