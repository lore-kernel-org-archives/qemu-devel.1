Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36099C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 20:00:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E46EE20838
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 20:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FgJM1Jy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E46EE20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5DyJ-0002wA-3G
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 16:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Dot-0000z1-0P
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:55 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45366)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Doq-0004uv-Rw
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:54 -0400
Received: by mail-wr1-x444.google.com with SMTP id z18so9297904wrm.12
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4PyfQa7ahU945SxQ17WhvHpJu4ijwLrsrnt3XXoa7zs=;
 b=FgJM1Jy9C1ig1fGoH+pMZIRzN3e75IH2TckgsHj9aKpRKDd8yyF9m9jCaOXfkQZua8
 0L2GmqeF2EJvogAMEilz+Es6F4Bim7OH30qJsNOFla89OTc+dINiXOqK2N3gcHdqjPg0
 ArIzPBSVujv7GU5fT4NM7Yx+y8UV1YlO/Uudc9MrfD0pWqSR6c3lC/vO+6CQt1zXuvqf
 zg+gbKtq2/r30CvHL7Vlj8/0n0j+9PmCSVDgDc3/Dsrudz0KNe5QsYqEGO4HjfMrJjc7
 Co/sY/JLtpOC9iWsEe9luzei8wcKlgJlhiSIVH8YCBcyetkYgOBWv9CJ1yKUeZnnoyrf
 Zkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4PyfQa7ahU945SxQ17WhvHpJu4ijwLrsrnt3XXoa7zs=;
 b=iGs0qDm8LGr7YzFwJrVTb2pGCQ+PFC6t6m0Lnd94QqM38ASNo8HyYjT0sqZvt4UVb6
 Y4vQ1e5JnWwXmbUrktQZRaleasxN00LJAi3+V7mXa5LA7pR/QrE7tP8m1JWJ3ulnh2+r
 pSZldRumyYM74IQb3gQcOXw9ZOdvPuyTJQ+v4x/nafaNciQaMu5fXzlRx10tvVtHrakl
 Xant4elycnd7ShrTQKg/TUwMMBpYblG0AmuoltWTJG2sm52Or76vCVVRg00uBlRBWppJ
 hy6V3aYuBwhpkOFyaW9e/oATaexszE2Q31B4V/EP7+VePdKFeUlE3u4y4rid7SVibjG+
 845A==
X-Gm-Message-State: AOAM530MMbQ6+RD7igrGw/4g0TwDE17dNiOm/U8uSlQhWp16herm8ddi
 XePYCONZh7yykx950EGFkAnAtTNo+w4u6g==
X-Google-Smtp-Source: ABdhPJxTgoILl2GusDc29acGF0+QwedND82L+3/InJ5HGSrf5HQCgjib3gRenbtqxO4IAflw9PJqRA==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr25808161wrc.257.1597089049283; 
 Mon, 10 Aug 2020 12:50:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b129sm976087wmb.29.2020.08.10.12.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 12:50:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 16/20] Makefile: Remove redundant Texinfo related rules
Date: Mon, 10 Aug 2020 20:50:15 +0100
Message-Id: <20200810195019.25427-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200810195019.25427-1-peter.maydell@linaro.org>
References: <20200810195019.25427-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We now don't build anything from Texinfo, so we can remove
some redundant Makefile pattern rules and the rule for
generating the version.texi file that used to be included
from many Texinfo source files.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile  | 31 +------------------------------
 rules.mak | 14 +-------------
 2 files changed, 2 insertions(+), 43 deletions(-)

diff --git a/Makefile b/Makefile
index fc3ccc15030..1bc0f4f1d5c 100644
--- a/Makefile
+++ b/Makefile
@@ -759,8 +759,7 @@ clean: recurse-clean
 		! -path ./roms/edk2/BaseTools/Source/Python/UPT/Dll/sqlite3.dll \
 		-exec rm {} +
 	rm -f $(edk2-decompressed)
