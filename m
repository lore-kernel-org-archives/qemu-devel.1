Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9611C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:41:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E854206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tZk9XZDZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E854206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD3jh-0006js-LS
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 06:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD3if-0004bJ-SU; Tue, 01 Sep 2020 06:40:53 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD3ie-0001s9-8U; Tue, 01 Sep 2020 06:40:53 -0400
Received: by mail-wm1-x343.google.com with SMTP id o21so677717wmc.0;
 Tue, 01 Sep 2020 03:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zZvjWb7AknUsK/mu73xU4Jmjdq77tQz7mAep9gjBMZM=;
 b=tZk9XZDZ6FeyZVvF/47xxgq0ilvRYSYUnU41wk2f1ioKiPjKqvqSJqAoawzjWKIUi+
 bI23K1Q1NoirJzR+8wRO4yzR0vjTz6b4DWCuUNu/LeQTqSGfq4Nc8VmR6sNN1QyQKrn2
 bamqUnpicfiD6gy2WqwjyAA7edcv0J1MOJAPwE5ceFadbo6KkUKRBqBZbzyVjuaRtgXA
 /aNG+Ar/h7cfuNAWqaHGuTteQn+CkKS2bl+8Dhg0x+Iy93YXlCnzTr3ZdMvfpyryTXlV
 T2zwBYzFAlzaFjRbfto1F28HSHATy/EO22jzCZ8FALqtHvGjBTdjz7QY2zgh14g+Z8zq
 jQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=zZvjWb7AknUsK/mu73xU4Jmjdq77tQz7mAep9gjBMZM=;
 b=uIdW2Teq405TkT75Lxw/U93Fze7JjpvYfXfPY47iqk7gdwVX2Fygoi3b4yezGoV889
 D0F4VaJ6vuI/vmkg4iEUP5jO1qde0JPy/e58Hrqmd2Cv3XdgvnWEZFl817PV8AoMrZcu
 sb6SNYn+9WI7EsUqoF+jMp95Ykv6oEwT62b8LEs/iUEvugpw3AOnjOxbNr5cmMFucZjY
 OAeaasuDoeGX+bXscRNKSmU5CaM4p8ekYPtXKkxWVo1vrFMK8hT/GZ9VfoR0vPRpamp+
 7WFlWeOd6TQgymdDY9OX40wFmqtdw84t/mOpl/gUayVPYmHpDvlZpc/MucnI69DDzkkn
 iDXg==
X-Gm-Message-State: AOAM532ysVWUk2vYRBWSY0K1Lu0ifdJzvA054WNVjzCXBLP3b3Fg4Ro3
 Ajmvdm8PQ0119ya4uAYIa5nQEXr5UdI=
X-Google-Smtp-Source: ABdhPJwiApc9hJMel2OUL9w5WmhWYMkx6MHEyA5Hasx1HxfoQGJSMenbwAXJybW/jhPFQw/pvEA89Q==
X-Received: by 2002:a7b:c3c8:: with SMTP id t8mr1121792wmj.101.1598956849831; 
 Tue, 01 Sep 2020 03:40:49 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id o9sm1541461wrw.58.2020.09.01.03.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 03:40:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] hw/mips/fuloong2e: Convert pointless error message to an
 assert()
Date: Tue,  1 Sep 2020 12:40:40 +0200
Message-Id: <20200901104043.91383-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901104043.91383-1-f4bug@amsat.org>
References: <20200901104043.91383-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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

Displaying "vt82c686b_init error" doesn't give any hint about why
this call failed. As this message targets developers and not users,
replace the pointless error message by a call to assert() which
will provide more useful information.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/fuloong2e.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 8ca31e5162c..f28609976bf 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -240,10 +240,7 @@ static void vt82c686b_southbridge_init(PCIBus *pci_bus, int slot, qemu_irq intc,
     PCIDevice *dev;
 
     isa_bus = vt82c686b_isa_init(pci_bus, PCI_DEVFN(slot, 0));
-    if (!isa_bus) {
-        fprintf(stderr, "vt82c686b_init error\n");
-        exit(1);
-    }
+    assert(isa_bus);
     *p_isa_bus = isa_bus;
     /* Interrupt controller */
     /* The 8259 -> IP5  */
-- 
2.26.2


