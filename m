Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39796C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:07:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0961D20781
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="amljOvBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0961D20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo63v-0002DJ-7L
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 10:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo61U-000582-2o
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:05:08 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46114)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo61R-0003Wo-RO
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:05:07 -0400
Received: by mail-wr1-x443.google.com with SMTP id r12so2377264wrj.13
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 07:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MIJDY0wCVkf83j0A2folG6JUn+sBiPxS+WIpYPexzXA=;
 b=amljOvBKYb19XKL33ec5BrEZxXJlWJo9bRCzIKec77yGf0buKkslUQThM9fO91t4iF
 43aL3IhhX9QgVp+Y4RBLFKpfTGeTD04zBiKemPeRlD4YFBMkHx7wVEjDuLG35La+Lip1
 74DKs6TNAbU61X2AffvS2oDQHuFw7Va3u5533t1s9osOJa+lCHopeKbenxba0swJAOjj
 piv6LSGE4O8UrMucTkr8X98WljFugesqdV0q5YoNAShRdO9QH3H2qk4ytoFLTX3e4mNE
 alZoz6+Rc36sOCllsLQCh1e01vLkJ1U3wLn5/ygxL/oV3gjLSQh4rH0niuiVaa0P+WSJ
 qB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MIJDY0wCVkf83j0A2folG6JUn+sBiPxS+WIpYPexzXA=;
 b=uR4AwNJDauVS9sMd6Vd9XkTrJENi3j+Amu/aEIgNiiP6Vuvpnbp9icyN9rG+aXyFgj
 RZH74if1COyJEXQmYAWvX/3UN6LuHU2qmL3fYA7JSnpGysakPOt75oHiM8yGEjnjR8Fr
 p1si31o/jEps9rH93XYOu+g9qGnpkHgsysJmRGq7ZetLuDdLpX0ltyvTzPD+bJ1Pi6xT
 pQ/qq6ybVpLDZI/0vjf17XKqKs70Ls5ShKuN75GbQ3SfUOrjqvCeHthcrnEQI0BBT7c6
 EpZeVZb4ZQiDI//IJHdu+4ejarukrru6rcu/+leK/ey56GYAoER7y4ZKqnopT932PYaR
 897g==
X-Gm-Message-State: AOAM5335SdUC7Lhyc8eImoD8lG1SFrQlHkf+ER2QzrVQIEMjcOAy9+Vd
 aGE5IZOgcaRFKOwtW7c3AAn4bw==
X-Google-Smtp-Source: ABdhPJwyKPX/7cdfW3jjDhePiHIxMw4yOMpTtCwt1bs4QdfHyqxZkGm2DmTzSfoOmdU2m+1CZcsyMg==
X-Received: by 2002:adf:9404:: with SMTP id 4mr30595963wrq.367.1593007504234; 
 Wed, 24 Jun 2020 07:05:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n5sm3827123wmi.34.2020.06.24.07.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 07:04:56 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6D3061FF9B;
 Wed, 24 Jun 2020 15:04:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 12/25] tests/vm: switch from optsparse to argparse
Date: Wed, 24 Jun 2020 15:04:33 +0100
Message-Id: <20200624140446.15380-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200624140446.15380-1-alex.bennee@linaro.org>
References: <20200624140446.15380-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: fam@euphon.net, berrange@redhat.com, Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

optparse has been deprecated since version 3.2 and argparse is the
blessed replacement. Take the opportunity to enhance our help output
showing defaults when called.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Robert Foley <robert.foley@linaro.org>
---
 tests/vm/basevm.py | 84 +++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 04d083409a5..93859362606 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -23,7 +23,7 @@ from qemu.accel import kvm_available
 from qemu.machine import QEMUMachine
 import subprocess
 import hashlib
-import optparse
+import argparse
 import atexit
 import tempfile
 import shutil
@@ -556,47 +556,47 @@ def parse_args(vmcls):
         else:
             return 1
 
