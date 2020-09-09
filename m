Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C8CC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:56:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6927215A4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHVFHbfk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6927215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFwqT-0006c8-87
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 05:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwhd-0007LQ-52; Wed, 09 Sep 2020 05:47:45 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:35436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwhX-0007mP-Gw; Wed, 09 Sep 2020 05:47:44 -0400
Received: by mail-pj1-x1044.google.com with SMTP id jw11so1086484pjb.0;
 Wed, 09 Sep 2020 02:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8S8LCq0vzh09WirR5+SRleiM+m06nOYh6OfHaB3TjgI=;
 b=QHVFHbfkRsdPSv37curnQ32C7mlhImkKmvTfHTLHkBBWdOkcU35r0/sKAAR+gfhiKK
 ePU6Lsb6kElFW2aUmR0eEBZDEDYAmQDwOJ8Skyonjahw6T4WX4vE12JEEzVvIyb50xFO
 o8g6cUFqKkziCTBeN+MBh0mrR1FtpQWE6L86lFYM8QTT8Zcy4MMyvHHEXXOFft8uyaXT
 IQNTFFCddE/NTDpuYsicX7t+/WPLm6MG8hR8oMHTt8nLhAfVlhPUQyI0RHig4Iol0Opu
 NiG4hSSDVCRQCqKv0PqtWWx9SWqd7EhUFTeiWhplrlFhsOSd51cJbiGo93s/ErY9RMf5
 3f/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8S8LCq0vzh09WirR5+SRleiM+m06nOYh6OfHaB3TjgI=;
 b=anBfq/PrLr2p8HYGIaKDp7ITkqaIgniYPvLEjUIApOnotSPqiPi2ZizYtnT79l+UtX
 JWi/ZWB9T8UvNHjpUbfgIpH3cT6mzWyWfHvbWe9k9wgR1IPK/SANbj63b8c8bloygvE5
 VTuqnRKCm6d/A9lblkAO4ktEYYuWMvNkxy7rLA/rRv7sOSteGoc2RF98IYj3Nl7nif9O
 AJhrYuQszRe2R6IpIW7DINz1AK0pSHt5lTBbfrR7lQMYmJXPIWRLcz+dFLwBJTV4MO67
 IWdTQmRV/FelQcBmr/Kc2rUb9jTY0bex/iNCFGu/j+fiBdKrgJYBpp34DOWgegKCSMNw
 kQtw==
X-Gm-Message-State: AOAM531D5kWWBoW8nPp+ctNk5sy00rVzjcU5We923tS+6ZyCSTaeeLsn
 5mdps9kkgFozXS1NXU5M7NEy1zt12yZ7KR+q
X-Google-Smtp-Source: ABdhPJwKxtD3JKLpSULe5IyfuMvqgMWxvb+kppkNNSOX7stOty4L6jYiB1/K9IHnlhq6BNI6rG5n4g==
X-Received: by 2002:a17:90a:7f8a:: with SMTP id
 m10mr108458pjl.47.1599644857477; 
 Wed, 09 Sep 2020 02:47:37 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 64sm1708312pgi.90.2020.09.09.02.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 02:47:36 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 15/21] tests: Convert g_free to g_autofree macro in
 test-logging.c
Date: Wed,  9 Sep 2020 17:46:11 +0800
Message-Id: <20200909094617.1582-16-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200909094617.1582-1-luoyonggang@gmail.com>
References: <20200909094617.1582-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

g_autofree are prefer than g_free when possible.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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


