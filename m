Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22E4C04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:06:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A2920872
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T2fohxur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A2920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37593 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS4fF-0004SF-Kp
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 15:06:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4dJ-0002nw-7b
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:04:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4ax-0002eT-7f
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:02:12 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS4ax-0002dm-22
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:02:11 -0400
Received: by mail-pf1-x443.google.com with SMTP id v80so5259821pfa.3
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 12:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=h2THfX9yFXUdDN24lXnYzdU4v3sPNpuvs1LZ+ysU720=;
	b=T2fohxur4IW6l9ZWBNTX2HfN2q2lDq6NzTStZEBEfzfNbyatAVicax5GJJXsY3xKjL
	pVrMgNYV3YpkmgoGtxPt6CdDMfJmngTNRhiMZBlJVsRPQ13RL4HIsvNxvQ/QFOnavGRR
	SNYEeGEgRrMd37b304TOf0dZcebF4tuqY+BpL3CvMfKC/3ZsONdt95AKxpL4LEffZJ0Q
	6yhPD9hjQ+rWVA5rCvR2VJsoOoEIVIsFJY8BdwIqZ+OWnMX9px+GRSsDKOzPqfgW7Wuw
	BPA/FJeAqz4hCTD2AOq3+h3VNFGI0ZFpEJUwuOLsJ4t6H5dUYTCpFDi+gKvz4vWaYp1Q
	Ponw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=h2THfX9yFXUdDN24lXnYzdU4v3sPNpuvs1LZ+ysU720=;
	b=ReG1ItfpLk4tPmGErsYfNNCgQEQauyzs+4KQwvYFLDYjbquIaqPuCw/Cv3PCiLSguR
	bJE9o/C2pV1DsImjGl/1YzZRMmC9oSYsCs3AjawFDzKUBBe2YwUkauk737dSfc8NLoMv
	4tJ2pKt8vBgChe031GbPVefGJLKhhN5DqfmRvsBWdlfzI2A1jGsHwPJwasS+6Lwrg2Q0
	SKDd5S0dUbU8UhP6VmoYWSxzUeOxad3q6SZIREakVHftsar9cQZ7nfOLKLyM8hICLR1s
	zmvsghzQ2SoTXw/c9Vs8ucyEPXMRNJfwR9xtlU4OOcQ226LsZK0jkE6MlWtGx2z8NbEP
	PfYw==
X-Gm-Message-State: APjAAAVry/4bosLMwiARxSonj3SgAKvYQifjLiD5elohkZZnyQiFzWBR
	zEpDNwGDDzar1wsgkmcxoWBWjWSCcNw=
X-Google-Smtp-Source: APXvYqyG/JDs/U7gJ3GJ4fwqcrfeImsn+Zie7ehQOfwmTamn6aYkMQtCKlmnGmYDvaaqw5D9u4nIfg==
X-Received: by 2002:a62:e201:: with SMTP id a1mr69446977pfi.67.1558206129695; 
	Sat, 18 May 2019 12:02:09 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id m9sm2751274pgd.23.2019.05.18.12.02.08
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 12:02:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 18 May 2019 12:01:48 -0700
Message-Id: <20190518190157.21255-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190518190157.21255-1-richard.henderson@linaro.org>
References: <20190518190157.21255-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH 07/16] tcg: Add TCG_OPF_NOT_PRESENT if
 TCG_TARGET_HAS_foo is negative
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

If INDEX_op_foo is always expanded by tcg_expand_vec_op, then
there may be no reasonable set of constraints to return from
tcg_target_op_def for that opcode.

Let TCG_TARGET_HAS_foo be specified as -1 in that case.  Thus a
boolean test for TCG_TARGET_HAS_foo is true, but we will not
assert within process_op_defs when no constraints are specified.

Compare this with tcg_can_emit_vec_op, which already uses this
tri-state indication.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-opc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index c7d971fa3d..242d608e6d 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -35,7 +35,7 @@ DEF(call, 0, 0, 3, TCG_OPF_CALL_CLOBBER | TCG_OPF_NOT_PRESENT)
 
 DEF(br, 0, 0, 1, TCG_OPF_BB_END)
 
-#define IMPL(X) (__builtin_constant_p(X) && !(X) ? TCG_OPF_NOT_PRESENT : 0)
+#define IMPL(X) (__builtin_constant_p(X) && (X) <= 0 ? TCG_OPF_NOT_PRESENT : 0)
 #if TCG_TARGET_REG_BITS == 32
 # define IMPL64  TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT
 #else
-- 
2.17.1


