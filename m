Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EDFC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:43:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 468AE2064E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ys9cJuu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 468AE2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ7qW-000177-2g
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 07:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQ7nQ-0007zY-3M
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:39:48 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36863)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQ7nO-0007td-HY
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:39:47 -0400
Received: by mail-wr1-x441.google.com with SMTP id z1so1768861wrt.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 04:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5+7THP4dY/8al2VHQ8XamujtFg9xFO4ttfHPSEDv+4I=;
 b=Ys9cJuu056cdEEG+tJK56Zabf2NT81/emyksgw4nwGBtIEvXZbxdK0SgVWPTWy3KNp
 ENoSBD0C4UNMlE66FUU06vFRyfGafpeDvy7P3Bt0yX7WINaOn18yPohsZ7G4mn3FPR33
 PzHiTjLUnHf/ICR1r57OINgWPlcBHkYBS9yjLj675syxuBwe9du8UsQuXfEKRsEm055y
 S5PH7B5J9uh7dkFdo+X7dG0GlTkJ2sVgt7I0v0BEHzJ7GVqMAU+nJcb4FNX6jRUBuzuq
 IKa6BVd0+IPdWcLXIcvJVDeJiVacubgpCV5L3Rdw2od3Wp83assja6yibLinHBfrQPXy
 9xFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=5+7THP4dY/8al2VHQ8XamujtFg9xFO4ttfHPSEDv+4I=;
 b=KaXnWiRAv9mutOZ7HqajA12+lBgUx75KRaj3bBt5qDeYbeL4f3jxWgDRqin/AvBFKT
 U728ovJjV6qq1XNj78XacOg1ReoX9boJvoiDdldWE84qr6Vkzgekaq5oGMXjddYdsMVN
 rIeZWtS/mWiSoTgr0RwdIfX1kUuTM/I90k9ifyhr5vHjWNKarkF0WPPY1RZgdnVFhPsS
 NppAGsAyvaY1wFIRKsW6dzbFvDn1klqcIgjhGhOlsqIzuyCCxOBzWOR+nQ72vYy3UZAI
 cuKvgvs4p0ckORIEHiXlywKA4PzvLGiY48wkhH+7N02lTNjKLzKfJuGJ2hG5qXfCu5Ec
 hLPQ==
X-Gm-Message-State: AOAM5313U8TOAXDkwhll/eQkouPqIKJqrXK4dgVWi4B9bqYdG3S9oES+
 eemYVNUaKncDjBxfcNKmCZVS8N8n/WQ=
X-Google-Smtp-Source: ABdhPJwfQJghyz/IFYjkA7rwU7Vl16RLPCx4J0LNOD13VPk/dUg+VxRnxH/J+USUwRyB17JiRi+hJg==
X-Received: by 2002:adf:ce01:: with SMTP id p1mr2871450wrn.33.1602070784757;
 Wed, 07 Oct 2020 04:39:44 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id u15sm2575279wrm.77.2020.10.07.04.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 04:39:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/misc/mips_cpc: Start vCPU when powered on
Date: Wed,  7 Oct 2020 13:39:42 +0200
Message-Id: <20201007113942.2523866-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit 102ca9667d we set "start-powered-off" on all vCPUs
included in the CPS (Coherent Processing System) but forgot to
start the vCPUS on when they are powered on in the CPC (Cluster
Power Controller).

This fixes the following tests:

  $ avocado run tests/acceptance/machine_mips_malta.py
   (1/3) test_mips_malta_i6400_framebuffer_logo_1core: PASS (3.67 s)
   (2/3) test_mips_malta_i6400_framebuffer_logo_7cores: INTERRUPTED: Test interrupted by SIGTERM (30.22 s)
   (3/3) test_mips_malta_i6400_framebuffer_logo_8cores: INTERRUPTED: Test interrupted by SIGTERM (30.25 s)
  RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 2 | CANCEL 0

Fixes: 102ca9667d ("mips/cps: Use start-powered-off CPUState property")
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/mips_cpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index 2f7b2c9592..7c11fb3d44 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -38,6 +38,7 @@ static void mips_cpu_reset_async_work(CPUState *cs, run_on_cpu_data data)
     MIPSCPCState *cpc = (MIPSCPCState *) data.host_ptr;
 
     cpu_reset(cs);
+    cs->halted = 0;
     cpc->vp_running |= 1ULL << cs->cpu_index;
 }
 
-- 
2.26.2


