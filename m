Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2A0C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:03:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85AAD2065D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uL7L7IHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85AAD2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7fjP-0005R7-N6
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1k7fi2-0003Ow-OC; Mon, 17 Aug 2020 10:01:58 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:42834)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1k7fi1-0001Xy-89; Mon, 17 Aug 2020 10:01:58 -0400
Received: by mail-lj1-x243.google.com with SMTP id t6so17571688ljk.9;
 Mon, 17 Aug 2020 07:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SlT2ICdzLrnaoALHk1KYrs2UvgiIgkYCqrO895ftDGQ=;
 b=uL7L7IHmKI2vdrlwkf6ZEfDat3isSF6s8qGdY5mmXT4Rn3KbtB0iBMhiupIoALLebo
 Bm3olxEPYFIvO9BHDQE4zx3reswsX2luEZfDp1GNRWfBHc3S1uQwAWVA30NkDQgD6goT
 Hl/4Opv0mPmhgN1nSfpOFe3XbEIFV7asG1fAp+6Mx7H7oSBvop0N2hM9IMiEYNKvGL1c
 xqhJvQhr5oZXVpSfIqJRNhpMRNBlTaf5hB9ThYO7sDfoSQUmwwRsK6BHREAQ+BYx851V
 zlECUd3+spNZgTK6ZlwuEMu2WnS4dZ1ngdwKh/oqhDk3GvA8Hvt5uvl6zEnmAiUlyNkq
 ylcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SlT2ICdzLrnaoALHk1KYrs2UvgiIgkYCqrO895ftDGQ=;
 b=RcIMLf2hLRb3ijqVjz8lpPZ20vxbUUAuvZnasplZ7XdI5nz6md2GM+wvU1r3l+/eIG
 6j3mwNShMBlgzSoHtm3cm67qDIhJ6LEe5AzrONfrOsFR6NZussO/qlBEfsOabLSohaDG
 04RfArP2/BmQ4tNZ9FEocyY6ARgV0rs/glM2+gUzMDRCEFDl6lH1JOe+EOLPwhwi32v0
 4tdoYUNsxBefjTMDJzyoLy9Ny6hqwid5bw+3Fe1AcGP3etEd44rVu5bnsaA7/ZchILID
 0eI+mbsJtfBjs0P+D2qVsWpIa2y/SvTcYPQulVtW3Fxj+ZQgMcKVlIb2nxNiN03IZwhw
 y6fQ==
X-Gm-Message-State: AOAM531y9ph2VLJ5YCro0ZC02/gTYlwhmB1tIpyRadCg7bc62w5YLEs+
 eqo9XtmDNzgSNBZIGsk2gJHH6GkH7/xqp/bh
X-Google-Smtp-Source: ABdhPJx5uGT4GruugLwOOG23iNxicSNakj2yRZD4C3e0ZLWc5h29Oeukmbrn5xlTYp5iimHQKuPBBQ==
X-Received: by 2002:a2e:85a:: with SMTP id g26mr7652335ljd.319.1597672913915; 
 Mon, 17 Aug 2020 07:01:53 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id l10sm3436818ljc.65.2020.08.17.07.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:01:53 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 5/5] configure: microblaze: Enable mttcg
Date: Mon, 17 Aug 2020 16:01:44 +0200
Message-Id: <20200817140144.373403-6-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200817140144.373403-1-edgar.iglesias@gmail.com>
References: <20200817140144.373403-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 2acc4d1465..2f7adaa6ae 100755
--- a/configure
+++ b/configure
@@ -8162,6 +8162,7 @@ case "$target_name" in
   microblaze|microblazeel)
     TARGET_ARCH=microblaze
     TARGET_SYSTBL_ABI=common
+    mttcg="yes"
     bflt="yes"
     echo "TARGET_ABI32=y" >> $config_target_mak
   ;;
-- 
2.25.1


