Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F00C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:20:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29FA7206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jbd4VB5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FA7206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jikjR-0003AZ-BY
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 16:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jikZK-0007rz-OF
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:09:58 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:41996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jikZJ-0005cO-TH
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:09:58 -0400
Received: by mail-pl1-x644.google.com with SMTP id x11so7922plv.9
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 13:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bZmmE8g6bACENWl1LtFwmXs+x0B5ALCEi1t1qd6zEd8=;
 b=Jbd4VB5tNNHl83ZC/85lNtZEpg1zmVsflfBRMACSeRar/5YVqcwprrkY43v9BuhXT/
 OAcnBHCKQ/V3oiS+8BNsYGOZVz1RSHA6YcDdlltJ7Lk0WXuTGQUslJgOsNj72l8UzFX5
 J4dvMoSDFDR4q5wpvDs4MhAqJa5Nc4IONPNAm7aaWLNBvcIncCeMwfQZouAnAvZEfUto
 f4SSeeTOnYAWtj2OaQ7bu6XGtA1UHI5d948/WpOHLcqHRtrkYajKthNooCkgszVwIdnf
 F4R9E3MP3TYBpGq4h2JBwxwosGjT+3hQv10CKClLtcSXKg8bJzJXIYNEZ6meIGbEnC6w
 YNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bZmmE8g6bACENWl1LtFwmXs+x0B5ALCEi1t1qd6zEd8=;
 b=Aey97XeAcf22dks8Eh8OFnBpKUdGVPv137ek2tijUAG09JjPcyhPvJ2h9EyxSEP7OU
 Z9lqChDPSIA2urm1HbC0C1N0WE+tl5c5m/31a3lR7yq6B7x3UEQTZ+x8zLjMq6+V6YU0
 W+jIdN+gc61JVX51RCBslarPGs6/yjGSmhTuWy6TE5XWqCy1nnDj/vPHyDTS/WRpQ1Vk
 fw0EZJbU9F9Ldihx1MzlyRaTHcMW1XsWhs+9nXL4l2Ao/GJ6vB+E25zEd9tcJvkLS9lW
 Buh6u2ZNAJAMDV1kf1BH6eE0rIxyk8SuKX5ASxVg9OdXfX8xLW5mGLJG1BrMUUU393eH
 cCLw==
X-Gm-Message-State: AOAM533VSuOKSQy6wtdGL+tGuQr/QJAVayaQ8FKRkMZzVGfkXVFBvxf/
 QSRhUzW6q9E9R6OdeLOwzVsK06f2eE5uqA==
X-Google-Smtp-Source: ABdhPJyu6EbSyaHoN1bHSnEOFkYtD4Fq5yIq6dhsgHdEWceX9rtvpP9BrJ0KGNyNC6IgMEwtPLftvA==
X-Received: by 2002:a17:90a:328d:: with SMTP id
 l13mr6262891pjb.236.1591733396272; 
 Tue, 09 Jun 2020 13:09:56 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1d09:cef2:3b1f:abce])
 by smtp.gmail.com with ESMTPSA id n19sm10523374pfu.194.2020.06.09.13.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 13:09:55 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/13] util: Added tsan annotate for thread name.
Date: Tue,  9 Jun 2020 16:07:36 -0400
Message-Id: <20200609200738.445-12-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609200738.445-1-robert.foley@linaro.org>
References: <20200609200738.445-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x644.google.com
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


