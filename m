Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719B8C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42DEA2075D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cKldk/6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DEA2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv4kI-0006ka-Iw
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 16:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jv4ge-000879-Va
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:04:29 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:37542)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jv4gd-0006IX-8A
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:04:28 -0400
Received: by mail-wm1-x32a.google.com with SMTP id o2so1076464wmh.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 13:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qFhIz7yTIzhv4ZECtrkYR3FRhbXI50/mJD1JravnOmY=;
 b=cKldk/6OJ9BpdVjh3uNLWqHfBSd6Niir92rdbxswNP6nDmR9QnWrzBg9GDexEHeGbp
 cuwBOZN4l9ZDGb3IVGDYL/DQ/1iLT2/4JF71A4Dlno12IOXOO5E2XiNZWLCSw8f5ba68
 lN1EtjT25fdp1Sahr+Sdwl/Igx+0hYbZ8bxxj7OQhB+zPNdzyjzRMA2nLBVgiJsqfq+b
 SQS2Rfc1kEOyHFQsGhHyhIOWH872mQD8sZnaVhraomgGYlh1AJ6MdHmf960SeLhQVIVF
 399lbJ41szLAMILnEI+scbxvptUXbp//E35HmT+7TFXymW4vb9uMOD+7Slno7gf5RGhE
 xZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qFhIz7yTIzhv4ZECtrkYR3FRhbXI50/mJD1JravnOmY=;
 b=RKeOyAmNoTgUvPfTvPcjlsoOlVbZhpmHa8eeY9kGo0WcIK1fMaq8ZSbBx/SAKAVT2p
 3NdInwXfFA5fFsNsKri4en9yAMtZSH0sxyI2hpc4XceJDd8kSehv+lQcLLBu7JHFgUzt
 Lj1TdKChc/xVOybfXDt6T35sN/v0+CxMCHft1ixlJ8OCXQ+x+QX/jCqKIy0tRTsTuyy9
 uDjj4KEmnc1EQF/cAtCwx3hWeNoGrzp+fbur38he8DCzn62cGV9OcLq9R8dbD7+pgus9
 xfr/nVoIG7sjit/y5QihaC0TCys8LDio9Ldr8/xN59F2IQzVNR1LcLo/YQatcHLUm4BR
 mC0w==
X-Gm-Message-State: AOAM532s9IcQx5weRzBrqhu3KsTcXudXHmoCcbYJnadHrBREocIcKkw0
 xe4ePEGIxSh6YiqgGChbLWe68w==
X-Google-Smtp-Source: ABdhPJwxlSKhMU/Vz84Uop3ctb505hTVWJy+k+9QzaLpygNwy/Dh+IOOVEeGCGURh7QmoHOjdYcnIQ==
X-Received: by 2002:a05:600c:2f88:: with SMTP id
 t8mr1030337wmn.186.1594670665891; 
 Mon, 13 Jul 2020 13:04:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f17sm1010645wme.14.2020.07.13.13.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 13:04:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1254D1FF91;
 Mon, 13 Jul 2020 21:04:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 05/11] tests/plugins: don't unconditionally add -Wpsabi
Date: Mon, 13 Jul 2020 21:04:09 +0100
Message-Id: <20200713200415.26214-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713200415.26214-1-alex.bennee@linaro.org>
References: <20200713200415.26214-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Not all compilers support the -Wpsabi (clang-9 in my case). To handle
this gracefully we pare back the shared build machinery so the
Makefile is relatively "standalone". We still take advantage of
config-host.mak as configure has done a bunch of probing for us but
that is it.

Fixes: bac8d222a
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - separate from main build system and check probe
---
 configure             |  3 +++
 tests/plugin/Makefile | 22 ++++++++++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index e1de2f5b24..08eaa99d19 100755
--- a/configure
+++ b/configure
@@ -7112,6 +7112,9 @@ echo "GIT_UPDATE=$git_update" >> $config_host_mak
 
 echo "ARCH=$ARCH" >> $config_host_mak
 
+echo "GLIB_CFLAGS=$glib_cflags" >> $config_host_mak
+echo "GLIB_LDFLAGS=$glib_ldflags" >> $config_host_mak
+
 if test "$default_devices" = "yes" ; then
   echo "CONFIG_MINIKCONF_MODE=--defconfig" >> $config_host_mak
 else
diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
index 3a50451428..e9348fde4a 100644
--- a/tests/plugin/Makefile
+++ b/tests/plugin/Makefile
@@ -1,9 +1,16 @@
+# -*- Mode: makefile -*-
+#
+# This Makefile example is fairly independent from the main makefile
+# so users can take and adapt it for their build. We only really
+# include config-host.mak so we don't have to repeat probing for
+# cflags that the main configure has already done for us.
+#
+
 BUILD_DIR := $(CURDIR)/../..
 
 include $(BUILD_DIR)/config-host.mak
-include $(SRC_PATH)/rules.mak
 
-$(call set-vpath, $(SRC_PATH)/tests/plugin)
+VPATH += $(SRC_PATH)/tests/plugin
 
 NAMES :=
 NAMES += bb
@@ -17,11 +24,18 @@ NAMES += lockstep
 
 SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
 
-QEMU_CFLAGS += -fPIC -Wpsabi
-QEMU_CFLAGS += -I$(SRC_PATH)/include/qemu
+# The main QEMU uses Glib extensively so it's perfectly fine to use it
+# in plugins (which many example do).
+CFLAGS = $(GLIB_CFLAGS)
+CFLAGS += -fPIC
+CFLAGS += $(if $(findstring no-psabi,$(QEMU_CFLAGS)),-Wpsabi)
+CFLAGS += -I$(SRC_PATH)/include/qemu
 
 all: $(SONAMES)
 
+%.o: %.c
+	$(CC) $(CFLAGS) -c -o $@ $<
+
 lib%.so: %.o
 	$(CC) -shared -Wl,-soname,$@ -o $@ $^ $(LDLIBS)
 
-- 
2.20.1


