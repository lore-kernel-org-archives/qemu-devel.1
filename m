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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EA0C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 06:16:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2C3B208FE
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 06:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxGVonQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C3B208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFtOw-0006Zl-RE
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 02:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFtOP-00068d-1V
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 02:15:41 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:37463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFtON-00066N-DZ
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 02:15:40 -0400
Received: by mail-pf1-x442.google.com with SMTP id w7so1239932pfi.4
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 23:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/5O7xuk/6i/kOVxMKHIsquRCapEjfrBOR1b2/a84soI=;
 b=BxGVonQyacF2cifydJEF/zJZZkc9yYvUQIq+QvezhngH3jKrMq9HhdICufiWGHW3r7
 y4NQ8IyL4g/HZlr9igZ1FH+JrwxnW9JR54Rg7GH47TPWMktVnaSvvHCD8toN9VjgpnuZ
 SQET/xoupcbTC+Vpy8dcZEoMEq6Hw5xZhVP1L3vlvTp3aVF93AGgCP3KG624zenRBpYp
 mqoooCZwDRKT93WAvOgwYG29RTqTlmopQB2UyUWySzMtfcHkWSxWFxLUM7/Oetuzlhq4
 vK4nQOsj2E6QKvZN7Pa25+MFGhYamufW5z4ds+OeAZHTJ3xPdAzyqajwgunbJHl5svHU
 je/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/5O7xuk/6i/kOVxMKHIsquRCapEjfrBOR1b2/a84soI=;
 b=rxWCJn0kL73rcwV8iBci4gzeo43nC84C0n9CIm/pjDj31EBZo16aTHtlwa/6kkGo09
 cg/APQAz5dw67dsCtazJ9+AXe1mB0YRY/FN0zdS1JdztFVy9pP9kvlkUs+kq5e0a2l5T
 wRMxk+kagOlX/djeA6AK+iCHzjUY7Ayauv+Y+YhcfOzWy0avFJL6TK+RfP1CPgMfE4yk
 u388FAd6U5j9QaqjKO4NkSECikJa0XycBMK/XXgRRmY42SBZEr1NZVlJVsYXTTDbfWHL
 n0BoJLQvy/TEFAFQZVhoq+QHHWooWmo31ZenZsO+Gy9+VXxbD6P4P95wdeoBulAx7DHj
 89Wg==
X-Gm-Message-State: AOAM530EJ9AXU7UjENUo0zBC3aGnV1qt6V8EQXSZvX81xccuIUDDSNQc
 BsQOVl8tZG+fyB6BAO/5UU60YtzM6pZcd1Zo
X-Google-Smtp-Source: ABdhPJxbK5gnR3W0FsofW93TLswJ59TiDVe8nzNrJwLKEQWuomSZv+SDT1Y0i2z3f494aAR6tBXkKg==
X-Received: by 2002:a62:c2:: with SMTP id 185mr2141285pfa.11.1599632135276;
 Tue, 08 Sep 2020 23:15:35 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id l5sm973113pgm.80.2020.09.08.23.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 23:15:34 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] char: the test-char.c are stuck randomly on win32 at function
 char_socket_client_test
Date: Wed,  9 Sep 2020 14:15:20 +0800
Message-Id: <20200909061520.1324-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x442.google.com
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The line I modified is the place that entering and line exit.
And when step into the function main_loop_wait(false);
the stack-trace are like this:

NtWaitForMultipleObjects (@NtWaitForMultipleObjects:8)
WaitForMultipleObjectsEx (@WaitForMultipleObjectsEx:59)
g_pattern_match_simple (@g_pattern_match_simple:221)
g_pattern_match_simple (@g_pattern_match_simple:336)
g_poll (@g_poll:207)
qemu_poll_ns (c:\work\xemu\qemu\util\qemu-timer.c:350)
os_host_main_loop_wait (c:\work\xemu\qemu\util\main-loop.c:452)
main_loop_wait (c:\work\xemu\qemu\util\main-loop.c:520)
char_socket_server_test (c:\work\xemu\qemu\tests\test-char.c:862)
g_test_summary (@g_test_summary:353)
g_test_summary (@g_test_summary:247)
g_test_summary (@g_test_summary:247)
g_test_summary (@g_test_summary:247)
g_test_summary (@g_test_summary:247)
g_test_run_suite (@g_test_run_suite:54)
g_test_run (@g_test_run:9)
main (c:\work\xemu\qemu\tests\test-char.c:1563)
__tmainCRTStartup (@__tmainCRTStartup:142)
mainCRTStartup (@1400014f6..140001539:3)
BaseThreadInitThunk (@BaseThreadInitThunk:9)

I submit this patch is looking for reviewer to help me fixes this randomly issue

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/test-char.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/test-char.c b/tests/test-char.c
index 80e5bac61a..207004f38c 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -1065,6 +1065,7 @@ static void char_socket_client_test(gconstpointer opaque)
 
     /* Wait for the server to go away */
     while (data.event == -1) {
+        /* This is the place getting stuck */
         main_loop_wait(false);
     }
     g_assert(data.event == CHR_EVENT_CLOSED);
-- 
2.28.0.windows.1


