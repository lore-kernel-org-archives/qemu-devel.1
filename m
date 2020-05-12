Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CC3CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 19:35:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A4B920731
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 19:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NjpZiQRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4B920731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYah2-0003Ly-2b
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 15:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jYaen-0000NX-Cn
 for qemu-devel@nongnu.org; Tue, 12 May 2020 15:33:37 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734]:41619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jYael-0001rZ-DJ
 for qemu-devel@nongnu.org; Tue, 12 May 2020 15:33:37 -0400
Received: by mail-qk1-x734.google.com with SMTP id n14so14913960qke.8
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 12:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BTKcYeUaFGhya1RL8BEXIQFfl5d3zBX2OKJUpLkqnTc=;
 b=NjpZiQRdMt5gv9uZV8Bp/WU1fBG4c49Q8pvOU3hZnfF3+Y3n1hwa7QH5FE/yoAmwtG
 b3rEG3iNb7Ulf7w0bzVzYq11OYLcOwa+s9qca2o16VD2mGjS7RMVwFrT6i01Od7AFMm1
 K8lJtEAMUR5cdnXxHdm2qYpROog9gTVfyMZUUbeqPs686y4hGnqkpVtKIrOnv07ZkzsE
 c1Rn42BYaTRw2NlXxNULFnF/h+fciYAXXDxRU7e+TcGdD5Ze+/SoXrfjSPcyZk1gmRlo
 NJuZpY7VTLRfMCOsVPjDPonZNoORb/RPEWgMuzDuqCIAOH/dtgFIKID+oESQLPZWFAOV
 cmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BTKcYeUaFGhya1RL8BEXIQFfl5d3zBX2OKJUpLkqnTc=;
 b=HWDNrDRgI+mj1TkMK+OPCvJW3Td/6feg8pKSx1TiuMbCaohyLHoKVB6fStyHlklOD2
 D0vFq+5tm3aVE4hhdhOo9sOkfQJwn9amzmURP61/ewlQREq+Eny6PMulD9RhiPt/r/VF
 7VymdTpM8AFO75mJIB23LTUcPTwFsycTIF13FBKGsCFTm5DpTlO2CAOdQmjRMvBb0pdM
 o0pbzwfjEhq+l8uAaOGzjiHFWNhEGT1KU9MLzusApYZ5p6cTYoxIi/OI5qtf2VDbowz6
 DLKL3hZ+wsq74FZs4raCWs4utiY2lgGVadHza1yxsM0rcvyfrJuXTnTOFGi1cRsV/xcP
 xlWQ==
X-Gm-Message-State: AGi0PubFgdxwlPSuMLyfllPRXNOcfRlUmfOB5F1FuICITX94T1236V0I
 j+Kcu7BFquIQg2K6KQICZ/mk1LbYCliN6w==
X-Google-Smtp-Source: APiQypI+AibBl1mfgamP98/Kx10dJWp75OESPEwEN5+8uHHdsQvQa9wi+US8b+Tsp0Hx/FqDF19u3w==
X-Received: by 2002:a37:b185:: with SMTP id a127mr21996182qkf.87.1589312014195; 
 Tue, 12 May 2020 12:33:34 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:d31:9f53:b3eb:9b53])
 by smtp.gmail.com with ESMTPSA id j45sm2100998qtk.14.2020.05.12.12.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 12:33:33 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 5/9] tests/vm: allow wait_ssh() to specify command
Date: Tue, 12 May 2020 15:33:36 -0400
Message-Id: <20200512193340.265-6-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512193340.265-1-robert.foley@linaro.org>
References: <20200512193340.265-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x734.google.com
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
index 1cb104c402..4fa1ea8fde 100644
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


