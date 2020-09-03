Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB40DC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3830206E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuSHpXP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3830206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDki3-00041h-O0
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 04:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDkfE-0007qR-Pw
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:32:12 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35878)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDkfD-0001WL-3S
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:32:12 -0400
Received: by mail-pf1-x444.google.com with SMTP id m8so1734650pfh.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 01:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AOceDgUhJcFyubHw/+EMBFvN3cPEnFJXi8B+bZPhtpU=;
 b=KuSHpXP+Hp2FKf1lkcuSX/rC4uM9ATNb1h3KibdxC6BWAMa1AERJrAP0JgtlqyiWHF
 n5FZ3GEXkUL9GxT11q3pH1ruEnoVVYipJ0uRPYO0hoUwThfyJv/dC5Sv0N3Qa0MhQrPg
 2FP5gKcvUGjMcx7TY91taniik4xQmp8Q1IGyqH/eS57+HsZXYpMU7lAPiPFomK0qhpX2
 ezm5fKV6wSAE/e3o92rnYuliDvQSUbaXbljAOPC8RAKE05m4yPG1g+6r5p7HPP4Cc30h
 cZbTDm59OjL2I9SGBrRxgkeI0zzZzyD3lhZ8Csa8Zsj7IV70lgLsoSyYZQlg5WNzABwY
 5i/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AOceDgUhJcFyubHw/+EMBFvN3cPEnFJXi8B+bZPhtpU=;
 b=pl/Sau+DBoKtqy6mjV+qQuNQlGfGMSh2D0r9jMJ4P/NSRRYArFOEjrl9aTRumDnSAC
 JDJb/IGAkT/LQSDQUhJpwS4PrLu0xJ6KMv+/b1iNC58T9tXDMIga5CyxxLooQqG2kjRY
 KNxSkU5YJEmToRqUS+12XDxjfUzLAaMXR13TbsRklj5dsg3a0czqwCyvnHVeiKb1Crse
 h279wVgDy7WUogj6tkNkeHKhm36MwdTuBlvvn4WMOb7g5ZzxQiVtIMY7mX3jyrHFalvo
 zOkV/m7gu35lyL+eY1kfQpsgIdTxXQLUkzUylz9ldcjfagchrjHYq9kbBJCI8XP22YYg
 phVg==
X-Gm-Message-State: AOAM5328wCKZBfWurK06rnYySVopjuwSJTfRGHGvNHZVh0ikgF2svpDL
 Zt4L6YL3wjax+Ggmz2ASrvFmQpcekGJBgfms
X-Google-Smtp-Source: ABdhPJwJLnR0mcQQoaJgtxkDdnKxegY88kLlIBdatdhrbyWq437AbISdzn6hAGwMlWf1JPQJwmrTRg==
X-Received: by 2002:a17:902:e787:: with SMTP id
 cp7mr2816717plb.125.1599121929347; 
 Thu, 03 Sep 2020 01:32:09 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id e7sm1759201pgn.64.2020.09.03.01.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 01:32:08 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 04/12] tests: handling signal on win32 properly
Date: Thu,  3 Sep 2020 16:31:39 +0800
Message-Id: <20200903083147.707-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200903083147.707-1-luoyonggang@gmail.com>
References: <20200903083147.707-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x444.google.com
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
2.28.0.windows.1


