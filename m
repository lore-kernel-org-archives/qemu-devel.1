Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF89C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:40:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 555A221473
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XXsFSncZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555A221473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi8ie-0004hg-Jo
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 22:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34206)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4pm-0005VG-5o
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:32:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4pa-0000Z3-Gt
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:31:32 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:35322)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi4pN-0000Rm-2w
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:31:19 -0400
Received: by mail-wm1-f48.google.com with SMTP id c6so1160659wml.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 15:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=jCabYHM40d2+5uj/C4fh8Q0u8TCASTWJ9SXGpNj41KI=;
 b=XXsFSncZWydLgSkofGymPCmNeXpPb+XzojABwfhJM4s3nP8u796rxY33Ax/z+gC2YC
 +OtokLgh0WJBZtpDOmx/itDw+leHGTqQU3wyfztKVImLlFQ4/aQe5u7oV7L54kNGVJ0w
 neqCuU4QTMAWXRpj0zraPoy3nNsZVsa6vTzpLniehytLiNuf33AGk5z084fM5Y/YwPIw
 7Qap1Id3u9UJMMnWPAJQ9FzaCiDGy0yVCpph3tOGifMgS5F8nMZoEfM4HDFYVG+dQ0Ek
 LKnNxctda6jF2KJpKJ/iqFDHGoyiVyPmZHy6nXKZ0/bZk50pwd13KuQA5FAZ7YRFHcqA
 a/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jCabYHM40d2+5uj/C4fh8Q0u8TCASTWJ9SXGpNj41KI=;
 b=GaY9ZTk5sySvzx9F3nt8wuwWPDkqcSBIKMq5oyiQAuZG2Z4QcNuZOWam1Y1TwW0c51
 4Mjg+yc1PXUe8lAlZz6pLyAn0jenGGjh1313MDPV/qzfmBy2CIldt9WiKmn5xP+h4zyu
 vyfeRvF+7KLcgYZqZEpIGP3rR1BcTX0tdJXMIOkQUDMSYqn0is/IR25cBrgmeb9iA6tm
 waUTmFOuNFo5Ke4PVgUnsckez51FIWrbuvOnO3B2nfozrW90in2JqMSkc82lPMBROvTI
 ir9JqckhboHPEm9smozzlF4hFGtTH3NX4DvzVDe2K8hKVNNOXdgQs8An/WHzLTIKE6hK
 c8aQ==
X-Gm-Message-State: APjAAAW10RLkXkjebMe/9vLgYpSqTtYbKWiT64ErlOeJ4t19iKStpEMd
 8B96ek4ok3mHJPbuV72ZC3YWtD+rz4BFkA==
X-Google-Smtp-Source: APXvYqyPKBj4F1RrnDKe5X9nBlRcEUF+wdx8NZ8XaCHNez70k2oT9rOTBfGAuDMvsSYwiPfwZiij6g==
X-Received: by 2002:a1c:700b:: with SMTP id l11mr133605wmc.106.1561999218880; 
 Mon, 01 Jul 2019 09:40:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.40.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:40:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:28 +0100
Message-Id: <20190701163943.22313-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.48
Subject: [Qemu-devel] [PULL 31/46] target/arm: Makefile cleanup (softmmu)
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Group SOFTMMU objects together.
Since PSCI is TCG specific, keep it separate.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190701132516.26392-5-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/Makefile.objs | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index 7a933eebc75..3fcda66132a 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -1,8 +1,9 @@
 obj-y += arm-semi.o
-obj-$(CONFIG_SOFTMMU) += machine.o psci.o arch_dump.o monitor.o
 obj-y += helper.o vfp_helper.o
 obj-y += cpu.o gdbstub.o
 obj-$(TARGET_AARCH64) += cpu64.o gdbstub64.o
+
+obj-$(CONFIG_SOFTMMU) += machine.o arch_dump.o monitor.o
 obj-$(CONFIG_SOFTMMU) += arm-powerctl.o
 
 obj-$(CONFIG_KVM) += kvm.o
@@ -35,6 +36,8 @@ obj-y += translate.o op_helper.o
 obj-y += crypto_helper.o
 obj-y += iwmmxt_helper.o vec_helper.o neon_helper.o
 
+obj-$(CONFIG_SOFTMMU) += psci.o
+
 obj-$(TARGET_AARCH64) += translate-a64.o helper-a64.o
 obj-$(TARGET_AARCH64) += translate-sve.o sve_helper.o
 obj-$(TARGET_AARCH64) += pauth_helper.o
-- 
2.20.1


