Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EB4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 19:06:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2623E20792
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 19:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WTOsK1dJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2623E20792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjp0j-0006Co-7B
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 15:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjox4-0000lS-5B
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 15:02:54 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33271)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjox2-0006sg-D9
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 15:02:53 -0400
Received: by mail-wr1-x442.google.com with SMTP id l11so10828599wru.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 12:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ETOQssqeunZMNuQuq6uQLfDZ8XDqPmQMuw/cPtqxYnI=;
 b=WTOsK1dJ344coxHh/p9IMYaPLchiSq/69ZtIMYYksULhBnjdgErp5eykewjDAVAcKc
 stZjNu4/u5QcJBuBEpiubkADWb00ZUC9w9sYbIA7gQr1bQv+XiJT2ep5G1HknqfByZ6L
 jCe4cRNJSHXnLbYNLfyYte3fYunAl7oRhfDCJUymRGFufqOozBfhRhAw/aJpEAA6xdBz
 5T7E0OX/5KoclM4asUDW8X1TP+Jmj8O/34X+FPF7JJIvfr9gkkXe68T64bRRjjmBs6P2
 DX4d62Og0qygg8ZC/yX2CtNqRsPVDCBcnvUFZNe9eQTGHK3pmJPSD68QOlznbFZBEStu
 n7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ETOQssqeunZMNuQuq6uQLfDZ8XDqPmQMuw/cPtqxYnI=;
 b=LcCqQaedbOssR3G///Y6HG9f5fALALE1TwAwwxIUlowidudEyePqKiMEkwe0RxWYhQ
 uvlUMIHWwucgbrMhRh/fMP+HZiCmxwKYLXVY2S4NMioVxtRTQI3n2xHM3eMJNkCOF87g
 HUI1PwMpYszvk25AVm5wsuQv0ELhkQhQh4IJm542cKn6QP8CTLLxySnknx0RwbJlEBOD
 nbsGnh/Jv0bS38PyqBi3Rxm4RxDJd5R0hzpTunI2mLWXJE8SsNRQQw1K4ZfqNkrzYmyJ
 m6hXVC4IlbJ0+fEnbq9zE1UTW4S2LKicXZ4ZqNwLd286L639jeXGArdK7scEBME+slJ3
 4FuA==
X-Gm-Message-State: AOAM5310MGKW403tF8v2zSTu428Ei/iec+z6i3ddhF5qYN3IMbJ7/t0L
 KYp//dMD3hxFdNlheFMW8kUR1Q==
X-Google-Smtp-Source: ABdhPJz4Gc7WwQMb80U1PFfcyk4RxpweZCFkWs/+P5EhamaZefxETqbdejWuic1rUVjiZuokYzkFfQ==
X-Received: by 2002:a5d:4286:: with SMTP id k6mr15817041wrq.140.1591988563534; 
 Fri, 12 Jun 2020 12:02:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a126sm10321622wme.28.2020.06.12.12.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 12:02:39 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 29C241FF8C;
 Fri, 12 Jun 2020 20:02:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 02/18] Makefile: dtc: update, build the libfdt target
Date: Fri, 12 Jun 2020 20:02:21 +0100
Message-Id: <20200612190237.30436-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200612190237.30436-1-alex.bennee@linaro.org>
References: <20200612190237.30436-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, cota@braap.org,
 Claudio Fontana <cfontana@suse.de>, aurelien@aurel32.net
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
---
 configure |  1 -
 Makefile  | 10 +++++-----
 dtc       |  2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/configure b/configure
index 597e909b537..af5d7aa57a1 100755
--- a/configure
+++ b/configure
@@ -4301,7 +4301,6 @@ EOF
           mkdir -p dtc
           if [ "$pwd_is_source_path" != "y" ] ; then
               symlink "$source_path/dtc/Makefile" "dtc/Makefile"
-              symlink "$source_path/dtc/scripts" "dtc/scripts"
           fi
           fdt_cflags="-I\$(SRC_PATH)/dtc/libfdt"
           fdt_ldflags="-L\$(BUILD_DIR)/dtc/libfdt"
diff --git a/Makefile b/Makefile
index d1af126ea19..9385c2e653b 100644
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


