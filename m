Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF90AC11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 14:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8636A2068F
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 14:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drUwT/is"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8636A2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4n37-00079i-FH
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 09:43:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1j4n2O-0006IA-Bp
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:42:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1j4n2N-0004C5-BW
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:42:48 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33502)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1j4n2N-0004BJ-6m; Thu, 20 Feb 2020 09:42:47 -0500
Received: by mail-pg1-x544.google.com with SMTP id 6so2059071pgk.0;
 Thu, 20 Feb 2020 06:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=r6loH1PyKYFmFT1PyHXkle7Gr60M16j3Lz2hlEr7IGI=;
 b=drUwT/isZRTc82AE05qbvlzN7+kh0TJp9W+rZIyIivG/G7UtkpDitytNJqCY9+ULju
 BnODFiz36auh7a4PcLcQt8JRzHYcpl5YciB0jiEgUiPh+bvEx2nBbKZjJiDGw/5EH9SL
 BEtaXBGKurwi4ZBn2XVE5uTcIkalIitXCRuFYGdWGkwVZAzdejGRnjf/nSTzJbzW3TZd
 IfdeJgJi5wgbNnuGfLz9/8GEK17RiZl17L+nKu4eHW3f5K74WVQO1725NRKsGKhMAZZN
 90j3h05L7Lw62wQtxBhLtoYsZkrp68Y8ZWL1GoVUqaCClDCXVnz2k7OumNtJbAGaufV+
 fEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=r6loH1PyKYFmFT1PyHXkle7Gr60M16j3Lz2hlEr7IGI=;
 b=izKfMKB55/f6dxhT7NrJktcWZETfxFEFb8bS57qCQdFA7KM2zNDBZzyJSFtaA3VWfF
 bTrPt+PWJeme0aWgLrZ6WYdgv3BOdFYj4MbHQutp8RhISlmRnmJ+rvFjDvOIKLAnhtKI
 olBpnjyMfyPHQ4Z/KAPrMCDw8zYvwaFl2ilVaY9dArqbDbuB1UUVjwfa78hHAiUyjIIV
 rWmhTykR54WeZmg3gb22cyg7Bwn3xlqDc9TrRZuB5E2am8EOTkOQq5iI750p4znI1/ve
 mYekV33XUrJOlxNTJtnL6W7dF4+mWs1hsrQ8yAtRKf+9W1/TF/AxszHD55Bu1cqaZoU/
 z6eg==
X-Gm-Message-State: APjAAAWjEbqVmnE0UagpnMYzXPaHy1VEB1PZc5WOLOaNPRI7pfmp6eW2
 FAz/bF6eVHwZ/02QM0FvL2Y=
X-Google-Smtp-Source: APXvYqzbX+FwUWSVQVndxIpoaJNZxZRvpPQknhSS5dIX3zNyNa4qPJAnOjTPU9HyPeu2gZr/YHBZVA==
X-Received: by 2002:a62:19d1:: with SMTP id 200mr31038643pfz.26.1582209765834; 
 Thu, 20 Feb 2020 06:42:45 -0800 (PST)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v9sm3837140pja.26.2020.02.20.06.42.45
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Thu, 20 Feb 2020 06:42:45 -0800 (PST)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 2/2] riscv: sifive_u: Update BIOS_FILENAME for 32-bit
Date: Thu, 20 Feb 2020 06:42:38 -0800
Message-Id: <1582209758-2996-2-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1582209758-2996-1-git-send-email-bmeng.cn@gmail.com>
References: <1582209758-2996-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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

Update BIOS_FILENAME to consider 32-bit bios image file name.

Tested booting Linux v5.5 32-bit image (built from rv32_defconfig
plus CONFIG_SOC_SIFIVE) with the default 32-bit bios image.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 hw/riscv/sifive_u.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index ca561d3..371133e 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -57,7 +57,11 @@
 
 #include <libfdt.h>
 
-#define BIOS_FILENAME "opensbi-riscv64-sifive_u-fw_jump.bin"
+#if defined(TARGET_RISCV32)
+# define BIOS_FILENAME "opensbi-riscv32-sifive_u-fw_jump.bin"
+#else
+# define BIOS_FILENAME "opensbi-riscv64-sifive_u-fw_jump.bin"
+#endif
 
 static const struct MemmapEntry {
     hwaddr base;
-- 
2.7.4


