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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09238C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:56:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8E0920658
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVrMSeRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8E0920658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFjiv-0003uu-Ox
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 15:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFjcd-0007Dd-Og; Tue, 08 Sep 2020 15:49:43 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFjcc-0002Z5-3c; Tue, 08 Sep 2020 15:49:43 -0400
Received: by mail-pf1-x443.google.com with SMTP id o68so169932pfg.2;
 Tue, 08 Sep 2020 12:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NnBwIumxkiQ9pXVAp8TmFXF/H8dsT5OnHNvh40zg8GM=;
 b=bVrMSeRQ1oJyHgTsyvccvg7Eys2QNfVoit8TIHv11obq3zBlAnFtY9jQtUptzWSfNT
 ZpgijD3Hpx9e7C6s1+mqrlTX2dBE3VfliItg0evYCeQguej3+sXeptYAtjFuWGUBWEij
 HonDhHRsx6PRr/mDSDbTsRwn2i9n/TufGWVZgOdMwc2x6JvqlxKAHbVi/ANSrQkg/bB6
 NZogTh+WfUoxm5a7v4wwL5pKELEGWJDRmyQrhMofjj5VWTUPLnHkHXwsp1R/6E29LW5e
 h8sJ6kheb4NzLBcglEGW9wdylU5uNjf5W51I50GWCNsgU8y6QMFVt8JhVqFaVFtCUxdD
 SKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NnBwIumxkiQ9pXVAp8TmFXF/H8dsT5OnHNvh40zg8GM=;
 b=uBSk4EEgHupuXnaJ7jsdwanvqYYKI1+/+dmhbmEtn492I6fT7IWhe0KENSKWU+LU+u
 rOt6AFEXdfiCH2/sd5B8793vDQ4vraYLtnxbqkn1fiySoKsNW1k3isUQiNE0HBdY+WQ0
 ZbpK/Jvj3zQOO76WsgpsJdcTfyrpnpQYdJuyWkVGK3f2DCd9MgekdoqGukd9BkTSaCgN
 LFyidFFbEf1D78qXjSvLcRJlcyWPwhem5JTixL/4G+k6kbLasifCBdTKC4m1sHkMH2wP
 qxqe2aQdzQM2Z0rYQF1rWQDBpIeCw0R3p+GAlNPOBW0r0Tm9BvKQlvUS5e7Wd1OiUpqL
 /KjQ==
X-Gm-Message-State: AOAM5337Sd/Lp0IrVpM9P2h5LRRAgFMtQ+YNVLJVbTj7JrQ2TMvVf9X+
 h1yXBqD4a4389Z2wmCQ0xQ3Au4BA9keu33P4
X-Google-Smtp-Source: ABdhPJxECESF3wPXCyYYQUzIWk2HMf16oIUBmW2M6gkpxRjx2wzUqMWQgcm2J4OUwRb7QFkDIcxTug==
X-Received: by 2002:a63:fa10:: with SMTP id y16mr271272pgh.304.1599594579828; 
 Tue, 08 Sep 2020 12:49:39 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id n127sm216922pfn.155.2020.09.08.12.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 12:49:39 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/16] logging: Fixes memory leak in test-logging.c
Date: Wed,  9 Sep 2020 03:48:19 +0800
Message-Id: <20200908194820.702-16-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200908194820.702-1-luoyonggang@gmail.com>
References: <20200908194820.702-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x443.google.com
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
 Wen Congyang <wencongyang2@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

g_dir_make_tmp Returns the actual name used. This string should be
freed with g_free() when not needed any longer and is is in the GLib
file name encoding. In case of errors, NULL is returned and error will
be set. Use g_autofree to free it properly

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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


