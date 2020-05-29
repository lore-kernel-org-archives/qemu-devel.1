Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D55CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2662920721
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qe/NoSKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2662920721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jef52-0005HW-4k
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 09:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jeezG-0004ah-Ur
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:23:50 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:39957)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jeezG-0003e3-3s
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:23:50 -0400
Received: by mail-pj1-x1043.google.com with SMTP id s88so760298pjb.5
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 06:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=v6Twul2TWinr3wq/OK/PDzXQA1fcuJlgD8ranJI4BbA=;
 b=Qe/NoSKmjgsBaIKdrrGbLmSUkEDBU33O+Vl6A1JnrohhWUBfA+ZpFdJ1ZkHzvj3B5M
 yUojEYpKfFWaGgW7z1gkxF96Hpnru/1JNlDY7zF0Ph1PebQ4KCM2ubni+L7wTsJfyznU
 wl7/LtFu+FgJXS7JWLTV83bw9ePIWnPUwas7FD217JjvPze6vIASVR95woWo/ILyMe3j
 6+i6HDArB8C9U9VtIBnDZ7xJMe8z0Dr1ASkNxgKcZw+4sCJIbDOJm48YGV8nDBxXQ5Oc
 FwqT0eGz/BF6++SrDXFRVOFydk63Jh9XYNERHThlITKjATRvtuq/hKxaKHMdTJmhrV9X
 M/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=v6Twul2TWinr3wq/OK/PDzXQA1fcuJlgD8ranJI4BbA=;
 b=Is4ZLhHsJrYzdXFd45DE6vHBNZH/ZJmYQ3eFgOKYeGh3jYUH9CTwhR9VrhSDS1i0YR
 Wyqc6z60ANWiHfpP2Ghf8zY5zsJPKJ2vM2w2oSmfhcVqS8C6xTBmZ7X8AGavJ5a8gGTK
 YNx3bF6mFgtZRduNnlfdHwXI0L4nMQ5RlgstzdxwRr7NqM2ZNPk0rK+K208clfXB6CUO
 7mXC48q5jTdMPKFZ8UkkXY0qTfYR9UU2mRR5tp9kTWzzoilYxX6gdchk+P9RU4ALdcy3
 SBzQzOC2bQ0BJ/7QJL9OM9T2H59GqWoQ03X+rJt1ybnznJ5L8fuaZo7d6C0+3xq105vo
 WDPQ==
X-Gm-Message-State: AOAM533eV4CiuLFk7oo8YJ6yki7sZzPeodjfQC5Osh5aOOxBdtLNkctF
 IDqWNFrZMsQD/49irg7tWm/9l0TQZtXeAA==
X-Google-Smtp-Source: ABdhPJxJr7WCt9SL1vpwjxoDAZ5ctP4a3Ed6bPuZp2mTbDNaV4NWPYmc7owjpltMEp9VuUy1sQ4umw==
X-Received: by 2002:a17:90a:238d:: with SMTP id
 g13mr9494110pje.213.1590758628414; 
 Fri, 29 May 2020 06:23:48 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:75ac:d268:da04:dde4])
 by smtp.gmail.com with ESMTPSA id e13sm1998686pfd.10.2020.05.29.06.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 06:23:47 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 07/12] translate-all: call qemu_spin_destroy for PageDesc
Date: Fri, 29 May 2020 09:23:37 -0400
Message-Id: <20200529132341.755-7-robert.foley@linaro.org>
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
Cc: robert.foley@linaro.org, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

The radix tree is append-only, but we can fail to insert
a PageDesc if the insertion races with another thread.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 accel/tcg/translate-all.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 3708aab36b..3fb71a1503 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -547,6 +547,15 @@ static PageDesc *page_find_alloc(tb_page_addr_t index, int alloc)
 #endif
         existing = atomic_cmpxchg(lp, NULL, pd);
         if (unlikely(existing)) {
+#ifndef CONFIG_USER_ONLY
+            {
+                int i;
+
+                for (i = 0; i < V_L2_SIZE; i++) {
+                    qemu_spin_destroy(&pd[i].lock);
+                }
+            }
+#endif
             g_free(pd);
             pd = existing;
         }
-- 
2.17.1


