Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFE8C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 07:54:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA26214AF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 07:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eWVcSsFq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA26214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkkxI-0001EI-9v
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 03:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52223)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hkku9-0005rK-Us
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:51:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hkku8-0001BO-U0
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:51:13 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41979)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hkku8-00019N-Nv
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:51:12 -0400
Received: by mail-pf1-x443.google.com with SMTP id m30so8873280pff.8
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 00:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ty0ceSlhLSlZJKGDv3kDThADamDPPm/37CRvid7ZnoA=;
 b=eWVcSsFq9aLtDqtSBovb1RXNVYi06MIZTx56QqIKqG9j3TY5gU/ZweOs6GXXjFukWQ
 S4ATp2+8TJg2v/yeVLaAqmvZzSsl+LUM4q8tL0YZgdOLJbSqBN6/Wug6OIHfM/X2brty
 nKVnwEp9hwJ6Cpx6HNfpTjEseWl6BAQaQxpDlrJDNuXMVYGBPU5WzSPPdOKK+UM3w4ng
 4K3dH9yX3uRHet9lQitMSsAzaUAc4KmNkkYlSLBK69aRWO5bEG2zuPA91Ef66acY0i8w
 iyXTmAOV/4W5dK7usOsv4rIToP+9LJ5E04FyKHN6nhq3/msOFujHkX0KIE0hSU0qAxPY
 B/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ty0ceSlhLSlZJKGDv3kDThADamDPPm/37CRvid7ZnoA=;
 b=Kp43iMVTTJzAqS+ap49HAXowaKGWneYYxLpjQGauVomO8FaPxAR5+ilrSEIofPkLnX
 G8L5ZPL0vUgiMhz7S5mbmjx3UhvKVJJJCvly3+Xmqk+5A38jgpQ15UYaD+b6VLhx7U5/
 eJuvIHjL0o0uc3UCKB91BCb6z2W+bL0/unku7+XZz1B5caQOu0uuRlwPAsh/Ddnfz1fj
 kZeINUBNRr7gXY0hnC+LohGCHcho4tyG6f1fZY2u9L4M+YbF1mJlPA0kE0q09xyx8Z4A
 5pzvZ4IjOrkiChoOmwOmJuH9O/xaRTZs5ZSygZnlB9owrDI77LWcnyhqaapjTY+Opr3k
 HyFw==
X-Gm-Message-State: APjAAAUe1K0OwZjE5TLxLzuGMsn5bpw1ktMjnQ2A6dfOSnI2/26au0/A
 lVwncFhx+PIe/NUViENGwEyqfwM7nqZwMQ==
X-Google-Smtp-Source: APXvYqwpCI+t2vRHjpzst1jT1BlqSWw5YLmPcAdF1fCem5IQLoeGrtsgGX0OEDE5R65/KPusQXr29A==
X-Received: by 2002:a17:90a:24ac:: with SMTP id
 i41mr30885394pje.124.1562658670711; 
 Tue, 09 Jul 2019 00:51:10 -0700 (PDT)
Received: from localhost.localdomain ([172.56.12.212])
 by smtp.gmail.com with ESMTPSA id y22sm28237375pfo.39.2019.07.09.00.51.07
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 00:51:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 09:50:42 +0200
Message-Id: <20190709075042.13941-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190709075042.13941-1-richard.henderson@linaro.org>
References: <20190709075042.13941-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PULL 3/3] tcg: Fix expansion of INDEX_op_not_vec
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This operation can always be emitted, even if we need to
fall back to xor.  Adjust the assertions to match.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-vec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index c8fdc24f56..6714991bf4 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -90,6 +90,9 @@ bool tcg_can_emit_vecop_list(const TCGOpcode *list,
         case INDEX_op_bitsel_vec:
             /* These opcodes are mandatory and should not be listed.  */
             g_assert_not_reached();
+        case INDEX_op_not_vec:
+            /* These opcodes have generic expansions using the above.  */
+            g_assert_not_reached();
         default:
             break;
         }
@@ -438,11 +441,14 @@ static bool do_op2(unsigned vece, TCGv_vec r, TCGv_vec a, TCGOpcode opc)
 
 void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
 {
+    const TCGOpcode *hold_list = tcg_swap_vecop_list(NULL);
+
     if (!TCG_TARGET_HAS_not_vec || !do_op2(vece, r, a, INDEX_op_not_vec)) {
         TCGv_vec t = tcg_const_ones_vec_matching(r);
         tcg_gen_xor_vec(0, r, a, t);
         tcg_temp_free_vec(t);
     }
+    tcg_swap_vecop_list(hold_list);
 }
 
 void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
-- 
2.17.1


