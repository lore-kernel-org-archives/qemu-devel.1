Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3114BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 13:33:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE5E4207FB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 13:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gGDlxSp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5E4207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb2ND-0000KF-5a
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 09:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jb2Gs-0005Ct-0v
 for qemu-devel@nongnu.org; Tue, 19 May 2020 09:27:02 -0400
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f]:39964)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jb2Gr-0008N2-32
 for qemu-devel@nongnu.org; Tue, 19 May 2020 09:27:01 -0400
Received: by mail-qk1-x72f.google.com with SMTP id g185so14929224qke.7
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 06:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5HieQNcS49Ddl5x13c1tlfdvYUU3jAT4qZ90zyOAgeo=;
 b=gGDlxSp2v75NrIPWM5D3XVLcOukIGQXHq7jfkPYa/r5m/dFii5nx9AA5MNV+d+oibK
 C5P+3TQs7SAxy77yabNMjmIS957d/52IcjbqMik7KdZunAspp3PXMMhao3sOvWjGXmrP
 Q5TwozpjXYIqM43wozOdjFTGNEFC2ivU6V1zxUJw9NH0q7uVxUkqCt+tJIIYxe2B9wad
 xtc9ZQYz+HJGWm9buC87hNu4fPNk1vpbzbGlzoJMBUml6xrLpcBCSQIB0jZUpzf+Yksb
 FwPUjsC6MuvNiCssYSMGeWrV3cP7CgaUUQtVltovYJfyhIWnmxTFe0bczpAh23bspE66
 ux+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5HieQNcS49Ddl5x13c1tlfdvYUU3jAT4qZ90zyOAgeo=;
 b=HWyDOHdRqAq23EcaXdmX5MZePxw88xdxgq3LxwlMKOb4CjX3/TuntTB0qjsv64qiVN
 GtWPOp09wEbr/A8SP6KFCYBP86elAjPCB7DqrDNKdpdIB9RcUBuas5Udq951ko60kslH
 eVZn4Cw43OQBo4l7tB8Z3JJJVEKLCV/oDhPTRWBQR3yomFaLF8zbJ/LqE6PaLbSB+EDd
 qMZ8X+EtXW04AvbT/8xwat2H6Bc/hBoQP9bxKdSwzezalWwyn47/S0FGQOlyJ7PrKb/A
 iU36nv+POd/xsEZ8AFdLvt3eu/+LHM07r6fL1S/KoDNNgJwpLiN92hCtP55DKmwJwp0g
 zfow==
X-Gm-Message-State: AOAM530t0JX5vaWbPIUIAFsLxZ1m6jS1W0BfG2k0XmukhgThqglcSrPO
 5RSd1u1X6Sbhd+tNx+MLYRQom/vgdYWocA==
X-Google-Smtp-Source: ABdhPJzRJQ17qSgOseMDZMOuyxaa2KbC3HjtQgfd8pfkm0+iViSKwqWcRqvO0N/sr0F0xWJzfWYkEA==
X-Received: by 2002:a05:620a:319:: with SMTP id
 s25mr20266873qkm.25.1589894819866; 
 Tue, 19 May 2020 06:26:59 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:dd6a:8c63:cd9d:ad15])
 by smtp.gmail.com with ESMTPSA id d74sm3482136qke.100.2020.05.19.06.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 06:26:59 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 08/12] tests/vm: allow wait_ssh() to specify command
Date: Tue, 19 May 2020 09:22:55 -0400
Message-Id: <20200519132259.405-9-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519132259.405-1-robert.foley@linaro.org>
References: <20200519132259.405-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x72f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: philmd@redhat.com, alex.bennee@linaro.org, robert.foley@linaro.org,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows for waiting for completion of arbitrary commands.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/basevm.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index d717b967ca..b610581d1b 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -409,24 +409,24 @@ class BaseVM(object):
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


