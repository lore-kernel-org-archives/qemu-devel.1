Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFEBC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:44:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2CAF206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eV8Pd2s/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CAF206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD3lu-0002De-1F
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 06:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD3ih-0004h2-Gy; Tue, 01 Sep 2020 06:40:55 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39737)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD3ig-0001sU-1s; Tue, 01 Sep 2020 06:40:55 -0400
Received: by mail-wm1-x342.google.com with SMTP id b79so657899wmb.4;
 Tue, 01 Sep 2020 03:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hzm65kQvKrAgJRdgdcCTLRYl0kqFFHOY2vCCMJID1VE=;
 b=eV8Pd2s/JWIFS4zIt5dXGLHw3hfwdNdS66j/QudRZnXb80PJCDKU0yctFfpyr+kjD5
 TFpYtzZm8b0BFsOFFcT+mipaNfmaW/ZhHOBH7fiCs12gfKgbEoalLnISXXJdNFF/Ybxx
 w42oiTur8Kt0YJYOaF9oyGb3H7xm2OJxCMLf+zpanHXbdmNEmb3rkqwBEjzx23g0EozI
 /oEgYduAB525/aohHixV6LkVi6mQx7a+QjIyXKBSu12RQcyZHEhzFAA9vIt42LtZvYFM
 pd6gCMB7WlcPWELWAtekjBOEIqbUBtiNwaAYxn26096ke1oTyBkhfhk6rfDyJeoCZcBi
 nvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=hzm65kQvKrAgJRdgdcCTLRYl0kqFFHOY2vCCMJID1VE=;
 b=Voe16Ltwe3bMgXt9DS7wz4InARvIZA1Soxw8mRQjXd8adwGG5/ZG+g65z15WAeFWiM
 9GVAKP3YmdamgoZhXmM7XUt/3CTjgCUYFjrV5Ji/W2Q7Fs2nVUnDDTyRagDaYFQ9oZfU
 +QVVQKHnITMdqLhOecCODCuQWtZs9cyy+f8bZ7ZjjpCRcLK45hkvsBwfB6t3GpdfsQpV
 +rKs/tP3YRJh3W1f/CRlmst08gKyzh8Nynzkxz3vAyPN4+iNJIQL56p8w3DjasBAMiuM
 f0UlPu9amOwrof0ZhhUHxaxm3u9XSFAuopf9zCo/b5EmLUDm760hjwxx8qKFRiA3w4Rc
 ApQA==
X-Gm-Message-State: AOAM531mqoApbvjWFkbjH5JERcgtJ/YZSQgb2kAan95pjZilfI6l+bK6
 TdNYg8PoJXgRm1bkC/+pzBQzJwq0/rM=
X-Google-Smtp-Source: ABdhPJw+niaClw4SraDQlPT/ijlyk58KHJmwU9bhxNJvmqQqEIRgVtXwO7M3YpwP+DYtO06Q7nC3vg==
X-Received: by 2002:a1c:28c1:: with SMTP id o184mr1197405wmo.91.1598956851497; 
 Tue, 01 Sep 2020 03:40:51 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id o9sm1541461wrw.58.2020.09.01.03.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 03:40:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] hw/ppc/ppc4xx_pci: Use ARRAY_SIZE() instead of magic value
Date: Tue,  1 Sep 2020 12:40:41 +0200
Message-Id: <20200901104043.91383-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901104043.91383-1-f4bug@amsat.org>
References: <20200901104043.91383-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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

Replace the magic '4' by ARRAY_SIZE(s->irq) which is more explicit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/ppc/ppc4xx_pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index 3ea47df71fe..cd3f192a138 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -320,7 +320,8 @@ static void ppc4xx_pcihost_realize(DeviceState *dev, Error **errp)
 
     b = pci_register_root_bus(dev, NULL, ppc4xx_pci_set_irq,
                               ppc4xx_pci_map_irq, s->irq, get_system_memory(),
-                              get_system_io(), 0, 4, TYPE_PCI_BUS);
+                              get_system_io(), 0, ARRAY_SIZE(s->irq),
+                              TYPE_PCI_BUS);
     h->bus = b;
 
     pci_create_simple(b, 0, "ppc4xx-host-bridge");
-- 
2.26.2


