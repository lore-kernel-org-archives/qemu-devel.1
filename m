Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2981EC433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 12:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA7820678
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 12:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVWJx2Kn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA7820678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgSfr-0006xb-4C
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 08:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgSek-0005er-H5; Wed, 03 Jun 2020 08:38:06 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:46888)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgSej-0006OV-39; Wed, 03 Jun 2020 08:38:06 -0400
Received: by mail-wr1-x42b.google.com with SMTP id x6so2148274wrm.13;
 Wed, 03 Jun 2020 05:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dQpGwQIn8Qp72xpxhIH2uANRxIHLlNTW+u2aj7Hblvg=;
 b=OVWJx2Kn29vAMe+mCF5zfaQv2AbDd+qpUGfkkaaXIVCzkifWw/rN+W7Vyfe44gv9xn
 Py3cSYGJlkuxGdmZOHYb5nsbLbdm+3iiiJvcTI9j6+i0kXziW2+vRjAv7JC2ua0oak7o
 YaQnbSj5RETsb4jGeUtfDzLCzm76xG2ANk4nsE7PKNP6GHpyqG2AAcFmckWpax4SrkPg
 Bb7gtTr8AOfK5uPLEHIfckgld47OGpQOC8dt4AKMyfaA7XakBgZsolG8HgL5KPfdMexL
 YL5yTLgGSCL75dKEcZW/SyArl8IymoBms4NyTEiC1k/4Gp/yYJRyInG1hVI5oLTdKH2q
 DbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dQpGwQIn8Qp72xpxhIH2uANRxIHLlNTW+u2aj7Hblvg=;
 b=lp44edT1/D/m0faH/8jsaR/j6h12p6C58kS1aFgXK1qTEAvgiFBSCoz8OOG6+jA6xg
 SGJlR6/jszz/z4/X1vWQ9jHia3hOXDwh/31VIXGJ4A3nlu7V6dIkR85aognjgB/zB/bZ
 7ZBulaXd1Ubsddm/m4jNZBYJ1cefgQyw5jlFk2ooz3eER3wYP7NrP39JDsL6r5xlnZOF
 mFA74nL3JnSq1/2sFjqJ5RxH30OuI3LYIP3hDUhe53AAKa1R6EkZqigBpqSlC5Bs/nTK
 OwzGys3uKwQzu/bWGbC1dT1mTH72Ng2uFoWRCy/E6Fz8PHMW8iisAXvUaIFHKQ/6+Fdn
 hsFQ==
X-Gm-Message-State: AOAM530g80KvCzvmTh8Za1NGq/k+XL2HfehMyoTbNnqmYXMcwREfHwck
 7KwC5mUKeF7FcCtx3rWWnH6jPGor
X-Google-Smtp-Source: ABdhPJwffy1u/Qr3EXdVZVUpSlRZ1FLhRmUoEkF4YGDRSN2RqYRhixsVticQIuvJb2c6gJpMpO0jgg==
X-Received: by 2002:a5d:4a04:: with SMTP id m4mr33729076wrq.153.1591187880043; 
 Wed, 03 Jun 2020 05:38:00 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id r5sm3370983wrq.0.2020.06.03.05.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2020 05:37:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] target/unicore32: Remove unused headers
Date: Wed,  3 Jun 2020 14:37:52 +0200
Message-Id: <20200603123754.19059-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200603123754.19059-1-f4bug@amsat.org>
References: <20200603123754.19059-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42b.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/unicore32/helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/unicore32/helper.c b/target/unicore32/helper.c
index 7d538e2144..53292ae311 100644
--- a/target/unicore32/helper.c
+++ b/target/unicore32/helper.c
@@ -12,9 +12,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "exec/gdbstub.h"
 #include "exec/helper-proto.h"
-#include "qemu/host-utils.h"
 #ifndef CONFIG_USER_ONLY
 #include "ui/console.h"
 #endif
-- 
2.21.3


