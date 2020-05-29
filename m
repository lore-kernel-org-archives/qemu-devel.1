Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAACBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:31:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B7C120723
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SkTUCqwc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7C120723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jef6p-00010L-Ic
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 09:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jeezP-0004xz-MZ
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:23:59 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:33624)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jeezO-0003ib-Th
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:23:59 -0400
Received: by mail-pj1-x1043.google.com with SMTP id z15so3151369pjb.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 06:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=yJ08HengHm5gv++XKOUrrTtG6i6MD5Dt3ZAL97dGxmk=;
 b=SkTUCqwccYlbbtrJkwUfKnNuedk0cp3LgopEKXPhrYTRfTU8Z/EcFaWthADE4RaV/C
 jiZvOxtsHoJfwOhuWmwb6L/RtU+d0AMC3SBiTkcXKbadtIkRi7P061iHZ7OX9ZZCK4kZ
 4iUNL/4A7FCM5/ATw3uh7c4lX6pC2IRDYtwVAFNJ3GR4czZ85aIIowhJo5Zp4fMdjGvt
 VaFzczl2/dtYhVPlAlG5X609YvKd1j4IX4Ff9rpb+PoNjl79QW+/aOUpsFvj9SWtmiUR
 o/X8OwWwIpRkfbHMaifXVKZB6/aN5HtR8ofzMb+dR8i4bZVqu3EwToNRlbT7LysEJorG
 FOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=yJ08HengHm5gv++XKOUrrTtG6i6MD5Dt3ZAL97dGxmk=;
 b=KIWhcGyqsHh5jMEXndCTadToIRagFMusLiNEuR9fj5LiCVQaESrQl37X52tPDfjcKs
 KtyYDMcNvKMOoWCou7A7o8Eukyi71JFlKclTMmOrZyx3dYc2gT8WwYipUCxnR8BQ5fxk
 Q82KvEL2TI1ZFyUTf4MLRGqQ5doFzu2ggPsb3IkoNFNUEOhDEBoZxPuVBCq5Zck5hTAI
 xVptcq2ewIYzaSWNmwziNmzKcn3CTXcpK9Z/ikpeviuH3NjqAifMmjhShtjnytvToTqf
 J3lyTS0Ef6mDdcvYSOY3GPjYiQ4g5pUe/HVbyLF3wE8xWvIHi3Dl5D9InTuunUzzk+9h
 qonA==
X-Gm-Message-State: AOAM531DAxVX7PmwKHLbjF+D8IbL9DERS4knA1oqzK37d48Tig5S9cCw
 idxme3flfnh2lovFykiqn40WDxK0PNmYdQ==
X-Google-Smtp-Source: ABdhPJwntGPkCaUGoUxpwAJAIS10p9r9UmnRjYQ3MNglbjBL4bUhdgRkqcCBPEjI2DB+rSlvHqtvTA==
X-Received: by 2002:a17:90a:8918:: with SMTP id
 u24mr9340872pjn.71.1590758637313; 
 Fri, 29 May 2020 06:23:57 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:75ac:d268:da04:dde4])
 by smtp.gmail.com with ESMTPSA id e13sm1998686pfd.10.2020.05.29.06.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 06:23:56 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 11/12] util: Added tsan annotate for thread name.
Date: Fri, 29 May 2020 09:23:41 -0400
Message-Id: <20200529132341.755-11-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529132341.755-1-robert.foley@linaro.org>
References: <20200529132341.755-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=robert.foley@linaro.org; helo=mail-pj1-x1043.google.com
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


