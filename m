Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4B9C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:45:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE92F207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsZFW+6N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE92F207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDaYw-0001u5-3G
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 17:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDaWi-0006IQ-DP
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 17:42:44 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:36416)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDaWg-0001Rp-VL
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 17:42:44 -0400
Received: by mail-pj1-x1044.google.com with SMTP id q1so431403pjd.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 14:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u7amQF5+q+U5pyEjmTJks994NcpROaetfXoezQ8sulo=;
 b=nsZFW+6NFvhRxDTCR9w4RsQMRNpjqR1B9WX+0jsI3LocbOeVvJKET9cPCUjpgzo6mI
 ar+zzLbrEgyFSWcBnBdgxrq4Mrpe0l1ytMVIW8oLM2Y2gmltIRosG6mtv0KgwwPcj3tm
 jGmSQbRVTbBf1r4k2/zbcE5dgcwYgtzoNXGCy3Kb+8dYXUDpYklmI+hbaLAi+UlBvG6i
 BAHhkgtVdPWERuYmoqiPMRNXAeCMMhV4c1rUGHFMZeI2pD+r5XScGrZDoprFnzmcMUoF
 p4ssAW0iZykc6Yr+yjVOlciYlijFIGQjYeG6TWBOItWOGXzfeZvIPZHdSZq3OZfje5AK
 i5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u7amQF5+q+U5pyEjmTJks994NcpROaetfXoezQ8sulo=;
 b=OLKy62LfZPBmYD/LD3+3YLaJufk0o/sQ73LNY27PQ0TDxqHXNhThH4/+jmktNUDCi/
 UX7KhnqZzJtk6C7US3H5Otvl4ACFDZtq8eP+0/Ri85vyrdvtyNRMzaFMYt7BCHqQIE6t
 CC2/h7gbQKdMcIbRWM/aDOYu7WIxI7+mrprEjYTksKLCp+zKcwzaXIabPE6Tel/nzzOQ
 /knmJioL4wLyvYPRpP6iIoJUlm91Chc2xTy95iIa8J72Nmsd0XZmpXVmZq+kJIuFqkBo
 oBtlE04AHwkV5NXEwDjkv6zOpJwGreGa3kXbWp0Sct3/nHS4oGXERUKqubAzkSyys1Ka
 9QKA==
X-Gm-Message-State: AOAM531CjOjxCdLVhSyG2iTpdNhgbz7JlT1foYyClYliEE0VK76OjUNq
 WpYuI1zUDAwv//F3YSGaATDMaBByrt6SQg==
X-Google-Smtp-Source: ABdhPJyC1UQu01pFcxLnAH4+34pKid3oy2MW8FqB4/OdeBHE/Gd8y+NKAimT3EMEZ+A4t9pe/1q+4Q==
X-Received: by 2002:a17:90a:3948:: with SMTP id
 n8mr4197824pjf.156.1599082961210; 
 Wed, 02 Sep 2020 14:42:41 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id x12sm328863pjq.43.2020.09.02.14.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 14:42:40 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/9] tests: handling signal on win32 properly
Date: Thu,  3 Sep 2020 05:42:06 +0800
Message-Id: <20200902214211.337-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200902214211.337-1-luoyonggang@gmail.com>
References: <20200902214211.337-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1044.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SIGABRT should use signal(SIGABRT, sigabrt_handler) to handle on win32

The error:
E:/CI-Cor-Ready/xemu/qemu.org/tests/test-replication.c:559:33: error: invalid use of undefined type 'struct sigaction'
  559 |     sigact = (struct sigaction) {
      |                                 ^

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/test-replication.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/test-replication.c b/tests/test-replication.c
index e0b03dafc2..9ab3666a90 100644
--- a/tests/test-replication.c
+++ b/tests/test-replication.c
@@ -554,6 +554,9 @@ static void sigabrt_handler(int signo)
 
 static void setup_sigabrt_handler(void)
 {
+#ifdef _WIN32
+    signal(SIGABRT, sigabrt_handler);
+#else
     struct sigaction sigact;
 
     sigact = (struct sigaction) {
@@ -562,6 +565,7 @@ static void setup_sigabrt_handler(void)
     };
     sigemptyset(&sigact.sa_mask);
     sigaction(SIGABRT, &sigact, NULL);
+#endif
 }
 
 int main(int argc, char **argv)
-- 
2.27.0.windows.1


