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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5951C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:29:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 897D0206DC
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biHIMGS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897D0206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIA5s-0002Uv-Ku
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 08:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9rL-0001RN-6C; Tue, 15 Sep 2020 08:14:56 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39598)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9rJ-0008IB-3Y; Tue, 15 Sep 2020 08:14:54 -0400
Received: by mail-pg1-x544.google.com with SMTP id d13so1886689pgl.6;
 Tue, 15 Sep 2020 05:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8LMHSaPzW0hzgrIuj2ua/jt2cvPDmkrSyzCQ3oAKLyw=;
 b=biHIMGS6AUChj1Czn1FRvISeqJYf+hTbjKLcP7bQwdTE91OE39FghWrXxri1McM1iT
 G6gNK/mrR8H152hRT20/i9PZMxiOAHtjf2bDVLyL0Al820R6qcdywELu0WUkw8PByOBU
 JGNtNhiK5PikY1eTYr4YiM9KABuBWSHa3ycHTGcPvN2hD4HBrSFwJZ7iU72eM0X3C5QV
 264FDVLua3f1pVIEOVYtdGBnSIAP32uCmymwOqrEdSJbuu/+IW53lbSplMsZM7EwrQW+
 F1nCYpyaAiA8eSr/TtA/4Mw+deJF+bIPsY0FQPTcbPpFwQCvfdFwkQJDd3OVbf0Zr1qG
 Gx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8LMHSaPzW0hzgrIuj2ua/jt2cvPDmkrSyzCQ3oAKLyw=;
 b=RBUmvaaY6d/NIHunNAEZZ2wihXWnz4JV1Yk5MRLCb+JDAELGvjg12LvyawV2bBF5WD
 ebfYC5S75SDbGvU2m005qntNyUPqPmD6VgrfUBNHgE/QcMUiQ5knbt5tVS5Pvl1gmyZq
 esWWiIOIIh34Av4fjcsSIIAUbobuo2Nx2G9WGOQQTQKKkGmBZIsIZlC81ShJ1OPqEOLb
 NLF6S/ZhVabj0T5XJ7vtBS+kzfJSp4AnUJlB6GRZsYYtJipFaLIEOavqYCRCEP++s0Ag
 54PT+t6HssO/60VRHSZqnqUNsLKWb/Ow9XEzp4SihOaX3QFa3BCw+zu7R48nlINCbmA8
 BjNg==
X-Gm-Message-State: AOAM533PgQQwRzClNyLZuoM0+XCXGf+LDHPEjh1o5ZIg+I8eJeC2laq9
 UgZY+xoail1ConKyVTZHeNQiYnsU3ZXldlG9LYU=
X-Google-Smtp-Source: ABdhPJxaC4MoxRFEbFJq/mTw7qXEKnuuqctg0eNoPhLbUsH5kmWRsCcdgZ8W3KeJimUnBkFe0tjL0w==
X-Received: by 2002:aa7:99c7:0:b029:13e:d13d:a056 with SMTP id
 v7-20020aa799c70000b029013ed13da056mr17610322pfi.28.1600172090242; 
 Tue, 15 Sep 2020 05:14:50 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 k28sm13683061pfh.196.2020.09.15.05.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 05:14:49 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 16/26] tests: Convert g_free to g_autofree macro in
 test-logging.c
Date: Tue, 15 Sep 2020 20:13:08 +0800
Message-Id: <20200915121318.247-17-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915121318.247-1-luoyonggang@gmail.com>
References: <20200915121318.247-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x544.google.com
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
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

g_autofree are prefer than g_free when possible.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/test-logging.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/test-logging.c b/tests/test-logging.c
index 8a1161de1d..783fe09a27 100644
--- a/tests/test-logging.c
+++ b/tests/test-logging.c
@@ -196,7 +196,7 @@ static void rmdir_full(gchar const *root)
 
 int main(int argc, char **argv)
 {
-    gchar *tmp_path = g_dir_make_tmp("qemu-test-logging.XXXXXX", NULL);
+    g_autofree gchar *tmp_path = g_dir_make_tmp("qemu-test-logging.XXXXXX", NULL);
     int rc;
 
     g_test_init(&argc, &argv, NULL);
@@ -212,6 +212,5 @@ int main(int argc, char **argv)
     rc = g_test_run();
 
     rmdir_full(tmp_path);
-    g_free(tmp_path);
     return rc;
 }
-- 
2.28.0.windows.1


