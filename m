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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2277AC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96AA1208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVTNEhXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96AA1208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEka-0000ww-Ks
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEWy-00006l-4y; Tue, 15 Sep 2020 13:14:12 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEWv-0002jn-DR; Tue, 15 Sep 2020 13:14:11 -0400
Received: by mail-pf1-x444.google.com with SMTP id k15so2295824pfc.12;
 Tue, 15 Sep 2020 10:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xbLEoF58D0tbgLJVVq5i1Stm39rTFIriYnuaDpYR+rE=;
 b=iVTNEhXMG+bRZESTBYZsOV+SeL1rGr6PS5e1uglyXscZlQbzAoEwZNzyo1HfcGukXH
 6g71QcC2ypIGPFJv9jFE69wKpCHhCufo/LPH1JsplLStUQZ96HjkZKQixmulUPa0Qvvy
 Nz2AllzRK4ZC+bLTs3k89XhPf0oiB6K8lqbFEPz9CsAjV/nrxLy13mzw1hkqVziUmt+V
 rqWDENh7/w8vWvgwX4ByDQeEcUJoT07epQeZxMVsXA5zlHGWQ6i/FOyL5hP1BHtR6uMm
 voz5JcfDj2FHsj70+8uiVRe8wcde9SOnLx7A2RJL4cQo5UHIbaTNbmZ9yIB0EbL4NGHs
 LVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xbLEoF58D0tbgLJVVq5i1Stm39rTFIriYnuaDpYR+rE=;
 b=g4kJtZYuO6HzkqeeUGNEh7HDUa+rsSlut/6zM2IlEjLbtwmTXz2NgoP5xSLZgWm2/H
 N5uS+uD15uAEIWHV9uZqORcFkci2t1hCE9/67QwjDDNWh99EmRFJR6io70cvnFiXrhb2
 agNKzOd1PXhBgFElTUhRr9NnkQSAwwQnytmSpiN8GgQH2tuY+NYJq1UfTcyDsiue1q1V
 miPlBGFanwElJKdNl6dwP8jTh08kwwLPLym5Gq6bZmLXEzVAUVW56a90AiK/w+C9+Y6j
 8j1Ed+FCaI12Oqd2/S0SJWvGzdJed1+V8/okdouPur6+4sBJsHL0C4Nt4zmoa7+55EV7
 Vp3A==
X-Gm-Message-State: AOAM530Oa/9Q+zO2IlV+8Lj7a7iS4+rb2a7F8E17yXteaw7BDgvgNpx3
 Uz+PvZZSX8seAIFIe9ChfJWq+1dAjSmS7yThnUo=
X-Google-Smtp-Source: ABdhPJzibWTPBroSY9dCwgfmTmEbO7hmur3M9u69JcqpQFdXr2JTXJ04mkZV0aFdrau8zw9YcsgXdA==
X-Received: by 2002:a63:3046:: with SMTP id w67mr15184957pgw.45.1600190044765; 
 Tue, 15 Sep 2020 10:14:04 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id j14sm124046pjz.21.2020.09.15.10.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 10:14:04 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 16/26] tests: Convert g_free to g_autofree macro in
 test-logging.c
Date: Wed, 16 Sep 2020 01:12:24 +0800
Message-Id: <20200915171234.236-17-luoyonggang@gmail.com>
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

g_autofree are prefer than g_free when possible.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/test-logging.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/test-logging.c b/tests/test-logging.c
index 8a1161de1d..cec18b31b4 100644
--- a/tests/test-logging.c
+++ b/tests/test-logging.c
@@ -196,7 +196,8 @@ static void rmdir_full(gchar const *root)
 
 int main(int argc, char **argv)
 {
-    gchar *tmp_path = g_dir_make_tmp("qemu-test-logging.XXXXXX", NULL);
+    g_autofree gchar *tmp_path = g_dir_make_tmp(
+        "qemu-test-logging.XXXXXX", NULL);
     int rc;
 
     g_test_init(&argc, &argv, NULL);
@@ -212,6 +213,5 @@ int main(int argc, char **argv)
     rc = g_test_run();
 
     rmdir_full(tmp_path);
-    g_free(tmp_path);
     return rc;
 }
-- 
2.28.0.windows.1


