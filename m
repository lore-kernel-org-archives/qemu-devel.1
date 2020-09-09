Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18164C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:32:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B803E20897
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vv4yaHnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B803E20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFyLP-0008Kl-Mr
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 07:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFyGg-0000PZ-Fo
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:28:02 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:51365)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFyGe-0006YF-Kp
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:28:02 -0400
Received: by mail-wm1-x32f.google.com with SMTP id w2so1921353wmi.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 04:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=duRNJozNW1tzS7SluJmXwYrD3gamZ2xs+epATXTsUdQ=;
 b=vv4yaHnNNpZ+ZcU74MXJffT/GQ5tPAq7GI+v3A/gj5gRl0Y0d0LoUUR1Lfb8fYYjYA
 C+fn+zadkmvqtEs6Ls1tKrsy0KERZ5y6YNmsXzC0QaQgSGYQzvSfjLKpDuvBGL3Plbva
 eYPR7Mm+0GRC1+T+hecKu1smNK6S9FArnA3Lpzr1ePwDMrSULFZH19athHT8wKiJEEsy
 FuxlY3hb7aVSzhnUhWHXpBEuESxxuIzrzNI4FCG1E3+Nn4Q/VscA4oBjWFbOeOA4RE1X
 q4HWYBTALrhO8DCfkJNBHpE8DHCJhrI2wumotmanEnosktGSp7Ufvwe8WXuJhQqmmGc1
 ibvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=duRNJozNW1tzS7SluJmXwYrD3gamZ2xs+epATXTsUdQ=;
 b=XBf/puMLnmvfShXzlxYmhyjzGtoNs9Vwn0vy+IIOCAwRNFnwRvlXErg963WnLiEBnG
 rx9CXllGVj5pzUafhpip9fKoRRv0kPtxP+Tn1msuNaxem2mbv8zCRMOkcE+FLc97O+Cz
 xkEfgFj4eYJ3+Vh+fIYFI7K/NirqIM709UxyJjedd897cl6Qd/aoUqe5omA52HNwOI4A
 B/6UjKYUFwzipx6jnvqek9RB+BulUH6TcWmzPhG/zT0qdcO5E00d2Io9WrNOoajaPec5
 RuqVT7grG1loRfN15oSdsBt4jFgGmgo4BKZiAE0Q0P63SvFDy56p2qLEqa+feIQ4vHLW
 BtUw==
X-Gm-Message-State: AOAM5316ZOD4N1kuxXZsFJqiBnpAzyHGd239ZcKirdnBNvBHWZO4bo86
 yR15dOC4QC3vXO8/vuJRU7Gy4w==
X-Google-Smtp-Source: ABdhPJyh5BMsu8leOwUgzeU1cid1ZRg8IgowX7yGhyo3nFUPFxs8c7tRf6uFZL47wJHMgGzLO7QZIw==
X-Received: by 2002:a1c:9d83:: with SMTP id g125mr3015945wme.41.1599650879214; 
 Wed, 09 Sep 2020 04:27:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k6sm3494329wmf.30.2020.09.09.04.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 04:27:56 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DBFB51FF98;
 Wed,  9 Sep 2020 12:27:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/10] tests/acceptance: Add
 Test.fetch_asset(cancel_on_missing=True)
Date: Wed,  9 Sep 2020 12:27:40 +0100
Message-Id: <20200909112742.25730-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200909112742.25730-1-alex.bennee@linaro.org>
References: <20200909112742.25730-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, cota@braap.org,
 Cleber Rosa <crosa@redhat.com>, aurelien@aurel32.net
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
---
 tests/acceptance/avocado_qemu/__init__.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

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


