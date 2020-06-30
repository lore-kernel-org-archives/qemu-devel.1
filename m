Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF95C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 16:49:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AE1C206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 16:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VftcJPlp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE1C206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqJRP-0000c6-FP
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 12:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqJPo-0007Ny-Qx
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 12:47:24 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:34279)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqJPm-0007zl-9O
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 12:47:24 -0400
Received: by mail-ej1-x642.google.com with SMTP id y10so21368801eje.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 09:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5Xny8L3l0VFSndMmYb2T1ad6LbQdW7hhdEvQurbhWF8=;
 b=VftcJPlpkpULIXiqv5v6vLtQeN5eMAdqOTFCEYnl4vc7xojZZQhe7l/+QlTiWS4SzG
 FQ7Wcv03nhLu1eRIbjTbrTj3Q86slJN3eIhB+v9vSTESkSnlNyZhHUXyYyh0K1Va/T+j
 SMZMgw0SamnUsmCqKBt/dLiAIU5FrMlRlEnl+k/R4NLuKiqGW+ASTmSjCOGtz1vRhT6X
 neB4DyYgA4CZwMIxMKiQab+knMp4f1VoCVANK9j43cLQvp2Yj01T4nzB/l1YYOTGWG5b
 P/U27YxNUcd4axrqB54efvQD1wVzbZXRLR5pdTEpmcYOuobv5ti+nNl64aJ3Na9H480B
 ZPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5Xny8L3l0VFSndMmYb2T1ad6LbQdW7hhdEvQurbhWF8=;
 b=Fb5+wdAPUKdk4vVL64DomFBXuk+8zHT086mn3m2r3i5w8St2djAMl7yeAwe7MIepYh
 F40BA4yjn4QJ3nshhv/jTe0aXmvk37kA2eXDjye6BZax3oNPJuklUg7vCkV37WtLcuXw
 b6kbfdkhR5PvXlOZOnr1uLqOyftqw7QREsivn1wEtI69x58tsfZySZn5QuZI6zvQVSJM
 6SasbbSu+LcfmxliGlkB4KHoR3H65LiebxWGnB2W6aHOWHJDPb4alBnN9GOvni6ce5eT
 sbGTrMoUzjlYV1Nn5EIfWWYrPv3mO3tiPFLi25hGI9eOdY2o51dQ5IJbYeRtI4W6KSCc
 bD6w==
X-Gm-Message-State: AOAM531Qxs1O9ru4fL4KLvQxhrX0aYHyT5gFToxmSDXlUmLciS9tS4cU
 nShy+KgqaNOx4SzpstEs9Mww/IOI
X-Google-Smtp-Source: ABdhPJwDQ73Axr9M5TLrtvxTSucU5+Y2n/5drNaus3J2wJaTBhjHy9novJy1Wgslxw/nNDyYX1+LcQ==
X-Received: by 2002:a17:906:6ad8:: with SMTP id
 q24mr13942592ejs.223.1593535640985; 
 Tue, 30 Jun 2020 09:47:20 -0700 (PDT)
Received: from localhost.localdomain ([109.245.225.97])
 by smtp.gmail.com with ESMTPSA id d26sm3233096edz.93.2020.06.30.09.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 09:47:20 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] MAINTAINERS: Adjust MIPS maintainership
Date: Tue, 30 Jun 2020 18:46:52 +0200
Message-Id: <20200630164653.24880-3-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200630164653.24880-1-aleksandar.qemu.devel@gmail.com>
References: <20200630164653.24880-1-aleksandar.qemu.devel@gmail.com>
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
Cc: Aurelien Jarno <aurelien@aurel32.net>, aleksandar.rikalo@syrmia.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paul Burton <paulburton@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paul Burton and Aurelien Jarno removed for not being present.

Huacai Chen and Jiaxun Yang step in as new energy.

CC: Paul Burton <paulburton@kernel.org>
CC: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 MAINTAINERS | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d8acf8d31..7fc16e21c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -213,7 +213,8 @@ F: disas/microblaze.c
 
 MIPS TCG CPUs
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
-R: Aurelien Jarno <aurelien@aurel32.net>
+M: Huacai Chen <chenhc@lemote.com>
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
 
@@ -1052,6 +1054,7 @@ MIPS Machines
 -------------
 Jazz
 M: Hervé Poussineau <hpoussin@reactos.org>
+M: Huacai Chen <chenhc@lemote.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
 F: hw/mips/jazz.c
@@ -1060,8 +1063,8 @@ F: hw/dma/rc4030.c
 
 Malta
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
+M: Huacai Chen <chenhc@lemote.com>
 M: Philippe Mathieu-Daudé <f4bug@amsat.org>
-R: Aurelien Jarno <aurelien@aurel32.net>
 S: Maintained
 F: hw/isa/piix4.c
 F: hw/acpi/piix4.c
@@ -1073,6 +1076,7 @@ F: tests/acceptance/machine_mips_malta.py
 
 Mipssim
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
+M: Huacai Chen <chenhc@lemote.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Odd Fixes
 F: hw/mips/mipssim.c
@@ -1080,7 +1084,6 @@ F: hw/net/mipsnet.c
 
 R4000
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
-R: Aurelien Jarno <aurelien@aurel32.net>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Obsolete
 F: hw/mips/r4k.c
@@ -1103,7 +1106,8 @@ S: Maintained
 F: hw/intc/loongson_liointc.c
 
 Boston
-M: Paul Burton <pburton@wavecomp.com>
+M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
+M: Huacai Chen <chenhc@lemote.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
 F: hw/core/loader-fit.c
@@ -2677,7 +2681,8 @@ F: disas/i386.c
 
 MIPS TCG target
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
-R: Aurelien Jarno <aurelien@aurel32.net>
+M: Huacai Chen <chenhc@lemote.com>
+R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
 F: tcg/mips/
-- 
2.20.1


