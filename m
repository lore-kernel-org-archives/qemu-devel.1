Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BF7C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:30:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 526C62087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKVoOqr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526C62087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzaFJ-0001YP-Dk
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 01:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZyB-0005O6-J3
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZyA-0000D7-Jt
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:39 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42057)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hzZyA-0000AP-C9; Mon, 19 Aug 2019 01:12:38 -0400
Received: by mail-pf1-x441.google.com with SMTP id i30so450048pfk.9;
 Sun, 18 Aug 2019 22:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=P1Efw+GJ/R7uVNYfucxL2Sw5lbopvlmJxyr6rTPycXA=;
 b=XKVoOqr0qw63Ctvqm84c6QLY26GnHJ2BZATpqQwOEgZLSmq72hPIvwEamjNXHbgo8m
 ttkL6GZX5mc9PgCpkisPYk850A37slqt7Ii4wQxXveaRNPhYaBVGibRz6m/RSVdZl96H
 e9JH4rv55kBzK2ZCzKoVSFqLzFgFLpCA5QTckJxjZAHemmG6BaDuqlQuJsUh7OSiaVnX
 wtpc09Q3poZT2YDXGVym723gXGVimdVl4sKLumyBKEiIotE9QCWubXAm6qXGEB7gKZql
 uRMIz9bPfiIxf2xmuOar/qCbkIBva8qysRnx7HcR6i0aoY+Dr+aNdC9Y8sJ67TtXQmqM
 taKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=P1Efw+GJ/R7uVNYfucxL2Sw5lbopvlmJxyr6rTPycXA=;
 b=XjM9IiHOzQAZAiI2lMeBWG2pysECIuCF+eVxFCllgithdo6U1KijARq7Hy4wxKPoFI
 NUw8/iIZglYc4IikqyKULAvCEH2ZN8itWTQm8ARW9RbEkAgBBbAgqsCJeL4/ndE6S328
 PQI380mgjPMXuPW+IcXs9c2mKOeb7wvk+CXTcJ5rtbToyrcz45yO1y9+4bRqvsMatEAa
 0rWBa8ueuzx//TaQ5r1A6BSk8Hp/KlMT9dedzmD86ELKH/D+W5sEotf5+AS1Qm508S5N
 7iIDJzXnjxur3PG98p/AU3F/fZo80Ms6Rr8xR7B1xgLf4N2GfhD7O12UDj4WFrel2dlC
 Rf1g==
X-Gm-Message-State: APjAAAWMqVVoI0SSd9UaPKuhF1mFBUdLktay1J2icO0M1UaJfyYoKgll
 TNLl9vN0rheUG+xdZF90QTw=
X-Google-Smtp-Source: APXvYqxunUYY6ovrqC5//ejF5+ZOPLt770EXJiEmXT3aPs/U+mgVZ5oFydrLj7zs1M35m3+44dl3Ew==
X-Received: by 2002:a65:68cd:: with SMTP id k13mr18241494pgt.411.1566191557629; 
 Sun, 18 Aug 2019 22:12:37 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id q13sm15464986pfl.124.2019.08.18.22.12.36
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 18 Aug 2019 22:12:37 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 18 Aug 2019 22:12:01 -0700
Message-Id: <1566191521-7820-29-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
References: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v4 28/28] riscv: sifive_u: Update model and
 compatible strings in device tree
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

This updates model and compatible strings to use the same strings
as used in the Linux kernel device tree (hifive-unleashed-a00.dts).

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 7d9fb3a..c5cc4bd 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -98,8 +98,9 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         exit(1);
     }
 
-    qemu_fdt_setprop_string(fdt, "/", "model", "ucbbar,spike-bare,qemu");
-    qemu_fdt_setprop_string(fdt, "/", "compatible", "ucbbar,spike-bare-dev");
+    qemu_fdt_setprop_string(fdt, "/", "model", "SiFive HiFive Unleashed A00");
+    qemu_fdt_setprop_string(fdt, "/", "compatible",
+                            "sifive,hifive-unleashed-a00");
     qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
 
-- 
2.7.4


