Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BE1C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D830F20675
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YajaLebr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D830F20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60748 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL9pD-0005NZ-5c
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:12:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eN-0004Pl-Uf
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eI-0006VI-GK
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:04 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9eE-0006Bn-GO
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:00 -0400
Received: by mail-wr1-x442.google.com with SMTP id o4so5177805wra.3
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=3hCqKWhEs+uyed/mP56baIBgXAfI++APiWRLJhSExvw=;
	b=YajaLebr2q7j6iLHUun3YVVHQEIWyb80UqcvVMn6EM5JmrAR1gJy5nmEDSyzlrcewv
	4SdG2atfrQAWnqPEKOqq24P+eQ9Lt28jnwqKVN5oiEP8BpKgIz9o+PCoefSmV3767DWY
	3vu9vRwOAkqM7MZR7LzSSKfBvTqWQxoW84xRX/MDcaiBgbkiietxVRrerECTNd4K/kHx
	1GAzVLMDgC6U8pky+XP1aRBb/WwZHRvCTqOKn9peQxz4KBlViwfJRE8BDGpawKxON/1W
	mLtDmhCUOtUdRdeGapzyqlwyvq1N06VH+eDGw1xVquEq/YAo6vPA0VGLnGvdeGJ5d3Gk
	UrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=3hCqKWhEs+uyed/mP56baIBgXAfI++APiWRLJhSExvw=;
	b=O8R9vhNeNvRwP7Ni8IOKCbpfY+tyx4agg/ZBiIVqDCunGLjuDVnMIvTAKBK5kPoPuF
	NcfeQRNso0oC0qo5whgbqoVhM8rkRVtZ8GPOoDFgWm3DAo4eEFNoXcsXxQuovH/ry+0E
	AgpTnUEpGKS8hQFWL+BHki8cBMXsVG/kDL6yP+25weU3xkOmxIWQKGG08R0DcybstAsx
	OToDTeAG1dhhGkSJcaoRroBzPmlNSOWq4vx1i221WbhutLspPSmdJX3DG8dLC/RyWAql
	gmsyyrQvv64QJTv3KPOVfwh964kzWvIVl4EIpfglijwhKxDGTs7E5l5EFP9Mqo7nCTzL
	QgLw==
X-Gm-Message-State: APjAAAUWAHsuqmND8YMMbtkvjTUtw2WRUIdmK98+PFDVDu5SQLS7r6hQ
	Pq8VeSOntHMno/bd7lIpIYvXnQYD6fY=
X-Google-Smtp-Source: APXvYqwzyHH1SLKerq7Uy9ZpnU6kU3kdfj6LA0T5koz25AD5rd0842mkiXb7MiwG+ve3zJpsJJ46yA==
X-Received: by 2002:adf:db05:: with SMTP id s5mr10651136wri.247.1556557241813; 
	Mon, 29 Apr 2019 10:00:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.40
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 17:59:55 +0100
Message-Id: <20190429170030.11323-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PULL 07/42] target/arm: Disable most VFP sysregs for
 M-profile
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190429165955.yDEuSYcvo_wLZkf6hQ0pTq-FK3jcbDlP9SgDwce-4So@z>

The only "system register" that M-profile floating point exposes
via the VMRS/VMRS instructions is FPSCR, and it does not have
the odd special case for rd==15. Add a check to ensure we only
expose FPSCR.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-5-peter.maydell@linaro.org
---
 target/arm/translate.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4ea4018e2b8..a9784535069 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3513,12 +3513,27 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                     }
                 }
             } else { /* !dp */
+                bool is_sysreg;
+
                 if ((insn & 0x6f) != 0x00)
                     return 1;
                 rn = VFP_SREG_N(insn);
+
+                is_sysreg = extract32(insn, 21, 1);
+
+                if (arm_dc_feature(s, ARM_FEATURE_M)) {
+                    /*
+                     * The only M-profile VFP vmrs/vmsr sysreg is FPSCR.
+                     * Writes to R15 are UNPREDICTABLE; we choose to undef.
+                     */
+                    if (is_sysreg && (rd == 15 || (rn >> 1) != ARM_VFP_FPSCR)) {
+                        return 1;
+                    }
+                }
+
                 if (insn & ARM_CP_RW_BIT) {
                     /* vfp->arm */
-                    if (insn & (1 << 21)) {
+                    if (is_sysreg) {
                         /* system register */
                         rn >>= 1;
 
@@ -3585,7 +3600,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                     }
                 } else {
                     /* arm->vfp */
-                    if (insn & (1 << 21)) {
+                    if (is_sysreg) {
                         rn >>= 1;
                         /* system register */
                         switch (rn) {
-- 
2.20.1


