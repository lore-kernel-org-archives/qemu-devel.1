Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E7FC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:26:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2C9420657
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pt8GE+Kb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C9420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTn9x-0007Ja-3E
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmpi-0003uE-KG
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:05:19 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmph-0003ut-1f
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:05:18 -0400
Received: by mail-wr1-x444.google.com with SMTP id i1so6609300wro.1
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8Ewc141UoMMZXp239BJOBQyclagaXr5vDLAwNvdaTwE=;
 b=Pt8GE+Kbr0H46mFNuSl9XlxOxkatk5AliYhHgOlEhrZxzYWPRG2CKoYh5zcJ4OqCu1
 CRJWpZeL2NHOVONLBicrH87Oxp82a96RXzauCM9wHi59d9WCNQ+vi8BmNibFg+YF50Pv
 t/ni+OoQQ25DtIl34g1PHDYuucJctuXQN6/6ko20ZN/Gb9w0t2FfPLtAfsrgGlyXLW4N
 2r+aPb7H65N3hHElfkBHecHhE0xfw+0njbmRcsIAZbiqA4zHzYCLVeEDWHPnIY8aWUdv
 U9pt8qJQc8XiAD6t225kUqDSIH4WAAkNiJMkQB57Wj9QLsPr6Qn8YQkkM4P+nRZMHrO/
 zC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8Ewc141UoMMZXp239BJOBQyclagaXr5vDLAwNvdaTwE=;
 b=pSb8fSMkMelr+jx+NOMK7FJ+kTcZlnbqEuSNKzlk0L3NJOZCHVGM6fB4GI+1dCs5P9
 pKDvhlFBR4F7xEwkOLfCxpYZ9LbqMZmPC4VMGQ0M6cq3rblChEPi8FldYqqROQ45hlWt
 n8lzPhEXhWYXuiU6Uv0C0ulMd0RIyit2cHlj2sYNaf6UzEATwYuRihwqUwpA9Xmm3gJQ
 +x6nBYyaPJ67urk/IPLYJOGiJ3nRkKWp9Ghv46OlAdz/Q+J3AOsmgMORlqDOdB3O92Va
 TzWaTbivJHMJshutG5WEIA+YtOng3dP57rmnnGjUe0L1XtBATL/IvnfnzniSpUei6BRu
 FGcA==
X-Gm-Message-State: AOAM533DyXrV+cRkCEJlljPEZs0Zp5l2lgujsJm9pKMa4S8y/fSBjsWJ
 /KVU8/Ocw+/D8rbWmyxqSyvMBvRMsfc=
X-Google-Smtp-Source: ABdhPJyCR3LaJnL3t89ztgrWpjhTPSzEmSGQFl+sk2JmpxBE8Yf6K5RXwxvyi0kx8U94dqtYmbeDJg==
X-Received: by 2002:a05:6000:81:: with SMTP id
 m1mr10518028wrx.67.1602943515522; 
 Sat, 17 Oct 2020 07:05:15 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id j9sm9162391wrp.59.2020.10.17.07.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:05:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/44] hw/mips/malta: Move gt64120 related code together
Date: Sat, 17 Oct 2020 16:02:31 +0200
Message-Id: <20201017140243.1078718-33-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'empty_slot' region created is related to the gt64120.
Move its creation close to the gt64120 instance creation.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20201012160503.3472140-2-f4bug@amsat.org>
---
 hw/mips/malta.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index a4a4c386268..944045d7701 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1239,13 +1239,6 @@ void mips_malta_init(MachineState *machine)
     DeviceState *dev = qdev_new(TYPE_MIPS_MALTA);
     MaltaState *s = MIPS_MALTA(dev);
 
-    /*
-     * The whole address space decoded by the GT-64120A doesn't generate
-     * exception when accessing invalid memory. Create an empty slot to
-     * emulate this feature.
-     */
-    empty_slot_init("GT64120", 0, 0x20000000);
-
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* create CPU */
@@ -1399,6 +1392,12 @@ void mips_malta_init(MachineState *machine)
 
     /* Northbridge */
     pci_bus = gt64120_register(s->i8259);
+    /*
+     * The whole address space decoded by the GT-64120A doesn't generate
+     * exception when accessing invalid memory. Create an empty slot to
+     * emulate this feature.
+     */
+    empty_slot_init("GT64120", 0, 0x20000000);
 
     /* Southbridge */
     dev = piix4_create(pci_bus, &isa_bus, &smbus);
-- 
2.26.2


