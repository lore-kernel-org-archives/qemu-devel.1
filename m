Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE02C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 18:18:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB0C720791
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 18:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuoKEmsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB0C720791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Hnp-0001a0-20
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 14:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6HlH-0006rm-Bg
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 14:15:35 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39675)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6HlF-0005yQ-UX
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 14:15:35 -0400
Received: by mail-wm1-x342.google.com with SMTP id g75so5841381wme.4
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 11:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UDbCjqzlKjTAWmhYvIyTUkU9gxUtTAYKow3YrvF3QOE=;
 b=IuoKEmsVDIX/gBWygovC+CzJcJXp06oFQVLl4pK6Xp/iHw7WPH1MrS8XTsD/H8J3UU
 1L4KeYQJ+1hhmlVzmUT2Kpnvlirn3keg5EOk0/DV68kZK8QvWcHwgydZ1UEIIKzL3lXn
 4zywGpKyXMDYueoazG94TCpycXXPZylFpswt3M09LO4Rz5otluxm6zGRD74mFRDw0xrD
 aOWHN0J4IV/i/YGG3b+wT9elaCEgmN5TKW/cBqPzR9zMO4HFVmcyaR9FBTYDthaC9Irs
 PIdZlKrcVj0epnt/YfpKfL6xd+4ha7tJ3PaLJs/eMF/USK7Oz5p+SXhwSur1UFUlmV7k
 5fkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=UDbCjqzlKjTAWmhYvIyTUkU9gxUtTAYKow3YrvF3QOE=;
 b=nPbjqMi6hXDo/u0it5F1pArL6/1UH9QkDD6H6ReJse1GuJkZYF57iELQv9rMenANhQ
 xBoSnDiBW6z8VvXLFeYpmk55qElEQkNIprPxAm9vnMRlQr7BxeG/Acuu4wseFGNFrbG9
 wc6mkIC4g+VyUd8enTWe9bD4J2vAhVUmGdx7NVKHXQ44jGxN3V9zobCHPDUNZUwkujia
 zyHoALEbqTl/VFYD+IKqDjO6iX5wXygx0QxlFdnS3lzvVxJUhqWaXa+RRYMWzr+FRaOM
 4IkJ1NdJ32l6MUPwSiUNHnwy+Yx+9oPm7nyMZFt61kl6AQFRoM+AbD+53fZ7rQSXGt5w
 liQA==
X-Gm-Message-State: AOAM531uNjeVjAmJ6hzwsr1+TkgOzFY9jucGUbw1u9kcmwDw1PDDWv4e
 dKDNcqOHmexXQg6QbMAdSNgvcSZq
X-Google-Smtp-Source: ABdhPJz/vjtwR4PSQYs4iS8zo0DGPEu0h2HkMt5QJz/r7kmZaPRx9sMk+j6ky5s3R80uScv8Fco9gg==
X-Received: by 2002:a1c:9d85:: with SMTP id g127mr420457wme.162.1597342532256; 
 Thu, 13 Aug 2020 11:15:32 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id h14sm10039926wml.30.2020.08.13.11.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 11:15:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 2/3] target/mips/op_helper: Document
 Invalidate/Writeback opcodes as no-op
Date: Thu, 13 Aug 2020 20:15:26 +0200
Message-Id: <20200813181527.22551-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200813181527.22551-1-f4bug@amsat.org>
References: <20200813181527.22551-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU does not model caches, so there is not much to do with the
Invalidate/Writeback opcodes. Make it explicit adding a comment.

Suggested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/op_helper.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 92c399d8d4..2496d1dd71 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -1578,16 +1578,19 @@ void helper_cache(CPUMIPSState *env, target_ulong addr, uint32_t op)
     target_ulong index = addr & 0x1fffffff;
 
     switch (cache_operation) {
-    case 0b010:
-        /* Index Store Tag */
+    case 0b010: /* Index Store Tag */
         memory_region_dispatch_write(env->itc_tag, index, env->CP0_TagLo,
                                      MO_64, MEMTXATTRS_UNSPECIFIED);
         break;
-    case 0b001:
-        /* Index Load Tag */
+    case 0b001: /* Index Load Tag */
         memory_region_dispatch_read(env->itc_tag, index, &env->CP0_TagLo,
                                     MO_64, MEMTXATTRS_UNSPECIFIED);
         break;
+    case 0b000: /* Index Invalidate */
+    case 0b100: /* Hit Invalidate */
+    case 0b110: /* Hit Writeback */
+        /* no-op */
+        break;
     default:
         break;
     }
-- 
2.21.3