-    parser = optparse.OptionParser(
-        description="VM test utility.  Exit codes: "
-                    "0 = success, "
-                    "1 = command line error, "
-                    "2 = environment initialization failed, "
-                    "3 = test command failed")
-    parser.add_option("--debug", "-D", action="store_true",
-                      help="enable debug output")
-    parser.add_option("--image", "-i", default="%s.img" % vmcls.name,
-                      help="image file name")
-    parser.add_option("--force", "-f", action="store_true",
-                      help="force build image even if image exists")
-    parser.add_option("--jobs", type=int, default=get_default_jobs(),
-                      help="number of virtual CPUs")
-    parser.add_option("--verbose", "-V", action="store_true",
-                      help="Pass V=1 to builds within the guest")
-    parser.add_option("--build-image", "-b", action="store_true",
-                      help="build image")
-    parser.add_option("--build-qemu",
-                      help="build QEMU from source in guest")
-    parser.add_option("--build-target",
-                      help="QEMU build target", default="check")
-    parser.add_option("--build-path", default=None,
-                      help="Path of build directory, "\
-                           "for using build tree QEMU binary. ")
-    parser.add_option("--interactive", "-I", action="store_true",
-                      help="Interactively run command")
-    parser.add_option("--snapshot", "-s", action="store_true",
-                      help="run tests with a snapshot")
-    parser.add_option("--genisoimage", default="genisoimage",
-                      help="iso imaging tool")
-    parser.add_option("--config", "-c", default=None,
-                      help="Provide config yaml for configuration. "\
-                           "See config_example.yaml for example.")
-    parser.add_option("--efi-aarch64",
-                      default="/usr/share/qemu-efi-aarch64/QEMU_EFI.fd",
-                      help="Path to efi image for aarch64 VMs.")
-    parser.add_option("--log-console", action="store_true",
-                      help="Log console to file.")
-    parser.disable_interspersed_args()
-    return parser.parse_args()
+    parser = argparse.ArgumentParser(
+        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
+        description="Utility for provisioning VMs and running builds",
+        epilog="""Remaining arguments are passed to the command.
+        Exit codes: 0 = success, 1 = command line error,
+        2 = environment initialization failed,
+        3 = test command failed""")
+    parser.add_argument("--debug", "-D", action="store_true",
+                        help="enable debug output")
+    parser.add_argument("--image", "-i", default="%s.img" % vmcls.name,
+                        help="image file name")
+    parser.add_argument("--force", "-f", action="store_true",
+                        help="force build image even if image exists")
+    parser.add_argument("--jobs", type=int, default=get_default_jobs(),
+                        help="number of virtual CPUs")
+    parser.add_argument("--verbose", "-V", action="store_true",
+                        help="Pass V=1 to builds within the guest")
+    parser.add_argument("--build-image", "-b", action="store_true",
+                        help="build image")
+    parser.add_argument("--build-qemu",
+                        help="build QEMU from source in guest")
+    parser.add_argument("--build-target",
+                        help="QEMU build target", default="check")
+    parser.add_argument("--build-path", default=None,
+                        help="Path of build directory, "\
+                        "for using build tree QEMU binary. ")
+    parser.add_argument("--interactive", "-I", action="store_true",
+                        help="Interactively run command")
+    parser.add_argument("--snapshot", "-s", action="store_true",
+                        help="run tests with a snapshot")
+    parser.add_argument("--genisoimage", default="genisoimage",
+                        help="iso imaging tool")
+    parser.add_argument("--config", "-c", default=None,
+                        help="Provide config yaml for configuration. "\
+                        "See config_example.yaml for example.")
+    parser.add_argument("--efi-aarch64",
+                        default="/usr/share/qemu-efi-aarch64/QEMU_EFI.fd",
+                        help="Path to efi image for aarch64 VMs.")
+    parser.add_argument("--log-console", action="store_true",
+                        help="Log console to file.")
+    return parser.parse_known_args()
 
 def main(vmcls, config=None):
     try:
-- 
2.20.1


