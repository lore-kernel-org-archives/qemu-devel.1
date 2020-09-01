Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738CFC433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:41:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E6C7206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7oDLRCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6C7206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD3jZ-0006LM-9J
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 06:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD3ie-0004WO-7S; Tue, 01 Sep 2020 06:40:52 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33963)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD3ic-0001rs-QE; Tue, 01 Sep 2020 06:40:51 -0400
Received: by mail-wm1-x344.google.com with SMTP id c19so676043wmd.1;
 Tue, 01 Sep 2020 03:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=os2g75NZJynKLqxUCLFQR7EXSgQAqSybj5K1q1ubV4c=;
 b=q7oDLRCBSQlEals5F8HOqPCDlbI33XdKStZTwZUOsfdz9JxRIj0zVYF5hbA4OsrKT9
 bUOVVyDVwkp0kji5QextZq+x5++t3LfpgoHzw+Kx/oZlQOYBDZQ7TbnR2Jg332Ly25Ws
 4vG75strPSdKZjSBvxseUYdO56XKA51JEI8A1UqDqEzmZCzdcFNJataFqIeOk3g8TSkY
 QVOdss3R6D5Xke0+qVKRKtJLC1fcMf73d9xRhb1I1lPFykTIqsl58rRafyLVtB2Ba7JG
 lzx5YYaCalh003u9BQKzFo9TifRZwnT2xNAf8GHnaCjC1whFyjFq2EFK1TWPwT39ChOf
 XKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=os2g75NZJynKLqxUCLFQR7EXSgQAqSybj5K1q1ubV4c=;
 b=GqicHqD4U5oxeBCSDNlYikXCKuwbtm2tXcN2ITlZc862+rAgb2LvgnvVViR/UPJN35
 675lBhc8PfUwUu/eM6xKbg9fsN4Z2MXVyr1QhsbxhooLtvTvLh40fhndrbD2muT3eyrs
 Az03Ppdqo7Ezf+O9boR//CUSJbhAk3V2D182j3rBQbDVysAiMnqjFcmU3oNFSiUACUTs
 64XgbGu53gKMgH2gmnwb0LYlgMJMdztZf8kaSuY3IlzkG2HDUbU+eZjNGeDVM3azZLzm
 g7Qzz3w/YZ5lhCC0QS+CLU8EAKK9LkcUYPdwALSfzfxWbc/bfSfuE58xRbimrkiLl+BN
 EKHA==
X-Gm-Message-State: AOAM532Bp4d5MbGwMkqnYQp+e1jD+6Pkxp+23BpnYrYmx0mef93avHL9
 8cGTNljFi1j+yk9NYY5vl3XZZUeUV5A=
X-Google-Smtp-Source: ABdhPJwZ9J6pck+SzQ737LShkB24MvQsS94u14Hs3PFPrhRzxwy6Fzs8u86oa8BO6VKkDqtDuTOoyQ==
X-Received: by 2002:a1c:c256:: with SMTP id s83mr1152559wmf.93.1598956848137; 
 Tue, 01 Sep 2020 03:40:48 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id o9sm1541461wrw.58.2020.09.01.03.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 03:40:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] hw/gpio/max7310: Remove impossible check
Date: Tue,  1 Sep 2020 12:40:39 +0200
Message-Id: <20200901104043.91383-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901104043.91383-1-f4bug@amsat.org>
References: <20200901104043.91383-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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

The max7310_gpio_set() handler is static and only used by
qdev_init_gpio_in, initialized with 8 IRQs. The 'line'
argument can not be out of the [0-8[ range.
Remove the dead code.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/gpio/max7310.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/gpio/max7310.c b/hw/gpio/max7310.c
index bebb4030d27..7f5de189acf 100644
--- a/hw/gpio/max7310.c
+++ b/hw/gpio/max7310.c
@@ -8,9 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/i2c/i2c.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
@@ -176,8 +174,6 @@ static const VMStateDescription vmstate_max7310 = {
 static void max7310_gpio_set(void *opaque, int line, int level)
 {
     MAX7310State *s = (MAX7310State *) opaque;
-    if (line >= ARRAY_SIZE(s->handler) || line  < 0)
-        hw_error("bad GPIO line");
 
     if (level)
         s->level |= s->direction & (1 << line);
-- 
2.26.2


