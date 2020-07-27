Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A90C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:38:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4335E20714
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LwSJmrv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4335E20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k02OY-0000nt-IJ
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 08:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02JC-0002o5-B4
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:32:46 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50642)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02J7-0007T4-Qt
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:32:46 -0400
Received: by mail-wm1-x344.google.com with SMTP id c80so14006873wme.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 05:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tOI4eNCeOvJeLfp6drp84GLtLjEuFDD1qv2L6pFrH6Y=;
 b=LwSJmrv6jhy4JDNIv539CsKeG1Avbu7HIGfZ/lW15nBAg/Xn/jDeQKPyaFk4P7kbBK
 GGncrHjB4qRy4uilpxoYhUnXm4dyRG/xZLegHQPNxn2aPAOo5GiBymMp7/KJbsUJS9/C
 3ejlbixcMX9vfP/kgtorWPkCPCLiRFVteRfTFtxY7wT/wTddHlZfJ1hUKpsBrGBIrVNU
 9IZm/5yVWBU5lN8lHevGDTa3R0ySsFbrv6NRpfBFtQo7ZIfVcGErOgtdtULmeEC+jvW2
 Sf9rJrDkh1HyVgmbUNrbrAyho5xugXoaEiy5N+gmSje9tSuj729oeT72gPeJsP+EgCzL
 ebLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tOI4eNCeOvJeLfp6drp84GLtLjEuFDD1qv2L6pFrH6Y=;
 b=V1aXOWqSnohobd5tUtiYCH5Azw6s64yF+3WxaSQ1LqJWG5mbR1rSCBVsmNG+LPC7wS
 3NtHI9CtbIctCtbw/WV0qk009wLO2qHcFxrYP0/ux9rDNHGJHrqmi0Dri2ymPpLMOJeW
 ZBpm26s49YYvtwM3R6e/Z1bv532eGWyC+WoGUI0BynCF5g78+HrBoAHsKpGLE0cBiG1g
 rpTwRCUeiSJT844WbQi8wThGPp0Sjbai5ITebhLSg8WbzdkaPO7CbCBPIsxjGBGppXDn
 JDRkMyCdzonyv2VUjc03QFNfdq3fmCafeOzKVQFSV9Wv4tbigueHtd8289gpxbNCYhp6
 zWbw==
X-Gm-Message-State: AOAM533Mq8BJ1Kbycxbayk5zX2O5jcypXQNrUBwa8eFtPKs9TGPvE/QI
 bGRPZHcoSkOvmOakkD9KTKEmQQ==
X-Google-Smtp-Source: ABdhPJzmUzfrTsX4fRtFgYM718NUN8VaAXHZgL5AtqWqxXFyhCh93q1N75gIO9scbQjXI/S+nqvUvA==
X-Received: by 2002:a1c:e382:: with SMTP id a124mr20435395wmh.11.1595853158389; 
 Mon, 27 Jul 2020 05:32:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o126sm6776581wma.20.2020.07.27.05.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 05:32:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D7CC61FF9F;
 Mon, 27 Jul 2020 13:23:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 16/16] tests/vm: add shutdown timeout in basevm.py
Date: Mon, 27 Jul 2020 13:23:57 +0100
Message-Id: <20200727122357.31263-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200727122357.31263-1-alex.bennee@linaro.org>
References: <20200727122357.31263-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Robert Foley <robert.foley@linaro.org>
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
Message-Id: <20200724064509.331-17-alex.bennee@linaro.org>

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


