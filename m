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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AD1C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:35:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C2420731
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jotwSAVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C2420731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIAAq-0000uM-Nw
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 08:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9rY-0001lD-8a; Tue, 15 Sep 2020 08:15:08 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9rV-0008L6-9g; Tue, 15 Sep 2020 08:15:07 -0400
Received: by mail-pf1-x441.google.com with SMTP id z19so1810642pfn.8;
 Tue, 15 Sep 2020 05:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=raGFyZs6MR9nEefX4kmRsgZPLq8a4zwcDe8/ve9JX8Y=;
 b=jotwSAVCO7QCer34R2d8YwkPUZNp0uU6b594L7lhhvvII3ieMBMS2Y+ROEAgAM6/4j
 5m62ikOoprdB2JD1WDAt5wdOrmw8t1IrznnlXH878vzXMtMk8O2rD0RH3E6IMoE9lIJD
 mVDZNbJQnjHq65hirPRahzokThVLRgum4K96wSHlGfB/s0o+AoEhnYXTrnTjl5bKdtI0
 fvDghLpWXgrELkFB6QVVm7lI78ufT/eoEqz6MNLtGvGBWyi007vxmq1sj7+fTwhS7PhW
 cF0rE9giAMK9+sbyRJaC5gOMlX9n9iikqFRBo6CciRYNjhx/3hQTRTdEZX+FiKj1Sq8t
 iyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=raGFyZs6MR9nEefX4kmRsgZPLq8a4zwcDe8/ve9JX8Y=;
 b=KUgHLQbQNcSTcgYmwVWHQVbcio9qVnwMaJoI8+1cTcj0XWENJ2WQMrCp2qIsKPH9rO
 5TEYQo9Rf8KFnwXplLKJUceTbNk3la7zQIELBL+Efe/uLQ3TrBUW8oBc6NQ5+Z4p1D+m
 Ig0hZTpX6lq/Lig8KxANLrV5+jAE15gcfRQILFVTete7zggKliXrHxYpKng3Q8c3x2W6
 k8KwFtX7TxVT3cosHWu5AiFceqfjAF/fS+n/SoRcqaghkVSvZwjAEdfAwRrkj5A+08hN
 6vdAg0R3y1Lv1wPhg7MAkVI28G/BlDDJNd6QDdEP1K6it6qv8B+L2E75bxvxj5UKrzMT
 TKoA==
X-Gm-Message-State: AOAM532q9CHDwew5iyT3VKM1Mn8aNFB56gF0TC2o35z/PKd4vlS1ksip
 4msxCcElQDZud1zU9kwR98MBOpJJV6knQPXzO1w=
X-Google-Smtp-Source: ABdhPJyduO21GmjIrmdXNMu7zQnfW0lKAXbIwbo0BOdqY2z1Oiwo1EfWKWPq/9oLcKrZUOPulLNUlw==
X-Received: by 2002:a63:580c:: with SMTP id m12mr13400026pgb.99.1600172103063; 
 Tue, 15 Sep 2020 05:15:03 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 k28sm13683061pfh.196.2020.09.15.05.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 05:15:02 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 19/26] tests: Fixes test-io-channel-file by mask only owner
 file state mask bits
Date: Tue, 15 Sep 2020 20:13:11 +0800
Message-Id: <20200915121318.247-20-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915121318.247-1-luoyonggang@gmail.com>
References: <20200915121318.247-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x441.google.com
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
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
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


