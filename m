Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEB2C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EAAC206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o8YRCw4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EAAC206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxWJO-0001Ka-EP
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 08:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53619)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hxWFQ-0002RB-8t
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hxWFP-0000kE-Br
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:56 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:32952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hxWFP-0000il-4H
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:55 -0400
Received: by mail-wr1-x442.google.com with SMTP id n9so107749731wru.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 05:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AnBJmMRud5m69w+DcinKsIKwrJcDkx/A9PXnd5Lo8CY=;
 b=o8YRCw4XyyN4LoHYAc33jsP4NYCB1y29zXgp0Helpxn+eb25Lod/iKXJI190sttG9M
 z8uaBLSO+nfnawb0dwkLX66s4A34xWnKrUVpNHE0J6Z1/UwC/veA7f85kcUvby5r9cjy
 ZcBbH7RVMHLwAaHXegETxOGAqLGH+Z2BoXObkI+48MOMTIRxV410VY2ncudgmgMk/LwL
 CEpf/D3blnZjfWMezlp351582IJQIHEfbLCZZJ2gHUp/DNHvuNBRv4qn/SQ741HKgkwH
 wUwfk9Qbz8q80kijgmFXHCHY3FdE23taMiguaRovuT2NR9RGTvUjJDE+koa9Fn74NHxP
 3iLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AnBJmMRud5m69w+DcinKsIKwrJcDkx/A9PXnd5Lo8CY=;
 b=COBH6edmvAy1zXHr/wEb611Xagx3clwhPV88zEpGcofgJl25BYYk2kvVmpu3ykfUPU
 +7Q0z1zQp/thHwQibFFfLBBphKNNi5Y1CZjoIwPAIBQxodMIVavOcCpq6lej6UkNaKxh
 Da25Fj7KsGF+Qp5qbiXrRPBPfA+91rHAQdh40PEey4MG48HhDX7vIT7yoTAQ5fkHWttm
 9/ZF6I9tnONNkCELpeAiMT0X2Ahu95AEIKtmm+OkEp3gaThGpEaTvcmzHPgvEdZE7f/i
 qkhmKnluJT6i18GZcJ2l0530I/T3VYuE/cz62WjO/faqmHn6by8oBBBqMJArs/betzQU
 MRpQ==
X-Gm-Message-State: APjAAAWS+CSNwJuuj+v4bXDIU9lwibGOAkiXTpC86NYhj49oBwYiehjf
 D2TZGaieJweRhqhdTV9bAVnqLA==
X-Google-Smtp-Source: APXvYqx5stjARqG1Zzv5C96pbzSR5zzSoyMdZ87558kET69cvWyKftHewP7Ho2qgy7NLQBTSwcHVVg==
X-Received: by 2002:a5d:4403:: with SMTP id z3mr47883756wrq.29.1565700594011; 
 Tue, 13 Aug 2019 05:49:54 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id c187sm2792724wmd.39.2019.08.13.05.49.49
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 13 Aug 2019 05:49:51 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B1D871FF99;
 Tue, 13 Aug 2019 13:49:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 13 Aug 2019 13:49:42 +0100
Message-Id: <20190813124946.25322-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190813124946.25322-1-alex.bennee@linaro.org>
References: <20190813124946.25322-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v3 09/13] fpu: make softfloat-macros
 "self-contained"
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, armbru@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The macros use the "flags" type and to be consistent if anyone just
needs the macros we should bring in the header we need. There is an
outstanding TODO to audit the use of "flags" and replace with bool at
which point this include could be dropped.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/fpu/softfloat-macros.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index 9a1d254a95b..605c4f4bc62 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -82,6 +82,8 @@ this code that are retained.
 #ifndef FPU_SOFTFLOAT_MACROS_H
 #define FPU_SOFTFLOAT_MACROS_H
 
+#include "fpu/softfloat-types.h"
+
 /*----------------------------------------------------------------------------
 | Shifts `a' right by the number of bits given in `count'.  If any nonzero
 | bits are shifted off, they are ``jammed'' into the least significant bit of
-- 
2.20.1


