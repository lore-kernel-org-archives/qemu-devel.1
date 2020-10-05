Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4398DC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:49:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C53092064C
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGDqUxBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C53092064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPMBI-0002ii-Pc
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 04:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmx-0008JE-8e
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:24:07 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:42332)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmv-0007LY-CM
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:24:06 -0400
Received: by mail-wr1-x42d.google.com with SMTP id e18so2568459wrw.9
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 01:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B0EEbOeWpIaNSLCsI3Ua5B6R36+5wfhjeByNHGUXgLM=;
 b=AGDqUxBO7LE0AzTYnXRJaxqLhcPlwqoyEkbPUks14FfvvuXQLHYp9QY8TuTwMLoACC
 XY8p4/3heCRHO8HoZ++Gybrj8flHNzYhdQDuSIA7WACnAs0tdCFxZ5ukC81M07OpznWF
 aZZG7ewWkLXwE6scEFQUIhM0MGIkiEktXYHfvd9aLA1YF6g6xyUlX11VvcbaEL/r+RrH
 X/oIjQ/+d9twbPaxf/JvJlAXgdqj8Q+VixXHlxvoPI1gjFml606VHa62u9pRDfD2OxPy
 2aNyxrT8OOja8uUfBPIDxd174OG97eEIIpw0sSVLMHXm1+A7dWJDpLXDgm9BnoeOIlfv
 N4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=B0EEbOeWpIaNSLCsI3Ua5B6R36+5wfhjeByNHGUXgLM=;
 b=pLZ/+i8fq9jrmkva8d89z3VI7ECfbKuDJPYeLR4/IQ2Vd1jbOlEdPE9H9+H2Bd07y6
 1oPoMRIhtkbLR4aCB1rj24yOKuh8JXvBkAQ2SmPchPM7FKGn35ZNf5wrchUgztnaTZau
 jSjaPCio1lJF103F2sMDinJJkKYpgF7JS8OzPb7cPu2XD5lLMYoKjT/mbfjJ8y06M/ck
 8bEdkkhCpQjLi0rxFMVGoBnObm9DFSkIt38KY+NKQBBVkDd47jyoC1FbN4/eO6Dw0G8K
 osnbJcYwJhv7TwM7I+wL2x+cTjliwiOqEji2aU3N5Xvr4otJh1hjYqgdvMhbGDLd4ZI9
 j5hw==
X-Gm-Message-State: AOAM531WyoMKBDL9iRbG6oaKaIeQMf2eTXnV1X+mwenyqS1xi/RJJ1C2
 Ie2X0XCRI/OGWGE/wUsskByDpDjZ0Yc=
X-Google-Smtp-Source: ABdhPJxH/vnHmR0NiNb+EknotZmxQs9GzicF8VIaSBJ/fPPlz2g5ZOVoi9nIdHNr4ztT4lsgOsfE9w==
X-Received: by 2002:adf:fe48:: with SMTP id m8mr1724887wrs.127.1601886243723; 
 Mon, 05 Oct 2020 01:24:03 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id z15sm11931434wrv.94.2020.10.05.01.24.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 01:24:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/19] tests: tcg: do not use implicit rules
Date: Mon,  5 Oct 2020 10:23:48 +0200
Message-Id: <20201005082349.354095-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005082349.354095-1-pbonzini@redhat.com>
References: <20201005082349.354095-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use pattern rules to clarify which targets are going to match the
rule and to provide clearer error messages.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 40d909badc..5aca98e60c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -50,21 +50,21 @@ RUN_TCG_TARGET_RULES=$(patsubst %,run-tcg-tests-%, $(TARGET_DIRS))
 $(foreach PROBE_TARGET,$(TARGET_DIRS), 				\
 	$(eval -include $(SRC_PATH)/tests/tcg/Makefile.prereqs))
 
-build-tcg-tests-%: $(if $(CONFIG_PLUGIN),test-plugins)
+$(BUILD_TCG_TARGET_RULES): build-tcg-tests-%: $(if $(CONFIG_PLUGIN),test-plugins)
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
 		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
 		SRC_PATH=$(SRC_PATH) \
 	       	V="$(V)" TARGET="$*" guest-tests, \
 		"BUILD", "TCG tests for $*")
 
-run-tcg-tests-%: build-tcg-tests-% all
+$(RUN_TCG_TARGET_RULES): run-tcg-tests-%: build-tcg-tests-% all
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
 		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
 		SRC_PATH=$(SRC_PATH) SPEED="$(SPEED)" \
 		V="$(V)" TARGET="$*" run-guest-tests, \
 		"RUN", "TCG tests for $*")
 
-clean-tcg-tests-%:
+$(CLEAN_TCG_TARGET_RULES): clean-tcg-tests-%:
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
 		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
 		SRC_PATH=$(SRC_PATH) TARGET="$*" clean-guest-tests, \
-- 
2.26.2



