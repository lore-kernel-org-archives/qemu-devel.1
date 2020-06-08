Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A393DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:04:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F2A4206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdS7zTCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2A4206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiDhW-0007I0-A0
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 05:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiDfH-0004s0-I4; Mon, 08 Jun 2020 05:01:55 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36467)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiDfG-0004Im-OV; Mon, 08 Jun 2020 05:01:55 -0400
Received: by mail-wr1-x441.google.com with SMTP id q11so16514197wrp.3;
 Mon, 08 Jun 2020 02:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u9uKPWNzNLOY7VTU1g9/yQJr0QmghdK+v0pLVKAdyqA=;
 b=bdS7zTCJVo2Fpi97pJ/a1kp2/MUtm/qcx88LDDB177sj1YJH66/o6fDRCv3xu07aCp
 oEVQbBQb4/NjA7BY79e/+8vMhiCMecg8tN5uAOUUq1N56F63P6299NpoeV2q7CbKVQGG
 yIcfRw16lDsHybX2iJyo8RaiL3461R/CTQ/vJi3dsXjxsKgJ3/PAsav/fwUTPEfLgtM9
 WNyXUHUwqJ7FZ1ApjgBFs0m8Y1QuVMA36/ySmTlR+XueRrz+sVGVqnA/IcMROtGLAq8M
 E8OLjMDsl2KIZcXeSHnO1ddaCooyhR9L907swt4moyW2xMlGnNGaL7DxaUiWJYzjLulz
 c6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=u9uKPWNzNLOY7VTU1g9/yQJr0QmghdK+v0pLVKAdyqA=;
 b=H8mH4piAKSauYxoQgYDYyonZxCLkZJTr5HlagG7DtprUPHl9dPiv2NQKJZlwhw+Q+b
 oUCI6U7pNDobtfHsXHpp0cLg/MwITpVYMljkGcEDcb8SGbOfom5PMdBRPjhV6fM82AVK
 O/NbC1bgLzjXdrri26kse+z8d1Fm/G4sBvjKaas+uzkdBO0MLsTwui1y8Js0uWGf5HfK
 nNToesgAQMqPVFKevnGvN7wprTuH8k9Hleb4dfjAmrHhHHtLamcTF8z4f/hG7oBt1yAV
 Nu9kAnNM40D7aq5BSPbQTvb9jIrFS7/u1X96j7oVSxbqTEuqct6qGAeVZX4tKmBet3bD
 1ngQ==
X-Gm-Message-State: AOAM533+U0fUjThhI8oEoOmckdyLWSSx9yzsdTTNPGkBUVH4C4vIwiwH
 vhvHmlTd/H1Xwz734rbh7p3XUg5z
X-Google-Smtp-Source: ABdhPJw8CNZCF7ebhT/i5V+X1bVg2Y3MR0QPPhz3on6NToiZNyMKIyxTaFYearezr8WJANLwL+QymA==
X-Received: by 2002:a5d:684d:: with SMTP id o13mr22295827wrw.364.1591606912395; 
 Mon, 08 Jun 2020 02:01:52 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id t8sm22192989wro.56.2020.06.08.02.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 02:01:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/8] hw/sh4: Use MemoryRegion typedef
Date: Mon,  8 Jun 2020 11:01:38 +0200
Message-Id: <20200608090142.6793-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608090142.6793-1-f4bug@amsat.org>
References: <20200608090142.6793-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the MemoryRegion type defined in "qemu/typedefs.h",
to keep the repository style consistent.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200504081653.14841-2-f4bug@amsat.org>
---
 include/hw/sh4/sh.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/hw/sh4/sh.h b/include/hw/sh4/sh.h
index 767a2df7e2..fe773cb01d 100644
--- a/include/hw/sh4/sh.h
+++ b/include/hw/sh4/sh.h
@@ -10,9 +10,8 @@
 
 /* sh7750.c */
 struct SH7750State;
-struct MemoryRegion;
 
-struct SH7750State *sh7750_init(SuperHCPU *cpu, struct MemoryRegion *sysmem);
+struct SH7750State *sh7750_init(SuperHCPU *cpu, MemoryRegion *sysmem);
 
 typedef struct {
     /* The callback will be triggered if any of the designated lines change */
@@ -32,7 +31,7 @@ int sh7750_register_io_device(struct SH7750State *s,
 #define TMU012_FEAT_TOCR   (1 << 0)
 #define TMU012_FEAT_3CHAN  (1 << 1)
 #define TMU012_FEAT_EXTCLK (1 << 2)
-void tmu012_init(struct MemoryRegion *sysmem, hwaddr base,
+void tmu012_init(MemoryRegion *sysmem, hwaddr base,
                  int feat, uint32_t freq,
 		 qemu_irq ch0_irq, qemu_irq ch1_irq,
 		 qemu_irq ch2_irq0, qemu_irq ch2_irq1);
-- 
2.21.3


