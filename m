Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9F8C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D55208E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PHKa70Go"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D55208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5c5e-0002EF-Fx
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5bv7-00087P-Dq
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5bv3-0006WD-5N
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:24 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:36559)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5bv0-0006Tq-Bq
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:19 -0400
Received: by mail-wm1-x32a.google.com with SMTP id p13so219948wmh.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Bl9ihYzO31h1s8ixDSGDQc1ywiHdznbrQuxAbSXVm60=;
 b=PHKa70GoOt1ksj6K7Pm57YYEZXh2NY+KMfCeGOCxUuEC1KsBWhso8V3imC1lo5/it2
 3L0IPQiDaTjjo6ommUF5i40l+Y5+cAw8WUzDK4MCpGDq+h4v616oy/uaOmi7rJLuovVz
 y8TET4QanafUn7EpUAknlA2/noDqzuQJj4pSHC8ZRFZnKHnSnBUWp0H49NYNnXXNkJYj
 ReUyo/FZfNBe/vMl3omHAcRTsM2edX/P1l49B67UMQ7PeaekBG097Z8ZmC17fGpBtLg1
 6dO7tWMCNdYKWbkU2AyAxbMPwc8LZIYSEUzhcvxJI5vzP5bWFO9snYUvssh/fj7BzVAk
 c9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Bl9ihYzO31h1s8ixDSGDQc1ywiHdznbrQuxAbSXVm60=;
 b=B+QqNN58y53RKv/EVhuu80e6x++XEaKOzHXtdlVkT+MPzslNOUAaHIjko/xy3V34OJ
 0GJyrlxYa+UI9vjOh1BP5Wb24yVj8YxmnGIScYK+rMo+7JQDoDVIhTKhruzhpUiVKURX
 J7JH4zf9uZRAVwmW/ph2SYRUrdpHFENpH4Uwg1QYSAaKsLCsrux2ZMgkCuxDE9Ct0Q09
 K97pfhWNwdu25F/jZ/4gJ/onSUL2kcQIIKudCd4bedHu+Gp+cvrRr4TBEQfbyaEW6Jm0
 26b8UYUnxo3c0kItNcxxv++9q/jfL6rz9JEH+gxkK6FWV0mapY1CgzScxrxdi2C5dvlF
 3ENg==
X-Gm-Message-State: APjAAAUehuQxrmekPMm2nVUOzzx7jF8ogk2zFlgPzyXxogz5DW02XA2S
 HJSKi+nxI/ziK0EfqCEzZC5ZGw==
X-Google-Smtp-Source: APXvYqzxxAM6dMFSVpnUKjDUVMUHeYU1NW4uEeuY0l7aIa6oMmDjLUBxpLo/wHdhnvIWgya1BdPMrQ==
X-Received: by 2002:a1c:9ec9:: with SMTP id h192mr82931wme.105.1567629015091; 
 Wed, 04 Sep 2019 13:30:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j1sm16570133wrg.24.2019.09.04.13.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:30:14 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8408C1FF8F;
 Wed,  4 Sep 2019 21:30:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:29:33 +0100
Message-Id: <20190904203013.9028-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
Subject: [Qemu-devel] [PATCH v1 02/42] configure: clean-up container cross
 compile detect
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The introduction of podman support inadvertently broke configure's
detect of the container support as the configure probe didn't specify
an engine type. To fix this in docker.py:

  - only (re)set USE_ENGINE if --engine is specified
  - enhance the output so docker is no longer just yes

In the configure script we can at least start cleaning up the
detecting and naming of variables. To avoid too much churn the
conversion of the various make DOCKER_foo variables has been left for
future clean-ups.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure              | 10 +++++-----
 tests/docker/docker.py |  7 ++++---
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/configure b/configure
index 95134c0180b..94845fc5101 100755
--- a/configure
+++ b/configure
@@ -495,7 +495,7 @@ qed="yes"
 parallels="yes"
 sheepdog="yes"
 libxml2=""
-docker="no"
+container="no"
 debug_mutex="no"
 libpmem=""
 default_devices="yes"
@@ -5894,14 +5894,14 @@ EOF
 fi
 
 ##########################################
-# Docker and cross-compiler support
+# Container based cross-compiler support
 #
 # This is specifically for building test
 # cases for foreign architectures, not
 # cross-compiling QEMU itself.
 
-if has "docker"; then
-    docker=$($python $source_path/tests/docker/docker.py probe)
+if has "docker" || has "podman"; then
+    container=$($python $source_path/tests/docker/docker.py probe)
 fi
 
 ##########################################
@@ -6474,7 +6474,7 @@ echo "qed support       $qed"
 echo "parallels support $parallels"
 echo "sheepdog support  $sheepdog"
 echo "capstone          $capstone"
-echo "docker            $docker"
+echo "container support $container"
 echo "libpmem support   $libpmem"
 echo "libudev           $libudev"
 echo "default devices   $default_devices"
diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 4bba29e104e..e23209f71ee 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -536,9 +536,9 @@ class ProbeCommand(SubCommand):
         try:
             docker = Docker()
             if docker._command[0] == "docker":
-                print("yes")
+                print("docker")
             elif docker._command[0] == "sudo":
-                print("sudo")
+                print("sudo docker")
             elif docker._command[0] == "podman":
                 print("podman")
         except Exception:
@@ -651,7 +651,8 @@ def main():
         cmd.args(subp)
         subp.set_defaults(cmdobj=cmd)
     args, argv = parser.parse_known_args()
-    USE_ENGINE = args.engine
+    if args.engine:
+        USE_ENGINE = args.engine
     return args.cmdobj.run(args, argv)
 
 
-- 
2.20.1


