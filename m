Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1A9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 19:16:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA4ED20739
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 19:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYvCjwOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4ED20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jldY9-000696-P4
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 15:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jldWy-0004A1-2w
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 15:15:28 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:43162)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jldWw-0006TD-Hf
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 15:15:27 -0400
Received: by mail-ej1-x641.google.com with SMTP id l12so3721616ejn.10
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 12:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B90u68HWanE8Ef/dq5GEfdfCsFqZeY71gyQo1Aa7Eho=;
 b=sYvCjwOvFVN5rXARk6uM5FvMiM1KPAMPk1MQmdM7Tl0dWKsmRBcyrNDleSLsDfj3an
 rIfcDZy1UdsF9bgKeXSPdZZYv4VnOHwqHEtn7qgVI4VVhhP7ENedxRg6pgcsNR1rzW0a
 mrL+Wnn3KnkRu4/8dglLrKwO5FsicxQOdu0rVEH+rUDRghb6phzzK+f+xIA1q2bbGbRs
 I5tExWuMftANJCOcGdPYhorUl9ZTUyMAlFMonFRpXngg7XtM4e9xraehjxDgcYNc2EbP
 ghU03VVFZj81HKTnn5yv/1i/J4vT3T+MaxisvfPU72P4MUUWM+zTWMFV4iJAtq1XmR+Y
 ZaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=B90u68HWanE8Ef/dq5GEfdfCsFqZeY71gyQo1Aa7Eho=;
 b=K3lOpB75Y0PX2Bum+FOvyihm2GSEhXYG4h57pNQEnj++6U3AL7r+u5q8/EjELprN6c
 TZnZeHU/rgh0zoJbT8ZWlqM1sIzfTb8Cy3kFpxD4dO8lZOTxAp3otrYy7v6HG5ncOCa4
 sWxwFuHbxhu07xThFFM4e1HjbGHIYKNDi5ING5p0TuUxiU+GDI7kmDdDyDNskaWMOh8w
 0oFf1WV2at/wfG2lZhrrcQHheVre/PZCOv/E5ZnG7Q4fnnIccv/Hz/kurKrl5TGP5Z70
 DrSgeLFNXTcAwTB1brAxSleaRTpCp++us5G+qeh1YitiYvPemKsy/Uw/pnDWGi9hus0j
 lavA==
X-Gm-Message-State: AOAM532glyISJuYb4JN2m+bEG3cL1Kij6KDRtcuoWzwRXqxS1v3aAlD1
 peXKY0TUXn+G8vgPAC0OCiE=
X-Google-Smtp-Source: ABdhPJzPMivgEyR7NeyLvzyj2XCk6zwTsYE/hlazfebHEf6arwP3QNuY0glCrm6796V3UHGcAzDFfw==
X-Received: by 2002:a17:906:d8bc:: with SMTP id
 qc28mr642199ejb.167.1592421325228; 
 Wed, 17 Jun 2020 12:15:25 -0700 (PDT)
Received: from x1w.redhat.com (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id y21sm324308edl.72.2020.06.17.12.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 12:15:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Richard Henderson <rth@twiddle.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
Subject: [PATCH rc1 03/15] hw/sh4: Use MemoryRegion typedef
Date: Wed, 17 Jun 2020 21:15:07 +0200
Message-Id: <20200617191519.14842-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200617191519.14842-1-f4bug@amsat.org>
References: <20200617191519.14842-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the MemoryRegion type defined in "qemu/typedefs.h",
to keep the repository style consistent.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sh4/sh.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/hw/sh4/sh.h b/include/hw/sh4/sh.h
index 767a2df7e2..fe773cb01d 100644
--- a/include/hw/sh4/sh.h
+++ b/include/hw/sh4/sh.h
@@ -10,9 +10,8 @@
 
 /* sh7750.c */
 struct SH7750State;
-struct MemoryRegion;
 
-struct SH7750State *sh7750_init(SuperHCPU *cpu, struct MemoryRegion *sysmem);
+struct SH7750State *sh7750_init(SuperHCPU *cpu, MemoryRegion *sysmem);
 
 typedef struct {
     /* The callback will be triggered if any of the designated lines change */
@@ -32,7 +31,7 @@ int sh7750_register_io_device(struct SH7750State *s,
 #define TMU012_FEAT_TOCR   (1 << 0)
 #define TMU012_FEAT_3CHAN  (1 << 1)
 #define TMU012_FEAT_EXTCLK (1 << 2)
-void tmu012_init(struct MemoryRegion *sysmem, hwaddr base,
+void tmu012_init(MemoryRegion *sysmem, hwaddr base,
                  int feat, uint32_t freq,
 		 qemu_irq ch0_irq, qemu_irq ch1_irq,
 		 qemu_irq ch2_irq0, qemu_irq ch2_irq1);
-- 
2.21.3


