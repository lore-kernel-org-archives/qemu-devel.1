Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B1DC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:32:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D09D72075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QgjpOkhe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09D72075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBakF-00027s-86
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBace-0004Sf-SA
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:36 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34753)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacd-0004IT-5b
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:36 -0400
Received: by mail-wm1-x342.google.com with SMTP id c19so441919wmd.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=fxmRf5DVdkRrGvUUcEHoxUAm6QSXXwocckAawvaTPHc=;
 b=QgjpOkheEcfJN8uveTmsCP08/sGn/SnT2VXS2GRy0VE6udOfZZyYSxuBFfqR8AkcZv
 BGoiexnoeGjTSNuUb5R8BL6ooQLfMIypN0VA9rG3cSZX1X5fwFajAyyNY1E8q0KnLShA
 xeUed+zeQEEhR+foSF55ui7MDc1uT1P7+2fyCQyZILlwNldOBngCVHKrHZc/OguACioA
 ObQOO9Yy4o/V1l7CueE13fGrl+M63KuXH4Fnsb3b0bwgABNdPvtu5HxWoQnUkqso+oD4
 z0nYuj/eaHFa5+LXLJH+wvD0PvKttqkSKByJJyg27RZ9ej1uTfoYFuGw4Nvj8NccIB7u
 ySVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fxmRf5DVdkRrGvUUcEHoxUAm6QSXXwocckAawvaTPHc=;
 b=oUZNoy54xxKqNLJz4BDT9xnT/FzXEFFDIGMb+O7Px3a0K4lev3XCuycbPfam0p51Qb
 xhmcl6/BNPbKeJXI8xGZRZX9Gq/nOH/T2Ej95a0nLDPKYQq4/DJ9seXZ42jmCbZzLqCc
 3IGBLRfLL+Z0dwDp+wqZIyqtYTWHShGQyAzC8iAtKfrs7rKEH2Yku0DMl2gWV50o6axl
 qPMyPBw4piTonbH+VLOEIbWH4LjCweoZ7xtwWMM64IGoxnIAqfMO9R9yOF9QyOlkrhcI
 +sJal7vr61BF3MdSOZxIDbuzCIVvYBmqad+juND4XWAdXaGD/PbP+9IPgVKPVMmWIICt
 LoTg==
X-Gm-Message-State: AOAM531W/mqxEvLrLh2aq+niCIV8m6k5Negy6zeNP2Km6bh5pBG+eRn7
 hMQLuowu1/IGyGmV0oLBPAkBpGTkxUbqDGCA
X-Google-Smtp-Source: ABdhPJyWtABsSKxx+AwHTwYjR2QTTBg5WijGY/PrMYsEnzrw89liN5PxiQSoNgHP8gCXVDm6r7iCCQ==
X-Received: by 2002:a05:600c:214e:: with SMTP id
 v14mr759798wml.118.1598606673619; 
 Fri, 28 Aug 2020 02:24:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/35] hw/misc/unimp: Display the value with width of the
 access size
Date: Fri, 28 Aug 2020 10:23:54 +0100
Message-Id: <20200828092413.22206-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

To quickly notice the access size, display the value with the
width of the access (i.e. 16-bit access is displayed 0x0000,
while 8-bit access 0x00).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200812190206.31595-3-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/unimp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/unimp.c b/hw/misc/unimp.c
index ee2e536c8b1..b4b318db1c3 100644
--- a/hw/misc/unimp.c
+++ b/hw/misc/unimp.c
@@ -35,8 +35,8 @@ static void unimp_write(void *opaque, hwaddr offset,
 
     qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
                   "(size %d, offset 0x%" HWADDR_PRIx
-                  ", value 0x%" PRIx64 ")\n",
-                  s->name, size, offset, value);
+                  ", value 0x%0*" PRIx64 ")\n",
+                  s->name, size, offset, size << 1, value);
 }
 
 static const MemoryRegionOps unimp_ops = {
-- 
2.20.1


