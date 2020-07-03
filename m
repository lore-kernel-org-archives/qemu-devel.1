Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD134C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97A90208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D1VJ+Z/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A90208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrP1y-0005gy-SQ
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxC-0004lh-Hp
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:22 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:38474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxA-0005fj-Uh
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:22 -0400
Received: by mail-wr1-x431.google.com with SMTP id z13so33425843wrw.5
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=kPIFln/ZZd6iY5dygLSdbDis7siBbqefdWWfXW/oq8c=;
 b=D1VJ+Z/b9X9wAPjRAJarSkLmuFafFb7Mns36BzzFhSdOYgJ676oripoY6GlfRqkJ8q
 VOpZ+uQz15mj3I2I+LqoKOtIwHdFvKNxiwNylaW/3rO7u7QCQWfER7oA8pw9QIyey+Ed
 1SQtbPIVGNjl0ZCqyp+ZaOBvoit2Qk3y8HxrcW4t/yB31dTrwOe36atapLh34qLHvYPP
 NsM+dfmNz5GOoKU9o77UcDWON2ldNlzPMUKNQAIqJWNr8Dx34Wu7wWf//lG0R3uCESaW
 wc+/phlunCSIdwC1AeH/4lWFNbkNshM98w23Fv1go86xpT+1U3IvAdXzlzxa/dvaJiv/
 8J9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kPIFln/ZZd6iY5dygLSdbDis7siBbqefdWWfXW/oq8c=;
 b=Bz43f1gc9WNomHbXkU02gqSKq9ctKmDWfrf8igK8kEGS5FO9X3edfyJIX5aMUf/I0+
 YRzooLLetHzRACW/Gv5Yj/4Wlqexc7e1NTwyzj5M4u5rmHAPfUoWA7/13RHzeRBFyG4D
 pgGN+XQS9FwBbBhk1B+V1XuH6b5TaQJZgiGhSYvZ7ba13w5k+VIp6HwDD8wTBhWsjXSE
 dbl7B9LSWqinKofGf2rRUZdSaQVbXZ5ArT1m+PhLzO4ejlUSASOzW7dDGDd1HqbXMmL2
 pNu8VKw+LTXhPaZ4jEe3v0wINFJn5ZdvoC2aFQcmp0i6sx/t+y15zW6Vabcg7m43Su3c
 K+Rg==
X-Gm-Message-State: AOAM533CEKitdvjoyfXE2jq9JGbz+dcZ/xQPfNTqvp9WSNxuRf69a5ON
 uCBSdU/1RrUaSbnjjJvdtdbhRCCkWimAxA==
X-Google-Smtp-Source: ABdhPJy7iVIhm8SzibeBiyyjIgLMe8i0G76kaI8UiNoeybfkDhbFx2o83UXGLNTIV1DeoY/KcQ9xjw==
X-Received: by 2002:adf:e850:: with SMTP id d16mr39253987wrn.426.1593795259234; 
 Fri, 03 Jul 2020 09:54:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/34] tests/acpi: remove stale allowed tables
Date: Fri,  3 Jul 2020 17:53:42 +0100
Message-Id: <20200703165405.17672-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=_AUTOLEARN
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

From: Andrew Jones <drjones@redhat.com>

Fixes: 93dd625f8bf7 ("tests/acpi: update expected data files")
Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20200629140938.17566-2-drjones@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 8992f1f12b7..dfb8523c8bf 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,19 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/pc/DSDT",
-"tests/data/acpi/pc/DSDT.acpihmat",
-"tests/data/acpi/pc/DSDT.bridge",
-"tests/data/acpi/pc/DSDT.cphp",
-"tests/data/acpi/pc/DSDT.dimmpxm",
-"tests/data/acpi/pc/DSDT.ipmikcs",
-"tests/data/acpi/pc/DSDT.memhp",
-"tests/data/acpi/pc/DSDT.numamem",
-"tests/data/acpi/q35/DSDT",
-"tests/data/acpi/q35/DSDT.acpihmat",
-"tests/data/acpi/q35/DSDT.bridge",
-"tests/data/acpi/q35/DSDT.cphp",
-"tests/data/acpi/q35/DSDT.dimmpxm",
-"tests/data/acpi/q35/DSDT.ipmibt",
-"tests/data/acpi/q35/DSDT.memhp",
-"tests/data/acpi/q35/DSDT.mmio64",
-"tests/data/acpi/q35/DSDT.numamem",
-"tests/data/acpi/q35/DSDT.tis",
-- 
2.20.1


