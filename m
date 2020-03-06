Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8A9C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:32:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 591942051A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vMiVjIeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591942051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGpN-0005O8-FH
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:32:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAGbj-0000Tn-IO
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:17:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAGbi-0007mZ-Ax
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:17:55 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:42183)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAGbi-0007jX-42
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:17:54 -0500
Received: by mail-wr1-x433.google.com with SMTP id v11so3244516wrm.9
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 09:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/M3Q1G0HKQfPtdI//TVmv2AXSWRuvnLUfsWsWozX0D8=;
 b=vMiVjIeAxCSysxI6JPX156+OLh+tgh/KmamOQ9kWVz99yx50EFmilqfi+Du8WgkJt7
 dmwTwe2pHPpeMfH9O42kpkugO8n0i7f46KGO++0YSw7O6usRvWgWiGDXElzvThC4td+o
 ij2MmT9GHTDTcqVokYkzETUm74jQb9/CwFYF/hOBZ5M+25z4AU5+QLm76PZBJidLOMtP
 KkzIauGdbzUKRSs/wnKap2WSAnUYSeJ03BfemZLkY5JNbLKE0KXpRpYLzBYKb9B9ZLjI
 3cdhAw8b7YmrKwssOwll0b3EeaKZeU9S1rFU5Sd0gICf+UkbEvwPwFhHl+VMmnGoCc7D
 3G0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/M3Q1G0HKQfPtdI//TVmv2AXSWRuvnLUfsWsWozX0D8=;
 b=lbLYs36JrHzFnMdoSXsRpcJGR4gGLFuLMijv0noV5mC+VzLE5skSos2ax4Si8isSLA
 Oc3gSd4KK6ENZn7HjU93irKZV6gyK4d9Bwo2zzN/mXU29vdSxyVW4kZbss16PFnzTL53
 hl6VkJxUGY46pBAjX9+KjnUIiCO5RgQG2ZQ1M30uM+2eg8VEKgSz6xkG/uLABevNaHxq
 O74iPNL0E4HEpRwNDUiRws/VuGv/m6Iee6pMiMJNd+f+HveeSv5IAJOFxZr7sBUAllcj
 zMGR2xre6rcFEyCOr8/w03yCtYd/WVPRyitwHcpNHF7EFg4e0z/ONN7QiPMJ1MLLQHGz
 oLcQ==
X-Gm-Message-State: ANhLgQ2UcKPaGpmo/qAcxwBijzJD4v1zDzDGDnH6BnC7+GqMsMHmCWeB
 Y9zSDGmuMaE5lSMSNcYubPrIL12zyGiNAA==
X-Google-Smtp-Source: ADFU+vtlRjyus0oCpLOlKh+eLSWNzXhLOPdPTC8SEDPk4wIrTpII0/jC0xQJ8o68Zo4PU4Y4BbkbWw==
X-Received: by 2002:adf:f70f:: with SMTP id r15mr5041239wrp.269.1583515072719; 
 Fri, 06 Mar 2020 09:17:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f8sm6948346wmf.20.2020.03.06.09.17.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 09:17:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/7] Makefile: Remove redundant Texinfo related code
Date: Fri,  6 Mar 2020 17:17:43 +0000
Message-Id: <20200306171749.10756-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306171749.10756-1-peter.maydell@linaro.org>
References: <20200306171749.10756-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The recent conversion of qemu-doc.texi to rST forgot a few stray bits
of makefile code that are now redundant. Remove them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 9d4b2241265..2ccd80065b6 100644
--- a/Makefile
+++ b/Makefile
@@ -761,7 +761,7 @@ rm -f $(MANUAL_BUILDDIR)/$1/objects.inv $(MANUAL_BUILDDIR)/$1/searchindex.js $(M
 endef
 
 distclean: clean
-	rm -f config-host.mak config-host.h* config-host.ld $(DOCS) qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
+	rm -f config-host.mak config-host.h* config-host.ld $(DOCS)
 	rm -f tests/tcg/config-*.mak
 	rm -f config-all-devices.mak config-all-disas.mak config.status
 	rm -f $(SUBDIR_DEVICES_MAK)
@@ -1088,15 +1088,6 @@ $(MANUAL_BUILDDIR)/index.html: $(SRC_PATH)/docs/index.html.in qemu-version.h
 	$(call quiet-command, sed "s|@@VERSION@@|${VERSION}|g" $< >$@, \
              "GEN","$@")
 
-qemu-options.texi: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
-
-qemu-monitor.texi: $(SRC_PATH)/hmp-commands.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
-
-qemu-monitor-info.texi: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
-
 docs/interop/qemu-qmp-qapi.texi: qapi/qapi-doc.texi
 	@cp -p $< $@
 
-- 
2.20.1


