Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47540C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 06:58:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1101A2067B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 06:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nm3jTVzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1101A2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkj4F-0005E0-Bz
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 02:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jkj3h-0004g6-07; Mon, 15 Jun 2020 02:57:29 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40647)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jkj3f-00083M-63; Mon, 15 Jun 2020 02:57:28 -0400
Received: by mail-wm1-x343.google.com with SMTP id r15so13599417wmh.5;
 Sun, 14 Jun 2020 23:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SCX7Y0uWvEKoPRCo0XNxyDaKzLlVeynL0mvSqc+FuX4=;
 b=nm3jTVzKKO1lrlN2qyeqR2Y7Ea7Pg2qBYxcPzrx8aFDxGou2DPsfMaj46xjCnuOvRu
 Rq7QIIV8kinEypJ3LMtM8JF12N6EBMhi/m/wCGj5CwzUdeotrzWhVovloArgqc+rwB+W
 9ElpRAXdgoHSdpNTgPYIFk3a/qA5tmrEcYhVhXDe3xuvKbRAUFKjlo/8EDgKCNkgNUJD
 mrvHScljip6jeb7dLLcXoTPsqLkleUuIxnIEoTnTVsu8djR+uTfOaUFTm2N7VmkS7AjP
 UXi6dZbJUO/HMhn4yl4FvvDnvcSKqMmETn/ScKYvca9X+lSOBgmZqCPfEhxLMzddxXlO
 +lCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=SCX7Y0uWvEKoPRCo0XNxyDaKzLlVeynL0mvSqc+FuX4=;
 b=Q1AgUlPBo/rUWz1IAzAAqc/TNlgPeAr/mNEQL+MI1IFk8oMIJ/Odla4gxBSVx5zEdT
 xSOKCMP4uKLM3LJ6s2c0s8rmixOL3URIItkQDBr4shZkmAJZxNrXYYUmP89BVIvHmLBj
 G4h7dw20Ix5xThPmqhLRi6O/7DYYChXC0youidhjRAcXx0lsUGR/5e4ZnXqZB3moIsiF
 0vSO6EVcBVKwtQ1R3wIqEnoGHi9wsL4pFPORAmi7xgOlgNH6V4yCUHGLSIpIjd6jmLhC
 iPV18TtjszIcBUuU9Vo93r6IBqW+zROQvCUi4CGJ3BGv5XQP1yK+PehMxCHcCBQP4PSF
 HL1w==
X-Gm-Message-State: AOAM532T0cJhN7rhScEaHfWujF9PCFnTjQ+AEo1Lnrq8G+N5XrBaI3t8
 9EPTx2bK7qUrVH4613Ojtcqz4t/r
X-Google-Smtp-Source: ABdhPJzlJAIkbRTOuPhe5nNsHhY8DgUYftFGXBH/mbTxKScPloVRA7XPRE7NpbNUS6yDmKVH+4zRGg==
X-Received: by 2002:a05:600c:c3:: with SMTP id
 u3mr10874782wmm.108.1592204244780; 
 Sun, 14 Jun 2020 23:57:24 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id 23sm20600008wmg.10.2020.06.14.23.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2020 23:57:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] configure: Let SLOF be initialized by
 ./scripts/git-submodule.sh
Date: Mon, 15 Jun 2020 08:57:21 +0200
Message-Id: <20200615065721.7873-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-ppc@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The git-submodule.sh script is called by make and initialize the
submodules listed in the GIT_SUBMODULES variable generated by
./configure.

Add SLOF when we build the ppc64-softmmu target for the pSeries
machines (which use SLOF). This fixes:

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
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
CI: https://travis-ci.org/github/philmd/qemu/jobs/698406512#L1596
---
 configure   | 12 ++++++++++++
 .travis.yml |  1 -
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 7c2adf36e5..f297a4b68f 100755
--- a/configure
+++ b/configure
@@ -2248,6 +2248,18 @@ if test "$edk2_blobs" = "yes" && ! has bzip2; then
   error_exit "The bzip2 program is required for building QEMU"
 fi
 
+###################################
+# SLOF is mandatory for the pSeries
+for target in $target_list; do
+  case $target in
+    ppc64-softmmu)
+      if test -e "${source_path}/.git" ; then
+          git_submodules="${git_submodules} roms/SLOF"
+      fi
+    ;;
+  esac
+done
+
 feature_not_found() {
   feature=$1
   remedy=$2
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


