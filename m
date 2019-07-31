Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C491C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:41:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4112320657
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O/GWG1vm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4112320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvPl-0001IE-HN
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60731)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMf-00049A-1E
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMe-0003Md-5y
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:24 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41503)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsvMe-0003Lv-0w
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:24 -0400
Received: by mail-pg1-x544.google.com with SMTP id x15so22297019pgg.8
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 13:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6IeFtwkeZbBPVLT5Rmllb3ExAsBhlKcdIq9EZhAeEOQ=;
 b=O/GWG1vm0GYyFApT/JUxE06dQDg+BEu9I0fKzi/ASPf07ZtfGyq9opJRL4dUai0mux
 eU7ruZSdfVcqEFARLpd/rSUmTwckk6nwb8nEx09lZUMw99HBKO7ZeodlseN5m6Rsr3uH
 NrJCjDhHmDoLZ0APwwhUsUPv0BXorZcsVjzb4X8rp0Vub3WO2fZmfMpt/MeMbSi39hYo
 zPFdo3VDUCJGRtpohDA9p0gKBcFPkEJE5pFVj5dQBsuncOG22hO78T6DZi9w8HYcIYLh
 11FEbIo2DltQXa5cvKMr0mba9j8LftBQuF1tPblPELqpKDxUdJa+QXO4ifV0+230SU8d
 fR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6IeFtwkeZbBPVLT5Rmllb3ExAsBhlKcdIq9EZhAeEOQ=;
 b=eZQwUPSSvEfpXborS0NKu4xQ32gao7VmtrUXeK5i60z8iUc7l9S0MjK3iCW59JVnoI
 PQadLKPmDRRX2zVQVqRgeE0aYaAx8IT6IwQUTlerPx7+wznCXRoITKq5tkUOWz8Mgauy
 aExMzo5Qbz6Lh4Lwm0jkr7EyFwHO1DOMVpuEoegL62OsmXqktay/6mspx/9GbZQ3XX96
 U2itGC4hUtgtyf4TqugoQuwG/iDQF7KTMC4+lV+dO6xmz8lC4207Fx5nq3oV1chdY2sV
 yCLxrNm/piWiom6ckKU9OKkzZVX70ziteWLdQ3wucoV9bYEVgd7RhxX/q+SvqTqFk2yu
 Z8Lg==
X-Gm-Message-State: APjAAAUcGYrwSH4wvZL0exBOdPcD5hNUBCVgj+uGgoTiUVz4xuzUNGsu
 Ev+Q71+tyEsT7/T8lLrs7JF5hwoLGUo=
X-Google-Smtp-Source: APXvYqxPcmvh5VYQWOzxJCBS0y9i2ckmXm+3TIue93ewDGEjwJkruVEQcz4UUPsK8Wr2AXnSKzDx1g==
X-Received: by 2002:a62:2582:: with SMTP id l124mr48886230pfl.43.1564605502801; 
 Wed, 31 Jul 2019 13:38:22 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g4sm84054164pfo.93.2019.07.31.13.38.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 13:38:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:37:47 -0700
Message-Id: <20190731203813.30765-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731203813.30765-1-richard.henderson@linaro.org>
References: <20190731203813.30765-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v2 06/32] target/arm: Define
 isar_feature_aa64_vh
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 94c990cddb..e6a76d14c6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3573,6 +3573,11 @@ static inline bool isar_feature_aa64_sve(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, SVE) != 0;
 }
 
+static inline bool isar_feature_aa64_vh(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, VH) != 0;
+}
+
 static inline bool isar_feature_aa64_lor(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, LO) != 0;
-- 
2.17.1


