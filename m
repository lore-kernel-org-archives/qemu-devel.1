Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75914C3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 10:05:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 410E72072D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 10:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MY2leZOM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410E72072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9QuJ-00044s-Fk
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 05:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j9Qqu-00071g-0l
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j9Qqs-0000kK-KB
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:07 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:33486)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j9Qqs-0000fp-C9
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:06 -0500
Received: by mail-wr1-x436.google.com with SMTP id x7so1627963wrr.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 02:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1Z8GPfWQG9JlhViWJSouPuAdwb1TR2JLNt392yI0Vq8=;
 b=MY2leZOMGWHvBHjmG2OR7WEP52MH3U00oVeP2UCl9r8WDU/6OjxYb11m/eKh4npm3L
 TOnrna0EVAsEv2by9ZC2hXfYVXBuqqq175vAyMCqfx/9jgz1E+12simcJT7LjPVorNWJ
 5J8bH1XaEqaaM0BrgAvwTZv1trKFkPg7ekFP8PsfOxBP7fst9WifcgBhIugDCKpXSIga
 jt3FlWtmovkF+a+pSfB0xAR1v0JLENwcmisRVd86d3z0TzBUB9h1P250PLHd0FHtfD4/
 EQVSG1HCcjFeAg/zpj4QVK549PlHRh8d/D0SBbxxn2XiM1Ml74qNJYvo80jAiMg70Ps0
 xgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1Z8GPfWQG9JlhViWJSouPuAdwb1TR2JLNt392yI0Vq8=;
 b=hEh+MHG/hsxQ8tyXtQfkSy2IUtGM5HMbVjgTMemklQehO0Jacy/huxmGqECZRQiDVD
 cb6zl24PxdRva6hBHHNQyYVbCbiL/p93aBjc8mx0E29UsdwSEfNBs6WhnNEAUqDB13DF
 w8AVSBfUOzvvtHAWK6XWd1KJg3mFv7PXEyb8xw5y9i//D/OP0faa7yxsEuqTDff+frqS
 N6wKlJt79Vfl9IgLClp+rN5/0PtoW+0kp6q8AenLxF7k+Bpn7dDmZTAn6PY4k9VVFdXs
 4te12P7ME89zXoyBz56A7LbtfS5hZ3F0WMG/9nij4SjwXNAwTEoTJdHDTus5wBvAWUoY
 pSiQ==
X-Gm-Message-State: ANhLgQ27VBIqVjECmITkirr9RdDUOZpNUk/ezlvfWGErKvGgNs5RHzeT
 HwNpNkjP26n4QaS5mUzJOyEDnA==
X-Google-Smtp-Source: ADFU+vtnMedWFfT6mg0nXXCnSRj91L2ToMFMkavdDWkwE70XYtBBHnAV0L0pzuKx0K8n1TSlwdklWA==
X-Received: by 2002:adf:cd03:: with SMTP id w3mr3365041wrm.191.1583316125356; 
 Wed, 04 Mar 2020 02:02:05 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z13sm10959666wro.93.2020.03.04.02.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 02:02:00 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3FC7C1FF91;
 Wed,  4 Mar 2020 10:01:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 4/9] tests/vm: give wait_ssh() option to wait for root
Date: Wed,  4 Mar 2020 10:01:49 +0000
Message-Id: <20200304100154.14822-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304100154.14822-1-alex.bennee@linaro.org>
References: <20200304100154.14822-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Cc: Fam Zheng <fam@euphon.net>, Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

Allow wait_ssh to wait for root user to be ready.
This solves the issue where we perform a wait_ssh()
successfully, but the root user is not yet ready
to be logged in.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200219163537.22098-5-robert.foley@linaro.org>
Message-Id: <20200303150622.20133-5-alex.bennee@linaro.org>

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 5ca445e29af..7f268922685 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -312,7 +312,7 @@ class BaseVM(object):
     def print_step(self, text):
         sys.stderr.write("### %s ...\n" % text)
 
-    def wait_ssh(self, seconds=300):
+    def wait_ssh(self, wait_root=False, seconds=300):
         # Allow more time for VM to boot under TCG.
         if not kvm_available(self.arch):
             seconds *= self.tcg_ssh_timeout_multiplier
@@ -320,7 +320,10 @@ class BaseVM(object):
         endtime = starttime + datetime.timedelta(seconds=seconds)
         guest_up = False
         while datetime.datetime.now() < endtime:
-            if self.ssh("exit 0") == 0:
+            if wait_root and self.ssh_root("exit 0") == 0:
+                guest_up = True
+                break
+            elif self.ssh("exit 0") == 0:
                 guest_up = True
                 break
             seconds = (endtime - datetime.datetime.now()).total_seconds()
-- 
2.20.1


