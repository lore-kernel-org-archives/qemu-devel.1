Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E616C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 13:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 272A620789
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 13:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpZq99Te"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 272A620789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ95c-00086v-Ob
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 09:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQ93P-0006vM-E7; Wed, 07 Oct 2020 09:00:23 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37460)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQ93L-0001Mz-Ue; Wed, 07 Oct 2020 09:00:23 -0400
Received: by mail-wr1-x442.google.com with SMTP id h7so2061586wre.4;
 Wed, 07 Oct 2020 06:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7Jsy/q8OA//1LlL/ti38A+9F0oBCn2y5LmKl2c8z0V4=;
 b=VpZq99TeYBXnQ0B+fURN6LDtAHFbKPWYMoyiAxP05+rVFojqKfWywU3CseEn9Q0Ege
 YkeKk5H4g42VVNebJNx+5bmPSl0OlG0vmnGE6GY/li0GgPqhChpQJXDVFJYwNBRxGnUR
 Q7+dOV/TGvQ7OqCpTX5pPhnpvxUcuLH03uo3lWSjksc1B3UGsiATMtgw3/5avXj4Frfd
 ooRl4CTb8TXbfavybQZxnazPK/8CXXEBmnOSbwBYF7nCOK81EKx6cbC8t45cz84yLmfA
 RpVdHH4W7E3+PPeZsM59REjncEm2IiwVwIYmxvbp+05wQQK5Jtz+35ZRS6km3RDvFyBy
 FJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=7Jsy/q8OA//1LlL/ti38A+9F0oBCn2y5LmKl2c8z0V4=;
 b=eDNkhBRwoEnFz4HNieIPJleOOyLHI7IwZ9+ZPd1sNemCW2TK0yOU3rdy5ByDohKduq
 u9OIoD7HAvUOvhxsMW+QASW0KLdmaL95GOl3bFgEvmX8LFHlIjds3g31bd6MmcS9N9pG
 9pVCAN62LTh4lz6+ZQdLhyUCWpAgi3ipMdze7n+yWznbz5Ra8d8Z2ABxKu5jrgQ29+SQ
 Fk9BIVIlv21AX2viUYCdH74P3uuOgBglvRiJ4iA6t5QEg/aT8YV3ESmxbhwGH1Y6dlFW
 SDC1LG9SyfzAUK/GvxrQ5EWL/9JmjRnzpssc4ftIVgcnseITXnQU39m3xVVjUF+ISxRr
 1Heg==
X-Gm-Message-State: AOAM531BuBxFkCLGEngRM2dVcmeaXBBAnoELxUQaFrsl1zNow2ACT1zw
 spTebuzIDiJtYPYyc8PY62aJx8tUK9U=
X-Google-Smtp-Source: ABdhPJyc6MweLMyE4pZLpCJJGqeXL34A/bRiJGQhanXxjoKG0DfmTcymwO3P+J7zJLk/G/3hNRbbww==
X-Received: by 2002:adf:ecc1:: with SMTP id s1mr3387394wro.120.1602075617414; 
 Wed, 07 Oct 2020 06:00:17 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id h206sm2858812wmf.47.2020.10.07.06.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 06:00:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/intc: Rename NIOS2 kconfig as ALTERA_IIC
Date: Wed,  7 Oct 2020 15:00:15 +0200
Message-Id: <20201007130015.2531633-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Marek Vasut <marex@denx.de>, qemu-trivial@nongnu.org,
 Chris Wulff <crwulff@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'NIOS2' Kconfig symbol is used to select an generic interrupt
controller, and has not much to do with the Nios2 target.
Rename the symbol as 'ALTERA_IIC'.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/intc/Kconfig     | 3 +++
 hw/intc/meson.build | 2 +-
 hw/nios2/Kconfig    | 7 ++-----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index d07954086a..d940c09cde 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -73,3 +73,6 @@ config SIFIVE_CLINT
 
 config SIFIVE_PLIC
     bool
+
+config ALTERA_IIC
+    bool
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 3f82cc230a..47c6726b8e 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -37,7 +37,7 @@ specific_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_plic.c'))
 specific_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic.c'))
 specific_ss.add(when: 'CONFIG_LOONGSON_LIOINTC', if_true: files('loongson_liointc.c'))
 specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_gic.c'))
-specific_ss.add(when: 'CONFIG_NIOS2', if_true: files('nios2_iic.c'))
+specific_ss.add(when: 'CONFIG_ALTERA_IIC', if_true: files('nios2_iic.c'))
 specific_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_intc.c'))
 specific_ss.add(when: 'CONFIG_OMPIC', if_true: files('ompic.c'))
 specific_ss.add(when: 'CONFIG_OPENPIC_KVM', if_true: files('openpic_kvm.c'))
diff --git a/hw/nios2/Kconfig b/hw/nios2/Kconfig
index b10ea640da..95e72186af 100644
--- a/hw/nios2/Kconfig
+++ b/hw/nios2/Kconfig
@@ -1,12 +1,9 @@
 config NIOS2_10M50
     bool
-    select NIOS2
+    select ALTERA_IIC
     select SERIAL
     select ALTERA_TIMER
 
 config NIOS2_GENERIC_NOMMU
     bool
-    select NIOS2
-
-config NIOS2
-    bool
+    select ALTERA_IIC
-- 
2.26.2


