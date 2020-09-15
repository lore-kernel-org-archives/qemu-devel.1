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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51535C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:32:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4916208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4ec9xfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4916208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEoP-0006yt-RI
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEXC-0000Oo-8s; Tue, 15 Sep 2020 13:14:26 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEXA-0002oC-4D; Tue, 15 Sep 2020 13:14:25 -0400
Received: by mail-pf1-x444.google.com with SMTP id l126so2325041pfd.5;
 Tue, 15 Sep 2020 10:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N0CxQxe/b50XIpbJDMgmSIuHeuMl2xPGe6WVLBKj7/I=;
 b=X4ec9xfhTYwWWoycPymRsJzDlroDiGypg7SybTNgG29AA74FBsgOIezu+JSi/pAuiO
 rSldTB7JF3GIHAgjuiDTKXe+aoI9+PKZUdEJRrYo63cEJ9aiDM357sekmLgKOu/qny9E
 NUvHPWEIpE62Dr/lEfIvbOZdjTOIr7twNGtzbefWYALwaci7xGoeyvl8hePPysyFOGMl
 QY8SgWbtmqWuMoUSSp3ESffrl9LaT+2rwMSCbUm8fNbcrBfCe8W8vo6Zv0e8bOsBH2Ly
 H2OUtx3lBST1HMeLC8WsPlVSr6zz0o4OYI5NiXzp/V4sitKorFoMiS9qTnavMKLfnYxm
 zrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N0CxQxe/b50XIpbJDMgmSIuHeuMl2xPGe6WVLBKj7/I=;
 b=P/c29KNs5SnADZ7Vlv9mie8gDT61TZWJ9DRNqmtFzNHtGJMPM9Hf9dj01Ac4f9ffNG
 /uiLJ0UqLJjxbojR/ZDJ4SWAuZ9CuLBmcdhHYIStn7561AxxLob5D7HLC3TsCJ+n23HH
 2OEz4EPYNkaQB9Q5c+mA095eaPl/SmYbMAKGqy6A1XLlyWGCrw3MOxSkzlgKhMFWRaU/
 RXuAooyFgQHMBqlWL/igddI9oXJRcTVM8fDzPMI9Qj3jRXbzWyo/XS7PXQV+ww/NMzBm
 b7imKq2tXIw8C4/AqIUwcza0Jhk/LydwzcmI/GyYLd3P3JuOoHnGvelKLo6ZC5Ad1ArN
 LOHA==
X-Gm-Message-State: AOAM532O6sbIUNYM4MejFk8jkz18JtC1mcfKJLy0BBdOfpd0KJRN24sh
 TidEgkGmK3unTxpwYyNLyjY/dphTd2H3kHoof5I=
X-Google-Smtp-Source: ABdhPJzmlKPO8jxXrIYh2v55JgQG5vTp+HFKWwQaNhkAoDOQv4NiOUTEFguYEuqxQG+82S1K2/ui+Q==
X-Received: by 2002:a63:5119:: with SMTP id f25mr15220778pgb.351.1600190058472; 
 Tue, 15 Sep 2020 10:14:18 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id j14sm124046pjz.21.2020.09.15.10.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 10:14:17 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 19/26] tests: Fixes test-io-channel-file by mask only
 owner file state mask bits
Date: Wed, 16 Sep 2020 01:12:27 +0800
Message-Id: <20200915171234.236-20-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915171234.236-1-luoyonggang@gmail.com>
References: <20200915171234.236-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>,
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/test-io-channel-file.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tests/test-io-channel-file.c b/tests/test-io-channel-file.c
index bac2b07562..0aa0477541 100644
--- a/tests/test-io-channel-file.c
+++ b/tests/test-io-channel-file.c
@@ -28,6 +28,16 @@
 #define TEST_FILE "tests/test-io-channel-file.txt"
 #define TEST_MASK 0600
 
+/*
+ * On Windows the stat() function in the C library checks only
+ * the FAT-style READONLY attribute and does not look at the ACL at all.
+ */
+#ifdef _WIN32
+#define TEST_MASK_EXPECT 0700
+#else
+#define TEST_MASK_EXPECT 0777
+#endif
+
 static void test_io_channel_file_helper(int flags)
 {
     QIOChannel *src, *dst;
@@ -56,7 +66,7 @@ static void test_io_channel_file_helper(int flags)
     umask(mask);
     ret = stat(TEST_FILE, &st);
     g_assert_cmpint(ret, >, -1);
-    g_assert_cmpuint(TEST_MASK & ~mask, ==, st.st_mode & 0777);
+    g_assert_cmpuint(TEST_MASK & ~mask, ==, st.st_mode & TEST_MASK_EXPECT);
 
     unlink(TEST_FILE);
     object_unref(OBJECT(src));
-- 
2.28.0.windows.1


