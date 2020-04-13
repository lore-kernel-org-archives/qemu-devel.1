Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CBEC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 07:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 561C120737
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 07:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+U8Kwzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561C120737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNtVB-00037n-3e
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 03:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenhuacai@gmail.com>) id 1jNtUI-0001y8-8r
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chenhuacai@gmail.com>) id 1jNtUH-0008Pm-8I
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:26:34 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37097)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chenhuacai@gmail.com>)
 id 1jNtUH-0008PT-2o
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:26:33 -0400
Received: by mail-pf1-x444.google.com with SMTP id u65so4164468pfb.4
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 00:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bZw6h2yo9U+Mfy3dzljKqyaJpon7bVmdpfdx+JLJk18=;
 b=J+U8Kwzn86Rc4sqH084u496a4YLWjSZok7YynJds7+m7/1NOtP1yztf181dwOfLhDl
 KToGfX1j7pUol8ZgqBsmjUA4lhvipo5wn6lyMD/lFPfZghjWA34eNZRnEyZxugtkNkQt
 ywSzvX2EfqwXDZJlDTD2YelivRnftxkEysc+Z4Egsv7vORdW/eOQArNwHZSQ/o4nf/rj
 mtV9xYDOBvdvSUOdo0gSSFUiImcJGDHkE/wcLGFMdpQyUnhqbwe0NqB3EV6ywT27mP/F
 Rz/CG47h765/07p0N+PMaJOU1irLHtDy1jEKarwdknCXNwal10rq8bfkaz74P854oKDN
 gWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=bZw6h2yo9U+Mfy3dzljKqyaJpon7bVmdpfdx+JLJk18=;
 b=aqip+keYI36JSJ+dmk/POgtCek+/H2V5iuO3w9vcUiQLY518L33XjC4+TZUdg4zPjg
 xPwwq5c5iCIly9MabAIMWpuIBiT7ND8DWbThQmUo60ziT7fWPI8EC4+V/wKJ2Kfk/JwG
 jQPPI1CUyl2qCaR6tdwdkq//1hI1Pky+D1+pABYCcSBKAB0TmrxYAcf72si3QXAB4D9Z
 TbvoCg+cPeP7vrXqhBB80VIlAz0v7mG38IIUYhIFfrC+744RzEFIoMlfmdtL+WNaqif1
 YijO14losonDvIxgfq/Udo4+Ojirblstc10QX5+6S9R3AC9praLJLUxeUWLKbKiodwwb
 xe4A==
X-Gm-Message-State: AGi0PuZjFNIxNVpSKjjxF5YH0ZI8OqmAFJRmiBaBqim8l3Hm9BOSWTpS
 EkR0oGIzeKEd/E6NYPQqzW0=
X-Google-Smtp-Source: APiQypL5+/JpeggvZ2dMsDBr8FlWbIdPo+KXT5Ndgn8wFWn18tzkVgeZUGMujR5wtOclfCatqUrB4A==
X-Received: by 2002:aa7:96f5:: with SMTP id i21mr17105073pfq.248.1586762792074; 
 Mon, 13 Apr 2020 00:26:32 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id u8sm7241341pgl.19.2020.04.13.00.26.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Apr 2020 00:26:31 -0700 (PDT)
From: Huacai Chen <chenhc@lemote.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 09/15] KVM: MIPS: Let indexed cacheops cause guest exit on
 Loongson-3
Date: Mon, 13 Apr 2020 15:30:18 +0800
Message-Id: <1586763024-12197-10-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1586763024-12197-1-git-send-email-chenhc@lemote.com>
References: <1586763024-12197-1-git-send-email-chenhc@lemote.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: kvm@vger.kernel.org, Huacai Chen <chenhuacai@gmail.com>,
 qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 linux-mips@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
 Huacai Chen <chenhc@lemote.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Loongson-3's indexed cache operations need a node-id in the address,
but in KVM guest the node-id may be incorrect. So, let indexed cache
operations cause guest exit on Loongson-3.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/kvm/vz.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
index e30ebb2..9a228dc 100644
--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -2853,8 +2853,12 @@ static int kvm_vz_hardware_enable(void)
 	write_c0_guestctl0(MIPS_GCTL0_CP0 |
 			   (MIPS_GCTL0_AT_GUEST << MIPS_GCTL0_AT_SHIFT) |
 			   MIPS_GCTL0_CG | MIPS_GCTL0_CF);
-	if (cpu_has_guestctl0ext)
-		set_c0_guestctl0ext(MIPS_GCTL0EXT_CGI);
+	if (cpu_has_guestctl0ext) {
+		if (current_cpu_type() != CPU_LOONGSON64)
+			set_c0_guestctl0ext(MIPS_GCTL0EXT_CGI);
+		else
+			clear_c0_guestctl0ext(MIPS_GCTL0EXT_CGI);
+	}
 
 	if (cpu_has_guestid) {
 		write_c0_guestctl1(0);
-- 
2.7.0


