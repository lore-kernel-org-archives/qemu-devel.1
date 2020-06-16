Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEE6C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:01:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 836F620707
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ytg0oS0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836F620707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlBD6-0007KD-O1
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 09:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlB63-000415-11
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:53:47 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:53048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlB5z-000087-Ej
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:53:46 -0400
Received: by mail-wm1-x333.google.com with SMTP id r9so2774621wmh.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 05:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J/tbW+i3GK+A8UpzokTnJFqdsmmwLI1SX+zoA10BfeE=;
 b=Ytg0oS0jVZvQeJb8RGmc6eZGzcOBOA6kX1hsaLi4wA7sQv1mxiVj3OOFVGCqV4nlBR
 suTZfR/LL1M5Mgzs7ZkP7n8zTjAgoZi3DW2hTbrBIYfOozl4pbFiB69K38bGcLfUSOGt
 dWoe0q0f12B+zp/vxlxTHBKTseuzkaKj6oj6QyDszOYctKuKLmOWec6plxsHZksNYYdf
 j0qHrdoTVI8x+0Cxw9OHu7hDzX5S7usscE4a5O7Bgw7JHCeqqooSQczYrsSZmJKxC0oy
 VoiYtM8FSZyXT3Vt8w+uJnVIPyN1Ab8Z/bzosxjokfCM7TvdKN2soLnYb+8DCKtl6tb7
 hQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J/tbW+i3GK+A8UpzokTnJFqdsmmwLI1SX+zoA10BfeE=;
 b=Y7L0gERqRq6t0oa/EFFbyKeBGWSxb1hVx+QDwVuGOLZJ/N7lw9JyC98icgdmkQ99cK
 UU1hP5NYMvP5ab9wxp6z8MtGIQbiEbzHx6CC8bedyJWljWdmccU7402t4nUKEohA5azB
 5nxBttsSvlUjfum+4I80aJ+OpPfSPOnL6tQpoEToXylNihHazsD2Bc7A2Jf+b9/vO2/D
 OE0nzwVjooR4p4Q7NONn6Ab6NVWzFvMcloUodf6+frGo3K3saL0aR4Pr8NYXvRUhbkcO
 dN4fyY5q1rCjcJwBrMzLrLJhwTq2Mftlnh4upZ9Vev+/qNvVeRqk28cs8xgSQeoZ1gfh
 bD7w==
X-Gm-Message-State: AOAM532pDKYFqu8iOgii/2xIFxi/wYdNEAVCxwI22TlbSY2HKyAuqoBI
 36wi989AYKzmaR4WxGJd3kdpOQ==
X-Google-Smtp-Source: ABdhPJxUimt5zGZhq+2PRaHVbLEj4Xl6Dxsv47/XSNyqGxf9y7iGFoQ1f0I1xrC2+LpPe42bhEnW8g==
X-Received: by 2002:a05:600c:218b:: with SMTP id
 e11mr3130276wme.162.1592312021986; 
 Tue, 16 Jun 2020 05:53:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c16sm29501139wrx.4.2020.06.16.05.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 05:53:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 99D511FF9D;
 Tue, 16 Jun 2020 13:53:25 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 14/21] util: Added tsan annotate for thread name.
Date: Tue, 16 Jun 2020 13:53:17 +0100
Message-Id: <20200616125324.19045-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616125324.19045-1-alex.bennee@linaro.org>
References: <20200616125324.19045-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G . Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Robert Foley <robert.foley@linaro.org>
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
Message-Id: <20200612190237.30436-15-alex.bennee@linaro.org>

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


