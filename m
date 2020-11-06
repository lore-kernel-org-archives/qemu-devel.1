Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BB7C4741F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 04:02:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00102206F7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 04:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3oD8gE0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00102206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasxE-0003bz-TG
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 23:02:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <msys.mizuma@gmail.com>)
 id 1kaswC-0002Kj-Cl
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 23:01:20 -0500
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:46765)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <msys.mizuma@gmail.com>)
 id 1kasw8-0007wj-Nc
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 23:01:20 -0500
Received: by mail-qk1-x743.google.com with SMTP id h15so18572qkl.13
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 20:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gqfS0vPwdGL8iAJZCo8QndKP0BdrEuzesTZw/MhJeIY=;
 b=q3oD8gE0jDNZLWRhw4blrrUiT6l5zGWYn1JKVvVCjJ0aZ6Q4Dsms4csgVZhn7+idkg
 BDrpR/rWvahxfabHbrBtyMScdc9TnyYURiRjm7Wk204R8vk8c1nIhmOGdfbye5eOF3fR
 qrHFMe8PXe2ZenNsd0Dpj1rZj4uSPW8kLuof21dkhyIpPXX/x/ATA60z37LRDHjS2axh
 CgLlJmpTftBhIhQy6dSlTbshAF4xr0zx/GRcLcY0k4mBwwjx8bGEn+mB+R+48aIx1kwI
 /441oAAoOLRYHMijRgTDdxPQ9fqOvJ0TIyYplucbt9J3xffFKh+ZqHK+nfhnC6OahT5W
 GFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=gqfS0vPwdGL8iAJZCo8QndKP0BdrEuzesTZw/MhJeIY=;
 b=qbyGsXCHlgvfmrW0mwsy7qfR3rm88z+BJJ2IbsUl5vx0dvmXV9SK8CItmppla1N0V/
 ydQhXKVeAkGlWT0YNcJqu9CX3KedED7oQHTQ24jtBM0IwKrK2PT8CXH8RTmqV8+8SaqH
 OmfKgNjepVEHB7X4ywCuHie3Un+ds2Q2RHmrTPbAkozkvxZPqF8TkoB/ifeQP8ELe7e3
 5D/xUfYJvJJ8ofkz4sKf1isVlLpbI6DOTT+Ptb7Hl/yT4BImjIZU46ldMdpv5e4TqD0Y
 0HWcgE8SfCi3eCPmhwS4UyDcGsN9HsKBFuf+BSl+eb1kW/oD/ZjQOCQZ5uFZ98rtg9T8
 yA4w==
X-Gm-Message-State: AOAM532Ece1S9lyrqMLeAkiyD5nHs22tFj39ZbjlalZVLj716dbyWsm/
 PkvBVO3jWG+sWm/iz9/GLEXjUHw1Ng==
X-Google-Smtp-Source: ABdhPJyMrYV29DjQvBx0iLIDMWKXyQ0vzPpa2cyo1iaQyJso+ldkSETojadSb3UoP3JswlPnnej0nQ==
X-Received: by 2002:a37:e213:: with SMTP id g19mr5376725qki.147.1604635275566; 
 Thu, 05 Nov 2020 20:01:15 -0800 (PST)
Received: from localhost
 (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com.
 [209.6.122.159])
 by smtp.gmail.com with ESMTPSA id x22sm2495885qki.104.2020.11.05.20.01.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Nov 2020 20:01:14 -0800 (PST)
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] tests/test-image-locking: Pass the fd to the argument of
 qemu_has_ofd_lock()
Date: Thu,  5 Nov 2020 23:01:02 -0500
Message-Id: <20201106040102.13892-2-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106040102.13892-1-msys.mizuma@gmail.com>
References: <20201106040102.13892-1-msys.mizuma@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=msys.mizuma@gmail.com; helo=mail-qk1-x743.google.com
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
Cc: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
 Masayoshi Mizuma <msys.mizuma@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Pass the file descriptor of /dev/null to qemu_has_ofd_lock() because
former patch is changed the argument.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 tests/test-image-locking.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/test-image-locking.c b/tests/test-image-locking.c
index ba057bd66c..2b823e1588 100644
--- a/tests/test-image-locking.c
+++ b/tests/test-image-locking.c
@@ -144,14 +144,19 @@ static void test_set_perm_abort(void)
 
 int main(int argc, char **argv)
 {
+    int fd;
+
     bdrv_init();
     qemu_init_main_loop(&error_abort);
 
     g_test_init(&argc, &argv, NULL);
 
-    if (qemu_has_ofd_lock()) {
+    fd = open("/dev/null", O_RDONLY);
+
+    if ((fd != -1) && (qemu_has_ofd_lock(fd))) {
         g_test_add_func("/image-locking/basic", test_image_locking_basic);
         g_test_add_func("/image-locking/set-perm-abort", test_set_perm_abort);
+        close(fd);
     }
 
     return g_test_run();
-- 
2.27.0


