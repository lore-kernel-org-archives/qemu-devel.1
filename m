Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F729C10F14
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:04:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FF8321D81
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sU/rQPoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF8321D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFi2s-0001iw-MP
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 13:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrL-0005QY-Rs
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrK-0003PR-Rn
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:15 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:39577)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFhrK-0003Oa-M2
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:14 -0400
Received: by mail-wm1-x32d.google.com with SMTP id v17so7696397wml.4
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=KnkKCuPSW2iymXOv36vMmluvofqorOTBfFwhuGseNQc=;
 b=sU/rQPoJ9FZlR9FrU59GsYPr7XzFiQVdV6XM3cmhW7+wA95OVH9+/R1DF2KzKIV8zx
 fzAz1Qtho0XSR0josAIV5Lz0gOkXm5WJn2KASBh4aGJ3KiURewWUaI/lERQLFj85Soci
 JY04metUAvTT7EqRoPODdcIokOxFgI3ZDfOo8kYDw6+fPSK4u2kPXqLS74E770hUomGx
 lDs1uvxemvkdL7cEJQGsoMHg/gmEJJ+V2GdWVTDH1k27QgutodF8zyAkKEW1Nogtf1UA
 ifBlcX0fCtDnGkPIZjiwu1HQ6vbQClupPel1BVajtcIBCJPSaRKiXp2JnN3BfVKCvDqc
 X46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=KnkKCuPSW2iymXOv36vMmluvofqorOTBfFwhuGseNQc=;
 b=pOogfOkw/Uhfy7zeGxTrtMNBiXlfvDVDyeAMGAIWoTsLuUC8I14Wv7Oo0S8srlZOZ4
 8AXCnj6ALy59VGsb+BsvVZLEa/nvdq9wRGEAgGp4ucxWkPiduEB+1TTzG2yuXilvRWx5
 WRJ/6DSA9vKURFZijdrA6foDdcxbeiqFWsYhWm+Oh8M+ON1pdZAW7rUhtiMiN4cjlxWz
 ezBTNSjxdElv471TI9qZvwuBQs/U+N27Nu9135SwwfS7MUHs4ZbUMmgj5lZeWJ5a27JM
 zjP34+NE1bHcxh4IT1TwBZtsjfwIt3FaPWgeibm+tJR32Iyy5jZGWXAdZbJ/mZGPO1bW
 XbvQ==
X-Gm-Message-State: APjAAAVcIVAaMD1Ep/Wk3H4r5HALcP2h1J02//1/QFJAcanog9uN+LWZ
 b/Bu6IELtubtDfaXNCpzE4zGTlV+
X-Google-Smtp-Source: APXvYqwy52RdFLfQqNYihsSXfmEgFC7fdVKgPuaomz37rj1TecaITXv78orqv2oYFfr4RpQpWbKv0A==
X-Received: by 2002:a1c:80ca:: with SMTP id b193mr3356516wmd.171.1570035133429; 
 Wed, 02 Oct 2019 09:52:13 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g4sm27303990wrw.9.2019.10.02.09.52.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:52:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/30] mips: fix memory leaks in board initialization
Date: Wed,  2 Oct 2019 18:51:41 +0200
Message-Id: <1570035113-56848-19-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

They are not a big deal, but they upset asan.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/mips/mips_int.c  | 1 +
 hw/mips/mips_jazz.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
index 5ebc961..863ed45 100644
--- a/hw/mips/mips_int.c
+++ b/hw/mips/mips_int.c
@@ -81,6 +81,7 @@ void cpu_mips_irq_init_cpu(MIPSCPU *cpu)
     for (i = 0; i < 8; i++) {
         env->irq[i] = qi[i];
     }
+    g_free(qi);
 }
 
 void cpu_mips_soft_irq(CPUMIPSState *env, int irq, int level)
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index c967b97..8d010a0 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -362,6 +362,8 @@ static void mips_jazz_init(MachineState *machine,
 
     /* LED indicator */
     sysbus_create_simple("jazz-led", 0x8000f000, NULL);
+
+    g_free(dmas);
 }
 
 static
-- 
1.8.3.1



