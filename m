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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CFDC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1D0F2068D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnSvImZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D0F2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFiob-0001Kp-Q6
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFigq-0002Gi-St; Tue, 08 Sep 2020 14:50:00 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a]:39471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFigp-0002dD-8j; Tue, 08 Sep 2020 14:50:00 -0400
Received: by mail-pj1-x102a.google.com with SMTP id s2so60412pjr.4;
 Tue, 08 Sep 2020 11:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FykcAGlQ92KK8Qz4pGd0AfXWzqAA8073pCgMiQdYiFk=;
 b=EnSvImZ9ysIOoTeUW56fjqLNh69zqxHYNmBL5xDWPtpCezyxZ1Ly2nea85yjCKA4eL
 iaOyqeugTudpRXhIUgLcovXUToZlskhYSdCqnptdrEQtO9Y22rIcJvu0aNIlQ694PSPH
 eGVPwibkhPa8mimNCDHCEL6SB2NfG/E0FbE3h3zMHzcwsWy39jhOB+B6U5jep8UKU3AH
 HRWvgHHITTAZ4mpF0g0PDeXclc8cC5n4YH6zR2v6WPyflj4/0AS4xPrvYzZpxfj+AYP6
 fOT0njiEJ7OkS9iBnNjJfBdbfU3tv/IkhHI7B0gFLGlW64RQsMZxn2+m7Zen29P1eJcw
 0XAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FykcAGlQ92KK8Qz4pGd0AfXWzqAA8073pCgMiQdYiFk=;
 b=kXdDJxDoNIiEt0/2kHwZxbgHiUVDjNRa67i3yLCGmxlRz9pTJn+fsMo/wnAQ2QRO99
 mUeHASlWIcDK53pOlZoX/6R0wl4QpEYHf4pJSOWpixoUaXBSeLxU2iqFv6JOaEup8eW6
 zef0hCbaNSj9xgrEMotH4zb9oVsgooTyzPt2eZn4eYws1VFQTv6vUmf+fLoyDk7yh32o
 4QZ9Vr1MQ2PumPhWeUjr9mM2KR/aRNgacHMF2CTjuBxHMx/N+krQblhGhhg3mMQNbbRI
 4rXXzrDEUoc2ka3MhsvnlWpxcfEOnzzPI94/SsFHd/3WVhRLjpZ30iCGfn4qdUAScBzA
 xSKQ==
X-Gm-Message-State: AOAM532A126MvUXkeB1wHOeGsXIdlqbRXxNRVegdjweqpG+NIkGBioKp
 NjE20/KmmS+NhwYRSJnAxOafvyj28sHsUK+j
X-Google-Smtp-Source: ABdhPJyN9mtI1X6PPEQMIj+rHr55fCzNb5mtEv/p1xzJg/WeOkzCWfJPBCv6ZoJaqR1vBRJkH782aw==
X-Received: by 2002:a17:90a:414d:: with SMTP id
 m13mr181147pjg.163.1599590994692; 
 Tue, 08 Sep 2020 11:49:54 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 8sm43553pjx.14.2020.09.08.11.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 11:49:53 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/16] tests: disable /char/stdio/* tests in test-char.c on
 win32
Date: Wed,  9 Sep 2020 02:49:07 +0800
Message-Id: <20200908184918.1085-6-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200908184918.1085-1-luoyonggang@gmail.com>
References: <20200908184918.1085-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x102a.google.com
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
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These tests are blocking test-char to be finished.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/test-char.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/test-char.c b/tests/test-char.c
index d35cc839bc..80e5bac61a 100644
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
@@ -1471,8 +1473,10 @@ int main(int argc, char **argv)
     g_test_add_func("/char/console/subprocess", char_console_test_subprocess);
     g_test_add_func("/char/console", char_console_test);
 #endif
+#ifndef _WIN32
     g_test_add_func("/char/stdio/subprocess", char_stdio_test_subprocess);
     g_test_add_func("/char/stdio", char_stdio_test);
+#endif
 #ifndef _WIN32
     g_test_add_func("/char/pipe", char_pipe_test);
 #endif
-- 
2.28.0.windows.1


