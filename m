Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778D5C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4498F217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyRxYnK2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4498F217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvGjL-0004fZ-IX
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 03:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36584)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvGdq-0000yz-MR
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvGdo-00085W-Hi
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:45:50 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43740)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hvGdm-00082B-DA; Wed, 07 Aug 2019 03:45:46 -0400
Received: by mail-pl1-x642.google.com with SMTP id 4so32482884pld.10;
 Wed, 07 Aug 2019 00:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=+kkIV9Pb3fWIlgocrgzv3WCYT64zAV7oz/qm/72ONo8=;
 b=RyRxYnK2NdyVA4uMD2xs+wJlTgGMcWd289X2W1Q4vq8zoknUS5PWCWCis9nerNsWyf
 gkqF4Kfev/uypEIifGnq0/HhunobnufFJokqkQQoJHPwJ8QqQtJSncBx46G5djOTh232
 iQHhqAL4xcTRDbnh5OVBUdHDo0gdPcyp6yp7S6FvEab6VZt08ubGZnYoMa44BfeLJcrB
 oVHt4Ipo5ZTMX/PgBkOyNWTtM9R7b88xkMCLFp1/xISfKPGFfNxIaSXFU4TAJcoVPZxz
 p0PKpmHwkcZlGuRs7VZH++plkhiqBHUZJiNgVHzOJg+x0KmQCEptj9HSI4kivIA3cT26
 +qcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=+kkIV9Pb3fWIlgocrgzv3WCYT64zAV7oz/qm/72ONo8=;
 b=sNoYcVYhq09oIWgZepNflJidu6vffY8PdDnuGMFDiSDtROYycOlHiDlrcdohbrZwNj
 2BRNZlrev5D44mGTFuJEkhNABdoEmiH0SRo/0Xe2OZHIAIk8rnUjlITAqMpezjf+tEHf
 b0OUWAyruk6/v8Sz6LfHb9FtjroVle5fwY6Q492OUZUKc5NUdKQZKoSOyl1neGduq2Md
 EIpJqS/YrLeVTGei8t3VfW9a0kjU9j0inBQhjsoWr/7cPYuVpFdMktvy69TFhuq/VY1M
 Z4O5j7iS4l8K6qifPng6+NYALyLzGFGFDS1pkowIj9vmArY+ai0cdEyX8gDB9ck9j3VN
 zc+A==
X-Gm-Message-State: APjAAAV5/+U64mld4cVxD72LhKpblhdc51geT4I3hECq50ezNlZ2ybeB
 vVeKHO7Xg8qqXHM2Xt83lkw=
X-Google-Smtp-Source: APXvYqwalnIBuczyjai0BeEtrANKbzrvAtIkD0pZT95K6jxsxwqKycJhG+BeMUITRNha95ojwH2TOQ==
X-Received: by 2002:a17:90a:36a7:: with SMTP id
 t36mr6990707pjb.34.1565163941418; 
 Wed, 07 Aug 2019 00:45:41 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id l44sm20154449pje.29.2019.08.07.00.45.40
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Wed, 07 Aug 2019 00:45:40 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Wed,  7 Aug 2019 00:45:06 -0700
Message-Id: <1565163924-18621-11-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v2 10/28] riscv: sifive_u: Remove the
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

Changes in v2: None

 hw/riscv/sifive_u.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index ea45e77..7557026 100644
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


