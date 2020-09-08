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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B119C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 15:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E6D922B51
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 15:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUTqAVf0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6D922B51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFfIG-00037J-2S
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 11:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFfHC-0001yz-GR; Tue, 08 Sep 2020 11:11:18 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:36303)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFfHA-0005jm-Qm; Tue, 08 Sep 2020 11:11:18 -0400
Received: by mail-pg1-x541.google.com with SMTP id m8so4956184pgi.3;
 Tue, 08 Sep 2020 08:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NnBwIumxkiQ9pXVAp8TmFXF/H8dsT5OnHNvh40zg8GM=;
 b=aUTqAVf0xcnhLm5LdCw/3Yl8J3FZAYlcM1wHA4Ly20G9WlSmMpddUMWzi/yQp0AabM
 aBGYTD0GO/3v+cUTVIslTQKGH1we0e+TJCqIxODSAg+DIaS+dSgwxqgtQcaadZTuZgkB
 evwWPAuXc18otDjIFOgTxyLS/i+yVmD6+YZx18PNTxjcXQ4XyHO3i6gLnt97duxru96c
 jMfYAULc3IxLhDfCKrJPHT3TDPSpPvmtNwlibOGv3tS6i2SLOB5pN/KBdWaEfhYLzADr
 Fm6IPigLmTsK8ehQPyO8k8SydD/0KozCRJJ4kjx7d3KWctmabpAcyVtxMZTDcbtbNpZS
 f20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NnBwIumxkiQ9pXVAp8TmFXF/H8dsT5OnHNvh40zg8GM=;
 b=Ntf//RVYoBbgN1G5UmdYGoNDK2epLCyi0PBRfca12xNteF3zQHWcZTISm9BTfA34B5
 CMZ4yGaZBCWSROvwsl/y7Pf1DPLOwCSsXaGCTTDW5GnZY4rwHLhuZFGjVh0uST4CnFIG
 ErX3qBjR5C2lfK8+DDBgdrEyyBnXUkiEfUtE/TO9SGXFED6QWoNOlpGKsvsAH7PLYGgB
 TBT8DkLTwAp0Rj0PgB7lCILbW6Pp+8ZiWu7bLUEHsK81Af53acCNAMzwhPx0Fe9CQ6Dw
 HK6tSOwVtP3KruT+6u8N3ihuEz+jeojYXim4hNMLJCb6RJVRdleHtN46gtuwBE830Zau
 O5TQ==
X-Gm-Message-State: AOAM530TM4KNBn1o1QdBGedki9TzcWyX1ruAp3/HZhHhAyIu4jaKkHc7
 kHasVlaJ4UBtx2X9sbpT0htDlEhxA9vdtwrl
X-Google-Smtp-Source: ABdhPJxAoU7RoiC4IFWY2lz92+ZxMDnoiscX+pYeT3t9AVEWdT0UeLYPG+FZiRILbbQjtLoIjGT04g==
X-Received: by 2002:a17:902:8c94:: with SMTP id
 t20mr23805794plo.76.1599577874581; 
 Tue, 08 Sep 2020 08:11:14 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id k5sm29436469pjl.3.2020.09.08.08.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 08:11:13 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/2] logging: Fixes memory leak in test-logging.c
Date: Tue,  8 Sep 2020 23:10:51 +0800
Message-Id: <20200908151052.713-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200908151052.713-1-luoyonggang@gmail.com>
References: <20200908151052.713-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x541.google.com
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
Cc: Juan Quintela <quintela@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 Daniel Brodsky <dnbrdsky@gmail.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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


