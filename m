Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1208C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:40:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7732E21848
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7732E21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAc4W-0001KA-OZ
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 11:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsE-0006il-HB
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsC-0006f4-Um
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:05 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:33104)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iAbsC-0006eh-Pd
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:04 -0400
Received: by mail-pg1-f174.google.com with SMTP id n190so65905pgn.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=EmC0jz3GTl2BrX2tWMEAqndIZJCvRtbADNjHP8GTEXU=;
 b=KtPe2leWNVN7jeOQO+eDXFGvmWpNPdkn74jQobEdI1KtoFqhbDDQtXXxPzGGLGGfJF
 /weW8ydhhCk5rBq8vTxXxeQ5fnHyhXgZIpusm14ru+Q3HvFGrjktZhE7D4jVyDblPS6J
 uIykLwBEjvegkM+jer7vPzzbvWbnWSUC44CrDNicf3GZJXEZaLMtdPTzW1F8ymr8v5VP
 0XCQmhUzw8GuYCUCYH2dl4JtTXaf65klb6AHc6LuUs4/WQ+auXg5NEPeAGzVkC1nqIeC
 Dd/D+JnlSNy6I8kDtg3FMx60S/n6mrNOMm2UKGE5hCHgyps/Suw2Abj388oeprWwGRZ0
 1W4w==
X-Gm-Message-State: APjAAAXspWM4LXUmB5SF+Cos6LFhyye7H+W/p/fdz93wxQI0sCPeRZzt
 2kMi8A5IOTFyOZehZua/Mih2jqLV0Ec=
X-Google-Smtp-Source: APXvYqyxP8Dx+q3aWO2zM+Zsmg68F/He/iMX6soMeNmsSgOAi9FcdlHFhbmd2IaqykAnN4Rcf4KsUQ==
X-Received: by 2002:a17:90a:1903:: with SMTP id 3mr4314838pjg.80.1568820483582; 
 Wed, 18 Sep 2019 08:28:03 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id d190sm5765349pgc.25.2019.09.18.08.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 08:28:02 -0700 (PDT)
Date: Wed, 18 Sep 2019 07:56:06 -0700
Message-Id: <20190918145640.17349-15-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918145640.17349-1-palmer@sifive.com>
References: <20190918145640.17349-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.174
Subject: [Qemu-devel] [PULL 14/48] riscv: hw: Remove duplicated "hw/hw.h"
 inclusion
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

Commit a27bd6c779ba ("Include hw/qdev-properties.h less") wrongly
added "hw/hw.h" to sifive_prci.c and sifive_test.c.

Another inclusion of "hw/hw.h" was later added via
commit 650d103d3ea9 ("Include hw/hw.h exactly where needed"), that
resulted in duplicated inclusion of "hw/hw.h".

Fixes: a27bd6c779ba ("Include hw/qdev-properties.h less")
Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_prci.c | 1 -
 hw/riscv/sifive_test.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/riscv/sifive_prci.c b/hw/riscv/sifive_prci.c
index 9837b6166f..562bc3dc4c 100644
--- a/hw/riscv/sifive_prci.c
+++ b/hw/riscv/sifive_prci.c
@@ -19,7 +19,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "target/riscv/cpu.h"
diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
index 3557e16701..711740939e 100644
--- a/hw/riscv/sifive_test.c
+++ b/hw/riscv/sifive_test.c
@@ -19,7 +19,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "sysemu/runstate.h"
-- 
2.21.0


