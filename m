Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D925C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:18:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99BE920714
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NouoASfG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99BE920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTn2C-0005i6-Dq
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmqF-00050m-8a
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:05:51 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:43722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmqD-00047A-Qj
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:05:50 -0400
Received: by mail-wr1-x434.google.com with SMTP id g12so6557815wrp.10
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dSahlHdpw0kcXQSlWWNINDnUw99PjFmYJxHiZAKo1Pg=;
 b=NouoASfGbmVP+SVsMkd1NA62REnHgBgetI9QIRqqpZcdxRlZ3m9sbBDecTPK7kS9sa
 YFgE1tfFNZ/ddcrlMRhZalz4rsFPxLLltjZWBAngTH62m5QiZKje5+yTeT1tnvC/fct2
 kPS2S/cG2H00sIZXpJRq9qsMuVwrbeKma12hWhI6VlCezRXr8BED3tG8jsrrRDRUr1zy
 lrUf76QYG95HGpSIGEAIN9HaZZdhaRqdcMDEL6xvlxtutz91W31O1e+EMLhcQAm4Mscr
 65GkGB3f+ta/e3GzzRbvs0xhpN/PTl5wTQNn33RIfJtRh8j7c+xw38R2tT1UBvo99b6J
 CidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dSahlHdpw0kcXQSlWWNINDnUw99PjFmYJxHiZAKo1Pg=;
 b=VaMFZshMDoF1UnvH7ZeHGaatU902s/zIVN1pfHW72/ByMiAd3S+GI9vtCGG8G64qpy
 2e5E2gjD9okluqJ3wUgaNA1hVg/OY04SHy/+CdlKjTpvrn8DzezimOPyfqAYBfCzCfLV
 TH842pPxvH64ZZJ9Lwwf+ciXUJpDpV4WNUc4eA6PiebPNQxHToOKwyGafxOomt5/MPyU
 Ue/oooif1P6cjnlDEO1EZb0NK5Vj3TCx+xJFWKSFc4xP0wbWdsuND7uFuSNUSHMBEfjO
 sSSxMGL7BeeG7hARuPIGT1+JROuG3Aivt6a/GF+d4zhJv7RmHN8snsc3qfc2Q9icviTj
 1nFA==
X-Gm-Message-State: AOAM532ocRCeNZTprJZ/ysWOU2I+a7uBs1R251MVK6oN7h8VIitW0UXk
 qVNq70yU+Rb5IprX0mmm7sluZWQz4OY=
X-Google-Smtp-Source: ABdhPJyLV7kknIDPho83bmmh68fhgs0vu8dzV8XoNcvbAXAnrA3PIH82Ft4ylENI4Vt3+JfkXeiNZQ==
X-Received: by 2002:adf:ef06:: with SMTP id e6mr10176502wro.397.1602943548359; 
 Sat, 17 Oct 2020 07:05:48 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id u195sm7587193wmu.18.2020.10.17.07.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:05:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/44] docs/system: Update MIPS CPU documentation
Date: Sat, 17 Oct 2020 16:02:38 +0200
Message-Id: <20201017140243.1078718-40-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Huacai Chen <zltjiangshi@gmail.com>

Add Loongson-3A CPU models description.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Message-Id: <1602059975-10115-10-git-send-email-chenhc@lemote.com>
[PMD: Split patch in 2: CPU / machine]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 docs/system/cpu-models-mips.rst.inc | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/docs/system/cpu-models-mips.rst.inc b/docs/system/cpu-models-mips.rst.inc
index 499b5b6fedb..02cc4bb884c 100644
--- a/docs/system/cpu-models-mips.rst.inc
+++ b/docs/system/cpu-models-mips.rst.inc
@@ -48,11 +48,17 @@ across all desired hosts.
 ``I6400``
     MIPS64 Processor (Release 6, 2014)
 
+``Loongson-2E``
+    MIPS64 Processor (Loongson 2, 2006)
+
 ``Loongson-2F``
     MIPS64 Processor (Loongson 2, 2008)
 
-``Loongson-2E``
-    MIPS64 Processor (Loongson 2, 2006)
+``Loongson-3A1000``
+    MIPS64 Processor (Loongson 3, 2010)
+
+``Loongson-3A4000``
+    MIPS64 Processor (Loongson 3, 2018)
 
 ``mips64dspr2``
     MIPS64 Processor (Release 2, 2006)
-- 
2.26.2


