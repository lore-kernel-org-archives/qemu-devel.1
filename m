Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6D4C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 00:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43B7B20760
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 00:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuO7wiig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B7B20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq4SK-0007jR-Go
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 20:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jq1ds-0007h7-Jg; Mon, 29 Jun 2020 17:48:44 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:34858)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jq1dq-000887-Ta; Mon, 29 Jun 2020 17:48:44 -0400
Received: by mail-ed1-x544.google.com with SMTP id e15so14337137edr.2;
 Mon, 29 Jun 2020 14:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=Pz6xAlQLysREZhnvq2M/sf0ysYF+TT9ZKiYqFaLQuTA=;
 b=RuO7wiighU8jJ7v2DItF5htekTBYqNmpK3TfeI+yOdvy5xXrogamRNiPU/emPplxFb
 YzGVb1P+GYzPch1GI+RvDE0MIc8P0kZV2JYBKMXkfuDxJwLxPH8iA/dGlpLzY+imJ33u
 b/DaiPs5v9aemgoOPRGmGNtBRwUq9gLLAc3s32rtVfAaPhqzmr2pM5wUaG5EW5LjNM72
 qGDQY0gUePETjMIn6xR+szWSh8jeR8Qp+2nUsVoqrNaXCWuHVwvVrREz65qAisZalMZg
 s3DGYf7J6GSVd8Qa7H4FFRSLBFdVKbP4wOmP8mRW2Z1xlhsMgN2wRf8KqjAqUZfqzVYP
 RgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=Pz6xAlQLysREZhnvq2M/sf0ysYF+TT9ZKiYqFaLQuTA=;
 b=Ce6aq4yHdF+mQioyP5bejh0vnuHY1820vRrEskMEgSeiDiipNq01zOF7LsfGU36C0i
 piprVXfYbcyhxxrDtyMEirwqXkB4CLla4LxAL6nu9GOfvIq0WjbraWCvo1prRidi09o5
 IWXdsklhdS0tbs/Llqwyz3TOlKMNOaqAm1PbuliOgjMFJQ096abaFQ7l0BnxaPkURxvp
 cKVCzIc8J9Jd3lvLf7J2BL1LLSBc7TrKMfGK0S6EBRAcK2/nV5mdXJp+kkxgBtANi2Ft
 7b4ZsUGgSVYaeVQW7Q8HLn2J26/828yMZEbCVsobuVgSLo7tsXVtfLzcdX8QmWsKUSvl
 HmRA==
X-Gm-Message-State: AOAM5339kKuwlpXuDhfftyH8kX86B0Xx0KXIFvlA4UNSQ1CG19Tvw/mU
 /iheG4/bI8b3MzTIWp+PBrWM+kbMUElUxgUrF1d1JGMoV3w=
X-Google-Smtp-Source: ABdhPJwvMYtpctIcPAvjg9DjJvKf++9u1NhWLfQ/o7Lz3ux2dgjMmTGK6bjDRl9rVKxF9FYFmiOy3oY9h+LYQLz/XS8=
X-Received: by 2002:a50:9a82:: with SMTP id p2mr19393094edb.130.1593467320905; 
 Mon, 29 Jun 2020 14:48:40 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 29 Jun 2020 22:48:30 +0100
Message-ID: <CA+XhMqzZaXorKXQKXRNue9bhbrE3iawtM6EHNUVjGOuSayuvAw@mail.gmail.com>
Subject: [PATCH 8/9] Skipping sys/syscall.h inclusion as only used in
 qemu_signalfd anyway
To: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=devnexen@gmail.com; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 29 Jun 2020 20:42:18 -0400
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

From b821b7e9bbf1f327058ee858a92c7a7ee6740e63 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Mon, 29 Jun 2020 22:20:39 +0000
Subject: [PATCH 8/9] Skipping sys/syscall.h inclusion as only used in
 qemu_signalfd anyway.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 util/compatfd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/util/compatfd.c b/util/compatfd.c
index c296f55d14..ee47dd8089 100644
--- a/util/compatfd.c
+++ b/util/compatfd.c
@@ -16,7 +16,9 @@
 #include "qemu/osdep.h"
 #include "qemu/thread.h"

+#if defined(CONFIG_SIGNALFD)
 #include <sys/syscall.h>
+#endif

 struct sigfd_compat_info
 {
--
2.26.0

