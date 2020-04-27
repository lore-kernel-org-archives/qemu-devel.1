Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AFBC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D525206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfVvfxVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D525206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT0BH-00014N-GV
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 05:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1jT09y-0007lm-Eb
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:34:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1jT09x-0005kK-V6
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:34:42 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43141)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jT09x-0005k2-Hk
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:34:41 -0400
Received: by mail-pl1-x644.google.com with SMTP id z6so6789503plk.10
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 02:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=NZd1iFkHpPpBXrnXcjAlLLDYkgQ24pu5fKGVYiWVpYA=;
 b=TfVvfxVJqwnMZDOj7fgT1WwpLyGZawfDym7LRwAwv5ft2uyySi5uI9Qb0zuOs27WtS
 pk35JWAmtJ3FxiA0eyFRMpi2qyGZq1xfHDOP04g95DgoYljqdq2/ls1fyHBer7sTTVj+
 3c5drTTWJA1hg5+3BG2bXmZJiMVxhpAGhZkAl3EvPd6bnKe3/74xVGcGrCH2t9hlQcPU
 qdh5HxJwWNJbcdGpwy3cJRgOedNJg0YElTCGRQHHOkTaHdxMiVivXaHdsuwEq4xXDZdJ
 Fm2ASdzLGA0ozRjcMMIQsd2eQEhfjLGVBM5fVOt4gJD76wujWXGMAhfu8pgLgg5xQm32
 429A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=NZd1iFkHpPpBXrnXcjAlLLDYkgQ24pu5fKGVYiWVpYA=;
 b=MU3v4/FfP4xngfq3pzWkoebcmNS5nVkumA5sq3xKEvmYLD27VNx05kb500rXxH1H3+
 DPaoGii47xd4WALwnRvMChvGt0wfFJqv+pQOViNNyDrIHwGWWXqXcraZPeZfBj7OuUe8
 TBLAOmTLhdrkJhtbhtXuvN/GaChWImxiK6fWUTnf+28DeAABkGCA7mRETOEkOc57DSnn
 0MLElw0h8uYJDI8GmoHsRChdm3zOPuP4yPYxVjQY5FyXHIhQ6qdelW7IXEJC9MRIZ5QU
 pyHf8AKebnkjIj1PSb07BI0KcAKjF+eIVak1YJbh5CrxkpYYceTjGC4f9f+5CdGII34u
 HtpQ==
X-Gm-Message-State: AGi0PuYDIj21UV1wNgWDSyAdRGAWVNg8hn2PDHEBcBNqcHtvsm7MKlkz
 3RdWB23GZyFa8eRb6P0YXkBXx/SGKvI=
X-Google-Smtp-Source: APiQypKska/wT4TOGS4VWZhp9g5HE5BXnagl8lEYFR7Ki/lAd3cBjpXk89Bsb/6odcwO/gn0UayWtg==
X-Received: by 2002:a17:90b:1104:: with SMTP id
 gi4mr23154080pjb.115.1587980080144; 
 Mon, 27 Apr 2020 02:34:40 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id u9sm11333073pfn.197.2020.04.27.02.34.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 Apr 2020 02:34:39 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH for-5.1 3/7] hw/mips: Add CPU IRQ3 delivery for KVM
Date: Mon, 27 Apr 2020 17:33:11 +0800
Message-Id: <1587979995-17717-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1587979995-17717-1-git-send-email-chenhc@lemote.com>
References: <1587979995-17717-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, KVM/MIPS only deliver I/O interrupt via IP2, this patch add
IP2 delivery as well, because Loongson-3 based machine use both IRQ2
(CPU's IP2) and IRQ3 (CPU's IP3).

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/mips/mips_int.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
index 796730b..5526219 100644
--- a/hw/mips/mips_int.c
+++ b/hw/mips/mips_int.c
@@ -48,16 +48,14 @@ static void cpu_mips_irq_request(void *opaque, int irq, int level)
     if (level) {
         env->CP0_Cause |= 1 << (irq + CP0Ca_IP);
 
-        if (kvm_enabled() && irq == 2) {
+        if (kvm_enabled() && (irq == 2 || irq == 3))
             kvm_mips_set_interrupt(cpu, irq, level);
-        }
 
     } else {
         env->CP0_Cause &= ~(1 << (irq + CP0Ca_IP));
 
-        if (kvm_enabled() && irq == 2) {
+        if (kvm_enabled() && (irq == 2 || irq == 3))
             kvm_mips_set_interrupt(cpu, irq, level);
-        }
     }
 
     if (env->CP0_Cause & CP0Ca_IP_mask) {
-- 
2.7.0


