Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37241C433F2
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 07:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 007BC206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 07:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p24LNxy8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007BC206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyVqx-0008KW-5K
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 03:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <duboisj@gmail.com>)
 id 1jyTsI-0002u9-RD; Thu, 23 Jul 2020 01:34:34 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:36178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <duboisj@gmail.com>)
 id 1jyTsH-0000d9-8D; Thu, 23 Jul 2020 01:34:34 -0400
Received: by mail-il1-x143.google.com with SMTP id x9so3345524ila.3;
 Wed, 22 Jul 2020 22:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1jdFZxnvJl+4lSdNbUF2yM8Kzsb7kVvm+ARBjj3c0GI=;
 b=p24LNxy8mV2KA9rU9MT24vyA9dKe0qDh4uA78DlYBiet3dbDHv8TvvVv3Ft8FGuEwU
 lY21oYDmmPcZcFNfsofUVON1k0Me4rtUBXZik3zHZJBY27Ze8ddRKLV/D+hTQk6Np4Cw
 p9l7uWkyQzi3lgHjgKTuTRjOJBNe3aNkHurbE0VFHUZBSK9R4QQ9XZv/ofyvBKS7jsvI
 Fs1P40TSTWVpAQrHZSkNYpM11KwO+VQg7fDETwxUIjBbv2EA3y3CSV4S/ycdM+gJhr/a
 C390QNQeF5IkjJN4HgWAgRaDUUQRMTHNhqc89P4B2tun+mmhiJzUqM4/2gYKM+ljQ/ED
 Nkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1jdFZxnvJl+4lSdNbUF2yM8Kzsb7kVvm+ARBjj3c0GI=;
 b=dt0NEfn4cxHXfaYNAc3YK1uwArpwJ9gKkd3s2v0Ls6xhc/A1bDlnOQSBBhAC0N+2Uf
 tAX21rcmk8w1oClPxNoK69fZ9uvZ05CKMXd0dvzlJ52LMyt51R4u45PcuxzCELXh04f6
 m+9zVZ/PLp/WfR1PXVJaNXrLzwZ5YxlfL98s+m6KX9aXg5w3ZS3fPOGzE6lDNtIqeFX9
 oiCr8+M2JEO75ETb2799iH6kv6O4leNrnulKuBa3qkNKFopQAf1vj/k1l5Uk2O9MV5Xw
 08xnL3MFBL4+1J8uSZzDwKq/WR6qRQ5c+pX8443xC/6kJrPljRfOydplU8pHO7+QrZWc
 kWLA==
X-Gm-Message-State: AOAM530OxN5pLsbni6B3m2Z/TRJavFB0Od24fZPNM7W1/rdVE5525gcT
 h1jK3HJt+f4/591Wzd/Ep6jT2Q8JBQMKQw==
X-Google-Smtp-Source: ABdhPJwp+uIFENshSNHHIPFno/rqcet/DZG0HPKFkK36HMRP/3IbCcQalucR2AaJwr96ZmeTlq/ZHw==
X-Received: by 2002:a92:bb84:: with SMTP id x4mr3509822ilk.177.1595482470940; 
 Wed, 22 Jul 2020 22:34:30 -0700 (PDT)
Received: from localhost.localdomain (50-93-248-134.fttp.usinternet.com.
 [50.93.248.134])
 by smtp.gmail.com with ESMTPSA id d16sm832634ill.47.2020.07.22.22.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 22:34:30 -0700 (PDT)
From: Josh DuBois <duboisj@gmail.com>
X-Google-Original-From: Josh DuBois <josh@joshdubois.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] trace/simple: Allow enabling simple traces from command line
Date: Thu, 23 Jul 2020 00:33:59 -0500
Message-Id: <20200723053359.256928-1-josh@joshdubois.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=duboisj@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 23 Jul 2020 03:40:32 -0400
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
Cc: qemu-trivial@nongnu.org, Josh DuBois <josh@joshdubois.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The simple trace backend is enabled / disabled with a call
to st_set_trace_file_enabled().  When initializing tracing
from the command-line, this must be enabled on startup.
(Prior to db25d56c014aa1a9, command-line initialization of
simple trace worked because every call to st_set_trace_file
enabled tracing.)

Fixes: db25d56c014aa1a96319c663e0a60346a223b31e
Signed-off-by: Josh DuBois <josh@joshdubois.com>
---
 trace/control.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/trace/control.c b/trace/control.c
index 2ffe000818..6558b5c906 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -225,6 +225,7 @@ void trace_init_file(const char *file)
 {
 #ifdef CONFIG_TRACE_SIMPLE
     st_set_trace_file(file);
+    st_set_trace_file_enabled(true);
 #elif defined CONFIG_TRACE_LOG
     /*
      * If both the simple and the log backends are enabled, "--trace file"
-- 
2.25.1


