Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4ECC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:58:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 154FA20B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W1M6nEko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154FA20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlBA9-0003xL-9d
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 08:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlB5q-0003iQ-T7
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:53:34 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:43215)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlB5n-00005P-Gc
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:53:34 -0400
Received: by mail-wr1-x42a.google.com with SMTP id l10so20620815wrr.10
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 05:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3KvyAfRcofuRLNj4oNNcFUoLgTecr2giSski/lyf7H4=;
 b=W1M6nEkohGCl+xddylcn+tl9y4BEJHcjxXoa0yR20DlLrb5Q1YzHKThse8T2QvbXgM
 dCxmbJqpDAKOru58olIg1cRlow6Bf/Kt4Jdb/90DkAN5XGvQ+UrsUt5CTy9hPaGbcgoJ
 A7KsuYeyPy4mrFJxMroM5Bp1XhspWaKu9Xz5iXWfRF9C13dH4nBIuqSdZjBrhJsgHC9y
 AypSo75qxWJE042//oc5L7U8cq34WVm/vM6kE27S8Y58VqVfomsD3TxkbJFGOHXYFkeZ
 HyYah1QT+XzLjlfGLELBwUxNNL3c5vREcTbDKtfZjtNjVKrz/qJc8heiwrZq7bKNKWmY
 /0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3KvyAfRcofuRLNj4oNNcFUoLgTecr2giSski/lyf7H4=;
 b=K0V6/aAE/vzbzI3MBFFqt5SY6u4fz5xlqcZdR1MVZkOgMTrc8gZYWYTG/hT98m3EAK
 ChIf7Bt+8hbiHrw4DJCUMm6u9QTKkdohITNreBzBSx4H0yKBQ/gAPBkpY7NFB7cHxyhx
 kGNndjsw3QQY6YA3PkPnNNtfTRsuXQ8foswjiEmdOSAhOSirLBKFVfB8qZCXwvfLup55
 JrUTxOIcKlPVsbYTBMl/tr9c06Ksq5uxlUYob08gO1G9ZdFRHE31KCXUQxItvHQkm7vz
 uCKShN1OQsk2r/BdwwBV6kqRgCkAR53BBhBvshsO/pAX8kZ2GWG6Tr4jlZmx258L1JKD
 2wYg==
X-Gm-Message-State: AOAM530yk2UeynfsSeavtaSsp2eYbyb+lhrCmbjiOYYUKPsex0zlldiV
 R5tuh/YXTU0M9dRbH6AKPp5fEw==
X-Google-Smtp-Source: ABdhPJzjcn+rqffc5nOdoPBe2vhynvVSDmfIXka8YY1g1GHXcRqja72sMxtXiMqCAVSwjyz8mLwfvw==
X-Received: by 2002:adf:ed51:: with SMTP id u17mr2735068wro.285.1592312008273; 
 Tue, 16 Jun 2020 05:53:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p16sm31603816wru.27.2020.06.16.05.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 05:53:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 75A7E1FF8C;
 Tue, 16 Jun 2020 13:53:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 02/21] Makefile: dtc: update, build the libfdt target
Date: Tue, 16 Jun 2020 13:53:05 +0100
Message-Id: <20200616125324.19045-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616125324.19045-1-alex.bennee@linaro.org>
References: <20200616125324.19045-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Claudio Fontana <cfontana@suse.de>

dtc submodule update, now call the libfdt target from the new
dtc Makefile, which has been changed to not require bison, flex, etc.
This removes warnings during the build.

scripts/ symlink and tests directory creation are not necessary,
and neither is calling the clean rule explicitly.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200518160319.18861-2-cfontana@suse.de>
Message-Id: <20200612190237.30436-3-alex.bennee@linaro.org>

diff --git a/configure b/configure
index 89867a17208..8a9f544b0b7 100755
--- a/configure
+++ b/configure
@@ -4312,7 +4312,6 @@ EOF
           mkdir -p dtc
           if [ "$pwd_is_source_path" != "y" ] ; then
               symlink "$source_path/dtc/Makefile" "dtc/Makefile"
-              symlink "$source_path/dtc/scripts" "dtc/scripts"
           fi
           fdt_cflags="-I\$(SRC_PATH)/dtc/libfdt"
           fdt_ldflags="-L\$(BUILD_DIR)/dtc/libfdt"
diff --git a/Makefile b/Makefile
index ed0ed93b2d6..895410fbf9c 100644
--- a/Makefile
+++ b/Makefile
@@ -526,13 +526,14 @@ $(SOFTMMU_FUZZ_RULES): $(edk2-decompressed)
 $(TARGET_DIRS_RULES):
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" $(notdir $@),)
 
-DTC_MAKE_ARGS=-I$(SRC_PATH)/dtc VPATH=$(SRC_PATH)/dtc -C dtc V="$(V)" LIBFDT_srcdir=$(SRC_PATH)/dtc/libfdt
+# LIBFDT_lib="": avoid breaking existing trees with objects requiring -fPIC
+DTC_MAKE_ARGS=-I$(SRC_PATH)/dtc VPATH=$(SRC_PATH)/dtc -C dtc V="$(V)" LIBFDT_lib=""
 DTC_CFLAGS=$(CFLAGS) $(QEMU_CFLAGS)
-DTC_CPPFLAGS=-I$(BUILD_DIR)/dtc -I$(SRC_PATH)/dtc -I$(SRC_PATH)/dtc/libfdt
+DTC_CPPFLAGS=-I$(SRC_PATH)/dtc/libfdt
 
 .PHONY: dtc/all
-dtc/all: .git-submodule-status dtc/libfdt dtc/tests
-	$(call quiet-command,$(MAKE) $(DTC_MAKE_ARGS) CPPFLAGS="$(DTC_CPPFLAGS)" CFLAGS="$(DTC_CFLAGS)" LDFLAGS="$(QEMU_LDFLAGS)" ARFLAGS="$(ARFLAGS)" CC="$(CC)" AR="$(AR)" LD="$(LD)" $(SUBDIR_MAKEFLAGS) libfdt/libfdt.a,)
+dtc/all: .git-submodule-status dtc/libfdt
+	$(call quiet-command,$(MAKE) $(DTC_MAKE_ARGS) CPPFLAGS="$(DTC_CPPFLAGS)" CFLAGS="$(DTC_CFLAGS)" LDFLAGS="$(QEMU_LDFLAGS)" ARFLAGS="$(ARFLAGS)" CC="$(CC)" AR="$(AR)" LD="$(LD)" $(SUBDIR_MAKEFLAGS) libfdt,)
 
 dtc/%: .git-submodule-status
 	@mkdir -p $@
@@ -820,7 +821,6 @@ distclean: clean
 	rm -rf $$d || exit 1 ; \
         done
 	rm -Rf .sdk
-	if test -f dtc/version_gen.h; then $(MAKE) $(DTC_MAKE_ARGS) clean; fi
 
 KEYMAPS=da     en-gb  et  fr     fr-ch  is  lt  no  pt-br  sv \
 ar      de     en-us  fi  fr-be  hr     it  lv  nl         pl  ru     th \
diff --git a/dtc b/dtc
index 88f18909db7..85e5d839847 160000
--- a/dtc
+++ b/dtc
@@ -1 +1 @@
-Subproject commit 88f18909db731a627456f26d779445f84e449536
+Subproject commit 85e5d839847af54efab170f2b1331b2a6421e647
-- 
2.20.1


