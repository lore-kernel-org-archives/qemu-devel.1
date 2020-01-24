Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC769C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7580620704
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OBbo5yX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7580620704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv1o4-0004tp-FU
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 11:27:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iv1mh-0002SU-Ck
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:26:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iv1mf-0002oD-UP
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:26:15 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:52077)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iv1mf-0002ms-On
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:26:13 -0500
Received: by mail-wm1-x32f.google.com with SMTP id t23so56443wmi.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 08:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oOLCLALD3GcgJUBOZ9tz3obHiRR8ETIrIGcxOBvtbNk=;
 b=OBbo5yX7o6dwaoqXuL1Is8LOx6HZBSkcU0PpObp/WwXEi0/80kPJnas0UZd9jLZzHS
 JL4TA6bXVMCw6MMOLZq3qSXeX3igxYgGOJyfKE1KixG3LQf3nHBha71RTHSFz3wcEBnF
 rWe6l74iNmeCjuLfIc/jlMPQectzaHKORod70eh7XYrSh7htONcZKxV+90sXm/PrtF6i
 Wk87+Y61+cMJeOoC/83aBj/eBl6lyZT4Nw63H1Sca5xITXGZ5Jm0erivwcomMwpj1R9c
 uIqTDHWpVcYfkghknMlwRushYZNinHtAGW+5/oZNs5FWOIzF6smTgYaSy5rllHp35mXd
 aFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oOLCLALD3GcgJUBOZ9tz3obHiRR8ETIrIGcxOBvtbNk=;
 b=nw8JTdAgKxEDShTIBT/jMaP6qapj8qptAcx24QOUBGzylNMix7YBmpDetBBAlZYaSh
 z1zzhEiSoNhrTf2JU0Vm01lBLh78IRij3STngZ3suCvnQBSdITg5tcitr/S4jmYVAejs
 TjcNOpBD/sHenNxnUFGFoPdTndnGHG86w2TMoQVxpHhtlZaLgqDw4RIq97roNtxdxY79
 5QWds5yW8Jbg/IGhi4TPMrGd1AB/mtX9S7n14hMWySjpPL/FXb4a0E3C8mu1L5go5aeq
 zUPNvvAWe/t0exqp5sXHT3p/blVA30tNpOhJkiH2c4CVKNMI8kzRxQXQK7dd0RvLuxUu
 TkQA==
X-Gm-Message-State: APjAAAVwgSY281CUynswnRXmKQZ4D3Vs8HX8giwowA2RxliG7W2VeMpa
 a8QZkd/Qu/2fuqFsF3H0YpLHdX005rlEGA==
X-Google-Smtp-Source: APXvYqyoARovtMX5fFiulhMbDetgUj9B0CwlmuOP9vflUWZdCLIItAd1yVhRGslZjznXYuqslcQrJg==
X-Received: by 2002:a1c:a796:: with SMTP id q144mr70633wme.6.1579883170885;
 Fri, 24 Jan 2020 08:26:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q3sm7054998wmj.38.2020.01.24.08.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 08:26:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/8] Makefile: Ensure we don't run Sphinx in parallel for
 manpages
Date: Fri, 24 Jan 2020 16:25:59 +0000
Message-Id: <20200124162606.8787-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124162606.8787-1-peter.maydell@linaro.org>
References: <20200124162606.8787-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Greg Kurz <groug@kaod.org>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sphinx will corrupt its doctree cache if we run two copies
of it in parallel. In commit 6bda415c10d966c8d3 we worked
around this by having separate doctrees for 'html' vs 'manpage'
runs. However now that we have more than one manpage produced
from a single manual we can run into this again when trying
to produce the two manpages.

Use the trick described in 'Atomic Rules in GNU Make'
https://www.cmcrossroads.com/article/atomic-rules-gnu-make
to ensure that we only run the Sphinx manpage builder once
for each manual, even if we're producing several manpages.
This fixes doctree corruption in parallel builds and also
avoids pointlessly running Sphinx more often than we need to.

(In GNU Make 4.3 there is builtin support for this, via
the "&:" syntax, but we can't wait for that to be available
in all the distros we support...)

The generic "one invocation for multiple output files"
machinery is provided as a macro named 'atomic' in rules.mak;
we then wrap this in a more specific macro for defining
the rule and dependencies for the manpages in a Sphinx
manual, to avoid excessive repetition.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile  | 17 ++++++++++-------
 rules.mak | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 04c77d3b962..9b7ff1dc82f 100644
