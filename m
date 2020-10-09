Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6996DC43457
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:56:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A8D22251
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cT5edKb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A8D22251
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvgn-0000IL-SZ
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQvct-0002bb-1E
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:52:15 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45769)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQvcr-0007iF-GR
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:52:14 -0400
Received: by mail-wr1-x443.google.com with SMTP id e17so10973528wru.12
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ED9ctdoCK+AGBSvVR1uFGDxKqs1IT3566nbTYT2S4dU=;
 b=cT5edKb+3luGr3fwd+TyfChIspEXb6AZbUatl1YGG7M+g6VsxQujwzW7JnwLiwAcpJ
 SVc2q27f56vm4xr8OjP87YG2gtC1Yygknz2Mte+6oV5fqEYHT6Nqs3kqdQnSPwDzBbDJ
 lV+29cuGmDdVL0dEekVIHkkXZEhvujp5nryk4BQxD2TC6o/5Dcjqkw/tdyFJTaoedqKY
 tIfqTjr5OMMbxSBlXcTcWLML/XDgwMr+QUWKNeLW3Km8At7ofStr+LZWJeskk03aU05d
 RfwmozU/DdpfirDF7UN0YC+ebUqLxsYb4YsG6YNutSg8eQdnexJnGnDCbNG+TqO2kkIa
 S/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ED9ctdoCK+AGBSvVR1uFGDxKqs1IT3566nbTYT2S4dU=;
 b=S2/lvGnSTnOvZYHsvx0W192PyfIm/p794emXaGO/vGKNVxk5BVbMdB36YCiuqPiCc8
 HrvNyrmyhS6FF8igp7w23YjWfDzKzU5ks5/A7ua84ic40tJlnp6ukGUed+5CcvWLmbg3
 f54JFkCK+SXvjz7i8PLUljvV9kRcNcnjnNkXVZGNF/437bvgQYqFjKOcOSEYrFN8BNzQ
 7FqyG6i6cMhccOTuq7HriOnE5nj28P9ovOmoNI7Y4sKkDXiRDhLpR3g99eHIG0DikNrz
 0oHYFXQGICObpbOkt4b0CroUR4WdaDWwiTMvgV/8h7/F1TWMso4/zJC63d8xPYcXTm+J
 umcQ==
X-Gm-Message-State: AOAM532WiJSMsSU1i0F20hN3jTLvmO1yxspK5VFXlFQniJyJWfbJ0slv
 RX6KQQJPJ0aqRcxQr28HVYKhPYIEdR8=
X-Google-Smtp-Source: ABdhPJzSo5YBcDC6Sfj2HX87r0VrvpdBBv4jJmrHx9I3JNaHgSnpxSTsTJayQt5w85qO6mP08U/BDA==
X-Received: by 2002:adf:9dd1:: with SMTP id q17mr9330396wre.317.1602262331861; 
 Fri, 09 Oct 2020 09:52:11 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id p13sm12777125wmb.5.2020.10.09.09.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 09:52:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] MAINTAINERS: Put myself forward for MIPS target
Date: Fri,  9 Oct 2020 18:52:04 +0200
Message-Id: <20201009165208.2905569-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201009165208.2905569-1-f4bug@amsat.org>
References: <20201009165208.2905569-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Chen Huacai <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To avoid the MIPS target being orphan, volunteer to keep an eye
on it and put together pull requests.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 426f52c1f63..d59e5c05c10 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -221,10 +221,11 @@ F: hw/microblaze/
 F: disas/microblaze.c
 
 MIPS TCG CPUs
+M: Philippe Mathieu-Daudé <f4bug@amsat.org>
 R: Aurelien Jarno <aurelien@aurel32.net>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
-S: Orphaned
+S: Odd Fixes
 F: target/mips/
 F: default-configs/*mips*
 F: disas/*mips*
@@ -2815,11 +2816,12 @@ F: tcg/i386/
 F: disas/i386.c
 
 MIPS TCG target
+M: Philippe Mathieu-Daudé <f4bug@amsat.org>
 R: Aurelien Jarno <aurelien@aurel32.net>
 R: Huacai Chen <chenhc@lemote.com>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
-S: Orphaned
+S: Odd Fixes
 F: tcg/mips/
 
 PPC TCG target
-- 
2.26.2


