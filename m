Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B545C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 18:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21D9220791
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 18:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CW9LVs14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D9220791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6HmZ-0008EZ-Bh
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 14:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6HlJ-0006vx-Vk
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 14:15:38 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34854)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6HlH-0005yd-Jq
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 14:15:37 -0400
Received: by mail-wr1-x441.google.com with SMTP id f1so6145398wro.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 11:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/FDG7shS3VVsrXaxNIhVRLZQrAk5x63G7KkzmWMq+m4=;
 b=CW9LVs14ByZ2Cid8eGVur34ImRKKyNMJB/JwvE3sfpkJcXHnWkCk6Kp5ESlvIJOgUa
 UOtGK/qOivJzHY+3YPIKaE2wkxOaaeyqz5/2ajc0I7vAiunNDFUwfA4jWhftW9eTw4Cm
 KjTXN2KrIEIl00iqB93aLiUe0Q/9gvBBQr3LIMDasvKc+fju457fz9Qr9kRYmgCt8JRw
 xZ+T/9F3FtGlMN6IGhyGhrB410PjP78qfCYsr3ifkVAoOfTHzQ9ymqEBO4myx1FL+WUj
 Ny/YRXVYNXzUnL5sr3cUldQJZYtOo57oF5c5dZszk+m3q52nFW10MzLKJmkiwZ9CMnWq
 cdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=/FDG7shS3VVsrXaxNIhVRLZQrAk5x63G7KkzmWMq+m4=;
 b=o6/xtZZqsWyMpWjAfHSD/ZQzAb3wr0XH6ccF9kGUcQGHnn7s4T5G49/DBkRjvhLvMv
 HcbIyaObNsF7BS+v2JGU7NulgchxWHTkfKJ62FjwAkstswOW5wcE7MwCHByPdgDRsQSQ
 6GTtZm4B8Gc64ndVCEFPNK4AzPWtKSlG0hA2E2+6+Sr8mD30SG67wYnwdYBw04g+xc44
 VSueLM1yMhW0f9ihviBtgMPAM8ND/3rIAYONn15jf2wbMqWLnOhZlEmWG5JLI/2RkZS4
 tvSHgrIv0R43n4+y1X5zH4iwjTHTkufDfv37vlIxn5wOTt2Jil9K4IePkeqty1UXiZlG
 lUgg==
X-Gm-Message-State: AOAM5317TYcoTwEcGmLKFqncUfsDKqofJmQlGLT5HS1YZxY+/2VRtl0l
 sxQfiCLERsRjGHpGquPoE75SWLAG
X-Google-Smtp-Source: ABdhPJyA6giXVddOi1OVhcEYwFjov30J4vrge5kQt+yaVVl3hSjdR9mi6GFYXdxp55sNaMV8OYG9+w==
X-Received: by 2002:adf:9ec5:: with SMTP id b5mr4877785wrf.190.1597342533357; 
 Thu, 13 Aug 2020 11:15:33 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id h14sm10039926wml.30.2020.08.13.11.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 11:15:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 3/3] target/mips/op_helper: Log unimplemented cache
 opcode
Date: Thu, 13 Aug 2020 20:15:27 +0200
Message-Id: <20200813181527.22551-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200813181527.22551-1-f4bug@amsat.org>
References: <20200813181527.22551-1-f4bug@amsat.org>
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

In case the guest uses a cache opcode we are not expecting,
log it to give us a chance to notice it, in case we should
actually do something.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/op_helper.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 2496d1dd71..a3b27f39db 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -1574,6 +1574,13 @@ void helper_msa_st_d(CPUMIPSState *env, uint32_t wd,
 void helper_cache(CPUMIPSState *env, target_ulong addr, uint32_t op)
 {
 #ifndef CONFIG_USER_ONLY
+    static const char *type_name[] = {
+        "Primary Instruction",
+        "Primary Data or Unified Primary",
+        "Tertiary",
+        "Secondary"
+    };
+    uint32_t cache_type = extract32(op, 0, 2);
     uint32_t cache_operation = extract32(op, 2, 3);
     target_ulong index = addr & 0x1fffffff;
 
@@ -1592,6 +1599,8 @@ void helper_cache(CPUMIPSState *env, target_ulong addr, uint32_t op)
         /* no-op */
         break;
     default:
+        qemu_log_mask(LOG_UNIMP, "cache operation:%u (type: %s cache)\n",
+                      cache_operation, type_name[cache_type]);
         break;
     }
 #endif
-- 
2.21.3


