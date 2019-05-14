Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4864EC04AA7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12B102084F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sBXrfU3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B102084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36603 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQL0m-000337-6r
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 20:09:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQKxx-0001cr-E4
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:07:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQKx8-00035H-SK
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:06:45 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:41400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQKx3-0002uf-3g
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:05:52 -0400
Received: by mail-pl1-x634.google.com with SMTP id f12so5249144plt.8
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 17:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=I6td3WuBBk5Qpr2iJ7wAnroVlDoSyj0rbd0/PnMjxvM=;
	b=sBXrfU3h7DR8iOmdcNVwa3erjb1ZKldKP6Cm7+2f/rnMLVzFlj6A5nGT9fWeQh7iob
	WqlZrJe+1lSiEbRNvw7K7uWJyRrRWc4xdB45wwPXImlIsgQd+kuSWLkWC5FY+y1PaPqs
	btYVefJG0d2qEJqf61xxCT4SPE9wM/fqPbzH7Mmba5d+5eWeayHUFwmLwfkA5iGE37uo
	84uxp3ZBOs+y0LPl/5ThT0l29Q7YyoL+UomSkt9jTPBkBkuMoFJS2j5L30jLDBsu5OYW
	Hfg3Ljyed6HMncCMD3E8VJOQS02z+wgfeSpPFKrH8F1e1bCc1ugKfhtWTH+coBVlzNqS
	Qdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=I6td3WuBBk5Qpr2iJ7wAnroVlDoSyj0rbd0/PnMjxvM=;
	b=Nsr+8hQ3uh762datARiizn6MNhQ8GeyjcuH0QwL8GwygVbQzwHaxPEki3V77ptkTlb
	yihwm0FsvDlLOhtB45CjKcfGjgCHPb+YkwS7DVlfWR9GV6JTISlT1N79BTQN2+WQeSF/
	ifgt5ALEpFmF06nPIbNNoXRmYr0mMMo0cmtF2gOb8r1zXApGnD5AYTdRs2yxlcEDQwIt
	dxHDCn1CzROsuBqQtEkgYzmAejzUHqxDVOvSnneThIhft3mqfPNQsSKKRFrkEcCjIMzi
	qS7pzQHc3H5awwKpEaSZtEslaiGrPtIJJMhGHQY7nEGybIpnR8jwf443seoNzBprKC/a
	sQpQ==
X-Gm-Message-State: APjAAAUskd5KcDe9YBR4NtGV1KBs+6nMvLI410GU0k96sk1ihM56Vp1L
	Dh/QSDMRmYfJpMRlZsJxuYADFqf4Bws=
X-Google-Smtp-Source: APXvYqydDPHJ4tv5gigb7yfTDJn1bI2uQaOOScuhExGPscgY3WcmdeugmJZ874rvAm5tjidt9fSwXA==
X-Received: by 2002:a17:902:8c82:: with SMTP id
	t2mr26391194plo.256.1557792345431; 
	Mon, 13 May 2019 17:05:45 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id u3sm238151pfn.29.2019.05.13.17.05.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 17:05:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 17:05:11 -0700
Message-Id: <20190514000540.4313-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514000540.4313-1-richard.henderson@linaro.org>
References: <20190514000540.4313-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::634
Subject: [Qemu-devel] [PULL 02/31] tcg: Do not recreate INDEX_op_neg_vec
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
Cc: peter.maydell@linux.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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


