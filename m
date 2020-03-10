Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1BAC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB47020727
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vhO0VdIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB47020727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBjdU-000145-19
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 14:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jBjbD-0005CJ-BY
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jBjbC-0002MI-AG
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:27:27 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:32864)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jBjbC-0002LF-3o
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:27:26 -0400
Received: by mail-pl1-x62b.google.com with SMTP id ay11so5778032plb.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 11:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8MBax5bvqnGFn59+X+0C/P+ZVgi3X2sGtV0kV14mTCU=;
 b=vhO0VdIYJSFchp3fKcitkAFupc8J8UfcV3mfm6YJ50fYh4rVAmPY+FuaTCjR0u2KSS
 JGT6+AXUhPUFaqzWRf3Wpn0zYIC1k2DzLBjdQ8kfx4xI4Hbor21wF7dU70pmoorwlo0k
 Yiv6TmIpWH3fV3A+4BV1ZyyrS4Ugo2d4UPGN50gLFyNJD2KwVI4taNqoNHm6nPg1s9z+
 fNJYk3dMCk1tpOIywr2GfCOCt4pEO0SNACV894NKNWaWvKTl+lcF3XsIeUVcEfBs4iGo
 9y9peRgxqKIRBnP/vxLZTyH7eIWi9L82Hjd/XZqO33DjAWMJz7ImVNH8HnJvR5nzDVd0
 RkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8MBax5bvqnGFn59+X+0C/P+ZVgi3X2sGtV0kV14mTCU=;
 b=Pee3Beb/mCVIkZW1GczPMOAK4be96Rfs0KQjcs0Rbox20K9iefvCuOdCveylnEEW9h
 YCKitf2odQRTwq5nJfgF21G9UoCEKrq0EpZjhr4vOf/IPWAQlQ5kNBvdWAIMn8tctqcS
 Uy2K9pTUxRIxGZ1bmOP/cgwY3QN4/UHqHe2/cK/dM5Eo2H7Gvo/aiTbrl/iU7cOXSaCk
 5ICG1mbKciCdc9uiuIV1uGorgFxH7kX6XEJrfDtCoO8Wgk2iDutyH/GR8OueLp81qnMT
 B2q0c5sXU6XS54DW5jS0gMjSV15GCzAMTqPXJCL9SFmX76NGO4rzIKr3o0VEE4MQLMo8
 00sA==
X-Gm-Message-State: ANhLgQ0Ug/0rFES5whsSVVWQyshaaC0LuoR+MYbWBCNBaSLZrIEm52vH
 Wp1lXddiw0TwIkeOMSFc/I20BABz6jQ=
X-Google-Smtp-Source: ADFU+vvHAc0zQJ9KGH5qD0sR9j51rX4f6LTF7zdEERCfzkaTlqe335EZ0r66p+0OZ+qk3XGNC5lBFQ==
X-Received: by 2002:a17:902:bf0b:: with SMTP id
 bi11mr10282373plb.245.1583864844846; 
 Tue, 10 Mar 2020 11:27:24 -0700 (PDT)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id p1sm8730692pfq.114.2020.03.10.11.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 11:27:24 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/10] tests/vm: allow wait_ssh() to specify command
Date: Tue, 10 Mar 2020 14:25:32 -0400
Message-Id: <20200310182536.11137-7-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310182536.11137-1-robert.foley@linaro.org>
References: <20200310182536.11137-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62b
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
Cc: philmd@redhat.com, alex.bennee@linaro.org, robert.foley@linaro.org,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows for waiting for completion of arbitrary commands.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 tests/vm/basevm.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 3562a33ffa..305b839000 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -394,24 +394,24 @@ class BaseVM(object):
     def print_step(self, text):
         sys.stderr.write("### %s ...\n" % text)
 
-    def wait_ssh(self, wait_root=False, seconds=300):
+    def wait_ssh(self, wait_root=False, seconds=300, cmd="exit 0"):
         # Allow more time for VM to boot under TCG.
         if not kvm_available(self.arch):
             seconds *= self.tcg_ssh_timeout_multiplier
         starttime = datetime.datetime.now()
         endtime = starttime + datetime.timedelta(seconds=seconds)
-        guest_up = False
+        cmd_success = False
         while datetime.datetime.now() < endtime:
-            if wait_root and self.ssh_root("exit 0") == 0:
-                guest_up = True
+            if wait_root and self.ssh_root(cmd) == 0:
+                cmd_success = True
                 break
-            elif self.ssh("exit 0") == 0:
-                guest_up = True
+            elif self.ssh(cmd) == 0:
+                cmd_success = True
                 break
             seconds = (endtime - datetime.datetime.now()).total_seconds()
             logging.debug("%ds before timeout", seconds)
             time.sleep(1)
-        if not guest_up:
+        if not cmd_success:
             raise Exception("Timeout while waiting for guest ssh")
 
     def shutdown(self):
-- 
2.17.1