--- a/Makefile
+++ b/Makefile
@@ -1028,6 +1028,14 @@ build-manual = $(call quiet-command,CONFDIR="$(qemu_confdir)" sphinx-build $(if
 manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst) \
               $(wildcard $(SRC_PATH)/docs/$1/*.rst.inc) \
               $(SRC_PATH)/docs/$1/conf.py $(SRC_PATH)/docs/conf.py
+# Macro to write out the rule and dependencies for building manpages
+# Usage: $(call define-manpage-rule,manualname,manpage1 manpage2...[,extradeps])
+# 'extradeps' is optional, and specifies extra files (eg .hx files) that
+# the manual page depends on.
+define define-manpage-rule
+$(call atomic,$(foreach manpage,$2,$(MANUAL_BUILDDIR)/$1/$(manpage)),$(call manual-deps,$1) $3)
+	$(call build-manual,$1,man)
+endef
 
 $(MANUAL_BUILDDIR)/devel/index.html: $(call manual-deps,devel)
 	$(call build-manual,devel,html)
@@ -1041,14 +1049,9 @@ $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
 $(MANUAL_BUILDDIR)/system/index.html: $(call manual-deps,system)
 	$(call build-manual,system,html)
 
-$(MANUAL_BUILDDIR)/interop/qemu-ga.8: $(call manual-deps,interop)
-	$(call build-manual,interop,man)
+$(call define-manpage-rule,interop,qemu-ga.8 qemu-nbd.8)
 
-$(MANUAL_BUILDDIR)/interop/qemu-nbd.8: $(call manual-deps,interop)
-	$(call build-manual,interop,man)
-
-$(MANUAL_BUILDDIR)/system/qemu-block-drivers.7: $(call manual-deps,system)
-	$(call build-manual,system,man)
+$(call define-manpage-rule,system,qemu-block-drivers.7)
 
 $(MANUAL_BUILDDIR)/index.html: $(SRC_PATH)/docs/index.html.in qemu-version.h
 	@mkdir -p "$(MANUAL_BUILDDIR)"
diff --git a/rules.mak b/rules.mak
index 967295dd2b6..50f6776f529 100644
--- a/rules.mak
+++ b/rules.mak
@@ -399,3 +399,39 @@ GEN_SUBST = $(call quiet-command, \
 
 %.json: %.json.in
 	$(call GEN_SUBST)
+
+# Support for building multiple output files by atomically executing
+# a single rule which depends on several input files (so the rule
+# will be executed exactly once, not once per output file, and
+# not multiple times in parallel.) For more explanation see:
+# https://www.cmcrossroads.com/article/atomic-rules-gnu-make
+
+# Given a space-separated list of filenames, create the name of
+# a 'sentinel' file to use to indicate that they have been built.
+# We use fixed text on the end to avoid accidentally triggering
+# automatic pattern rules, and . on the start to make the file
+# not show up in ls output.
+sentinel = .$(subst $(SPACE),_,$(subst /,_,$1)).sentinel.
+
+# Define an atomic rule that builds multiple outputs from multiple inputs.
+# To use:
+#    $(call atomic,out1 out2 ...,in1 in2 ...)
+#    <TAB>rule to do the operation
+#
+# Make 4.3 will have native support for this, and you would be able
+# to instead write:
+#    out1 out2 ... &: in1 in2 ...
+#    <TAB>rule to do the operation
+#
+# The way this works is that it creates a make rule
+# "out1 out2 ... : sentinel-file ; @:" which says that the sentinel
+# depends on the dependencies, and the rule to do that is "do nothing".
+# Then we have a rule
+# "sentinel-file : in1 in2 ..."
+# whose commands start with "touch sentinel-file" and then continue
+# with the rule text provided by the user of this 'atomic' function.
+# The foreach... is there to delete the sentinel file if any of the
+# output files don't exist, so that we correctly rebuild in that situation.
+atomic = $(eval $1: $(call sentinel,$1) ; @:) \
+         $(call sentinel,$1) : $2 ; @touch $$@ \
+         $(foreach t,$1,$(if $(wildcard $t),,$(shell rm -f $(call sentinel,$1))))
-- 
2.20.1


