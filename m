Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DF6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:42:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C3AC2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pb7YG1V/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3AC2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGMc-00047D-OY
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jhGI2-0004Bk-6h
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:37:58 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:54198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jhGI1-00041L-At
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:37:57 -0400
Received: by mail-pj1-x1042.google.com with SMTP id i12so2952457pju.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 10:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bZmmE8g6bACENWl1LtFwmXs+x0B5ALCEi1t1qd6zEd8=;
 b=Pb7YG1V/Bc6/e68fO44j042QeV5pS685k3SzEN9JMM8i5rIjB47b4i0OyCCLtjp+KQ
 6stzaFiwg+D7f0syW+O5RT/6ph5E6kxe5oQ6YZ6B+pwjiloLjto0rPT1L/tokSUIFc0f
 Egy1oplXvb+OyFUm8BeXEVY6zOVyu7lisfzTbqsM62tOsfpChEKcVpWlx5s8bmEDzjIK
 v2KBBuiGkwKCD7iStGTynAP0gNEHKNYppjTtEwZZmXuoj8VV3VDHJmVRCjc4OHiyvF0h
 YStOIO2lIXx/KD+KC2xByHvbzaU/v9BAdMeiZJlONus4vXqUCMincrxX9bFd3u4cnozN
 qzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bZmmE8g6bACENWl1LtFwmXs+x0B5ALCEi1t1qd6zEd8=;
 b=M4ceFjfHudfbRR0smxknOxwgDzjbB7gb14ZX0Uiwxyn21sgDEpBRktS3ncdu58Sl8k
 tLSHL07WAqe0hUNPPUS4Jo6Ji0EnmUTYKBhb3FglI2k7qQiaAIeby1gFqqxxQv7aoVYZ
 kgk7wvWsTQT+MUqfU5D37RDvNt5TOd8LYNea7AEtMxwy3+7kU19d+lmYhZJ0OpZRpjPb
 ChQJN/RkGBp+Z9ve/8LkZVHTEBOQgyVxcNFwG7VCv7Wjv61w1Xb8lralncGlh5UZIM+r
 7L6GYh1KzcCPtopMj8/GSHJGMhe6d08MTUltAW6QmGsSVGrSoHkMwLAJg9wRkOER3P03
 ifpw==
X-Gm-Message-State: AOAM5325dC5MZ7Bot228yOzjSRcIAS39twM63u6w+8updpIWst85cxzm
 GAMA8GZ1WcD8F6M+F6MpJ25kdqWj1vpsgQ==
X-Google-Smtp-Source: ABdhPJx+Y/7CJ4ddPxc2IR6/oSwFA7XEzN/7/4gUy3R5JBcAHa/psL3INyDWZd64Xr1hoqe2/jGIwg==
X-Received: by 2002:a17:90a:8594:: with SMTP id
 m20mr4199964pjn.38.1591378675749; 
 Fri, 05 Jun 2020 10:37:55 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 (c-73-47-162-176.hsd1.ma.comcast.net. [73.47.162.176])
 by smtp.gmail.com with ESMTPSA id a19sm188307pfd.165.2020.06.05.10.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 10:37:55 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/13] util: Added tsan annotate for thread name.
Date: Fri,  5 Jun 2020 13:34:20 -0400
Message-Id: <20200605173422.1490-12-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200605173422.1490-1-robert.foley@linaro.org>
References: <20200605173422.1490-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=robert.foley@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows us to see the name of the thread in tsan
warning reports such as this:

  Thread T7 'CPU 1/TCG' (tid=24317, running) created by main thread at:

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
---
 util/qemu-thread-posix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 838980aaa5..b4c2359272 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -15,6 +15,7 @@
 #include "qemu/atomic.h"
 #include "qemu/notify.h"
 #include "qemu-thread-common.h"
+#include "qemu/tsan.h"
 
 static bool name_threads;
 
@@ -513,6 +514,7 @@ static void *qemu_thread_start(void *args)
 # endif
     }
 #endif
+    QEMU_TSAN_ANNOTATE_THREAD_NAME(qemu_thread_args->name);
     g_free(qemu_thread_args->name);
     g_free(qemu_thread_args);
     pthread_cleanup_push(qemu_thread_atexit_notify, NULL);
-- 
2.17.1


