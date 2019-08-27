Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC51C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6C03214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2gbg9Cv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C03214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2dDK-0004Zd-Do
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 11:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i2cvx-0003G3-UZ
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i2cvv-0003Qp-Ca
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:58:56 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37195)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i2cvu-0003PE-M5; Tue, 27 Aug 2019 10:58:55 -0400
Received: by mail-pl1-x643.google.com with SMTP id bj8so11919698plb.4;
 Tue, 27 Aug 2019 07:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=bph9QJ0bNuPskxMhwrZk+kqRsPAn0NFXg/LQc9J4RXw=;
 b=Y2gbg9CvjQ5C7fyxiVU2g9D8zb3NF3nYMoLQ+IrOzN87aMJpmvtvd2ZxyrWxeIrRtO
 AbXUIKlkl3gWk9Lj52wBC0kN1sivQ7LNTCT95REBBTj7zkhSHfcpbsfIhhTEsqAUBzdV
 wJROFrqmj8H9NGTgcd0017Q2lbYppmoUvkMi2N5GqUg1B8vQp4ib9yENn+KZC3Kyx692
 9S8yHH6gS6WSC93zliAWXnMP+d0CGmNjsD2evNf8mjJzd3mBKVeeU7PdzQmgsck2KcbX
 o3Ln9tHQPzy6emLDtvKV5WhpyL3xUJRAF3LqXJEwtTfw1lNrgkewZLJ7IsBeoWGrbw2q
 iGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=bph9QJ0bNuPskxMhwrZk+kqRsPAn0NFXg/LQc9J4RXw=;
 b=JEqxYbc0dfSYr6FxOm2eOc31n96frTt4+h+FU/z22DDYwKwMqaL47ZN0EbRSdogfKU
 gIdtNOhIzIvhOK+ST3AtvwRCvU5WmSsEi9S0P7O6DZ1PL2sMV1TOYb2OqPIxRsgeno6Y
 1rVzmUa71ZeE1lYAFk9gm3FzkfPehLjYEPQNSdvHPTlv3Vcg4qi4TKnrPEtlPPcZ7l3S
 ZPT1KxUE3ALBjLS6VMt4JMUXINxsTFL/26jbXgTt+DIbIHRk6GQWgK5wx2TgslGB2ZMU
 RqeJiXI4bioSmx8LFg2cqjr6b3bJv3RGUWlG5kmUwbyh1X91Y3vASI39Egs6j0LUS/2j
 8jFA==
X-Gm-Message-State: APjAAAWTX/dQmRbz7TyY/6jFevUyMM3oASmDBXyvmpQl7mp6zyo6njRy
 j9pZiUsz/lgUn46nH8XwHFM=
X-Google-Smtp-Source: APXvYqxvPxL7tuF5Kc1X64iOAuRYnwQlnHrCpSTBel7INXKFBn/MujouENqm0koMNyDaaCTQR0V6og==
X-Received: by 2002:a17:902:8a93:: with SMTP id
 p19mr25202024plo.106.1566917933929; 
 Tue, 27 Aug 2019 07:58:53 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id j15sm14839344pfr.146.2019.08.27.07.58.52
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Tue, 27 Aug 2019 07:58:53 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Tue, 27 Aug 2019 07:58:17 -0700
Message-Id: <1566917919-25381-9-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566917919-25381-1-git-send-email-bmeng.cn@gmail.com>
References: <1566917919-25381-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v6 08/30] riscv: sifive_u: Remove the
 unnecessary include of prci header
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

sifive_u machine does not use PRCI as of today. Remove the prci
header inclusion.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index e22803b..3f58f61 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -39,7 +39,6 @@
 #include "hw/riscv/sifive_plic.h"
 #include "hw/riscv/sifive_clint.h"
 #include "hw/riscv/sifive_uart.h"
-#include "hw/riscv/sifive_prci.h"
 #include "hw/riscv/sifive_u.h"
 #include "hw/riscv/boot.h"
 #include "chardev/char.h"
-- 
2.7.4


