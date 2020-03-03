Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040B6C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0A122073D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="puCW+K7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A122073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9992-0004xh-UR
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 10:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j997v-00036J-50
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j997u-0001k2-62
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:31 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46506)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j997u-0001jn-05
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:30 -0500
Received: by mail-wr1-x444.google.com with SMTP id j7so4693251wrp.13
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 07:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z7tiVgE0/FNumYwGDaf9+n6Hr38jcg9tS9OSWzqMpF0=;
 b=puCW+K7M1qDXOA3YLGijkY6E9syrW2o8IpoNtWh2TilgVJtBR+laDUtM9TNcp3mrMf
 VJjB8+gKNj9A+Bwp+8F0K0OZEJLCJFAI4lnOWHl3jekXZ7KUKnX0Mtq3DqKG7lgbZxsb
 Ta3sYvoz9cCre8XpRcYhfaJcjpvKNlaL6CpTX5cA5K3gT4qwMBixa/SoMFjpO5uuK9lj
 m0XqH3kM5lXGWOe2+AB8axXpIKP2209PEnYQfXYzjQjAUt5TMxJ4vxkX42Cw+nS3QGuU
 RRudoNHiqyKe4xD1iEMozwQcbHCgdg87QEEe6VV/HVsCFGibhWMQMnGTd5wUzkzSGcAe
 ZQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z7tiVgE0/FNumYwGDaf9+n6Hr38jcg9tS9OSWzqMpF0=;
 b=sHQCggy3M3/VgJAdvksAvYKUiSdy9uRlJyqcURiz3qa+0a6azKiiCzlTHWmenXXVgD
 K6GIaq3XFWIepbHNhHAVkVHgkVFjpsvDP/Qt6nFYicWmYp6SAZrooijiD6RecmQyjKRX
 QjKcj25uSp7wgFsBc2vRFeOKuiMecodwJU0nEHAOQAKZ78s8bCtsPvP6gxiu/WZY1IHz
 GAY+bNAJBvNVE8hPakgDtpBDb6kLh90YQNTUgNM53/PA6rhEhJ46157U/hiOlh9XXaqj
 L7Vo8ub13j22nwr6XgZDwsikCfWM6HCY8Iz7Bn8DmOUiUcu6GWydTCKbfE3b6AfA9lvl
 3wOA==
X-Gm-Message-State: ANhLgQ3cijTvHQzZXxCujcIDB2le/GJwzrMkHY+hnNoPk3SyXRkpA9dj
 zkiN+BdA48gy2TUz8oEaiRiBPw==
X-Google-Smtp-Source: ADFU+vuWA08vxfWswosPclcGySdBcm04AlrFc0IPOvHidTGwfUpgDkv5IZvNxPqOy0ZqdAqzZlojKw==
X-Received: by 2002:a5d:66cc:: with SMTP id k12mr5720823wrw.72.1583247988944; 
 Tue, 03 Mar 2020 07:06:28 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k7sm34676625wrq.12.2020.03.03.07.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 07:06:25 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2B1E91FF91;
 Tue,  3 Mar 2020 15:06:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 4/9] tests/vm: give wait_ssh() option to wait for root
Date: Tue,  3 Mar 2020 15:06:17 +0000
Message-Id: <20200303150622.20133-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303150622.20133-1-alex.bennee@linaro.org>
References: <20200303150622.20133-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Fam Zheng <fam@euphon.net>, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Robert Foley <robert.foley@linaro.org>,
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
---
 tests/vm/basevm.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

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


