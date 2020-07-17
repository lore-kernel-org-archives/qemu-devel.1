Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E773C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 20:37:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3987820684
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 20:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tzADuf5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3987820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwX6K-0007pu-Ew
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 16:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jwX5N-0006Jo-Kc
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 16:36:01 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39141)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jwX5L-0000UT-PD
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 16:36:01 -0400
Received: by mail-pl1-x641.google.com with SMTP id b9so5920454plx.6
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 13:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BXD39H2r315BUklguxxDX43DDtP3dHTaS3Nmt0J1RaY=;
 b=tzADuf5Vzcqwc3qVkefTGHnni/t6G8bCSl0unioeoFhsTP5lnuWPnD3/pS07WycTdd
 x9O42WJ0ZtGZJKUm4Ymc/ZtHUI4y/iynhxotgsmg7+XcnddbUDVbG2KRDWVfzK60cDFS
 FlxY2khu5+TdhbiiQ5JJkDdKHaZBN+DuAeMBt4EofiPPmVDhJGq891Ne8SPafKRXC1tT
 nwMO2fJcJLP6/AcMXESf/1RA84mU4i+TRfO6L1CI9HJsf57Rpn+GH5KMsOl7r4lf8/ux
 +BzlgN9IeOwnBlGps1zg/IVeR+s7YMiIXt3cqve3TM91mW1vs/xz8/CcWwCokUpShei8
 3ABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BXD39H2r315BUklguxxDX43DDtP3dHTaS3Nmt0J1RaY=;
 b=tXlDikutV/F1bfgxkoFo+Vg4HIyN9Mq7zTYpXwf0lfjg9QxXvk0/R9R+CQFpnXjeH8
 PVfY1pFK021VtLlEzCXU769tWy/yUVdankskx7MhpNCaXyyrFx9T7mMVasyznugRXTuC
 0NnOWW05a3iTrHreMB6o72je9jKfZO86Ygq/iJP0z66R/tmX3AQoIkPHdqXS70jRcGzd
 YXsuVCQWdWJILbz1uxpC+z/nMvI5Iy2ap5Bor00wByPjidrmSS0xQ2iE7OgHGUTLsNjI
 KUH6G4tkZ5j948Ch8gKDrha/d0GosB7t9h8Hqwgy5Qcdy2ijpAy1Yuklwj9QjjLB9AJs
 52ZA==
X-Gm-Message-State: AOAM532Ru/I/WEVuuToiHj9CjyrWUmeRrzchGqxQT6HC3/bEdoA49jAZ
 yHb1ApwJHjm/7kQ3mOFwrdciD4eHab4=
X-Google-Smtp-Source: ABdhPJwqS/y0O/ohfauNls1h2VWRfR9oOF8riGl1vjOHYdLcl7UN4YTyuC0HKZ5Nur2j43JdT5ul5Q==
X-Received: by 2002:a17:902:8c93:: with SMTP id
 t19mr8961533plo.196.1595018158019; 
 Fri, 17 Jul 2020 13:35:58 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:b0d0:3aae:620c:a8c5])
 by smtp.gmail.com with ESMTPSA id x7sm8212848pfq.197.2020.07.17.13.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 13:35:57 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 3/3] tests/vm: add shutdown timeout in basevm.py
Date: Fri, 17 Jul 2020 16:30:41 -0400
Message-Id: <20200717203041.9867-4-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717203041.9867-1-robert.foley@linaro.org>
References: <20200717203041.9867-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x641.google.com
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
Cc: Fam Zheng <fam@euphon.net>, robert.foley@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 jsnow@redhat.com, peter.puhov@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are adding the shutdown timeout to solve an issue
we now see where the aarch64 VMs timeout on shutdown
under TCG.

There is a new 3 second timeout in machine.py,
which we override in basevm.py when shutting down.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 tests/vm/basevm.py | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 7acb48b876..3fac20e929 100644
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
2.17.1


