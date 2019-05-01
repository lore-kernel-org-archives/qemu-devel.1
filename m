Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0593FC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1BD420866
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bJpHG+XM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1BD420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36249 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLhVm-0001M0-TL
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 01:10:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRI-0006Kt-CF
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRE-0002o4-0u
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:52 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:44994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLhRD-0002nP-R1
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:47 -0400
Received: by mail-pf1-x441.google.com with SMTP id y13so8131342pfm.11
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 22:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=iaXmBLRJ4AetvIw8U8LEOO46+IUqp272JP0xIL80EUs=;
	b=bJpHG+XM9UHP61vhMXtcaKUHzVCkogXlwPAEtaxU7AaLE653zRzyOToaHJbyd66wUe
	AmdPT2g7oEubhmctL2Rwf/jzl48qp79Uzc6/Cjqb8rDq9JTsBjrLYFDlxHhphTS8Bufe
	N3tw9w+NaZd+0ZCeR8JBU94rhBmR5jBdDEiJatZFTWY7wOMZJA3PX9Huw4F4p2gDNBJ4
	FneJBv2PidSECvG1y7CGKKut+y0c+MpOpLSOdCu7gHbRYkrbULBqrCL+JcD58qpbiIuD
	TiNLGGekouyMCYEsfznwc3vkF+xv7ZG7YaHa5RCBeQ7n/9Pe/O+4TM2ySXey800Szdra
	El0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=iaXmBLRJ4AetvIw8U8LEOO46+IUqp272JP0xIL80EUs=;
	b=imE5Sdc5PsVbceHedF+jolMhOqrWPXYRnujTX3mZAmZT4DnYEzLy5FpGe77dJB0YL/
	KvdugtONcSPjqJYaIi+S+xHftq3GGhlPLjmHYCNq86c3go84A5U+YeCSNM8hZ33iFWTX
	fW/q9Uw8JKWHf1Fxj2VMlvOEm4Xr/j9rF907F0fxrXrZDRB53lWh4YWg0oaye6pehbb2
	M1xT565d3/RyuGFxFK8++yQp9LXsdd067RcUKnj9OI1ShmR/7ombE+EhT06zmBCRMrrk
	OYPovdf357j+fJHNozZ6HL1iSHOO8+mnZnp+HcKHpAQ/ZobXzaKYDJHbV9phXgvuoB28
	MXnQ==
X-Gm-Message-State: APjAAAUR7UNUVmwQGhILH+/ve271PxVSvoTOxxMXOLPuNTjcbIiYT2ZV
	PRFUABv4G2oaH8eD6VfbsIF7f1LoTFo=
X-Google-Smtp-Source: APXvYqzByx6ts/TL86aIBY9pTbQ5MkKH6y69TGu79jnENQ5NqfRdTcozHRtQGt7iS8k9qpIAh4OP9g==
X-Received: by 2002:a63:564f:: with SMTP id g15mr18297097pgm.258.1556687146456;
	Tue, 30 Apr 2019 22:05:46 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	t127sm9687251pfb.106.2019.04.30.22.05.45 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 22:05:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 22:05:09 -0700
Message-Id: <20190501050536.15580-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501050536.15580-1-richard.henderson@linaro.org>
References: <20190501050536.15580-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v2 02/29] tcg: Do not recreate INDEX_op_neg_vec
 unless supported
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
Message-ID: <20190501050509.67OqpMvTGNFPSofV_BjhUhe2-yg0Y3pGo2xtkVUFqPU@z>

Use tcg_can_emit_vec_op instead of just TCG_TARGET_HAS_neg_vec,
so that we check the type and vece for the actual operation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 5150c38a25..24faa06260 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -734,9 +734,13 @@ void tcg_optimize(TCGContext *s)
                 } else if (opc == INDEX_op_sub_i64) {
                     neg_op = INDEX_op_neg_i64;
                     have_neg = TCG_TARGET_HAS_neg_i64;
-                } else {
+                } else if (TCG_TARGET_HAS_neg_vec) {
+                    TCGType type = TCGOP_VECL(op) + TCG_TYPE_V64;
+                    unsigned vece = TCGOP_VECE(op);
                     neg_op = INDEX_op_neg_vec;
-                    have_neg = TCG_TARGET_HAS_neg_vec;
+                    have_neg = tcg_can_emit_vec_op(neg_op, type, vece) > 0;
+                } else {
+                    break;
                 }
                 if (!have_neg) {
                     break;
-- 
2.17.1


