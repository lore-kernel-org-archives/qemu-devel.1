Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69EEC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FBA7208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="trTDeXCR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FBA7208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEsA-0004kg-DV
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEXO-0000f1-Ml; Tue, 15 Sep 2020 13:14:38 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:37620)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEXL-0002pS-MD; Tue, 15 Sep 2020 13:14:38 -0400
Received: by mail-pj1-x1044.google.com with SMTP id kk9so124289pjb.2;
 Tue, 15 Sep 2020 10:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EBhZ0tPMEzEbVc2ih32FHbQeoM4d+XPCBYcJq9Mkgzw=;
 b=trTDeXCRqAK71fBTmFO/K9BLMGThkKDvB1Z2UZgixDgb27SwnUNzqfD6qpe11kP2+R
 zF1tUOoLCIqAft0nMRrSZAOdhFEYdl1rBtrTNzTh26n+dcz4ONV2ygqDrfu5dc93/Z47
 bIZq2HpNgvh+K6iSqS4PYscvrnmjG8w6zbuFO4oMhP1cCHGiflTgMFYw8CmCO3vyPMZf
 8WGKnGaGUpPszNrcSUuQTEm4EwwRWQ5oXcDGYHb/UiIgM/U8D9Gcm4RV5ymlCQMZ0E8s
 9plJBl0RmHu5sGMOXDMnWkLhh/lwhWwNLIli8kCCFl4P8eeEBNaiFH22quhGSe6GlNGR
 8bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EBhZ0tPMEzEbVc2ih32FHbQeoM4d+XPCBYcJq9Mkgzw=;
 b=AeHLz4xZEDHFNfQQfWgMVDB6MFTdDq1koE7O6r3K+ZBobObIUwpBa7sVzDypYEzEJQ
 vVBUNvQYAGsWfyywxnUTSEda+y3J/s1JIhdjzpNazM80qRL/BGeitmR75+ei0vGizdyl
 +MZwKE2p9goB+xvCvxie7cvZnGm5IYSIk0smRp/ZNTszszxzpHCHNn4ztjDBBaQMXvcU
 pxWENwZc7By3sQmNfUKWKhw+RLE6FsDUejE0oqzPvU8FHqe8D7sWLmqa9XH+doAsEIt5
 E6qLxGDVk5Auqo1WmKSi37z7qiqoMFgF0UHEldgnHoOy/AjM0mrQ/5aDWuXcmROQ2tbX
 +GVQ==
X-Gm-Message-State: AOAM532w0PDrm+zPM/gemXNoTU4fiZTmDQQXgSDTyqfO5NFlEBNIBnPF
 bTQN2CJCkXYWNpNKvvZARj9QuFUCMZhk74Fbyec=
X-Google-Smtp-Source: ABdhPJwBg2Q6Q34oj/JelEKd6Cm+W7qeXLJKXsGTdMxWEtu+fzD71g2mUoeR94RtymDpUhQnrM1GXg==
X-Received: by 2002:a17:90b:3105:: with SMTP id
 gc5mr315565pjb.225.1600190071522; 
 Tue, 15 Sep 2020 10:14:31 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id j14sm124046pjz.21.2020.09.15.10.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 10:14:30 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 22/26] rcu: fixes test-logging.c by call drain_call_rcu
 before rmdir_full
Date: Wed, 16 Sep 2020 01:12:30 +0800
Message-Id: <20200915171234.236-23-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915171234.236-1-luoyonggang@gmail.com>
References: <20200915171234.236-1-luoyonggang@gmail.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

drain_call_rcu is necessary on win32, because under win32, if you
don't close the file before remove it, the remove would be fail.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/test-logging.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/test-logging.c b/tests/test-logging.c
index cec18b31b4..a7e36dbfe8 100644
--- a/tests/test-logging.c
+++ b/tests/test-logging.c
@@ -211,6 +211,8 @@ int main(int argc, char **argv)
                          tmp_path, test_logfile_lock);
 
     rc = g_test_run();
+    qemu_log_close();
+    drain_call_rcu();
 
     rmdir_full(tmp_path);
     return rc;
-- 
2.28.0.windows.1


