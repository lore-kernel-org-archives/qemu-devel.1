Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC27C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:22:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 183F82075B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JDUik88I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183F82075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzLH-0007S2-C2
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAz-0005QT-U5
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:25 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAy-0006eF-AP
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:25 -0400
Received: by mail-wm1-x343.google.com with SMTP id q15so13461959wmj.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=74P0QPv7N4CwWIZNwbGdxlAllKsjgzH/XuRXK1wCbsM=;
 b=JDUik88I33XScCsoKOTAyMSzOzlE7JHbDELuA95WO/GYjRhlCixYgSeQkPPnL0O2IF
 FHxTlBU6M9Km4T3Dvzaa4l//LuJCdToG96PDCqsuYEl1oc4HyFnqpBa8LuM+6Kq5jxWE
 apcHfzp+wDeoHViwXs2J/rZy6YN+V9+iT5q2ejmuPnwpKp0nVbVCuROQ+bAOAkpoMDVC
 ukGaXHCp5tycC/YaohPwziBl11V9tNkpXOAhPjXhGOuKpxBi4nMSuqnTSYVk5kalltIR
 h0MGVnJByNeq3n7SVSsc7sjf+vGII6QXO6X+oQBd8EucADve+PyPNQzi+EEYuBNaw/ZE
 +FxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=74P0QPv7N4CwWIZNwbGdxlAllKsjgzH/XuRXK1wCbsM=;
 b=pPfKe9E30yFgB1XvX2p5Gc4FI1Bw1cLx9ZyK5LUkHnyxaww5xmSI+RMPiwbgJ4hhF8
 vrFL7R85/lW7DPy1xckAh6qqMyzQmzdiW6H29B0oQAGxppERtXL1KzXkiWC1yZOyEG+/
 aage55hytipv1Y//MJ1ldWAMHBiG+re2prjDwvRGO6AzGdm1gez33gg/X4yHvwFdSJiU
 GYqQPH01DYMaZcLZrSA1TCpcHMlSRmneW523EIYWUf+ZqxDnBgwR38+4LqngUsdP5pCr
 X4OVCdbLJ7WmQg/YgEm4Jqu00vkJf3gsfDP0UGgReKmYoLZ+lwpuyLZBSA8TjM+uGNu7
 W8Zw==
X-Gm-Message-State: AOAM532ZzQr3M3GCyWu5RgC7T3XLI+PB7cjlA7+EK9UZS0ezI0nvnqvg
 UVUwyw+cWRVyRkoCRt9lygHP5++T4cS3yA==
X-Google-Smtp-Source: ABdhPJzK74QtYyAmm/nDVLOtdaE21gpw2nLFIVoIfHVnNIaVlMvzNxMAJDjxoIt/0iKTc8py5TamOw==
X-Received: by 2002:a7b:cc85:: with SMTP id p5mr184351wma.18.1594649482708;
 Mon, 13 Jul 2020 07:11:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c136sm24031297wmd.10.2020.07.13.07.11.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:11:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/25] util/compatfd.c: Only include <sys/syscall.h> if
 CONFIG_SIGNALFD
Date: Mon, 13 Jul 2020 15:10:53 +0100
Message-Id: <20200713141104.5139-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713141104.5139-1-peter.maydell@linaro.org>
References: <20200713141104.5139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
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

From: David CARLIER <devnexen@gmail.com>

util/compatfd.c includes <sys/syscall.h> so that the CONFIG_SIGNALFD
code can use SYS_signalfd. Guard the #include with CONFIG_SIGNALFD
to avoid portability issues on hosts like Haiku which do not
provide that header file.

Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200703145614.16684-8-peter.maydell@linaro.org
[PMM: Expanded commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 util/compatfd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/util/compatfd.c b/util/compatfd.c
index c296f55d148..ee47dd80897 100644
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
2.20.1