-	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *.pod *~ */*~
-	rm -f fsdev/*.pod scsi/*.pod
+	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *~ */*~
 	rm -f qemu-img-cmds.h
 	rm -f ui/shader/*-vert.h ui/shader/*-frag.h
 	@# May not be present in generated-files-y
@@ -795,7 +794,6 @@ distclean: clean
 	rm -f qemu-plugins-ld.symbols qemu-plugins-ld64.symbols
 	rm -f config.log
 	rm -f linux-headers/asm
-	rm -f docs/version.texi
 	rm -rf .doctrees
 	$(call clean-manual,devel)
 	$(call clean-manual,interop)
@@ -1015,31 +1013,6 @@ ui/shader.o: $(SRC_PATH)/ui/shader.c \
 	ui/shader/texture-blit-frag.h
 
 # documentation
-MAKEINFO=makeinfo
-MAKEINFOINCLUDES= -I docs -I $(<D) -I $(@D)
-MAKEINFOFLAGS=--no-split --number-sections $(MAKEINFOINCLUDES)
-TEXI2PODFLAGS=$(MAKEINFOINCLUDES) -DVERSION="$(VERSION)" -DCONFDIR="$(qemu_confdir)"
-TEXI2PDFFLAGS=$(if $(V),,--quiet) -I $(SRC_PATH) $(MAKEINFOINCLUDES)
-
-docs/version.texi: $(SRC_PATH)/VERSION config-host.mak
-	$(call quiet-command,(\
-		echo "@set VERSION $(VERSION)" && \
-		echo "@set CONFDIR $(qemu_confdir)" \
-	)> $@,"GEN","$@")
-
-%.html: %.texi docs/version.texi
-	$(call quiet-command,LC_ALL=C $(MAKEINFO) $(MAKEINFOFLAGS) --no-headers \
-	--html $< -o $@,"GEN","$@")
-
-%.info: %.texi docs/version.texi
-	$(call quiet-command,$(MAKEINFO) $(MAKEINFOFLAGS) $< -o $@,"GEN","$@")
-
-%.txt: %.texi docs/version.texi
-	$(call quiet-command,LC_ALL=C $(MAKEINFO) $(MAKEINFOFLAGS) --no-headers \
-	--plaintext $< -o $@,"GEN","$@")
-
-%.pdf: %.texi docs/version.texi
-	$(call quiet-command,texi2pdf $(TEXI2PDFFLAGS) $< -o $@,"GEN","$@")
 
 # Sphinx builds all its documentation at once in one invocation
 # and handles "don't rebuild things unless necessary" itself.
@@ -1109,8 +1082,6 @@ $(MANUAL_BUILDDIR)/index.html: $(SRC_PATH)/docs/index.html.in qemu-version.h
 
 html: sphinxdocs
 
-$(filter %.1 %.7 %.8,$(DOCS)): scripts/texi2pod.pl
-
 # Reports/Analysis
 
 %/coverage-report.html:
diff --git a/rules.mak b/rules.mak
index 694865b63ee..1dc2a353ee6 100644
--- a/rules.mak
+++ b/rules.mak
@@ -144,7 +144,7 @@ cc-option = $(if $(shell $(CC) $1 $2 -S -o /dev/null -xc /dev/null \
 cc-c-option = $(if $(shell $(CC) $1 $2 -c -o /dev/null -xc /dev/null \
                 >/dev/null 2>&1 && echo OK), $2, $3)
 
-VPATH_SUFFIXES = %.c %.h %.S %.cc %.cpp %.m %.mak %.texi %.sh %.rc Kconfig% %.json.in
+VPATH_SUFFIXES = %.c %.h %.S %.cc %.cpp %.m %.mak %.sh %.rc Kconfig% %.json.in
 set-vpath = $(if $1,$(foreach PATTERN,$(VPATH_SUFFIXES),$(eval vpath $(PATTERN) $1)))
 
 # install-prog list, dir
@@ -381,18 +381,6 @@ define unnest-vars
         $(eval $v := $(filter-out %/,$($v))))
 endef
 
-TEXI2MAN = $(call quiet-command, \
-	perl -Ww -- $(SRC_PATH)/scripts/texi2pod.pl $(TEXI2PODFLAGS) $< $@.pod && \
-	$(POD2MAN) --section=$(subst .,,$(suffix $@)) --center=" " --release=" " $@.pod > $@, \
-	"GEN","$@")
-
-%.1:
-	$(call TEXI2MAN)
-%.7:
-	$(call TEXI2MAN)
-%.8:
-	$(call TEXI2MAN)
-
 GEN_SUBST = $(call quiet-command, \
 	sed -e "s!@libexecdir@!$(libexecdir)!g" < $< > $@, \
 	"GEN","$@")
-- 
2.20.1


