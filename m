Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4D9C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:18:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAB0F2075F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvXbf6Op"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB0F2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jamDe-0000mj-TW
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 16:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jam64-0006uA-Fs
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:10:48 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:35710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jam63-0002N5-Iy
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:10:48 -0400
Received: by mail-lj1-x243.google.com with SMTP id g4so11253282ljl.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 13:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L66Agc2lHgpy7FO0yh6pn/rfQ2aSoQ2VmphzAuOdIik=;
 b=WvXbf6Op/tEIC9dFN2IdaH5OujHm7XX7lFsH1jUlHLk6XoZc1OQ1wwoYvpj6CONjAF
 eL0h+gRP58/I2ZJ81M5j8X5/I1g1Fl+pkj8DCeTjbu1dGoLBspBczSCE0yHuG9Gnqq6z
 y3tNr+ACo5AjOFQ7+peyEPLArDmTGmF3XYo/sf18uQq1CvXZ8F8bjRETTKQq3xUS6oCp
 Z9WgLOJxj738GusgYC+3FTABJ1/aPuzUgoPxXaI39gFkoRm/jiQ6mdZ0PXv4Zf8lOiUj
 zrGpNRMuCReWEsVJ99HDQVt5QRLukoGIWPr2rgZsa1T6/3UjsDeo2hKAX/cUA/mWMgdB
 TIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L66Agc2lHgpy7FO0yh6pn/rfQ2aSoQ2VmphzAuOdIik=;
 b=Yuhn/esIGfZMM79ypITwKZv0XDy82NXgTlszFwTKjoL2fsudqOL2MXfUd67bGZHDTa
 ZhtU/yWC0haScTKPY0HSD6W/Wn1RJro5089S3jFRR0FX10PZ4pKW6NJ1S4yhsVykmjvi
 j6A1JpQsvKFZO7ET0LcU1hzEi4b13QxoW3Gl7eqFx/Xfi4cwltNc1vjbFr9xH3TPkPPL
 4xKGo9ui5EZkQtcCe5Tuw630zUOLPTjzP1KML1kDOiERXcdyYDBpldGd/2c4NKNmHhFn
 w3S37J3jULxzCa724pSbeHkdYgobQDHNolNtMKLAtU0Be0+D6mIYM7A7Ea5zNMz6DDNq
 v2Kw==
X-Gm-Message-State: AOAM5304ANiKaeM1RWMM4Dt5OoN7n7+SQo4aPdztfU2aTwk5QShs+CPO
 1DGbjut21AL467DcvLH60w/1WFcfRE4=
X-Google-Smtp-Source: ABdhPJyf1g4dysbByR92ocgFfoS3dY93iMoS4HxSgC1TO07yloBtOhiSt9G/YV7C85kFrYuMwBakZw==
X-Received: by 2002:a2e:a313:: with SMTP id l19mr11581209lje.133.1589832645909; 
 Mon, 18 May 2020 13:10:45 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id c78sm8700591lfd.63.2020.05.18.13.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 13:10:45 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 20/21] hw/mips: Add some logging for bad register offset
 cases
Date: Mon, 18 May 2020 22:09:19 +0200
Message-Id: <20200518200920.17344-21-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518200920.17344-1-aleksandar.qemu.devel@gmail.com>
References: <20200518200920.17344-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_PASS=-0.001,
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

Log the cases where a guest attempts read or write using bad
register offset.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 hw/mips/mips_malta.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index e4c4de1b4e..88869b828e 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -427,10 +427,9 @@ static uint64_t malta_fpga_read(void *opaque, hwaddr addr,
         break;
 
     default:
-#if 0
-        printf("malta_fpga_read: Bad register offset 0x" TARGET_FMT_lx "\n",
-               addr);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "malta_fpga_read: Bad register offset 0x"
+                      TARGET_FMT_lx "\n", addr);
         break;
     }
     return val;
@@ -515,10 +514,9 @@ static void malta_fpga_write(void *opaque, hwaddr addr,
         break;
 
     default:
-#if 0
-        printf("malta_fpga_write: Bad register offset 0x" TARGET_FMT_lx "\n",
-               addr);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "malta_fpga_write: Bad register offset 0x"
+                      TARGET_FMT_lx "\n", addr);
         break;
     }
 }
-- 
2.20.1


