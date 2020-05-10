Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C389C38A2A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 20:35:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 306BF20731
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 20:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCrUm0Un"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306BF20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXsfm-0003jq-Km
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 16:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXsf9-0003J3-3z; Sun, 10 May 2020 16:35:03 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38320)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXsf8-0004Fe-DU; Sun, 10 May 2020 16:35:02 -0400
Received: by mail-wm1-x344.google.com with SMTP id g12so16862560wmh.3;
 Sun, 10 May 2020 13:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CdR2hYCzbd1Jp+0wuJ0jJdj1H6jPDY78QR9wtm9dhxs=;
 b=LCrUm0Un7MPEJO13S04LGY6UQwkyJZmxYz3o6UeJ6bpEpqCfOaew0aCcJcBgiTRugp
 MnPJV6dtifMco50XyhhJwUfSSiBHWdO+AYHz1dg/66aeal3jVdIgyaC5bcEs+dTFS3da
 ox48CDuECQAo3AAT3xbg8jedXiOauu/nEBBRmQA9qvps1ejlDVnYme8pxbmAOWy78vCs
 zZl2q+MbyYYcaEb/X81Zmne1IOmRQnRa/sWMQL0/cs6LvA77pC4DLHD0JfI8zSRrA4Ex
 01GJEQ04ZDY/Us27BNn3yP43YIvRk/VmdoqVP168h/ieA4B8YIDy7ZT31jiRMSg8gGIn
 rpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=CdR2hYCzbd1Jp+0wuJ0jJdj1H6jPDY78QR9wtm9dhxs=;
 b=rthnyxqjSmw1rfwtzhyj/MDXafnU6ctkSH+kmWynQNkF6ToYFrOIklcLNeOZzPKZh+
 nVtnE9iQjyf0Kn9/SomFpRa7KWxRIrEKMXozU1QvpZpKbDpUZNp7rj1xgLdqmHmobloE
 +n3FXCtCCBV9zHMoeg8WGjBFDzjEacqgx+aPn+bVb2CL+wZXNFX6sfrgQm4UvVnvFeo1
 VKKvjfO+GI6/jzflvWx4HmcTrSSd/M2K/ocN5h/9o6gbZptDg7e4KD2/UFtZgEEJPrKY
 +rnnZjEBmJIHlpH7NogSXXueIKdA+98OJXuqeI6uNVLJg9P0odrOgY5SzlN2car/BaVO
 NNXw==
X-Gm-Message-State: AGi0PubgjVvcq51XD2rI2wAvGomOR5ZG6zRhrK0bf7MDGI7goh9YpgFQ
 vw1LazZCgxSkALF5zeudP6HA7PUM0Qc=
X-Google-Smtp-Source: APiQypLdF8Tfp/bXfNZJBzvO4dcsPezdOhhxyXxFWaRMZ3W11CIihEQecz9G6smKxboSOvD+p3D2OQ==
X-Received: by 2002:a1c:7213:: with SMTP id n19mr1998096wmc.88.1589142900284; 
 Sun, 10 May 2020 13:35:00 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 5sm23486211wmz.16.2020.05.10.13.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2020 13:34:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/registerfields: Prefix local variables with underscore in
 macros
Date: Sun, 10 May 2020 22:34:57 +0200
Message-Id: <20200510203457.10546-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

One can name a local variable holding a value as 'v', but it
currently clashes with the registerfields macros. To save others
to debug the same mistake, prefix the macro's local variables
with an underscore.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/registerfields.h | 40 ++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/hw/registerfields.h b/include/hw/registerfields.h
index 0407edb7ec..93fa4a84c2 100644
--- a/include/hw/registerfields.h
+++ b/include/hw/registerfields.h
@@ -66,35 +66,35 @@
 #define FIELD_DP8(storage, reg, field, val) ({                            \
     struct {                                                              \
         unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
-    } v = { .v = val };                                                   \
-    uint8_t d;                                                            \
-    d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
-                  R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
-    d; })
+    } _v = { .v = val };                                                  \
+    uint8_t _d;                                                           \
+    _d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,          \
+                  R_ ## reg ## _ ## field ## _LENGTH, _v.v);              \
+    _d; })
 #define FIELD_DP16(storage, reg, field, val) ({                           \
     struct {                                                              \
         unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
-    } v = { .v = val };                                                   \
-    uint16_t d;                                                           \
-    d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
-                  R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
-    d; })
+    } _v = { .v = val };                                                  \
+    uint16_t _d;                                                          \
+    _d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,          \
+                  R_ ## reg ## _ ## field ## _LENGTH, _v.v);              \
+    _d; })
 #define FIELD_DP32(storage, reg, field, val) ({                           \
     struct {                                                              \
         unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
-    } v = { .v = val };                                                   \
-    uint32_t d;                                                           \
-    d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
-                  R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
-    d; })
+    } _v = { .v = val };                                                  \
+    uint32_t _d;                                                          \
+    _d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,          \
+                  R_ ## reg ## _ ## field ## _LENGTH, _v.v);              \
+    _d; })
 #define FIELD_DP64(storage, reg, field, val) ({                           \
     struct {                                                              \
         unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
-    } v = { .v = val };                                                   \
-    uint64_t d;                                                           \
-    d = deposit64((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
-                  R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
-    d; })
+    } _v = { .v = val };                                                  \
+    uint64_t _d;                                                          \
+    _d = deposit64((storage), R_ ## reg ## _ ## field ## _SHIFT,          \
+                  R_ ## reg ## _ ## field ## _LENGTH, _v.v);              \
+    _d; })
 
 /* Deposit a field to array of registers.  */
 #define ARRAY_FIELD_DP32(regs, reg, field, val)                           \
-- 
2.21.3


