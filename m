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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC190C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:48:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FF8621D79
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFJsgCbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF8621D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFwiT-0000LQ-5u
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 05:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwgs-0006jJ-T3; Wed, 09 Sep 2020 05:46:58 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:51311)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwgr-0007gS-8W; Wed, 09 Sep 2020 05:46:58 -0400
Received: by mail-pj1-x1042.google.com with SMTP id a9so1071077pjg.1;
 Wed, 09 Sep 2020 02:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QPOpSG9Zo5ax6O+oTlvoQEKu10ulnbdfFW/pj17nxUM=;
 b=IFJsgCbr696oMGcFoMiuw94twVJ0hxIZIxqJaTRRkVwT28XFw0ctJfF50N6GbE868Q
 6IqCHwKum1aVEmEuEwG18BLJrD+dXglRHBTHtKFOabAg/9MQ7hpaaECI/cTd00TX3PLM
 LQytcWEkKKDKVEeLWlZmrNyUeo2n5urKYu08N4DSpYY1TA1RP4QYsd+2GV8tNCbVZ14R
 nZUDxDvaDhe6ma1qyBVgGmYDDJLIDj/EPeoPO331aRQOu2IxBxQw3+K20HdAhZTI9YW5
 cMW37z1JgHpGScyC5ylWcCmS94Rv70xzbfoED8unl35kxzWP6XTtoP8+78hPbFaZXKfi
 Uqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QPOpSG9Zo5ax6O+oTlvoQEKu10ulnbdfFW/pj17nxUM=;
 b=S2A1G8SofIkGalaAdBPtYqaTZed17I35jlckQu2OV/+C6Pr7AqBWiNYOOPtxS7Px8y
 kTOUkLZ8v5KwW7oGlYJ7HAHn/3cdNmcIIdFAggaZB6CegTgw9PsGDYkE3KbT9qCNbieV
 Z4IZXaarMxzUJL2oCWgk9UgWrHgc3opNvxuW9JQA4z6pW7kF0rNcPc0MU59696AiOmkt
 vI2ztz2wf/5aw+PDu5dRf9hs9Pt/5qN3yIs5GRuwk6O0nMKPel4CbGikTl1G+3TOc37t
 ma3rgGoUQv4O5YeUYAFq8ofCseQfL1RdBqv8YrNi9K0l3wvqxQSA1Zzn4HZGiuUSK+uy
 aqSA==
X-Gm-Message-State: AOAM532YK2PPhGLPM0vA1x+uCqcxWs86+VOTFZAsZYSQpwVIqASPhQTf
 0RlJIGz5Py9eRJvhd/af0tKJHX2LFdmyCQ0e
X-Google-Smtp-Source: ABdhPJzBNbrqC4gJ0/fzYXe8BK/zG6edytANrC2VU8cHxHNRFgQsFXTzKVPKo+J/SdmwNOOjLvQGjQ==
X-Received: by 2002:a17:90b:4b82:: with SMTP id
 lr2mr111870pjb.184.1599644815180; 
 Wed, 09 Sep 2020 02:46:55 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 64sm1708312pgi.90.2020.09.09.02.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 02:46:54 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/21] tests: disable /char/stdio/* tests in test-char.c on
 win32
Date: Wed,  9 Sep 2020 17:46:01 +0800
Message-Id: <20200909094617.1582-6-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200909094617.1582-1-luoyonggang@gmail.com>
References: <20200909094617.1582-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1042.google.com
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
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These tests are blocking test-char to be finished.
Merge three #ifndef _WIN32

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/test-char.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index d35cc839bc..ab037647bf 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -103,6 +103,7 @@ static void char_console_test(void)
     g_test_trap_assert_stdout("CONSOLE");
 }
 #endif
+#ifndef _WIN32
 static void char_stdio_test_subprocess(void)
 {
     Chardev *chr;
@@ -126,6 +127,7 @@ static void char_stdio_test(void)
     g_test_trap_assert_passed();
     g_test_trap_assert_stdout("buf");
 }
+#endif
 
 static void char_ringbuf_test(void)
 {
@@ -1471,15 +1473,13 @@ int main(int argc, char **argv)
     g_test_add_func("/char/console/subprocess", char_console_test_subprocess);
     g_test_add_func("/char/console", char_console_test);
 #endif
+#ifndef _WIN32
     g_test_add_func("/char/stdio/subprocess", char_stdio_test_subprocess);
     g_test_add_func("/char/stdio", char_stdio_test);
-#ifndef _WIN32
     g_test_add_func("/char/pipe", char_pipe_test);
-#endif
-    g_test_add_func("/char/file", char_file_test);
-#ifndef _WIN32
     g_test_add_func("/char/file-fifo", char_file_fifo_test);
 #endif
+    g_test_add_func("/char/file", char_file_test);
 
 #define SOCKET_SERVER_TEST(name, addr)                                  \
     static CharSocketServerTestConfig server1 ## name =                 \
-- 
2.28.0.windows.1


