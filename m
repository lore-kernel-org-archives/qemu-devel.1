Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F883C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 23:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE5222087E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 23:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AuSe0hVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5222087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS8U1-00070U-84
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 18:43:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iS8SA-0005UU-QE
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 18:41:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iS8S9-0004d2-Oj
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 18:41:38 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37421)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iS8S9-0004bm-HA
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 18:41:37 -0500
Received: by mail-wr1-x443.google.com with SMTP id t1so17626746wrv.4
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 15:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RzXz801WN8Wx2siaVGOD6DywcY9lAErvVsKc+KJI/kM=;
 b=AuSe0hVBeklV+RVM2hnDJCbwpAIF4Z34BL4zM7yMYZKcHOZxyxaNgfQrW8ZV8e2e++
 mU6fdzUZqxpe6oeiDXzA9uCIoSJgVAhr7b/1QtNaRVNHvUBIUY6Bxm7G53FA5K4NPGBP
 GJ9CZ3oqTM9W9cQI1PIcE25klx96XF5SI8Gl7A9qc0jz4/DEbFLlCrTcO9BvbruNLsSK
 tmOKG1nUQiVkFT2dRCSVlZfCqlryUNsXrx6ZJlbnHlgsnfZP6qlzw28VHIwg5NpK3UBz
 rRNpgLBG/ZYSofRzRYBaA+B/CL5/wezGWuTonyTcxRinVMLyG161MlWQ/nUg3xsn/S5X
 s/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RzXz801WN8Wx2siaVGOD6DywcY9lAErvVsKc+KJI/kM=;
 b=otWejV2qNYlX0mUM+nsDf8OrZfK6gkJAr8get2rQaQoOf8oL+XvhHJqaNBMYIuC5SE
 NTSGuov/tG/ip8WY1o8JHzow0UnZaVh9mqH4r0idk0PITxf0FOw3/8Q8FVKSFncRP4/k
 dvDyGrAEHyhNNNMhcallHhDZeZTnaC0kCKWilosyvRyHh4ldHxvAUwCQpGUiWQrEMEa4
 1YT9jbJcdiMlM4U5CLY/ktQorjOi47pnsBqgzhbcEXWKsVTgadWuL3qgxQv7ezc+jXqr
 AFQ87vc/2PvHos3NgMViVUGoUgi/OPVn18SpyUX05JCB4/zocpiU+ZuFKeeXj1Fh/PXd
 CdUQ==
X-Gm-Message-State: APjAAAWkRkr3QFpSbFjQzYGLPLsZSszH4bIBNCvxWzpK7D7CMkUPMuyu
 Vn1jh8edVnOtLKqvcUHFXDTvkBdynL9urQ==
X-Google-Smtp-Source: APXvYqyJwJv+kQe8FbjKTbzUGqNNcZWRvqFVq0poixXXwRZvPFUTVnAURAYcejKoEutFVdFYJQErCw==
X-Received: by 2002:adf:d850:: with SMTP id k16mr25717671wrl.204.1572997296466; 
 Tue, 05 Nov 2019 15:41:36 -0800 (PST)
Received: from moi-limbo-9350.home
 (host86-144-13-94.range86-144.btcentralplus.com. [86.144.13.94])
 by smtp.gmail.com with ESMTPSA id q25sm27295010wra.3.2019.11.05.15.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2019 15:41:36 -0800 (PST)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] tcg: cputlb: Add probe_read
Date: Tue,  5 Nov 2019 23:40:57 +0000
Message-Id: <20191105234100.22052-2-beata.michalska@linaro.org>
In-Reply-To: <20191105234100.22052-1-beata.michalska@linaro.org>
References: <20191105234100.22052-1-beata.michalska@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: peter.maydell@linaro.org, quintela@redhat.com, richard.henderson@linaro.org,
 dgilbert@redhat.com, shameerali.kolothum.thodi@huawei.com,
 eric.auger@redhat.com, qemu-arm@nongnu.org, pbonzini@redhat.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add probe_read alongside the write probing equivalent.

Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/exec/exec-all.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index d85e610..350c4b4 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -339,6 +339,12 @@ static inline void *probe_write(CPUArchState *env, target_ulong addr, int size,
     return probe_access(env, addr, size, MMU_DATA_STORE, mmu_idx, retaddr);
 }
 
+static inline void *probe_read(CPUArchState *env, target_ulong addr, int size,
+                               int mmu_idx, uintptr_t retaddr)
+{
+    return probe_access(env, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
+}
+
 #define CODE_GEN_ALIGN           16 /* must be >= of the size of a icache line */
 
 /* Estimated block size for TB allocation.  */
-- 
2.7.4


