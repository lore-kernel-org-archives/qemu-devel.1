Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE98FC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:43:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED12206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITHAeOB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED12206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD3lV-0001pY-Ky
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 06:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD3ij-0004mG-97; Tue, 01 Sep 2020 06:40:57 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38669)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD3ih-0001sm-Qa; Tue, 01 Sep 2020 06:40:56 -0400
Received: by mail-wr1-x441.google.com with SMTP id g4so463209wrs.5;
 Tue, 01 Sep 2020 03:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QM/qItNwIVdoGPTKGlbv5UVZGHDIASoQ0JbROkkPkZk=;
 b=ITHAeOB7hg0WDXlzVCSmo58ARpY6dRSf1ppu3qg6z1SBzGe+LEVD3bnalTesNfsLhh
 kYq4W/KBAqRUaxrbMf7fSosDe38aS0SmNZm5rPf2WVPT5cUcft8JQsi7WSGv2ng74QV2
 ia4wOdE4GROioj31NLunxLdJXyTsjqRZ6OpqrLUtOVGB+9YlUwwaESvIE9gE8tvL2/pf
 Y9Vuxg5UJjG3aLsfdNSXMfGfTL3XFoFD4DROxwn5rs9Qqf9OkjwyHs2SQGkLCdBaWAg1
 QWlTuvS850mVdhEYgGpaCAiN+Yj+IgE8s5+m6oPii1n6IoEoqDw2XG/0+bpxtH3kjEOD
 nBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=QM/qItNwIVdoGPTKGlbv5UVZGHDIASoQ0JbROkkPkZk=;
 b=dv1mB2aPDmY979UND2Qhb69PMU217lCDw8bD/HrDNZ9YvsR6FkJWjnUnLnyVHTeq2O
 Eb5gi032z1SVklq0G5GEtsqVbJzfb8R+0LxGFuosQiGgOsPKz6N1rCduKzTW9FApDQTX
 7Sx920XIZ2T4Mdh25pePn0h+S5nCe8KSS0nxYhwTtUqeGyksRjEjhvD5Fxz8GT3doL4c
 HSwRPT9I639H89zG3Q1Hh1XTkImmDrtHhR1B8OVAd1FcrojGflKX7kLJylKwVHcRUnz6
 VerL/SYVsA1vtHzBw+xuXqIXG/J9VcwpzXYIWTpBm4uYvJDk0EzOOPbHs/VGWlJkhgHY
 5gzQ==
X-Gm-Message-State: AOAM5303VIDlkci2Oaypq5NqPZ84e55FdBboWtj15ptKYQm/n54iJAtT
 H5NM9nC795lwY58nDN3frplfcmY9Ru8=
X-Google-Smtp-Source: ABdhPJwXl28ngZChT+9qkSgHjaRIy03w+6BZ5SFIjXqyP2iihqusROiWuLYBsCw2R23671WYjEBwyA==
X-Received: by 2002:a5d:63d1:: with SMTP id c17mr1201861wrw.241.1598956853136; 
 Tue, 01 Sep 2020 03:40:53 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id o9sm1541461wrw.58.2020.09.01.03.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 03:40:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] hw/ppc/ppc4xx_pci: Replace pointless warning by assert()
Date: Tue,  1 Sep 2020 12:40:42 +0200
Message-Id: <20200901104043.91383-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901104043.91383-1-f4bug@amsat.org>
References: <20200901104043.91383-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We call pci_register_root_bus() to register 4 IRQs with the
ppc4xx_pci_set_irq() handler. As it can only be called with
values in the [0-4[ range, replace the pointless warning by
an assert().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/ppc/ppc4xx_pci.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index cd3f192a138..503ef46b39a 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -256,10 +256,7 @@ static void ppc4xx_pci_set_irq(void *opaque, int irq_num, int level)
     qemu_irq *pci_irqs = opaque;
 
     trace_ppc4xx_pci_set_irq(irq_num);
-    if (irq_num < 0) {
-        fprintf(stderr, "%s: PCI irq %d\n", __func__, irq_num);
-        return;
-    }
+    assert(irq_num >= 0);
     qemu_set_irq(pci_irqs[irq_num], level);
 }
 
-- 
2.26.2


