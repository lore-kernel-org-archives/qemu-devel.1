Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53060C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 09:24:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B272206C3
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 09:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNAF+WyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B272206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jexir-0003fq-7d
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 05:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jexi0-0001yB-I5; Sat, 30 May 2020 05:23:16 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43312)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jexhy-000740-Qp; Sat, 30 May 2020 05:23:16 -0400
Received: by mail-wr1-x442.google.com with SMTP id l10so6486239wrr.10;
 Sat, 30 May 2020 02:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qKEUX8J9UiexOSRaGrgM4+4clMJ9RxUveCPFaOqjRAw=;
 b=XNAF+WyCEPYn+K8pA149hIefVJEC2mB3WdgSJ7y1EoHMDfZ9lFSfK3GLh96rQSi7wY
 QVbaRYS35i7jvqVdtGOlfKq/+3rjawhNPkmCeXV+TLJ90XFC1ayFp8b+ia8t1zm+tlN8
 0Sb5GEjsM3q9w3N19G2LsiIQw3uUfqcoTnYgJRkAjf1vPCBR9FgxORA6h2QxWNjpz/gs
 IK1w+WzVYIGP7Bjx8TIEkSGXqU02LuLIgKUDO5fa5PZyAs0+xXOtTObb5DdvzRUcTnbY
 bWHBTMRQlpIZ8J1Tiq/EoT6bmYfxm0sdXQUe+uCwiJuFD4wMsm+KsrVtWp5pJ14vimD/
 6VmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=qKEUX8J9UiexOSRaGrgM4+4clMJ9RxUveCPFaOqjRAw=;
 b=cS/KQlzfl2GFYX0a3L1fVB1ei0syIbZ58vkAYZXpsXDmFGQqVIvbA+Z1AdQ8GA5fV5
 mHXx4MUxWhAjz1ddJWe8J8PvttrWK4AWnLqMqhSk7v4R671om+GoggEnP2gCsvoHydvz
 H/50/VII3iWYE6fJRaPaOi4RqnXZZwaBzU4Z1DKW+aQpWW5P65ro5WBi4F29zt5F5Jrv
 vrbSqAFNB1EWTvq+oCPm7OvYpAqQJzuLOgIwBt8Yhb59yuK+Bwmfs4VL7o79LRhtzKY3
 hWsRHdbF4Sq1TsE7fgZmQGXrt63HdF9QxEBMTz3nFRszfd7NWaRgfa4AMyZxY6OGdfgC
 ekXA==
X-Gm-Message-State: AOAM533fVoH0pVfcz/L6AGC0Y6+la6McIxeOrqNc1R3i9vGQiFES6p11
 XESs6oCq0A6bYrKR2Ye6apCeuG3e
X-Google-Smtp-Source: ABdhPJy4p/9AabZ8/p3DMmqhI8SOuxOijEwra3Ul4sIvl9lFyGWJZOZ/0vdutZ7NqhuVKwWB4h1EMQ==
X-Received: by 2002:a5d:5447:: with SMTP id w7mr8211903wrv.178.1590830592949; 
 Sat, 30 May 2020 02:23:12 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id h1sm3195237wme.42.2020.05.30.02.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2020 02:23:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] hw/timer/sh_timer: Remove unused 'qemu/timer.h' include
Date: Sat, 30 May 2020 11:23:04 +0200
Message-Id: <20200530092306.26628-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200530092306.26628-1-f4bug@amsat.org>
References: <20200530092306.26628-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: Fam Zheng <fam@euphon.net>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove unused "qemu/timer.h" include.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200504081653.14841-4-f4bug@amsat.org>
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


