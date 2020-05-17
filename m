Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15377C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 09:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBFBF2065F
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 09:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lp+cpK5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBFBF2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaFi5-0005as-3M
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 05:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaFXD-0004bK-7D
 for qemu-devel@nongnu.org; Sun, 17 May 2020 05:24:39 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:41127)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaFXC-0001pJ-Ch
 for qemu-devel@nongnu.org; Sun, 17 May 2020 05:24:38 -0400
Received: by mail-lj1-x241.google.com with SMTP id v16so2569161ljc.8
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 02:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tW+0eLzQ2UZfvVWbxFduozLUGGyjb7gucIG22bozEe0=;
 b=Lp+cpK5WMRiqblHp6OAv6rZ2mwtg0ZO7zPd1e9RbMnwwkQ2PnqYSYA4v3s/+X2U9/F
 40wSpwmcJWuZwu/gf9FK0+pLT0TTE3qP4wUqDVIo9iLhmEhmUud2tp3yqCB2h0GCrde7
 O/gYI4zxZ2NzCcpKQnSx4dVZHxKIAicoaOSGuR2k8JK2vWdLmJ8MLdfLEwr2+Uzo+4OE
 zmsO4SnmY39mcD9BbmQEAMxeWF6ofDFdZcsG/X6A9dMITVfAc5dbpbQ/hnKh4GpZewaK
 nDpD+UDkzaEfzejom3VtQHEc23Ng7QrVSQVNyxmckdUtlFZlhGbIfVosDbC1RL90kK5d
 7RTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tW+0eLzQ2UZfvVWbxFduozLUGGyjb7gucIG22bozEe0=;
 b=Ty9Q+9tCEGK2vIKMLKLPdBizc6YCAGd33twSYnaPolFbuSirISc3YG6uiJNjQIpQFM
 4wW22FAuiKUMxWJuXfA0nwHf+E5yt3W1zns8tXMgorrpTYumV8/6UnpwIG8UGk3rvopk
 uNecK3zLsc/08rctbc1rWK3Z3v4l7hsgp2eU7CYYpd/hDjEs1lU/um96h4om8uxfVrFF
 fZKiLd/3uRwKmfWC3TywK/hAReM7QxBMqsdf7dJ+qcPuZOSLV3/7hUMRr4MKzOq7Am0Y
 13gdFRDjitLPsMFHGPwgGjnFPwcvozZ53WrS10eao0vRMaEf0i181MOAyjcljnhxgkhU
 u6Nw==
X-Gm-Message-State: AOAM533ONUkzQsb7vO023+bhwmHd4VvNqNZZBRWmq9AHdCvPpk1/D9iX
 q7FSepiolXcuukoJuLOlhUG/voIBC0s=
X-Google-Smtp-Source: ABdhPJxvtqr42mpUCESmUuLH4SxgsZayN274ovP7cQbRlJ4Sz2qR0lwBFiEJP7xS00I26LZrwt6XdQ==
X-Received: by 2002:a2e:a58e:: with SMTP id m14mr7127671ljp.95.1589707476379; 
 Sun, 17 May 2020 02:24:36 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id l2sm3872138ljg.89.2020.05.17.02.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2020 02:24:36 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 19/19] hw/mips: Rename malta/mipssim/r4k/jazz files in
 hw/mips
Date: Sun, 17 May 2020 11:23:57 +0200
Message-Id: <20200517092357.1469-20-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200517092357.1469-1-aleksandar.qemu.devel@gmail.com>
References: <20200517092357.1469-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.rikalo@syrmia.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Machine file names should not have prefix "mips_".

Folong2 machine source file will be handled in a separate patch,
to avoid conflicts. That patch is pending integration into the
main tree.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
CC:  Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/Makefile.objs                 | 8 ++++----
 hw/mips/{mips_jazz.c => jazz.c}       | 0
 hw/mips/{mips_malta.c => malta.c}     | 0
 hw/mips/{mips_mipssim.c => mipssim.c} | 0
 hw/mips/{mips_r4k.c => r4k.c}         | 0
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename hw/mips/{mips_jazz.c => jazz.c} (100%)
 rename hw/mips/{mips_malta.c => malta.c} (100%)
 rename hw/mips/{mips_mipssim.c => mipssim.c} (100%)
 rename hw/mips/{mips_r4k.c => r4k.c} (100%)

diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
index 525809af07..1d767ed9a8 100644
--- a/hw/mips/Makefile.objs
+++ b/hw/mips/Makefile.objs
@@ -1,8 +1,8 @@
 obj-y += addr.o mips_int.o
-obj-$(CONFIG_R4K) += mips_r4k.o
-obj-$(CONFIG_MALTA) += gt64xxx_pci.o mips_malta.o
-obj-$(CONFIG_MIPSSIM) += mips_mipssim.o
-obj-$(CONFIG_JAZZ) += mips_jazz.o
+obj-$(CONFIG_R4K) += r4k.o
+obj-$(CONFIG_MALTA) += gt64xxx_pci.o malta.o
+obj-$(CONFIG_MIPSSIM) += mipssim.o
+obj-$(CONFIG_JAZZ) += jazz.o
 obj-$(CONFIG_FULONG) += mips_fulong2e.o
 obj-$(CONFIG_MIPS_CPS) += cps.o
 obj-$(CONFIG_MIPS_BOSTON) += boston.o
diff --git a/hw/mips/mips_jazz.c b/hw/mips/jazz.c
similarity index 100%
rename from hw/mips/mips_jazz.c
rename to hw/mips/jazz.c
diff --git a/hw/mips/mips_malta.c b/hw/mips/malta.c
similarity index 100%
rename from hw/mips/mips_malta.c
rename to hw/mips/malta.c
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mipssim.c
similarity index 100%
rename from hw/mips/mips_mipssim.c
rename to hw/mips/mipssim.c
diff --git a/hw/mips/mips_r4k.c b/hw/mips/r4k.c
similarity index 100%
rename from hw/mips/mips_r4k.c
rename to hw/mips/r4k.c
-- 
2.20.1


