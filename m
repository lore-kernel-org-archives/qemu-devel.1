Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99B7C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F12F207F5
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhi0FCg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F12F207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqhSR-0002Jl-Ng
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 14:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqhR8-0000Yy-Ho
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 14:26:22 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:40755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqhR5-00049Q-Hx
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 14:26:22 -0400
Received: by mail-ej1-x642.google.com with SMTP id o18so21558235eje.7
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 11:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/XnIS6XF5CC1zqf9zQ7/SX/fLjnbwp9fJEnkQPx0xiE=;
 b=nhi0FCg7VrIMZZMZ2pUN8TA0y6Mt+fDcjnNplIb2jgx8SYhnzKIPktozDzUmsYiKfY
 g/uKdCYKm8lvd3Hdg8ybAJjcUPfOb/uNyp5xoKoW6hLq8tSOU+sWSBZzSO06AczDwdLX
 3YwIqCI00slzoLBjOBASqpAVrun0Uzat3oAUZUsb61sDej/TaGLEYMM8nl/0yve0IvAW
 pIb2zlhBQzvZbYxeUv3ztIFSdwzuQ2FbFNo9Q6g9dpysYVe80+b90GH3GcQhqZOrA4DQ
 Ww83wTkWDKXGDIxk10fkmxdjqFPALXKYJYvamLZ/oBSe8hQe+rCPMEErT3vW9OjmF4TS
 Dn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/XnIS6XF5CC1zqf9zQ7/SX/fLjnbwp9fJEnkQPx0xiE=;
 b=GhH00tcCDI4WlEXuJ44JtfZdtjNILLA7tPOQRemOrAftvRyBvWoHE1hGdZniUC9+e4
 eHnbChbmi2ib2h+4UlrDEXF0oMGddTLlCR+TIiBBV8o85vXVs2Vt+nFSMxOg3z97GpHj
 I4OEDUE/LOAy4LgLx7Dx82k656wLZpK4gNsfK31UnoG/Qnk9ekwh37TE9Eb79rHVoyJD
 35QbkXffSqGOLmnBWLcsoUKefDRtScvGgb9obz0muPHG7aeUXMYlSOUz6UIxeK4LUiot
 PQtiAeADwt/Ox0+gPpRtsmmkmwnXINI3gzk45i2qhTZR071pnSHJz9Rx/beYGe+3GRCq
 Dfrw==
X-Gm-Message-State: AOAM533m+fvxiqCdKVQ9zOKjcS3DKBeuw4eqVjjWDZDiNb65dE+jpbSW
 23gtqn1OCMTVCw8cy7EKg+APFvJk
X-Google-Smtp-Source: ABdhPJwPCeaziShSALaSc/EwzhiAy5S9+7i/hQGemULBJrfmeHPxnng7KJki7DZ4TM3bE6QX0wKlVA==
X-Received: by 2002:a17:906:cd18:: with SMTP id
 oz24mr23790047ejb.118.1593627977654; 
 Wed, 01 Jul 2020 11:26:17 -0700 (PDT)
Received: from localhost.localdomain ([109.245.225.97])
 by smtp.gmail.com with ESMTPSA id y22sm4809333ejf.108.2020.07.01.11.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 11:26:17 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] MAINTAINERS: Adjust MIPS maintainership
Date: Wed,  1 Jul 2020 20:25:58 +0200
Message-Id: <20200701182559.28841-3-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701182559.28841-1-aleksandar.qemu.devel@gmail.com>
References: <20200701182559.28841-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.rikalo@syrmia.com, Paul Burton <paulburton@kernel.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paul Burton and Aurelien Jarno removed for not being present.
A polite email was sent to them with question whether they
intend to actively participate, but there was no response.
In cases where needed, other persons step in instead.

Huacai Chen and Jiaxun Yang step in as new energy.

CC: Paul Burton <paulburton@kernel.org>
CC: Aurelien Jarno <aurelien@aurel32.net>
CC: Huacai Chen <chenhc@lemote.com>
CC: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 MAINTAINERS | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d8acf8d31..6f96c03f3e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -213,7 +213,8 @@ F: disas/microblaze.c
 
 MIPS TCG CPUs
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
-R: Aurelien Jarno <aurelien@aurel32.net>
+R: Huacai Chen <chenhc@lemote.com>
+R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
 F: target/mips/
@@ -377,6 +378,7 @@ F: target/arm/kvm.c
 
 MIPS KVM CPUs
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
+M: Huacai Chen <chenhc@lemote.com>
 S: Odd Fixes
 F: target/mips/kvm.c
 
@@ -1061,7 +1063,6 @@ F: hw/dma/rc4030.c
 Malta
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 M: Philippe Mathieu-Daudé <f4bug@amsat.org>
-R: Aurelien Jarno <aurelien@aurel32.net>
 S: Maintained
 F: hw/isa/piix4.c
 F: hw/acpi/piix4.c
@@ -1080,7 +1081,6 @@ F: hw/net/mipsnet.c
 
 R4000
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
-R: Aurelien Jarno <aurelien@aurel32.net>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Obsolete
 F: hw/mips/r4k.c
@@ -1103,8 +1103,7 @@ S: Maintained
 F: hw/intc/loongson_liointc.c
 
 Boston
-M: Paul Burton <pburton@wavecomp.com>
-R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
+M: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
 F: hw/core/loader-fit.c
 F: hw/mips/boston.c
@@ -2677,7 +2676,7 @@ F: disas/i386.c
 
 MIPS TCG target
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
-R: Aurelien Jarno <aurelien@aurel32.net>
+R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
 F: tcg/mips/
-- 
2.20.1


