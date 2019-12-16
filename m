Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32D2C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:15:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C43A206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lDJCgjql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C43A206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoL7-0005rI-O0
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1igoE8-0005My-OO
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1igoE7-0003k4-IP
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:48 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53108)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1igoE7-0003is-CK
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:47 -0500
Received: by mail-wm1-x342.google.com with SMTP id p9so6261133wmc.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IVVyJ2WnySPx9v78HV3GXr2KlEjRKr49Z+2VJrgBMpg=;
 b=lDJCgjqlS7kzMl4Z8OZc6casJCqhgfTfFyWX8ufk4eb5JS7duEix6i1097l3zLFoUi
 zTGNggT8ACsqrvrLSyRbiZWpZcW5N2XoUvygYSwJaKwmivG/d/2PLtNhvZpUwwrKdrny
 JMlabUv0j+Ir8WrMdgHukrX2xY9lcGpfG5V0EoD7/jjNNHaEgGRxRjc2/BnxICtMsKXE
 tlFXmOoNcdQpxvPj+uSwD0V1Mt3IXHgZiP7DUFvAhKKvHWr1rXPf3r2JdI+kDI0IzV1g
 z8vPxU4pVPeqE9Y9E82WNv0PorvgECVfFT8NvP0T8BgCUS1Hp/o1zuJcFMlNWop1tJhJ
 jI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IVVyJ2WnySPx9v78HV3GXr2KlEjRKr49Z+2VJrgBMpg=;
 b=lzve6fYc+6grVg3NFFvZEvSUS3pleGudL5Jr0s7x3F7fd6jCNJbLu2vbhM2IMGfLeG
 5QGx9F9C79J8IvZ9kXUcfM+IDjmkuwY3mcDwRXijM8A2gOB98CG03HYmE6hL3dpoax+i
 uLcWiTYYwkpjjFev/4jm4lXez9mswImCsOsxcJQ5HWQ7u8HY73GLI6ivhjK0RHSwby64
 2IVihzX5yAK5fCGzi5v++8LQybbNUAlUpzFR3sqZf/kHuUFfb1bjzmFCCIqUmNrPdJlD
 rGgc0h+A5YcojL0hcZPbNqjoiYFfZxWdE4nPCcLFhrqG1yiVRAuhguhakzejmPBVn+iK
 oQ5A==
X-Gm-Message-State: APjAAAUeBTdcpbeUQv1Q8F285QfLnuGOJAPwMt98fhYZtwHseG37fIGt
 iFSPsKOdY1H7CGhDjqgSwoIesw==
X-Google-Smtp-Source: APXvYqxgDPkbb5eL0DtAtLnKbIWmO1N5goEIUX4ixR8NAG6D2QIHlRorUPUvRkhi+ZlksQnINcodSA==
X-Received: by 2002:a1c:48d5:: with SMTP id v204mr27536137wma.88.1576494466383; 
 Mon, 16 Dec 2019 03:07:46 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k19sm19030689wmi.42.2019.12.16.03.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:07:39 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DA1DA1FF98;
 Mon, 16 Dec 2019 11:07:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 08/16] tests/test-util-filemonitor: Skip test on non-x86
 Travis containers
Date: Mon, 16 Dec 2019 11:07:24 +0000
Message-Id: <20191216110732.24027-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110732.24027-1-alex.bennee@linaro.org>
References: <20191216110732.24027-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

test-util-filemonitor fails in restricted non-x86 Travis containers
since they apparently blacklisted some required system calls there.
Let's simply skip the test if we detect such an environment.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20191204154618.23560-6-thuth@redhat.com>
---
 tests/test-util-filemonitor.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/test-util-filemonitor.c b/tests/test-util-filemonitor.c
index 301cd2db619..45009c69f41 100644
--- a/tests/test-util-filemonitor.c
+++ b/tests/test-util-filemonitor.c
@@ -406,10 +406,21 @@ test_file_monitor_events(void)
     char *pathdst = NULL;
     QFileMonitorTestData data;
     GHashTable *ids = g_hash_table_new(g_int64_hash, g_int64_equal);
+    char *travis_arch;
 
     qemu_mutex_init(&data.lock);
     data.records = NULL;
 
+    /*
+     * This test does not work on Travis LXD containers since some
+     * syscalls are blocked in that environment.
+     */
+    travis_arch = getenv("TRAVIS_ARCH");
+    if (travis_arch && !g_str_equal(travis_arch, "x86_64")) {
+        g_test_skip("Test does not work on non-x86 Travis containers.");
+        return;
+    }
+
     /*
      * The file monitor needs the main loop running in
      * order to receive events from inotify. We must
-- 
2.20.1


