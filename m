Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F4CC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:38:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58317214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jwmi22dV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58317214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38364 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSlJJ-0002Gu-Ga
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 12:38:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hSl9H-000387-Ap
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hSl9E-0001Hz-NK
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:28:27 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hSl9B-0001FI-JJ
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:28:23 -0400
Received: by mail-wr1-x443.google.com with SMTP id e15so15346985wrs.4
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 09:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=PkWoGkmjDkhsD31RM3UCQj/839ATuI528gwh2A5xGB8=;
	b=Jwmi22dVbDnOydNY0B5odrgKV11CmiOu58HW75RFMOF+ajMvP6M8TNN9G0wVXg1w4g
	DPknhgM5CQc/ZvzQ2kefCY+bRy8vbb0F1sD4ZlbFWwost/aaHmEE+YJvbgm+RuDWxTa3
	Hn7SexgatDSuWC3WRjuu+f8Pk+/Gt7rSwQbCpVjh5kqgpLHmGFRvsinQszxZAuFgODMm
	rC2geh8z3gCmt/zg6PBCUhI9iLyNThh/rTKFhCnQaKvtkd8lm4dwZc7hGLTfWeUXOfKC
	x1s6JXp/Zho6Pay/ztjRqgVwfVPzxQa1oIzJB9OMYZxA2eQ/6p9Pze4kA46UvvQGeDpO
	A2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=PkWoGkmjDkhsD31RM3UCQj/839ATuI528gwh2A5xGB8=;
	b=hiNxr9eUbp0ZFNV96OEE0fVt7wuyfxFU3wd2/ttDqUpvETEUlyijvZqPMBpundUrYM
	gUdqWk/xe6T1z4lqeZp1lxqPXAL8x2grX7p5jofpudO1kcS6G4zyQopeR8KQgQ2+kdfP
	6yYCpgwh3roXZDQbQ3ezjrIhuMUdeB34Dz1A7vXIEBRGdI14/5khjQEqMQh/5ezLVb9i
	81+n4ziF6tlu7ALUv20fRAzewGHb8gS/vg/VN/xMJmml0nsG58rZHFVOaPM9zyxwLZaM
	xt8E4mD8UooUDCxFkkBR7ySCuH6Bptm5gmNQQwqAaklrtceyHpmvz/p5R5XFRtIOWd5j
	9ypg==
X-Gm-Message-State: APjAAAUAiSAT2P5jNuDfXUcWAmwAFUmloni5xBg9fVhHRU0B/MyPOVWn
	oY2TlSV9KnknkBfhX+VO6DRey6CjmOQ=
X-Google-Smtp-Source: APXvYqyvwza0d1YNjIod0mAxx1dxR6SAwz/9cS1l0kmdV0f5hiAqggXktcxHUsBwJ1fehZDLGDyw/w==
X-Received: by 2002:a5d:4907:: with SMTP id x7mr33644400wrq.199.1558369697410; 
	Mon, 20 May 2019 09:28:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id x2sm5830394wrs.39.2019.05.20.09.28.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 09:28:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 20 May 2019 17:28:09 +0100
Message-Id: <20190520162809.2677-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520162809.2677-1-peter.maydell@linaro.org>
References: <20190520162809.2677-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 4/4] hw/intc/arm_gicv3: Fix writes to
 ICC_CTLR_EL3
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

The ICC_CTLR_EL3 register includes some bits which are aliases
of bits in the ICC_CTLR_EL1(S) and (NS) registers. QEMU chooses
to keep those bits in the cs->icc_ctlr_el1[] struct fields.
Unfortunately a missing '~' in the code to update the bits
in those fields meant that writing to ICC_CTLR_EL3 would corrupt
the ICC_CLTR_EL1 register values.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_cpuif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 000bdbd6247..3b212d91c8f 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -1856,7 +1856,7 @@ static void icc_ctlr_el3_write(CPUARMState *env, const ARMCPRegInfo *ri,
     trace_gicv3_icc_ctlr_el3_write(gicv3_redist_affid(cs), value);
 
     /* *_EL1NS and *_EL1S bits are aliases into the ICC_CTLR_EL1 bits. */
-    cs->icc_ctlr_el1[GICV3_NS] &= (ICC_CTLR_EL1_CBPR | ICC_CTLR_EL1_EOIMODE);
+    cs->icc_ctlr_el1[GICV3_NS] &= ~(ICC_CTLR_EL1_CBPR | ICC_CTLR_EL1_EOIMODE);
     if (value & ICC_CTLR_EL3_EOIMODE_EL1NS) {
         cs->icc_ctlr_el1[GICV3_NS] |= ICC_CTLR_EL1_EOIMODE;
     }
@@ -1864,7 +1864,7 @@ static void icc_ctlr_el3_write(CPUARMState *env, const ARMCPRegInfo *ri,
         cs->icc_ctlr_el1[GICV3_NS] |= ICC_CTLR_EL1_CBPR;
     }
 
-    cs->icc_ctlr_el1[GICV3_S] &= (ICC_CTLR_EL1_CBPR | ICC_CTLR_EL1_EOIMODE);
+    cs->icc_ctlr_el1[GICV3_S] &= ~(ICC_CTLR_EL1_CBPR | ICC_CTLR_EL1_EOIMODE);
     if (value & ICC_CTLR_EL3_EOIMODE_EL1S) {
         cs->icc_ctlr_el1[GICV3_S] |= ICC_CTLR_EL1_EOIMODE;
     }
-- 
2.20.1


