Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BF4C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 17:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5627D204EA
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 17:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1bjHqaZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5627D204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfSBW-00055H-Je
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 13:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfSAL-0003cM-ME; Sun, 31 May 2020 13:54:33 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38983)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfSAK-0007cs-Pn; Sun, 31 May 2020 13:54:33 -0400
Received: by mail-wr1-x443.google.com with SMTP id t18so9214904wru.6;
 Sun, 31 May 2020 10:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DBQUDGRuCGTWntTIf+/3MDtftJR4gTvYShUP8HbRMhY=;
 b=P1bjHqaZWE44yroDGPGV25akgfIYjPuGLihF6RHZT8HDl0TtROZ3yDCm/0dxAPMmHW
 YIdgBhJiTUjWhFMYt0AIoLqQuiVw/Og550Qk9OJ8FcB0/lljfXf1P5LcVNgZhpivblTK
 soCIirx7gqk9sv6jnMLtuBkamYEljqIYgXVnTjxA7yz/K7j0D2FEDl7myIIkm8IOZ+BH
 Cud28U4PmnaaEg9atppXL0QUD0siM4OIMridWgG1qbLhM4GMBbZYSs7IAZm//dftOBcV
 E0eG0xuoSia7GTR4BvwpIAwxX603cNi/mJNc99NsA373ECpUZ3AgcyAy03XvOZgO7brj
 9N7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=DBQUDGRuCGTWntTIf+/3MDtftJR4gTvYShUP8HbRMhY=;
 b=DlzuR43D1nG9vyjA0rNQ+TNqpVFzIUlrvi2f/9vEwwEPosLHtWXYC42GlzRqRLrXsi
 atZ9DEs9SdKBpefF312n1lCtR0zbtaRsDew7QSTBey8CfDEy8PotjngNNGPxUkdvrXx5
 aF8oyj4aPt/GPqllM++cA7p5oNVvaiIDsB1KV8UkyZcQVmBm1ud4fp96fI4arZy1FyMx
 9YBy9PHSYVGnXnYVFGAmP8tzVuylQtuaSL9TG2F0CFog9eAjgrI5ypJzrxPlDyoRhr/b
 sqPRW4VyUOOM3tGV/nlAOtINpJZu+XMDtWUEOaB+1JPlRPxAW29ArGJeyeXRsGNZ3FY5
 VQ+Q==
X-Gm-Message-State: AOAM532ewBwPOZlzg9bdVcpuM6VkGMstE3wcYjlyRwlEh+7QKIS+3N2X
 BK84g1l1Pkusv2ikRPWdouLxe2eV
X-Google-Smtp-Source: ABdhPJytI2CNMDNjMq8ZFRMNVmEv8gdBBAxqVsiqsYyIK0qBiIp1jl4HClPeskoN0yIUV2a0GsdPFA==
X-Received: by 2002:adf:b354:: with SMTP id k20mr18343908wrd.412.1590947670503; 
 Sun, 31 May 2020 10:54:30 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id z7sm17862531wrt.6.2020.05.31.10.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 10:54:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/6] hw/dma/rc4030: Use DMA address space to do DMA accesses
Date: Sun, 31 May 2020 19:54:21 +0200
Message-Id: <20200531175425.10329-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531175425.10329-1-f4bug@amsat.org>
References: <20200531175425.10329-1-f4bug@amsat.org>
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
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The DMA device should not use the CPU address space
to do its operation, but its own address space.
Replace cpu_physical_memory_write() by dma_memory_read()
since we already have the DMA address space available.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/dma/rc4030.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index eefbabd758..c39fe2bb69 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "sysemu/dma.h"
 #include "hw/irq.h"
 #include "hw/mips/mips.h"
 #include "hw/sysbus.h"
@@ -301,7 +302,7 @@ static void rc4030_write(void *opaque, hwaddr addr, uint64_t data,
         if (s->cache_ltag == 0x80000001 && s->cache_bmask == 0xf0f0f0f) {
             hwaddr dest = s->cache_ptag & ~0x1;
             dest += (s->cache_maint & 0x3) << 3;
-            cpu_physical_memory_write(dest, &val, 4);
+            dma_memory_read(&s->dma_as, dest, &val, 4);
         }
         break;
     /* Remote Speed Registers */
-- 
2.21.3


