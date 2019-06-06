Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D48AC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:11:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F084420872
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eHm8JCBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F084420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35483 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYvvZ-000833-4x
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 13:11:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYvuf-0007YC-Kp
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYvue-0004gT-DE
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:10:53 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYvue-0004Td-2J
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:10:52 -0400
Received: by mail-wr1-x441.google.com with SMTP id c2so3223882wrm.8
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=+1eWxKuIPwR4Tloaz6TIjljvK8BIfg7auA41U3tlw74=;
	b=eHm8JCBjM0XyARgnPlT4t6xuzBk107s9RI1XrhIde6WogKebEPjG4gIwnNC6VZsbXZ
	JUtnKg3etT5CwY3cjzjUJ7asPZC31xuwfk6W4gTSEFO3zPkSvbgCJL2I9w6rVbqLpJGR
	oIZr4jGcrJZUA1iUCKs7763P7mfAeZEL4HRY57HBJUJuFgwj3GBVoK/lMTgpbqs1BIur
	JL0+bqXia+i1NzhZn8yuJf0HbDqNIpe7umzDmpvdlrxEVvEQpioZDlDN+9b+eoaO1RU/
	Kr2RTjgajdcjtJOopl1PHjWyHZYZpDXW+90fSkjJiOR958b48E3bSZkOrsn1lAwgbHeN
	dHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=+1eWxKuIPwR4Tloaz6TIjljvK8BIfg7auA41U3tlw74=;
	b=EkvLKxbI0ytqvB+GuV2+lzJ+pKYYTiUwQtzH7hGg1mMXcTxwVdKRjNEylC1EbnEazP
	BQiSNCCDJq+AIsoH6p6MhSNuy2AzVcl9leGReLBCk91Gij0REmm4TS3zjvUWGsG2YgzS
	7PjFiKNpKEp7quz4He30UfOOz3lWOz7JN5eOGz11X3S+7sWBXLq7Am22+fYSgYm58GB5
	zgx2K3UK6NoJwo9fuF1Q0tBDEXUkKT4EOIiaGQcUSDCwExp0mkylEAun6wEYmXbuFJjv
	xNTB6J77EhGx/YQsexbWyOEUrfUUFR6jhHk4w8Qp6GYQzd2LYDM0teJFtmvs9Cm54GGi
	75RQ==
X-Gm-Message-State: APjAAAVCwLYwRjMLdHOjb2tLBOTW4KS3zIv7dzJx3/QHi2a6rxYIqfJT
	xZRR9hwDRC0zYh0todyIRuJ05Q==
X-Google-Smtp-Source: APXvYqwoeJpdYcwDBnraakr1HalD+i5z4HQK5p8mePYr3EHi29GHoVOf7xxms6O++Wjj7pUCOcwtkA==
X-Received: by 2002:a5d:53c7:: with SMTP id a7mr16244855wrw.91.1559841048806; 
	Thu, 06 Jun 2019 10:10:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	y184sm3037092wmg.14.2019.06.06.10.10.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:10:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:10:46 +0100
Message-Id: <20190606171046.2732-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH RISU] arm.risu: Add patterns for VFP<->gpreg
 transfers
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add instruction patterns to cover the "transfer between
Arm core and extension register" spaces (A7.8 and A7.9
in DDI0406C.c). We omit VMSR/VMRS because they might
have side effects (for stores to special regs) or give
results dependent on previous execution (for loads).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I think these are the only VFP insns we were missing.

 arm.risu | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/arm.risu b/arm.risu
index af73345..9009e6b 100644
--- a/arm.risu
+++ b/arm.risu
@@ -111,11 +111,6 @@ SBC_imm A1 cond:4 0010110 s:1 rn:4 rd:4 imm:12
 SBC_reg A1 cond:4 0000110 s:1 rn:4 rd:4 imm:5 type:2 0 rm:4
 SBC_rsr A1 cond:4 0000110 s:1 rn:4 rd:4 rs:4 0 type:2 1 rm:4
 
-# vector duplicate (reg)
-# b:e == 11 UNDEF
-VDUP A1a cond:4 1110 1 b 1 0 vd:3 0 rt:4 1011 d 0 e 1 0000 { ($b == 0) || ($e == 0); }
-VDUP A1b cond:4 1110 1 b 0 0 vd:4 rt:4 1011 d 0 e 1 0000 { ($b == 0) || ($e == 0); }
-
 ########### Neon loads and stores #########################
 # These patterns cover all the Neon element/structure
 # load store insns, ie the whole of the space in section
@@ -707,9 +702,6 @@ VFNM A1 cond:4 11101 d 01 vn:4 vd:4 101 sz n op m 0 vm:4
 ########### Extension register load/store #################
 # The following sets of patterns cover:
 #  'extension register load/store insns' (A7.6)
-# Still TODO:
-#  '8, 16 and 32 bit transfers' (A7.8)
-#  '64 bit transfers (A7.9)
 # as described in DDI0406B
 ###########################################################
 
@@ -775,6 +767,31 @@ VLDR A1a cond:4 1101 1 d 01 rn:4 vd:4 101 x imm:8 \
 VLDR A1b cond:4 1101 1 d 01 rn:4 vd:4 101 x imm:8 \
  !memory { reg_minus_imm($rn, $imm * 4); }
 
+########### Extension register transfer ###################
+# The following sets of patterns cover:
+#  '8, 16 and 32-bit transfer between ARM core and
+#  extension registers' (A7.8)
+# as described in DDI0406C
+# with the exception of VMSR/VMRS.
+###########################################################
+
+VMOV_core_single A1 cond:4 1110 000 op:1 vd:4 rt:4 1010 n:1 0010000
+VMOV_core_scalar A1 cond:4 1110 0 opc:2 0 vd:4 rt:4 1011 d:1 opc2:2 10000
+VMOV_scalar_core A1 cond:4 1110 u:1 opc:2 1 vn:4 rt:4 1011 n:1 opc2:2 10000
+
+# vector duplicate (reg)
+# b:e == 11 UNDEF
+VDUP A1a cond:4 1110 1 b 1 0 vd:3 0 rt:4 1011 d 0 e 1 0000 { ($b == 0) || ($e == 0); }
+VDUP A1b cond:4 1110 1 b 0 0 vd:4 rt:4 1011 d 0 e 1 0000 { ($b == 0) || ($e == 0); }
+
+########### Extension register transfer ###################
+# The following sets of patterns cover:
+#  '64-bit transfers between ARM core and extension
+#  registers' (A7.8)
+# as described in DDI0406C
+###########################################################
+VMOV_core_2single A1 cond:4 1100 010 op:1 rt2:4 rt:4 1010 00 m:1 1 vm:4 { ($vm != 0xf || $m != 1) && ($op == 0 || $rt2 != $rt); }
+VMOV_core_double A1 cond:4 1100 010 op:1 rt2:4 rt:4 1011 00 m:1 1 vm:4 { $op == 0 || $rt2 != $rt; }
 
 #####
 # v8 only insns
-- 
2.20.1


