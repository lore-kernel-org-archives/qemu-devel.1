Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166B1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:48:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D98022070B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tbFibdVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98022070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyrVj-0000jI-3b
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 02:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyrSW-0004La-5s
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 02:45:33 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyrSS-0000Ll-4n
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 02:45:31 -0400
Received: by mail-wr1-x441.google.com with SMTP id f2so7245495wrp.7
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 23:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o96Arm+AsiTT6WxJk5cGUcDJbyjeQXafxD+vVt8iLyE=;
 b=tbFibdVm08jBFOPNF7mmdndak7mQhIfIJNgz2pAo4Muftj7bHdgmhDoUdG/9UMeY0W
 l/3bPQUY3+d/JfEl2DAYdk4cHfnjjBuzxjHGHWqizV4ESVR4g2zL/SpjhWNG9keG0o9P
 quh9JLM6WDVS2zMUj5LymZNcLASaoFlb1YlE4FQRvYZeY3lhHdOuOi5ar/Kvi2IJMwGj
 je3MsImUGydAtRLwq4MQUdmfrAuApBHB6SmoKaSYLA+6DJ2ivmzhrCxufyHfWaOdWDON
 DbRPVyA8Ac3FfyHtHRJEe29mpn6QJObhUWyW4v77oqU/GkSaxtTHvQejorqZMv8oNvJe
 sRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o96Arm+AsiTT6WxJk5cGUcDJbyjeQXafxD+vVt8iLyE=;
 b=GCk9pZTtB8MWlM+Dg6iBdgqmyFoDDBuUMwZmXIQqlkualPJigMA1VD9KmY3wsNCVQX
 lV5I7CWIj0OHi31Q10GxPD1ak7jq/TOwScFFs6I0CRYyRsCxB3S782e84jqFt/8+3v+O
 jpbUPMvKjBa7yYavxDGPZKZ660WAYqWb4QO4VScc2o12opAmfAO/tyAAEpsOdTK72iyR
 hLdA7tFsZjOH+quC+wPoWGoIdo+QDTuFdzaNiXLL1Oey9sTaMjH6u/2zCjpVfKTK/Et3
 lR2L0XF+HNGhIjLgPvi/xn44hIbjMCm7e0He9i8N6I6b4pyXvrVz3Ut9zsxMBifO4S8y
 l8Jw==
X-Gm-Message-State: AOAM5336Gvh0QYzRU53UymPRSTgv/mZI/SQgvbemoNsL0edzjLbAlHnO
 H6XQsCg9YRk7AejO51sNaXBsAw==
X-Google-Smtp-Source: ABdhPJwtTb/q6C6+OPYA1tNwy7OcpnpvGbCzUz3WeAMCo3tjo0AjVZo1wdsMFEb3y5Q3YCo4y88lcQ==
X-Received: by 2002:adf:de08:: with SMTP id b8mr6764130wrm.4.1595573126400;
 Thu, 23 Jul 2020 23:45:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o4sm5729789wmc.13.2020.07.23.23.45.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 23:45:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A7E591FF9F;
 Fri, 24 Jul 2020 07:45:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 16/16] tests/vm: add shutdown timeout in basevm.py
Date: Fri, 24 Jul 2020 07:45:09 +0100
Message-Id: <20200724064509.331-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200724064509.331-1-alex.bennee@linaro.org>
References: <20200724064509.331-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com, Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

We are adding the shutdown timeout to solve an issue
we now see where the aarch64 VMs timeout on shutdown
under TCG.

There is a new 3 second timeout in machine.py,
which we override in basevm.py when shutting down.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200717203041.9867-4-robert.foley@linaro.org>
---
 tests/vm/basevm.py | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 7acb48b8761..3fac20e929a 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -80,6 +80,8 @@ class BaseVM(object):
     arch = "#arch"
     # command to halt the guest, can be overridden by subclasses
     poweroff = "poweroff"
+    # Time to wait for shutdown to finish.
+    shutdown_timeout_default = 30
     # enable IPv6 networking
     ipv6 = True
     # This is the timeout on the wait for console bytes.
@@ -87,7 +89,7 @@ class BaseVM(object):
     # Scale up some timeouts under TCG.
     # 4 is arbitrary, but greater than 2,
     # since we found we need to wait more than twice as long.
-    tcg_ssh_timeout_multiplier = 4
+    tcg_timeout_multiplier = 4
     def __init__(self, args, config=None):
         self._guest = None
         self._genisoimage = args.genisoimage
@@ -141,9 +143,12 @@ class BaseVM(object):
         if args.jobs and args.jobs > 1:
             self._args += ["-smp", "%d" % args.jobs]
         if kvm_available(self.arch):
+            self._shutdown_timeout = self.shutdown_timeout_default
             self._args += ["-enable-kvm"]
         else:
             logging.info("KVM not available, not using -enable-kvm")
+            self._shutdown_timeout = \
+                self.shutdown_timeout_default * self.tcg_timeout_multiplier
         self._data_args = []
 
         if self._config['qemu_args'] != None:
@@ -423,7 +428,7 @@ class BaseVM(object):
     def wait_ssh(self, wait_root=False, seconds=300, cmd="exit 0"):
         # Allow more time for VM to boot under TCG.
         if not kvm_available(self.arch):
-            seconds *= self.tcg_ssh_timeout_multiplier
+            seconds *= self.tcg_timeout_multiplier
         starttime = datetime.datetime.now()
         endtime = starttime + datetime.timedelta(seconds=seconds)
         cmd_success = False
@@ -441,14 +446,14 @@ class BaseVM(object):
             raise Exception("Timeout while waiting for guest ssh")
 
     def shutdown(self):
-        self._guest.shutdown()
+        self._guest.shutdown(timeout=self._shutdown_timeout)
 
     def wait(self):
-        self._guest.wait()
+        self._guest.wait(timeout=self._shutdown_timeout)
 
     def graceful_shutdown(self):
         self.ssh_root(self.poweroff)
-        self._guest.wait()
+        self._guest.wait(timeout=self._shutdown_timeout)
 
     def qmp(self, *args, **kwargs):
         return self._guest.qmp(*args, **kwargs)
-- 
2.20.1


