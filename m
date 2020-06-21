Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24BEC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 12:49:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71561248EB
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 12:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDm/Defo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71561248EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmzPP-0006iG-M2
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 08:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmzOS-00053s-Ho
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 08:48:16 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52370)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmzOQ-0002pA-SH
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 08:48:16 -0400
Received: by mail-wm1-x344.google.com with SMTP id r9so12448184wmh.2
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 05:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B90u68HWanE8Ef/dq5GEfdfCsFqZeY71gyQo1Aa7Eho=;
 b=fDm/Defoy+MDv9gG69+oVhdZUeh07HrddWE4eVoyI7hD0Jdl3/qS4VLOwkRXkOBQ0I
 nFVUyvLSgfEe7bdt99C6yQBajQCN6HX6V8a1f3pGaW1Q3yLoihBg6FAujCapFvqG2EgF
 ATxEDXPx6cG9ETtxPge8L7U5T9cvVJorvllu89x/+QTLlGE6y3NiFRRyDGiONJ31aGgB
 xAMDJ25FHzephkKmbCU+le3imW4aJpiXjMX61sg4/blXRPfTt8SfnEX/h2vAl7vgYn99
 E8dEFrDUur38QMxl5C6WnJ9pJ4FBqBi3luPZmxhdAk1A04z85g7CninlP8M161DVIHqG
 658g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=B90u68HWanE8Ef/dq5GEfdfCsFqZeY71gyQo1Aa7Eho=;
 b=dmxMaM6BWdQLhHEtc62cvzLvycZh3uA0dp1umgc6oRkYRDJZ2fr5clSH9gxLjHhXqz
 mITOhMI3SIWhKNdfjx/JwrhWDAwQcPtGCeiCjlvbQBBFnMY9x48iSN8xM1sdyMxhH+B3
 DKIjw4w1O8P7r/aSmXDn2w5ngN+3DpUqy83lRHUir7IMeve5qwOusIwPwSiYvRDvQm00
 7dti177rmlcNpOr6c9+j0HKgzkw/Iww0wK5y/3TEP5PZUax4f8BjSh4StB64PfwNl5Nn
 3GtZ63RxLulIZ4qmnjKOenyXtgNoZig74YtUybv6WsanlvlV+gB39J4gtaUip2z8kP8c
 Aq9g==
X-Gm-Message-State: AOAM532RxkFjLO/cKaKQiDSnh+73JUWQSJj6WF4GoWNU9gfIJCcw378i
 eQ6f/JwM8wVIioltIbw5gANFV8gj
X-Google-Smtp-Source: ABdhPJzS6/z49w11SeX/vO+j7p9cEGA0RkhEkK32X3UZqocOPs+C+XFqnAEgISFESPFh41842J81qg==
X-Received: by 2002:a1c:6a01:: with SMTP id f1mr12970847wmc.52.1592743693554; 
 Sun, 21 Jun 2020 05:48:13 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id o10sm13779362wrj.37.2020.06.21.05.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2020 05:48:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/15] hw/sh4: Use MemoryRegion typedef
Date: Sun, 21 Jun 2020 14:47:55 +0200
Message-Id: <20200621124807.17226-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200621124807.17226-1-f4bug@amsat.org>
References: <20200621124807.17226-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
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


