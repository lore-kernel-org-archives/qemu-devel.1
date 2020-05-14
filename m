Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A928AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:33:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7500F20643
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcoVmf/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7500F20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZJbd-00083X-HO
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 15:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZJQK-0007cK-AQ
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:21:40 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:34159)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZJQE-0007Oh-76
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:21:40 -0400
Received: by mail-lj1-x242.google.com with SMTP id b6so4843478ljj.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 12:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sGqFZp4/8DHvwZ4dwcHeJPKSRCfhEUhOLVb+pJ0fcYc=;
 b=kcoVmf/7rWZQ3ieQtqhjlmoFlCaRBPBGQI6mdwc0aROGhX/M6LeTzE7g+K1mebcTX3
 zatmeS9MIz3rF6828fY69IlwCRk0kzpG1YQtE/CYH8BD/3Ef2LdOG2ibAqt1pgC72ZdI
 6R3WXQsUi/qvZ4SPBRGhuQiJZcmiW4isewgwc0eNxrneEswZnGjOE0U5JErFIYIuzR58
 r1fWeXbT29zZgwoaZrQZ7n97P/JpOBjJJftIjGjzZ80Buq2VjA4R+lkhmpq3vMizTbh4
 kkg8em0Wa4880VwHwOw6KvDAjnVFqcXdkGxG2kMER2Ai99bH7FaN2d5D+mOerDrgAL3H
 f5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sGqFZp4/8DHvwZ4dwcHeJPKSRCfhEUhOLVb+pJ0fcYc=;
 b=DXgNhGrOMUqB5om0I7Cx7kMNjj3YFTAIfNNCq4poukTUn0JH9WahxdC5jJne3N2RBQ
 GAlDiGzPs8sSEDiCCxGERbRdRGKjZRB2Rr8cdmKiVCwlxJK0RpxwGn5cbhOot9mP4XwU
 hwALL0n/4yXGrWm57RTrVluXn28PqmGZXHsUzdZQBV2fsdCPbNWq5kUW299U8xQfxeN+
 xHbrePX5WI6ifBjxszJIQdC0TVOw4ZYGEFzVt4CSXMyMwwE3lO02WcuZwO76HWzAlTdQ
 5vCyuo25C+OB3GTza/hkFwglDPx8USf+E6RDpuJHDdzTtqVJHt4/sXUov9dhGV8UP1Fa
 n0cA==
X-Gm-Message-State: AOAM530FtPxWszI/4aB0PscHSF38LQgMVptrXswl4RAnkx64FJUa9Sii
 qNXjz2+zpU5gA/qAe3f8EyJ5JvzqC7s=
X-Google-Smtp-Source: ABdhPJxW+wUIvOrX83fnFTMxN+5xQ5rkrx/+jSt8OjtZ1Msh66IPDpIV/ya6oW14ZgD0CFOc9xRhpw==
X-Received: by 2002:a2e:8296:: with SMTP id y22mr3834680ljg.254.1589484091338; 
 Thu, 14 May 2020 12:21:31 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id h3sm2427257lfk.3.2020.05.14.12.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 12:21:30 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 17/17] hw/mips: Convert Malta "ifdef 0"-ed code to comments
Date: Thu, 14 May 2020 21:20:47 +0200
Message-Id: <20200514192047.5297-18-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514192047.5297-1-aleksandar.qemu.devel@gmail.com>
References: <20200514192047.5297-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x242.google.com
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
Cc: aleksandar.rikalo@rt-rk.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The checkpatch complain about "#ifdef 0". Convert corresponding
dead code to comments. In future, these cases could be converted
to some no-nonsense logging/tracing.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
CC: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/mips_malta.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index e4c4de1b4e..f91fa34b06 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -427,10 +427,12 @@ static uint64_t malta_fpga_read(void *opaque, hwaddr addr,
         break;
 
     default:
-#if 0
-        printf("malta_fpga_read: Bad register offset 0x" TARGET_FMT_lx "\n",
-               addr);
-#endif
+/*
+ * Possible logging:
+ *
+ *        printf("malta_fpga_read: Bad register offset 0x" TARGET_FMT_lx "\n",
+ *               addr);
+ */
         break;
     }
     return val;
@@ -515,10 +517,12 @@ static void malta_fpga_write(void *opaque, hwaddr addr,
         break;
 
     default:
-#if 0
-        printf("malta_fpga_write: Bad register offset 0x" TARGET_FMT_lx "\n",
-               addr);
-#endif
+/*
+ * Possible logging:
+ *
+ *        printf("malta_fpga_write: Bad register offset 0x" TARGET_FMT_lx "\n",
+ *               addr);
+ */
         break;
     }
 }
-- 
2.20.1


