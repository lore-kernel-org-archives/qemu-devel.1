Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415DAC433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:20:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D4AC2053B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kqm0/B/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4AC2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04va-0002ry-4T
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 11:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k04uZ-0001Yw-B4
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:19:31 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:41559)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k04uX-0001MB-KZ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:19:31 -0400
Received: by mail-wr1-x42b.google.com with SMTP id r2so10202892wrs.8
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 08:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=uOYlhryYGKuk9GHY1annootwLvGZo9Yx/GyMtSFdjtA=;
 b=Kqm0/B/WozkP+XG2CKFgyPXDYDrLMQnhkh1nKqwyl9HbOmzMU0Fv4i0DcYrXGpY43h
 wfyf827TtCrhfJRS+d2jQd8PrU5Bjq+o+AGP4gzBUBYbM9S/u7QbEK1bQN+Ae48aMXEK
 ajzVXiTZuuFyCHHhK8vmqySZ7O/ip8fp3y+V8uMW4hI3JK1nHPsboNBmfUUgRL6L04UM
 +Mi2pFZOI2dWcXw3VknOZocy75p95BhQasd/9WoLELR0/lL1zYO4uIG5RfvHd1rfP/zO
 PAom2mv8lX5DTbPedvyHJSWeeLTiyZos6YTBfr+BareInztzvEQrh7/GJHhNTf74gtju
 U/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uOYlhryYGKuk9GHY1annootwLvGZo9Yx/GyMtSFdjtA=;
 b=dRFRmw8XOf3fn6yZze6xl/lfGgo7LIzYYQLs9chBtkan8JU2pRixe7p9n6tfGaOF/s
 e0htcddJMagEYmCXSAAqUcTK01M00R2ghem7+Do4+YVB9qnc+XKt/IY3jnwu5fgjQYNc
 PpL3BhLfSju4Xuo9K8QF31OOmnggmNmCq0ifBB8gss6X+dTlEWQJpDLuzgNDASdIxeDO
 cWXxlGZ7AyrcY/aprSfLCH/DRIdjHVwolr8v6BfkxvyWO3Y8E3/PGwR1+O5t5G1fodya
 46m9FCIS3b2O3wZtU1UCkhQNleTfGbXgrT1k6gr4o+HAb4liilv5NSmY7iXHaVfjZEwJ
 bIIQ==
X-Gm-Message-State: AOAM5324CxWO+rDoZivbR0C0xnHiGkwR88W62ZejJZKGYbewI5thoKgk
 C4WmPhP50En4oPtLVgp+ih2tefo82eR2sg==
X-Google-Smtp-Source: ABdhPJwQgjN6+aevGwF9RimnsJW3hna/+qpKOFjRrPYaO2mL1C9rs59/lQPk2IMPlljgvbiH3BmR2w==
X-Received: by 2002:a5d:48c8:: with SMTP id p8mr20277745wrs.84.1595863164850; 
 Mon, 27 Jul 2020 08:19:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h199sm18744996wme.42.2020.07.27.08.19.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 08:19:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/7] ACPI: Assert that we don't run out of the preallocated
 memory
Date: Mon, 27 Jul 2020 16:19:14 +0100
Message-Id: <20200727151920.19150-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200727151920.19150-1-peter.maydell@linaro.org>
References: <20200727151920.19150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dongjiu Geng <gengdongjiu@huawei.com>

data_length is a constant value, so we use assert instead of
condition check.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Message-id: 20200622113146.33421-1-gengdongjiu@huawei.com
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/acpi/ghes.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index b363bc331d0..f0ee9f51caa 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -204,16 +204,12 @@ static int acpi_ghes_record_mem_error(uint64_t error_block_address,
 
     /* This is the length if adding a new generic error data entry*/
     data_length = ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH;
-
     /*
-     * Check whether it will run out of the preallocated memory if adding a new
-     * generic error data entry
+     * It should not run out of the preallocated memory if adding a new generic
+     * error data entry
      */
-    if ((data_length + ACPI_GHES_GESB_SIZE) > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
-        error_report("Not enough memory to record new CPER!!!");
-        g_array_free(block, true);
-        return -1;
-    }
+    assert((data_length + ACPI_GHES_GESB_SIZE) <=
+            ACPI_GHES_MAX_RAW_DATA_LENGTH);
 
     /* Build the new generic error status block header */
     acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE,
-- 
2.20.1


