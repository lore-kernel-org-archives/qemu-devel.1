Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD714C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 19:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76151212CC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 19:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjNLThgA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76151212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jldaG-0001Qn-IS
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 15:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jldX0-0004Dl-Bi
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 15:15:30 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:39853)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jldWy-0006Th-TV
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 15:15:30 -0400
Received: by mail-ed1-x542.google.com with SMTP id g1so2938077edv.6
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 12:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fCWXr6zHNQbQPJ8BLLwrAx76MymcZFD1NlfKOZXdkr4=;
 b=RjNLThgAvzaQoq3a2zb+uJbSSs/aHwSKC0ddALBLx8RtNxKQ2WK/SFla+HlnAxVYzy
 qMhWrmA6dflXxg17+01unvk/+kDIi+HoDejORBzY2st6uEPrQDF4jV+2whfFGlnv8f1D
 kWKBp7kFpkUj50uqbL23jn0dpMncjsQns3F9IGDYi5ejaFyZR3zEUgZ9GPWoFAw+gynP
 EuaAxuP03J6r/kbq+Eo9OpLrA9xYiwFDscAxefRHOjnFmrTBAGUDW0SUnjlsXtqGCz8f
 dYLx83taefzvdnoJOTE42gkfwv3oHmrlkfoeqeo+tqfOsnBbBLjYm7r6Lp/AprvJFSDk
 PZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=fCWXr6zHNQbQPJ8BLLwrAx76MymcZFD1NlfKOZXdkr4=;
 b=rARN2+gqV02sbHPCnZ8OcjIcQpOAkn2e6FoWObpbH3MwNHoICK7jWD/HVl/oeeKMbx
 9ondpu8JWgXx8/pYX7mziPij/Peu6t0OOFQ87RuLvMYvqlsqjVd8UGL/FwCD5xsOpU5g
 1I0RqW8WuwqyCEY+9aQL/ZX/9j83BVxppHVAoTVF5gFUG8uczNlskSmV0XgXx1I9iO53
 Q6UICSK4q3I9kF1gDiMwUBCH4LYgqBkBwzTrnRorF5uiuy+pzlY5Sq/cJQ2TG9QPtBFh
 de56Z1IOeeEKp1qidSEZ51XLLBEv87lkZaRLblwuzqI1+2OkFX64aACGbxlLcT2zQpM/
 eYnA==
X-Gm-Message-State: AOAM533N4i8wUmFad4nxmYhjahq3oPTo1Qt5J5EWYjd+wOlYTUc+JqOj
 kmSkK13ZrwvPIArZopNg9iA=
X-Google-Smtp-Source: ABdhPJyB+8f06IRp7+7RbXWWe3badY+zvfm1qquQAI6U4G0ZEFT/oWwioNMr/iRaBbFqjHJMia0g7w==
X-Received: by 2002:a50:f297:: with SMTP id f23mr650282edm.222.1592421327637; 
 Wed, 17 Jun 2020 12:15:27 -0700 (PDT)
Received: from x1w.redhat.com (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id y21sm324308edl.72.2020.06.17.12.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 12:15:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Richard Henderson <rth@twiddle.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
Subject: [PATCH rc1 05/15] hw/timer/sh_timer: Remove unused 'qemu/timer.h'
 include
Date: Wed, 17 Jun 2020 21:15:09 +0200
Message-Id: <20200617191519.14842-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200617191519.14842-1-f4bug@amsat.org>
References: <20200617191519.14842-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove unused "qemu/timer.h" include.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/timer/sh_timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/timer/sh_timer.c b/hw/timer/sh_timer.c
index b9cbacf5d0..bb0e1c8ee5 100644
--- a/hw/timer/sh_timer.c
+++ b/hw/timer/sh_timer.c
@@ -13,7 +13,6 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sh4/sh.h"
-#include "qemu/timer.h"
 #include "hw/timer/tmu012.h"
 #include "hw/ptimer.h"
 
-- 
2.21.3


