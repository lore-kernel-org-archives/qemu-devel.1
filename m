Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87580C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:29:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A7020714
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZktoJS4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A7020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWFQM-0002c4-Bo
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 04:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jWFMv-000558-SB; Wed, 06 May 2020 04:25:29 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:45810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jWFMv-00079c-5g; Wed, 06 May 2020 04:25:29 -0400
Received: by mail-lj1-x241.google.com with SMTP id h4so1369269ljg.12;
 Wed, 06 May 2020 01:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4ElgN4Yyb+eIV6c4I3OLIyiUxN+73Gjyr4WakNYFeQ8=;
 b=ZktoJS4mnGX0eZRF6ZloA5KkZz4XYCCAbE04KQ2SJNxGHQl7B07GeW+tRYrgNnCivE
 oSfshteVeUkxRe+7VQJVtr5bgpklAWprrITJNZ+CjteOaINfHvcshLY4f/sWCBcmDVuu
 gSjDLA+2jwNCOj6IfjpQE/q1yHxke8L+EAkPhppNGCNcAm8xuHoLCjrDwwaFAUM0G915
 mte6H4vS4gzYU/aeiKDAENvA5C1jPxBH37ZZPLyDsHZAkeqqHuO42lg0gU/uTiH248Pc
 pGYgAFiHQBhx3AMR149X1n32chHkjPAH7+En5kdK1JS7V1jgQWmTgynn6BpixC1RNrDL
 NZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4ElgN4Yyb+eIV6c4I3OLIyiUxN+73Gjyr4WakNYFeQ8=;
 b=puveFV5aAWbmr64fE7qZwug/3CAbCyv1r5kzplhZMWKTaKHhf9mN0azg607/N5bfmR
 CV4zcE7iHl2XNNqCQXKRgYf6ffTAKOI7y+h/Uu6g+rU56DmahOqUZg0i/Ysg27KVkv5w
 CU4s2CsKIUpBsrfaFXjUuEZnEpyZR2qrM/lo7qNUAbv+k+6fByASxZfEvapvVNonTBkB
 1cXFfvHL+TLyGMKooPp383rNnEMU87xFNXe6bii817QieIepEgH1ePJU0KLFxeznS5qf
 h74k3KKaiI7xUvnLiMz7Awo30we8A6rMcXImTojw7mMr4DcN+xYBdetHRp5oC7uzXoph
 58fA==
X-Gm-Message-State: AGi0PubSSLxw9FsouMxoR2VbSIuAfZqxYEIMY+9tlCoHEp10aH1LvvoH
 pXO34VO11jx07RESrCa7KryM5FNhy7M=
X-Google-Smtp-Source: APiQypIMIB2x/PXhl5mHh41PAmGRb5xaHUGE5ZEHxWY3+T1/Ff3893HuKgTiNv6FwiXOj61SSDviBQ==
X-Received: by 2002:a2e:8807:: with SMTP id x7mr4267886ljh.173.1588753527081; 
 Wed, 06 May 2020 01:25:27 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id h4sm1012453lfc.97.2020.05.06.01.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 01:25:26 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 9/9] MAINTAINERS: Add myself as streams maintainer
Date: Wed,  6 May 2020 10:25:13 +0200
Message-Id: <20200506082513.18751-10-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506082513.18751-1-edgar.iglesias@gmail.com>
References: <20200506082513.18751-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.399, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: damien.hedde@greensocs.com, peter.maydell@linaro.org,
 sstabellini@kernel.org, edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, jasowang@redhat.com, alistair@alistair23.me,
 frederic.konrad@adacore.com, qemu-arm@nongnu.org, philmd@redhat.com,
 luc.michel@greensocs.com, figlesia@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Since we're missing a maintainer, add myself.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1f84e3ae2c..d3663d6c9a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2315,6 +2315,12 @@ F: net/slirp.c
 F: include/net/slirp.h
 T: git https://people.debian.org/~sthibault/qemu.git slirp
 
+Streams
+M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
+S: Maintained
+F: hw/core/stream.c
+F: include/hw/stream.h
+
 Stubs
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
-- 
2.20.1


