Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D2EC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:14:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91CAF21D47
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5I7xPeq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91CAF21D47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFcVc-0005HC-MZ
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 08:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFcSU-0000GE-9L; Tue, 08 Sep 2020 08:10:46 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:36541)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFcSS-0005bm-Gu; Tue, 08 Sep 2020 08:10:46 -0400
Received: by mail-pj1-x1043.google.com with SMTP id b17so5793305pji.1;
 Tue, 08 Sep 2020 05:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j17zuiaUdGHjZ6HaKD51lqXmkK/V3ZfOk3mrKeguzbk=;
 b=e5I7xPeq+l0JoG1l/B+j/qxSxIQQKWMcAmvJEQE+UKHOxoqvSHS/qBROMxHG1VZ5hM
 WTB3/8GE1eKRGpGSHMfh4rhJC92tA1gOaa6rXT66HzCsTo0Dc+qwNIP3KxeWH3DT2SB0
 5VqHHK4dZlqZeiv514jjWqy5AyXllBAgvormhmTBz9JWI5Z2bHDzyyuj/VXaZ4JMjpX0
 cSv+aPTnMlrJvso+6tZmHs9L7FI0ypljsMO75en5aYnrFHBn+5T69ntt9+HZ4NIWu/S2
 H+VRz1m4PHp+E+yCgcUPIyuHXo6loqunbU7Mgwwt2d66FYVn8OmXjDtXYcVpzfsuxEVq
 uhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j17zuiaUdGHjZ6HaKD51lqXmkK/V3ZfOk3mrKeguzbk=;
 b=gQ2Os0WoqAUKJgAKmqGjOwWpoZAvpSN2qgeQmwzOKrG1sK9ybZ9hX+6DS1xNMB15Yc
 Ubeyz8Ye/IA/ckfRxGOk+TSa63BCSnecs70uruoSOqPQZ77Py2DLFrs9maYBhchmllYH
 n3QyZPDEQQGI6vU/W+t75Nya7T5BXTDX/ST48NUBHs3VBi0ciK8nN9VnB/C8iPeYgDJi
 a8oJAlZmrnJfp7z3TXa0SDViA5XdTjuAxJLOSPXD+iG/HM5wycKlumAIRU4+NRJYnmV3
 oidNxgQnARUHNbNExdgcstcX4wr8SQa3oHxg+2sy3EQEz1Rs1ItM4frM30TjY5nHB+mX
 Wd+w==
X-Gm-Message-State: AOAM530t9Wro4iZ6BfC6f9BE8KqtJp2V4ynHUGwF6uxlbn5ZC+IGqGxl
 3LG06hZCJsIGOo/iR46CIFmL4ekyzx8XM9Gj
X-Google-Smtp-Source: ABdhPJzte7D7H75KOUmnCzhgl2UQ3nWgUZTRx9ZksXN5oW8PK1BxKyhO68c8h5kt2JdMAPbRd/Yulw==
X-Received: by 2002:a17:90a:ad8b:: with SMTP id
 s11mr3692086pjq.40.1599567040503; 
 Tue, 08 Sep 2020 05:10:40 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id
 t15sm18731657pfl.175.2020.09.08.05.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 05:10:39 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] logging: Fixes memory leak in test-logging.c
Date: Tue,  8 Sep 2020 20:10:21 +0800
Message-Id: <20200908121022.11-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200908121022.11-1-luoyonggang@gmail.com>
References: <20200908121022.11-1-luoyonggang@gmail.com>
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Daniel Brodsky <dnbrdsky@gmail.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

g_dir_make_tmp Returns the actual name used. This string should be freed with g_free() when not needed any longer
 and is is in the GLib file name encoding. In case of errors, NULL is returned and error will be set.
Use g_autofree to free it properly

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/test-logging.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/test-logging.c b/tests/test-logging.c
index 8a1161de1d..957f6c08cd 100644
--- a/tests/test-logging.c
+++ b/tests/test-logging.c
@@ -196,7 +196,7 @@ static void rmdir_full(gchar const *root)
 
 int main(int argc, char **argv)
 {
-    gchar *tmp_path = g_dir_make_tmp("qemu-test-logging.XXXXXX", NULL);
+    g_autofree gchar *tmp_path = g_dir_make_tmp("qemu-test-logging.XXXXXX", NULL);
     int rc;
 
     g_test_init(&argc, &argv, NULL);
-- 
2.28.0.windows.1


