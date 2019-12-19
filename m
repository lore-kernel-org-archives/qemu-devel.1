Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B0EC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D7B24650
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I7TgzPE0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D7B24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtTC-0007Oy-Oi
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 05:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtNL-0006gm-RY
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtNK-0000CL-MV
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:47 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:35736)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihtNK-00006z-BP
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:46 -0500
Received: by mail-wr1-x42d.google.com with SMTP id g17so5493194wro.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 02:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q6QACTT6MNs1QawRF/X6ryVYhQD/X9R+o2LVrD4Tw14=;
 b=I7TgzPE0szFXokiwAgTKTkzrbZlqX49gLuMLtx84rOsOV0Fmev+rmvopGBVxFnZMSJ
 ofTsAkyx1sdEgtnwliYCbSOTTrr+R0Ya2maRQ0moIx9MF09IwFgNOXglTGise1K2SNDS
 VQ/265mb8pT/LC6+RuQnOujs68JL4FlCIM6fV05rvBO6OS1wyc0NzzRedPdvR5wrrdBK
 Ipz23ptRCUa+Y6CODQJrWrwk30CxGMDQQhCGvtBX0X2FWAyTywpC4mtSJeNavXMuEEbf
 OFMtFqa/BqMiQLvZEXVrmJO9NpH+ZvRjroS8w6kDr6eaZdkYXMN7b0Ztz5sT4J3iv5vq
 GCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q6QACTT6MNs1QawRF/X6ryVYhQD/X9R+o2LVrD4Tw14=;
 b=NHtDm+K0/Th4Sp6IpUk/jEEWZrv11cX2Vs8FX9XJ0y13wzh2fkjMP5vYw9+F/C38w+
 NVaXdtl1F6l5RThjQiu9jeBr5P9S0GfKfCCJJHaJnEDLP4tKA2+qGVQ+aKsAVuVVbP/U
 4G87JEjAl/sgA26RR93+GG22AUydG2FqPEAsFGv4i0BfRl6XiWkbWG9nHneEXTE6q78M
 rfWR9vneZahxLpOux7ZqtVMlUh4GeKQcN9q1ruwRFu/cZF1sTGGtct4bC6oKsWNtVQfm
 grPVuWyVtTFyn/h9/tzCkrs4ElRhtTYc4iqBUaC25DKqjUK67QrUAIba858POOjC81A/
 k0Fg==
X-Gm-Message-State: APjAAAWHOo7lVkh/msVgubVXBamn6Hzq5t8XW5zbWoI2PbDXMzqgqaZN
 3YoOm2xc/txVEXgAGPoy5VF6uw==
X-Google-Smtp-Source: APXvYqy0o1B+EyjrQyCAHwDYykLJBRR0gKUIA+wUXz3Aoy3AUiVCS/X4b2HZSk12R3w2ECb99Elweg==
X-Received: by 2002:adf:e78a:: with SMTP id n10mr9036693wrm.62.1576752585299; 
 Thu, 19 Dec 2019 02:49:45 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s82sm6075064wms.28.2019.12.19.02.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 02:49:41 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2C2021FF98;
 Thu, 19 Dec 2019 10:49:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 08/25] tests/test-util-filemonitor: Skip test on non-x86 Travis
 containers
Date: Thu, 19 Dec 2019 10:49:17 +0000
Message-Id: <20191219104934.866-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219104934.866-1-alex.bennee@linaro.org>
References: <20191219104934.866-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20191204154618.23560-6-thuth@redhat.com>

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


