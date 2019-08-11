Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB40C0650F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:10:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1B90208C2
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EySjcQa/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B90208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwiw7-0005tf-8V
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 04:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60185)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwisq-0005pD-4K
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwisp-0003vH-7N
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:20 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46547)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hwisp-0003uk-2D; Sun, 11 Aug 2019 04:07:19 -0400
Received: by mail-pl1-x644.google.com with SMTP id c2so46684525plz.13;
 Sun, 11 Aug 2019 01:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=33iCXJdQye0W0dczJpxKBXpSVkEIwnX6R1YYAPi3V34=;
 b=EySjcQa/Kc+ytfnaSXHJtNzo0CHYfqSePd339xyuZlPSdDnm/MT+7mNvgy/irWswZq
 BmufWmvO2ZleDqesdVEcykzGgsQuSvV9oC4/OWPIto7OPRByb5VfH/Z2bd0VyyCFYE1g
 oiNV0DyHYvavw5A/CCWLHK/UMe1fomoKnqK2/2QQ+enMh1AdlFDlYdWdLb0CB7snpFXD
 Ol60nyvIkX6J7rG2QYFs7X5zZa2gfx1q44SLzsm70TJOLGDsh894bapN0ve7ENMonev3
 IzzmE15zBV5cvsBv0XtIgaAshWRDDXkLX0zmR0zz8+xK8/7ct5mUsBu4FBNhCBEkBMUf
 4y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=33iCXJdQye0W0dczJpxKBXpSVkEIwnX6R1YYAPi3V34=;
 b=fdIqzPK5/YeGGIfpHYLdjVOa57JUahoSZ/gtHWmhhPHQpPLGlyTS7zNUxy+GjAl0qv
 g8XHjtaZAnB1romAuLZf+avs1m0EUND3EuGfkvidySStLBSf7af5jZg9Cq7hiaWeQJNL
 ZzdY9mdrOnFR57u7P2VwzQJRz8Byp5zvSO6sOrPdVGDWtOzrL/gA9RLcEcLGYYYmXGqY
 rEy/P55x3/e7b4t2mDwqh5jOT+WjBvW24luZABueVtTpwwdrAZLes5Da0n3zWxLYL+OQ
 4Bq96uGhmfW87yryEvyhnxEMBX3Y05DZECtsdc3uOsMmEdWgizaezbOVM8JGrgXumsOo
 uzAA==
X-Gm-Message-State: APjAAAVcjNo9wDJ2mhAlET0W4UMSby4fgH8p3ydhKhAv1XRuOKl67lhG
 5Q4l8knHwanXJNAz0Zo7twQ=
X-Google-Smtp-Source: APXvYqxn4IzKzebt1fE039gf5Hb6xb1CaOYxtSaXfF3cOkfm94TMz47XQkaprFgT7FBEOP9k7ADlVA==
X-Received: by 2002:a17:902:5a5:: with SMTP id
 f34mr13072818plf.178.1565510838055; 
 Sun, 11 Aug 2019 01:07:18 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v8sm87339107pgs.82.2019.08.11.01.07.17
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 11 Aug 2019 01:07:17 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 11 Aug 2019 01:06:43 -0700
Message-Id: <1565510821-3927-11-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
References: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v3 10/28] riscv: sifive_u: Remove the
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

Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index f24ec2e..e071838 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -41,7 +41,6 @@
 #include "hw/riscv/sifive_plic.h"
 #include "hw/riscv/sifive_clint.h"
 #include "hw/riscv/sifive_uart.h"
-#include "hw/riscv/sifive_prci.h"
 #include "hw/riscv/sifive_u.h"
 #include "hw/riscv/boot.h"
 #include "chardev/char.h"
-- 
2.7.4


