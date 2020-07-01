Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA69CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:14:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8629E20702
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hEJKumSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8629E20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdVX-0007fG-RI
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdKs-0004r1-HR
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:03:38 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33293)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdKq-0006pU-8k
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:03:38 -0400
Received: by mail-wr1-x441.google.com with SMTP id f18so15926434wrs.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 07:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sygc/Hw6fwtICc5dsEJZsfgG0asRPmeTFs6oktvnw3o=;
 b=hEJKumSL8s1zcrxYe9HpeFavd7BSWgdHT+xUxjaQPDp+YEHfPGS5bTXzUBJ2K1Ai4d
 kwLS9hGuTxeY9lEdifXJFBK6PSgswQ/AABLcsVwRIAwUlzaw6wRhoX7LNSuR0DDzbJSj
 YyeDVBeMtqIxYubyoQQDyxmtKdJ2TbU6lzudjWtzG1wJh2OeAXuecIUVfdrcQDTTzPdq
 uTlfqyMrFM2+nJinEdWkkpIa20wbRu9wNeIm30rqIv9lLpmPd9wPfhRaaRhp/AF4HQXu
 9rJLtvBfPY+p0oGr+DZqUcKsNaMx64EMkUNOAtCr2ByKxDVIjSLZeIkIGoWbpT4AiXMs
 jLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sygc/Hw6fwtICc5dsEJZsfgG0asRPmeTFs6oktvnw3o=;
 b=SxcZ+rFgTPPDOKgdCPvqR7S4+O8F77UvYXFWF1WUOgkDlBcd1sz7XzX6yPqpM0vDxm
 HZkB2saadJT22lR/c1av/qjG/GxeD9uOfMgHx/8M1a5kjJjYp72qIFxM6td2BcgcqH/Q
 OTgPYUUw0aek9kAQuiilBsEdYkYvyZny70qRmLlnYWt2XNcIwLhL7pvYctpKW0gFqY9G
 VzHuzSzUnNTSVtpp9D9GMgcrD3brDMC2wd+jQOeYIRjm0h+kDJpJP9cwjYTCy1gTzmSQ
 dqMcwKnO0lbkFfSe4rfksalGLYuB9iV2Dvx/I7ec4zhhpfNYEg0UAH0rUl9o86G2HLcM
 j4hQ==
X-Gm-Message-State: AOAM530Q54Qbw5IWNCToJYja8jJuzr1ye6Q8wXW6S2HL8+CSkLzAc0KG
 eCorZYxN9/0HXwL7JXQc/pXu5g==
X-Google-Smtp-Source: ABdhPJwKeXDxzbk6kiP/VesS1WR+iX7bxdGgi5yOwgWneWr9/PZpadwaEwZ7q+0PUSWLOQwTqXbKyQ==
X-Received: by 2002:a5d:444e:: with SMTP id x14mr25745822wrr.279.1593612214789; 
 Wed, 01 Jul 2020 07:03:34 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g195sm7530342wme.38.2020.07.01.07.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 07:03:32 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3FA641FF9D;
 Wed,  1 Jul 2020 14:56:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v4 14/40] tests/vm: switch from optsparse to argparse
Date: Wed,  1 Jul 2020 14:56:26 +0100
Message-Id: <20200701135652.1366-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701135652.1366-1-alex.bennee@linaro.org>
References: <20200701135652.1366-1-alex.bennee@linaro.org>
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
v2
  - add explicit parser.add_argument("commands", nargs="*")
v4
  - fixup call to parse_args in aarch64vm.py
---
 tests/vm/aarch64vm.py |  2 +-
 tests/vm/basevm.py    | 93 ++++++++++++++++++++++---------------------
 2 files changed, 49 insertions(+), 46 deletions(-)

diff --git a/tests/vm/aarch64vm.py b/tests/vm/aarch64vm.py
index bb04cb19c91..d70ab843b6b 100644
--- a/tests/vm/aarch64vm.py
+++ b/tests/vm/aarch64vm.py
@@ -46,7 +46,7 @@ def get_config_defaults(vmcls, default_config):
 def aarch_get_config_defaults(vmcls):
     """Set the defaults for current version of QEMU."""
     config = CURRENT_CONFIG
-    args, argv = basevm.parse_args(vmcls)
+    args = basevm.parse_args(vmcls)
     qemu_path = basevm.get_qemu_path(vmcls.arch, args.build_path)
     qemu_version = basevm.get_qemu_version(qemu_path)
     if qemu_version < QEMU_AARCH64_MIN_VERSION:
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 04d083409a5..890bbc5549a 100644
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
@@ -556,54 +556,57 @@ def parse_args(vmcls):
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
+    parser.add_argument("commands", nargs="*", help="""Remaining
+        commands after -- are passed to command inside the VM""")
+
     return parser.parse_args()
 
 def main(vmcls, config=None):
     try:
         if config == None:
             config = {}
-        args, argv = parse_args(vmcls)
-        if not argv and not args.build_qemu and not args.build_image:
+        args = parse_args(vmcls)
+        if not args.commands and not args.build_qemu and not args.build_image:
             print("Nothing to do?")
             return 1
         config = parse_config(config, args)
@@ -619,12 +622,12 @@ def main(vmcls, config=None):
         if args.build_qemu:
             vm.add_source_dir(args.build_qemu)
             cmd = [vm.BUILD_SCRIPT.format(
-                   configure_opts = " ".join(argv),
+                   configure_opts = " ".join(args.commands),
                    jobs=int(args.jobs),
                    target=args.build_target,
                    verbose = "V=1" if args.verbose else "")]
         else:
-            cmd = argv
+            cmd = args.commands
         img = args.image
         if args.snapshot:
             img += ",snapshot=on"
-- 
2.20.1


