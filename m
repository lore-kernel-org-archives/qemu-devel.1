Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD72C4740A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:46:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF77E20863
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oHpVkJ8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF77E20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7bnK-0005NM-RO
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bki-0003KU-L0
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bkh-0006Hb-FX
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:56 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:44340)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bkg-0006GB-15
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:54 -0400
Received: by mail-wr1-x42a.google.com with SMTP id k6so6224083wrn.11
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0Lr8Rspy6mGDHTxemrpnhcEpoVqVML2BOuqqGvyKoTM=;
 b=oHpVkJ8GqujKUnI3zOPCEopU9M4QyGs9+KOQozb2X15VzPZfHfVuSX4Pk4iXddOL3l
 slD93TBYWvmQT1S/yqMw0c7HSf16XPWZBAUR79GQzerCG+tHWJknRr3Q8C77i8VzIXGZ
 zvOBaomUWJWBMGhQ0H6uPtT8eirqRln8ouVmVw/MDUlVOS8vKazYp/UL37IxESQbedeF
 7Fnas/baBidIL1VdPS8zKd1J2qebFDur1fbLQzu0MsyQ18Bso83tV82yO8xCvqDnmeIY
 HVve/yCHiB/QBmuuVQl7SYnE2poUkXpBYzBuHdVQXOGMY82wAN5aQ9lDdLfALt6xTCfq
 y2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0Lr8Rspy6mGDHTxemrpnhcEpoVqVML2BOuqqGvyKoTM=;
 b=Idj7aWt5eUNtFVS88L3NUHFTH60+jxPlgrdZwUeByuWYDGxoedc/guFWcnOQzRkog1
 WyeN8W5NVC0jdPKFoqKXu105ISwEPdCljF6oBU3d7LtA7L7Ik+w06xtRciBj4yOk+WvA
 5hg4DUc0E7aiFkGWfJ2tEE1NRC7Ts3Nt6/MYtxYQdHHvw+ozQsQy8uoCSinh1iIWULre
 pbbqdVrV1ak8bT9dZyhW7gYWHo/NZr0cgPZ0XPxuW2vsv2WH3E09hrll55jDhGuionbz
 lmvFJ0XpRQGT6s3ab6CHPxrI1LQRSXELrNfe1PSMmStkclZDokYpryOD177DQUjw30um
 EIgw==
X-Gm-Message-State: APjAAAVE+wCkmezlRF3ZzNiztNO3ajaQcvt+m6M84JDvqXHvhTjd3hyN
 1YC94IutRflm2aatXYLVBQWCBQ==
X-Google-Smtp-Source: APXvYqxss6LQ31bXri1L1vMxvxM0GR57SU6PPI9rVfuDCBE7x1hhwhQjk6Ea2Ij1cLzL7pl1m+wwAw==
X-Received: by 2002:a5d:428c:: with SMTP id k12mr25064614wrq.196.1568105030831; 
 Tue, 10 Sep 2019 01:43:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b144sm2446435wmb.3.2019.09.10.01.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:43:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9B0B81FF8F;
 Tue, 10 Sep 2019 09:43:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:06 +0100
Message-Id: <20190910084349.28817-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
Subject: [Qemu-devel] [PULL 02/45] configure: clean-up container cross
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
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

Fixes: 9459f754134b
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: David Hildenbrand <david@redhat.com>

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


