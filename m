Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C885BC43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 05:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91FE92084A
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 05:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j6Ed9zvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91FE92084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51660 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMngQ-0002u1-QV
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 01:58:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbj-0007fx-1o
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbg-00045w-St
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:10 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnbf-00040g-5e
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:07 -0400
Received: by mail-pg1-x544.google.com with SMTP id z16so3752275pgv.11
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=I6td3WuBBk5Qpr2iJ7wAnroVlDoSyj0rbd0/PnMjxvM=;
	b=j6Ed9zvPVfgFE345UhCgcXLjlK9sxLIcyyLAnWDCg+1hj7E7vFyAVBWGtMCSrxQQ5Y
	qSuGenvsDm/nzYq5Ecs/vYbeBjM18NGEPyHRAUAgCMsFtxFyddC6xcUsVHzbIWPmXNzt
	dw90ga+Jemye76G/p5FnfZHonvdt9VHn2BOGgyqfKj9m4pRGr9zvrHJWkxxsRjEj1Lpw
	ZUgCj6jzuWe6hqyPy+/1Tu72JVfoMyRjfCH+A6O4rF0GkBGXCxSkNpTzIyu7h9VrtY2L
	ZTJPDUpiniTuhjXTC/UlkpKPDOpfBF3+qvt8HHjGxRD57ZuuiE9uAZ0oOsQjnTYsLCHB
	GnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=I6td3WuBBk5Qpr2iJ7wAnroVlDoSyj0rbd0/PnMjxvM=;
	b=bDz0HZtLez/U71LsEL/Os0BApdWHFjNgUucS4egiD9igLfuF4XVG+K+FNO1kHilOQN
	HFwJ+umPR9Wo7RSp/0QzZX0qqfyxZqFPVAdbS+yv2g2DKxMItlw6XbWkMLXblslXwEvQ
	mCV/3eVG7bSAt7a+URDGc1yd60HtYtQ4r1z7x/9cI/VG0o/UxuDX0XZANtGT2rDCAY2C
	Hz2hSCRBS/7StOsRWCRIPe5oEuTi1F+voKClwy39GzYMKVUP4++ZygC+LixvvzTdxwAG
	NIBSFO52m3tLEpKCf66iNmndYVJPifr0VBiYZiA9Eqt4RNSS6rjLRq1umICPPnIqRqtF
	VuHA==
X-Gm-Message-State: APjAAAUs2RT9CP0LScz9s60p2vWR4afeCVryoZK/dFcGFW1ah3ZuKHrN
	UO1268ynTh+2bZJj7fHjHA2MxVqResg=
X-Google-Smtp-Source: APXvYqwWcio4EpkiSMPjPx1V1ZNSIO+XAG+g7d14LmJqRPVzigMuxh3okomSefX6pKNw+EKGhJcUdw==
X-Received: by 2002:aa7:86c3:: with SMTP id h3mr16344330pfo.169.1556949185156; 
	Fri, 03 May 2019 22:53:05 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	15sm6680423pfo.117.2019.05.03.22.53.04
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 22:53:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 22:52:31 -0700
Message-Id: <20190504055300.18426-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v3 02/31] tcg: Do not recreate INDEX_op_neg_vec
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
Cc: alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190504055231.PXr1gXBL49JIdILk0ROsHu7QKb2Jdt9NmslTL3lIIFA@z>

Use tcg_can_emit_vec_op instead of just TCG_TARGET_HAS_neg_vec,
so that we check the type and vece for the actual operation.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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


