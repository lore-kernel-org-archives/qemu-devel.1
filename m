Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCBDC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:37:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A65D720881
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kloKS3sr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65D720881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52617 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTZrc-0001M0-3i
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 18:37:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZiz-00035A-OB
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZiv-0007Ni-PV
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:41 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29]:34528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTZis-0007LP-0u
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:35 -0400
Received: by mail-yb1-xb29.google.com with SMTP id v78so1508084ybv.1
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 15:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=h2THfX9yFXUdDN24lXnYzdU4v3sPNpuvs1LZ+ysU720=;
	b=kloKS3sr0XYU/InhwH+l7vSipYhfurUNODSj/0nRtWyH1TlryQE6iCEvYC5JN76S4Y
	QjT5mGLvMh3TVYXXjqhLDYtxxSn6mKoR3LISPBRzRruSxfH+C/wowE0APooPS/T1p8+b
	5UXNm+DYewk3nq/q36yZtGQaQ1pSeTfwSwZIOSkI0dG13xKFOCmy0tfTqOATpJWmjjlX
	uyINEgXB6g4fMMremipfHc1Nv7KpfmeYZLTKW4RjC1pNCwq2GzReHvbtF0WDQJHk1FZu
	dFOqROyRQikAcRQr8N7Txc0/zCM5SovjNqSmfNbZAyb5UjyKvg7Vv2CRN6FZRRGiWk5/
	jZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=h2THfX9yFXUdDN24lXnYzdU4v3sPNpuvs1LZ+ysU720=;
	b=a6EXEX7z7aeq42POTHslMhf+q4dHvUcm59aM5CdqlHSPVu9ErfE3s8mxxQG4yOyArd
	+0CBQcsI9xa73XvYx4gfUWyp0FbT7Tm0GOHl9J2+dB9VzHVQB7NnjXyA7DzR1iMb6JUq
	keyq/uWwoLTizKql1mpysYQ1AkPtnIC4Cy8rJMejbEmWbA0WI/DB7WJ3OxjAYKWrzPLU
	70SngtjTok6UdlBmuqClEmXOXY8EM4J/Rn0f28NF4zLmtu/5EMSFqPygFOQQTURfSBLp
	Ev0rIHVDNwLrPloRwsQldmLfRgq+qEZRMAFVq+V6Aed808VRsJx/u/paDTlb1CZJHZiw
	6afg==
X-Gm-Message-State: APjAAAVSCwCcvx7M+NhC31uR7ozGQuEBgyJwhPpuO1TycoLN+E15qjHc
	T2JkoguTL5llmQ2NKz/STIOVtdXeXAw=
X-Google-Smtp-Source: APXvYqxvl13RNClaE8ll1hnOI0i5FOY7lbvsMvnrdyz07jbKvwpVRKY7AB0WTSkdf9CR7NQ96I3hBg==
X-Received: by 2002:a25:3302:: with SMTP id z2mr13908073ybz.437.1558564111712; 
	Wed, 22 May 2019 15:28:31 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id q11sm2276453ywg.7.2019.05.22.15.28.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 15:28:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 18:28:12 -0400
Message-Id: <20190522222821.23850-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522222821.23850-1-richard.henderson@linaro.org>
References: <20190522222821.23850-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b29
Subject: [Qemu-devel] [PULL 07/16] tcg: Add TCG_OPF_NOT_PRESENT if
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
Cc: peter.maydell@linaro.org
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


