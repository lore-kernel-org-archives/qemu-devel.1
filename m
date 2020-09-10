Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD463C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03672207FB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rvpmaHWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03672207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGMUW-00040H-23
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 09:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kGMQC-0004KA-W7
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:15:29 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:40177)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kGMQA-0006GD-29
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:15:28 -0400
Received: by mail-wm1-x333.google.com with SMTP id k18so5745121wmj.5
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 06:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7UF2Z5+SuIyq9l+IsO7cNSeFnpuZpKompmhgJjMgzVo=;
 b=rvpmaHWP7HWrI+tkZsAUHhytka4nY0N0VuqtNt49rzCrbx37B0ED37fUlGRi1C1Ef9
 uK9jFeinbF2zSet/7DuwVlFG0sgwQYeC8cmXtSEeE5LRjAyzixIaexo8gKNIn0zaDZWL
 phyuaNlhVVHI5QDuDnLekMsltBazc1S8LXzycEWdrvtTZhhECR8l/Kd/cgolM9oinYoD
 Xvf1c42QJKpImheGkmKjlDOrquXqs8EBkSh7S4RDOESxLc3YnLoucABLRD10dGvfV8tI
 q4qmXcs574awLAVPCrLuF5yMyj7lF7M6e5jh9aXGgk20yHArdWjj8RktBukilAzvpzf+
 3bZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7UF2Z5+SuIyq9l+IsO7cNSeFnpuZpKompmhgJjMgzVo=;
 b=ZuffjhcKoYA7pM6LQFC5mPuPU1vFXjeiQWqvW0zvcztXoPiPP73M9lQ8e4BIKAQliF
 lbyLf3N6qqOszwrET+n/JpCPMIHyyvXFHJ1jmqWAGPX6WBoO1jm3RQTQLf64164S2f13
 I4THHNhqVaKuKUBuWaIh5Fv1JbRvIBI9vsP+Dj++a2jRtqtzbe0YuWriTXWCQm93zMEz
 FuUWTL7KgMVWEnqMXxlZY7NOQ29m5lGb6h6Hz0nyKhpfZ0JDRhLEbo7cJ45E3C8nQ95J
 giO41AQGWLfHhcU8+b4epbvo512aMKk42ZxNIC8bTpiAwIblY2NKckLKAggLIqNMQ7KB
 s+7w==
X-Gm-Message-State: AOAM530aYP1pUGoo3vduEx/dtUDGEZZE5F0gJCY/plZr0+KKNeIWDAdm
 8+bZZuvbf5qPwrz6jgfGVmUYmg==
X-Google-Smtp-Source: ABdhPJxuEtCtSTwrYZfPP/CqRSFzc581PuFt7M3Rg8c6eKT35AgHyPAqnO9bdRBhRxLhwrca5/CVnw==
X-Received: by 2002:a1c:b3c6:: with SMTP id c189mr24923wmf.27.1599743722942;
 Thu, 10 Sep 2020 06:15:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 70sm3814892wme.15.2020.09.10.06.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 06:15:19 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3256C1FF98;
 Thu, 10 Sep 2020 14:15:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 09/10] tests/acceptance: Add
 Test.fetch_asset(cancel_on_missing=True)
Date: Thu, 10 Sep 2020 14:15:03 +0100
Message-Id: <20200910131504.11341-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200910131504.11341-1-alex.bennee@linaro.org>
References: <20200910131504.11341-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Invert the default of avocado.Test.fetch_asset 'cancel_on_missing'
keyword: accept missing artefacts by default. If a test is certain
an artifact can't be missing, it will set cancel_on_missing=False.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200908202352.298506-3-philmd@redhat.com>
Message-Id: <20200909112742.25730-10-alex.bennee@linaro.org>

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
index db9c0f5d79d..4cda0371879 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -192,3 +192,15 @@ class Test(avocado.Test):
     def tearDown(self):
         for vm in self._vms.values():
             vm.shutdown()
+
+    def fetch_asset(self, name,
+                    asset_hash=None, algorithm=None,
+                    locations=None, expire=None,
+                    find_only=False, cancel_on_missing=True):
+        return super(Test, self).fetch_asset(name,
+                        asset_hash=asset_hash,
+                        algorithm=algorithm,
+                        locations=locations,
+                        expire=expire,
+                        find_only=find_only,
+                        cancel_on_missing=cancel_on_missing)
-- 
2.20.1


