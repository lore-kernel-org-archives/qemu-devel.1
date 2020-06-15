Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5575AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 07:50:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2361B2067B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 07:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYiLY/A5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2361B2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkjt4-0001oy-Eg
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 03:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jkjrz-00014i-3t; Mon, 15 Jun 2020 03:49:27 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42085)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jkjrw-0008P3-0t; Mon, 15 Jun 2020 03:49:26 -0400
Received: by mail-wr1-x443.google.com with SMTP id p5so15972312wrw.9;
 Mon, 15 Jun 2020 00:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=d2z0H2KquWx3HT1eYgUtC8NXl28vDPDmrrtiULiYSXk=;
 b=VYiLY/A5nJPg9qqwYZJI3LuIHz1krNcBUN7cn9Dsd0EJl7vGLu3SdZvAeJgwOcGezN
 5BmQZWs68nv3RT/UHQC+fg86E0Hgn2ywjGUpNzO5nxqKaDoUoB9dEsv7LCwwfV3MT5lt
 knsEQE2VDGwLfFRXVsyciAl9eUFagNXbKMGYRhQzXppQaqrWuXnMAQT9aAyo+e8DjS6q
 Jm89n7/3r9H8VjFzjA66mCmX3QoINCqshbRoxoms5rhx+UIkuUnX6IUeu7Rfj/66n2Gb
 YgLRBQtff5DR/ADvWTaGCmdtHEVtCdcwjfnt8MNi5knOHYBoL9MlapAEbdtIwVgmRy2l
 ElNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=d2z0H2KquWx3HT1eYgUtC8NXl28vDPDmrrtiULiYSXk=;
 b=VlKYd1tAie5yfVp6To49krBPZLYXdg4YrxuAMYQvuck2pcYmpoOMiqdGzpE9iHrHtY
 MOsjsnoVwSFi+5RZwWcUlZEhKC1dnOPJMDJu3TYeJ6pX7oXcLz5RMU+6Z0ccwFrfZjFs
 JiwMy6OZSSAKgizvuzyiKxXNIm6DK4QFtF878i8sdu07Zl2c7cJbCuO3i/0U7AfCCbff
 BhC2H7M+lA9Hindcri8QMArL1ZQJx0mg59d104M0+yGJZOm21iVb7gS6/MjlYx5cXkse
 gHChIvRX5xk06LCzk3tJjFzUbdQ4b7vQFs9kwRInLSU4shbgSLGgLVS1solgguM+RcNC
 bN6Q==
X-Gm-Message-State: AOAM533J/NCMQmyvPkkxFGNZ1CXZkGlm6bE51uWcFNhQgllNZsvl3OF1
 J7JUNbPO4TgouvoQlo3uUCbFdhba
X-Google-Smtp-Source: ABdhPJwDywemJ/V40LqaQdLHWbPUYNYr+v1t3DjUyPyVMLAp0uXakf4rfrWplHty4ayPofzz2XufLw==
X-Received: by 2002:adf:e588:: with SMTP id l8mr29200771wrm.255.1592207361717; 
 Mon, 15 Jun 2020 00:49:21 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id y14sm20833121wma.25.2020.06.15.00.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2020 00:49:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] configure: Let SLOF be initialized by
 ./scripts/git-submodule.sh
Date: Mon, 15 Jun 2020 09:49:19 +0200
Message-Id: <20200615074919.12552-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The git-submodule.sh script is called by make and initialize the
submodules listed in the GIT_SUBMODULES variable generated by
./configure.

SLOF is required for building the s390-ccw firmware on s390x, since
it is using the libnet code from SLOF for network booting.

Add it to the GIT_SUBMODULES when buildint the s390-ccw firmware,
to fix:

  $ ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
  Submodule 'roms/SLOF' (https://git.qemu.org/git/SLOF.git) registered for path 'roms/SLOF'
  Cloning into '/home/travis/build/user/qemu/roms/SLOF'...
  fatal: unable to access 'https://git.qemu.org/git/SLOF.git/': Could not resolve host: git.qemu.org
  fatal: clone of 'https://git.qemu.org/git/SLOF.git' into submodule path '/home/travis/build/user/qemu/roms/SLOF' failed
  Failed to clone 'roms/SLOF'. Retry scheduled
  Cloning into '/home/travis/build/user/qemu/roms/SLOF'...
  fatal: unable to access 'https://git.qemu.org/git/SLOF.git/': Could not resolve host: git.qemu.org
  fatal: clone of 'https://git.qemu.org/git/SLOF.git' into submodule path '/home/travis/build/user/qemu/roms/SLOF' failed
  Failed to clone 'roms/SLOF' a second time, aborting
  The command "( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )" exited with 1.

Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 configure   | 5 +++++
 .travis.yml | 1 -
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index bb7fd12612..927e4a3d06 100755
--- a/configure
+++ b/configure
@@ -6533,6 +6533,11 @@ if test "$cpu" = "s390x" ; then
   write_c_skeleton
   if compile_prog "-march=z900" ""; then
     roms="$roms s390-ccw"
+    # SLOF is required for building the s390-ccw firmware on s390x,
+    # since it is using the libnet code from SLOF for network booting.
+    if test -e "${source_path}/.git" ; then
+      git_submodules="${git_submodules} roms/SLOF"
+    fi
   fi
 fi
 
diff --git a/.travis.yml b/.travis.yml
index ec6367af1f..220855c1f0 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -496,7 +496,6 @@ jobs:
         - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},s390x-linux-user"
         - UNRELIABLE=true
       script:
-        - ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
         - BUILD_RC=0 && make -j${JOBS} || BUILD_RC=$?
         - |
           if [ "$BUILD_RC" -eq 0 ] ; then
-- 
2.21.3


