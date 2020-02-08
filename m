Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF033C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 12:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F9D520726
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 12:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XP/JEWx4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9D520726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Pho-00025N-PV
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 07:59:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgl-0000OO-4p
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgk-0004b7-38
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:23 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45985)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j0Pgj-0004ZQ-TX
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:22 -0500
Received: by mail-wr1-x443.google.com with SMTP id g3so962279wrs.12
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 04:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xtW+FSSefxatLNrrEmn+GvZA5uNXwjZFYEeWUyFoKGE=;
 b=XP/JEWx4NU6g4VtDbSBwPdjxevhfE2JL2asufRvsplPOeEpbiGmuF6hojoO++2faRP
 oCJtNxHVviTQ4hJA0l7a7Wz58hbQUrxQeH6TYFYJf7AiyGzys0DGA91zeD10+wtVf8po
 L3x0zFmcVmTiJJXhhwk8XILyyK9cmqbHPg/fYdtQiGV8WQ8ABcfoHa+wyflJq51Cuowl
 9LiLVMJ0Gy8ap27qVy9pqFGydLaEuu3+/LhWtd98pZlHU1mtXr818qRikMNbp8EY/qAv
 mJchN/TTp7Q6V2yJFmVjlbN6hY/S+QotYuAe17TMI071ksRj0qM74F/QoWUee4A5PzR2
 Hvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xtW+FSSefxatLNrrEmn+GvZA5uNXwjZFYEeWUyFoKGE=;
 b=MI5Og65J8x+JOaAhEZFy707cRIBLBqzhXfSFOiEsje5pxvBwwzPchfhCT56OwOwSO1
 sy/RBNyon1dG1tVqkYUfnKqLPAgY/ZmluOidYnlUWz3rTNutOqV5ym/dUzErBYn6KK5J
 g5nXtCBaFrj/l5Dn8eFI2oPrb5O/vdDoSCiDYSZ9f9iObvmBBGDP1AKMNUyDonGXSdga
 wGvMfSxjAbmSdOymI7DCbC9jdp549Ksi13Qj96qOJwqq12SJ6NPaFVrZDsVW5drbjh/Y
 Bji7xw25oQvY4M5MqHMRnA0CcVlwyZ+dbITjiaB0xWmXlW/jv5ca77AcHFv7YRXethk6
 by5Q==
X-Gm-Message-State: APjAAAXTPzB2+LERNOaoD6EAJCNeqlbcyeZdEHWAuaAAu/DJrQ/6qaiJ
 guYsYTT3sfwVAC+1rPn1yn++i7GKcCtyVw==
X-Google-Smtp-Source: APXvYqx5ICfyIY4JLh+Lj/qOpE8U0o4ZO2dJGSwlUkZhpSqoMwWZVu6ZI/zw7zxljpyATYf/582aow==
X-Received: by 2002:adf:d850:: with SMTP id k16mr5284870wrl.216.1581166700754; 
 Sat, 08 Feb 2020 04:58:20 -0800 (PST)
Received: from localhost.localdomain ([82.3.55.76])
 by smtp.gmail.com with ESMTPSA id p5sm7490534wrt.79.2020.02.08.04.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 04:58:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 03/20] target/arm: Add isar_feature tests for PAN + ATS1E1
Date: Sat,  8 Feb 2020 12:57:59 +0000
Message-Id: <20200208125816.14954-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200208125816.14954-1-richard.henderson@linaro.org>
References: <20200208125816.14954-1-richard.henderson@linaro.org>
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Include definitions for all of the bits in ID_MMFR3.
We already have a definition for ID_AA64MMFR1.PAN.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c63bceaaa5..08b2f5d73e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1727,6 +1727,15 @@ FIELD(ID_ISAR6, FHM, 8, 4)
 FIELD(ID_ISAR6, SB, 12, 4)
 FIELD(ID_ISAR6, SPECRES, 16, 4)
 
+FIELD(ID_MMFR3, CMAINTVA, 0, 4)
+FIELD(ID_MMFR3, CMAINTSW, 4, 4)
+FIELD(ID_MMFR3, BPMAINT, 8, 4)
+FIELD(ID_MMFR3, MAINTBCST, 12, 4)
+FIELD(ID_MMFR3, PAN, 16, 4)
+FIELD(ID_MMFR3, COHWALK, 20, 4)
+FIELD(ID_MMFR3, CMEMSZ, 24, 4)
+FIELD(ID_MMFR3, SUPERSEC, 28, 4)
+
 FIELD(ID_MMFR4, SPECSEI, 0, 4)
 FIELD(ID_MMFR4, AC2, 4, 4)
 FIELD(ID_MMFR4, XNX, 8, 4)
@@ -3443,6 +3452,16 @@ static inline bool isar_feature_aa32_vminmaxnm(const ARMISARegisters *id)
     return FIELD_EX64(id->mvfr2, MVFR2, FPMISC) >= 4;
 }
 
+static inline bool isar_feature_aa32_pan(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->mvfr0, ID_MMFR3, PAN) != 0;
+}
+
+static inline bool isar_feature_aa32_ats1e1(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->mvfr0, ID_MMFR3, PAN) >= 2;
+}
+
 /*
  * 64-bit feature tests via id registers.
  */
@@ -3602,6 +3621,16 @@ static inline bool isar_feature_aa64_lor(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, LO) != 0;
 }
 
+static inline bool isar_feature_aa64_pan(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, PAN) != 0;
+}
+
+static inline bool isar_feature_aa64_ats1e1(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, PAN) >= 2;
+}
+
 static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, BT) != 0;
-- 
2.20.1


