Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361B8C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:42:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A63420BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kH3KdYQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A63420BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGK2B-0002B4-Ky
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGJxw-0002Rh-PU; Thu, 10 Sep 2020 06:38:08 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:37372)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGJxr-0003jz-Du; Thu, 10 Sep 2020 06:38:08 -0400
Received: by mail-pj1-x1043.google.com with SMTP id kk9so2834576pjb.2;
 Thu, 10 Sep 2020 03:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=raGFyZs6MR9nEefX4kmRsgZPLq8a4zwcDe8/ve9JX8Y=;
 b=kH3KdYQeQgc8VQqxB45Fk0UqrKtgeZqQN4NOKKW/fq1hTpV87UFWr6kZxLBZkAjVGN
 RcHrfZMlWabzXfm1fxoFDK0XYsLIZFwA/y69VPjGoydslshb/vvkY9ilWGUWJ1Ti6j/0
 GXLqQuf4xQZd3015Y1aQG1gQ+RHHpuwQjTxCdgqt3hUj+VsVNxnVREIJGd4nou0WyQ9E
 3Dy4nTM7egEXA/2H2O+jy6O2wrZnAvtmj78Lpj05NYxz5Xj7+SGDgYgTXeE4s2lu3hZ/
 eJetMuqfI+krId6eKdKxOV4Xc3E8mkYvlxCEOxmgVYTvMD0BdaPMbFSTIePq3EPHpwk0
 XfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=raGFyZs6MR9nEefX4kmRsgZPLq8a4zwcDe8/ve9JX8Y=;
 b=cKnSuDXVEa4UM3Czga1W0PDFWsYICCWJkvCVAUOi5XU2GVPAdBWWcLL94Vx9ftxqNS
 Z3KClHh5I03AJ23P1pDrsimhixUTBY0NvcoD7dyWRCNMKb7wYDPjMy1wpke5dRoQMBzC
 3u9Gbgv1y92Pm+qt542I3+bIgS8lPEPOZuJm7EgGYMlrEH7zCN81uF6vWfgfLZURPN4J
 0KPe/2AJWwhKR+jifEH+WhbNLJ/FWUiYsnTrDLtf5Xrqi5vaiaVSwUPtNBzOpb7s+hph
 nWKFfofwtH/tvTo/y46VnaMxOENSNRP4/NDZuHD0hzE3twfUA3mQhAFITMmYi3H6jo4o
 6t3A==
X-Gm-Message-State: AOAM533qhJRCZsjlem2JrhYd6CfRF1n/PU5hrXW5+RCuPLR7lZza17SY
 EGw5BKXPedKPstqJLFJDGkwamyue0L4D72yw2Pc=
X-Google-Smtp-Source: ABdhPJxJFSdG4QYUPXJnmkatCgZe1naydWGR/qrJRH9EXbx1nY+mhjIdDzaV6ZLCShwD3TxMvvoj8Q==
X-Received: by 2002:a17:902:9a06:b029:d0:cb2d:f276 with SMTP id
 v6-20020a1709029a06b02900d0cb2df276mr4850122plp.15.1599734280894; 
 Thu, 10 Sep 2020 03:38:00 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id 99sm1781191pjo.40.2020.09.10.03.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 03:38:00 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 21/25] tests: Fixes test-io-channel-file by mask only owner
 file state mask bits
Date: Thu, 10 Sep 2020 18:37:21 +0800
Message-Id: <20200910103725.1439-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200910103725.1439-1-luoyonggang@gmail.com>
References: <20200910103725.1439-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1043.google.com
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

This is the error on msys2/mingw
Running test test-io-channel-file
**
ERROR:../tests/test-io-channel-file.c:59:test_io_channel_file_helper: assertion failed (TEST_MASK & ~mask == st.st_mode & 0777): (384 == 438)
ERROR test-io-channel-file - Bail out! ERROR:../tests/test-io-channel-file.c:59:test_io_channel_file_helper: assertion failed (TEST_MASK & ~mask == st.st_mode & 0777): (384 == 438)

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/test-io-channel-file.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/test-io-channel-file.c b/tests/test-io-channel-file.c
index bac2b07562..1b0e8d7c1b 100644
--- a/tests/test-io-channel-file.c
+++ b/tests/test-io-channel-file.c
@@ -28,6 +28,12 @@
 #define TEST_FILE "tests/test-io-channel-file.txt"
 #define TEST_MASK 0600
 
+#ifdef _WIN32
+#define TEST_MASK_EXPECT 0700
+#else
+#define TEST_MASK_EXPECT 0777
+#endif
+
 static void test_io_channel_file_helper(int flags)
 {
     QIOChannel *src, *dst;
@@ -56,7 +62,9 @@ static void test_io_channel_file_helper(int flags)
     umask(mask);
     ret = stat(TEST_FILE, &st);
     g_assert_cmpint(ret, >, -1);
-    g_assert_cmpuint(TEST_MASK & ~mask, ==, st.st_mode & 0777);
+    /* On Windows the stat() function in the C library checks only
+     the FAT-style READONLY attribute and does not look at the ACL at all. */
+    g_assert_cmpuint(TEST_MASK & ~mask, ==, st.st_mode & TEST_MASK_EXPECT);
 
     unlink(TEST_FILE);
     object_unref(OBJECT(src));
-- 
2.28.0.windows.1


