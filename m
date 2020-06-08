Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83910C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 18:48:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 493772063A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 18:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GVS1zey+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 493772063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiMoz-0000OH-DH
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 14:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jiMdy-0007ky-Sd
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 14:37:10 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jiMdw-0001XK-Q7
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 14:37:10 -0400
Received: by mail-pg1-x542.google.com with SMTP id e9so9116695pgo.9
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 11:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8qc6oDN4Zl6MEuNRZIzxS7SMNWB7rYpnfgGgJ3Ds2L8=;
 b=GVS1zey+JiL1DezhHOb5u5mzona8AwUJxPYKELcvwr+RlFs/gYu+4BrPnxh1KWT/NG
 o1OepK57+v5GRiOwNTYfnmR2Xk7cKaxICELRh/EPSlR4YWwpBmFV9SMk9qxZjTTz0ljb
 Ua43K6UQMIfuY8vizwrkWq1ZZEJvnl1rdmsU0VsWX79ACFSDvTqjJ8e4OxlvNtan4+ow
 77idhvmfENzlWeZMBkDM9pkf8+V6GasxrwCERR84iGbb2KnyDooo5FKH+eaCdovEBnVY
 ixvvsaLdI8VSZdqS/Ymxnuxb852BAQ7u81Hp+ANMq9kM9ACxAEIYbuwSk0EX2dqxXBwC
 l8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8qc6oDN4Zl6MEuNRZIzxS7SMNWB7rYpnfgGgJ3Ds2L8=;
 b=Bf3ZLwj6yMkfsG52eXU5OyjmgNfcng6213TXUgFOYYlUnHJnazUx/TWcG2v2jLivJg
 YFTafWFv8259zBdY6eD93V8co7HsqaILroQNRN/bBqnmhMP+rcTmTha9NQ36EGSsxJ9B
 GTW2PbZXfHuyqoF+GkJS8oX8/r9xEtxvBXFYeTS/LhAnI0tbG5lnsATrgW2BpEdYDuSo
 NZw2S+yonkPxT6MBZbvssXEh8zYe7a5KLvz3lX3ven7UfenKOt2ucGrKiZRe7D+NTG5M
 6r4cGEKdSIIg6XlPLIxX81rJ2D4xiGNVWF4/j0fMJ99A3S1zlXi1XBU0Rtziak0XcFW6
 I++Q==
X-Gm-Message-State: AOAM533K4b1z/Wa3/vCuUTEHQBr2Ir+NTZy5pQ/TShRRFyqxCs5OVmPV
 IW+6ZATKEsl/kzwUeBQCGDZR6XEMLU0=
X-Google-Smtp-Source: ABdhPJwsxJGeSo1UaST1KY4QTHnLdKlq7Zawhpl/iOtDdv+SB5G9anEMdepoJRot9cR8DAOMbz7KRw==
X-Received: by 2002:a65:51c7:: with SMTP id i7mr21553265pgq.382.1591641427019; 
 Mon, 08 Jun 2020 11:37:07 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i22sm7854235pfo.92.2020.06.08.11.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 11:37:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 9/9] target/arm: Use a non-overlapping group for misc
 control
Date: Mon,  8 Jun 2020 11:36:52 -0700
Message-Id: <20200608183652.661386-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608183652.661386-1-richard.henderson@linaro.org>
References: <20200608183652.661386-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The miscellaneous control instructions are mutually exclusive
within the t32 decode sub-group.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/t32.decode | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index c63082fc9c..c21a988f97 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -312,13 +312,13 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
                  &cps
 
     # Miscellaneous control
-    {
+    [
       CLREX      1111 0011 1011 1111 1000 1111 0010 1111
       DSB        1111 0011 1011 1111 1000 1111 0100 ----
       DMB        1111 0011 1011 1111 1000 1111 0101 ----
       ISB        1111 0011 1011 1111 1000 1111 0110 ----
       SB         1111 0011 1011 1111 1000 1111 0111 0000
-    }
+    ]
 
     # Note that the v7m insn overlaps both the normal and banked insn.
     {
-- 
2.25.1


