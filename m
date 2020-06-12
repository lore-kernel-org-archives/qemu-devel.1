Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56187C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 19:15:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C7120792
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 19:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jbfiRuW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C7120792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjp9O-0005a0-8N
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 15:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjoxU-00013V-3B
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 15:03:20 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35740)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjoxS-0006vd-Eo
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 15:03:19 -0400
Received: by mail-wr1-x444.google.com with SMTP id x14so10821941wrp.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 12:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TVkmiGx2GSH0speASlWaGVuivqVtJrK614sZoAezQaY=;
 b=jbfiRuW76O2HMBDL4roJyZJ+RjZb4r/s6nKMsWDHOlbb5+Skva9mnLXTk7tzNFJITG
 5H5PnJnaXpERvv0Z61wiao6iKNoPl+i2um/xKCg3Ca4/haf3+TQmHjO38PLNi+2ybu9H
 CiKpF8dQqyE3KvgU1Y67FT9CV4AKqsnfiiITGyjOFNmj2iHD4PAhp0HDR/uF9mPHXdnp
 Fd1KopHuG3CNi1ohkz3gbv7sO1M/wXteGVo+qbcmlPTLe5m08GQapDwVjvTgW8s2coOv
 l1OeZnO8oSoJzqZ0TKBsvYjNu2bzyT1Ia1qQtZgBHOaPGhMdUj4ErT3nOHsbzQdb5+R5
 ASSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TVkmiGx2GSH0speASlWaGVuivqVtJrK614sZoAezQaY=;
 b=SgIh63WMdZTwx07Cx56CDobqvqeEbHsm8Gylk8Vgn2hv1dfhMUmdsQn6VxOmvyO2j0
 9CDDWarA0SJJHRk4vfleNsjCx367UUbAypYh6YnN3h7nwDUA0e/ob5nnM5co90d2ueXr
 UHfKaI1KRwtRh9yLLZMEHYK1fG1GXFCM9OheInzbiM5aPv1qgcNJ22mWv65m5nPW1IKA
 6P/BEQ3wDqUxCyWuaTN9LwpdNP5aGQC212YTBtnTWBPslzKifhVVDJDeouas0xF/MdJs
 e4/szRZceGifZ2f38e+Cm3SATOJS3ONvO1XbvUBKm5Wzw8iSqJmS896M39cimk+Qf+UV
 8RNg==
X-Gm-Message-State: AOAM533dwK748JaEPuf1zKMzFDD7Ce1X2c+m8xlatKjhWkyJ5T+4qxkZ
 yiBEFQbXJyuNvse8fRfIVFlZSQ==
X-Google-Smtp-Source: ABdhPJyHEOOzLRaFm4n/BvBnkv73QDKuKq95vcPWpIU3q6JddILl5xMOaGY+JDg44Qr2I3Lf/OOPkw==
X-Received: by 2002:a05:6000:104f:: with SMTP id
 c15mr16279897wrx.391.1591988581155; 
 Fri, 12 Jun 2020 12:03:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x186sm10255201wmg.8.2020.06.12.12.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 12:02:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 56EAF1FF9C;
 Fri, 12 Jun 2020 20:02:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 14/18] util: Added tsan annotate for thread name.
Date: Fri, 12 Jun 2020 20:02:33 +0100
Message-Id: <20200612190237.30436-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200612190237.30436-1-alex.bennee@linaro.org>
References: <20200612190237.30436-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, berrange@redhat.com, Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

This allows us to see the name of the thread in tsan
warning reports such as this:

  Thread T7 'CPU 1/TCG' (tid=24317, running) created by main thread at:

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200609200738.445-12-robert.foley@linaro.org>
---
 util/qemu-thread-posix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 838980aaa55..b4c2359272a 100644
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
2.20.1


