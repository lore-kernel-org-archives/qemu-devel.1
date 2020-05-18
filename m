Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD90AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84FEC20758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Flh1kB0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84FEC20758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaiAu-00077p-Ng
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jai4s-0003BJ-Og; Mon, 18 May 2020 11:53:18 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53828)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jai4r-00006S-Uh; Mon, 18 May 2020 11:53:18 -0400
Received: by mail-wm1-x342.google.com with SMTP id k12so20927wmj.3;
 Mon, 18 May 2020 08:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AnPjL1oCKd4/b0PMNN6nSj2GzQNIyIXoJD4PkkEccRM=;
 b=Flh1kB0guv4yAbKeDYrp5crvlMR5ihhTkgC4sUeRwuaqgo7GD0MKjJWTUa6Hw2L8xS
 CIsyCqO5AvcZ8OwqPdLT8OmZa/ij6U5deh3S8uaWtf/VidtkoeX+VHIABeeardCArTHX
 XNSnRdTy+EpyBchdo7vAMIvPG9o1VFjX+MkOHh1KL+C8pX1vZ0yVTp7rYBokW9sBGV7p
 uaLB7O6eaQG+1utdhsPZlItO485bABIknYR8tYuO+twhZvT1wOLhGP6aF/ija6iTfvyZ
 QkiXHLZ+FGIYWRNLOIOko72PY6W/2aVr6hJAQD/zFfc6NyNFkhqADfHmd5GIQxeXeG49
 +otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=AnPjL1oCKd4/b0PMNN6nSj2GzQNIyIXoJD4PkkEccRM=;
 b=SnddOz38SngJwdoBAbwWbehQvMLxqtvxOeVIIoMmaflu9hLQDieyNIcVeoNyHyNQKt
 PZuBgIx2dx2XCdf0i3wgW7zNhcAtpHYnmgDTJuUyi6wIMPfeKz/ArtCgpRZuRzsAmAk8
 RhkTAIY4fk70QELvgV3fbIbaxouFdDWCc2j4ZnOAZbXh/13VzEzrvDX4cmWNvpzpDyQM
 Zhu1b3KN2NCeuOpgpNo3Oi/bV41t7jtO6lqR+yNSb6ZwHwQYagXKFyLUyHWS+yx0QaHG
 lunAQwG0rwvtKCTGOgD9tbLLEngPB0l03GCrsJ/jNqMJt3YjfinIabAypjU5QlXCYjUe
 WXRw==
X-Gm-Message-State: AOAM532YjEGDH1y49Y9AhgWjM88zvO9gQJvF8OOktLe2OFEQM6A5qxhx
 glGxwb5Zo29u3GCZVH8SDXPWiXlIPVs=
X-Google-Smtp-Source: ABdhPJz/PtyrwAQIbRp4mpLoU+mt0aZlERs2l79lSNvZZ5pevIUK5/V9XwfG5nxxlERMi6Y3l+3eOA==
X-Received: by 2002:a1c:3187:: with SMTP id x129mr24994wmx.27.1589817196118;
 Mon, 18 May 2020 08:53:16 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 7sm17647462wra.50.2020.05.18.08.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 08:53:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/7] hw/arm/boot: Abort if set_kernel_args() fails
Date: Mon, 18 May 2020 17:53:06 +0200
Message-Id: <20200518155308.15851-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200518155308.15851-1-f4bug@amsat.org>
References: <20200518155308.15851-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If a address_space_write() fails while calling
set_kernel_args(), the guest kernel will boot
using crap data. Avoid that by aborting if this
ever occurs.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/boot.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index fef4072db1..7cc271034c 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -291,7 +291,8 @@ static inline bool have_dtb(const struct arm_boot_info *info)
 
 #define WRITE_WORD(p, value) do { \
     address_space_stl_notdirty(as, p, value, \
-                               MEMTXATTRS_UNSPECIFIED, NULL);  \
+                               MEMTXATTRS_UNSPECIFIED, &result); \
+    assert(result == MEMTX_OK); \
     p += 4;                       \
 } while (0)
 
@@ -300,6 +301,7 @@ static void set_kernel_args(const struct arm_boot_info *info, AddressSpace *as)
     int initrd_size = info->initrd_size;
     hwaddr base = info->loader_start;
     hwaddr p;
+    MemTxResult result;
 
     p = base + KERNEL_ARGS_ADDR;
     /* ATAG_CORE */
@@ -326,8 +328,9 @@ static void set_kernel_args(const struct arm_boot_info *info, AddressSpace *as)
         int cmdline_size;
 
         cmdline_size = strlen(info->kernel_cmdline);
-        address_space_write(as, p + 8, MEMTXATTRS_UNSPECIFIED,
-                            info->kernel_cmdline, cmdline_size + 1);
+        result = address_space_write(as, p + 8, MEMTXATTRS_UNSPECIFIED,
+                                     info->kernel_cmdline, cmdline_size + 1);
+        assert(result == MEMTX_OK);
         cmdline_size = (cmdline_size >> 2) + 1;
         WRITE_WORD(p, cmdline_size + 2);
         WRITE_WORD(p, 0x54410009);
@@ -341,8 +344,9 @@ static void set_kernel_args(const struct arm_boot_info *info, AddressSpace *as)
         atag_board_len = (info->atag_board(info, atag_board_buf) + 3) & ~3;
         WRITE_WORD(p, (atag_board_len + 8) >> 2);
         WRITE_WORD(p, 0x414f4d50);
-        address_space_write(as, p, MEMTXATTRS_UNSPECIFIED,
-                            atag_board_buf, atag_board_len);
+        result = address_space_write(as, p, MEMTXATTRS_UNSPECIFIED,
+                                     atag_board_buf, atag_board_len);
+        assert(result == MEMTX_OK);
         p += atag_board_len;
     }
     /* ATAG_END */
@@ -357,6 +361,7 @@ static void set_kernel_args_old(const struct arm_boot_info *info,
     const char *s;
     int initrd_size = info->initrd_size;
     hwaddr base = info->loader_start;
+    MemTxResult result;
 
     /* see linux/include/asm-arm/setup.h */
     p = base + KERNEL_ARGS_ADDR;
@@ -419,7 +424,9 @@ static void set_kernel_args_old(const struct arm_boot_info *info,
     }
     s = info->kernel_cmdline;
     if (s) {
-        address_space_write(as, p, MEMTXATTRS_UNSPECIFIED, s, strlen(s) + 1);
+        result = address_space_write(as, p, MEMTXATTRS_UNSPECIFIED,
+                                     s, strlen(s) + 1);
+        assert(result == MEMTX_OK);
     } else {
         WRITE_WORD(p, 0);
     }
-- 
2.21.3


