Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609ADC17441
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 15:58:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21D4021783
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 15:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ABDieHid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D4021783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUC4w-0002vK-Lt
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 10:58:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iUC2z-000188-Gv
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 10:56:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iUC2y-0007oq-DR
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 10:56:09 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:45389)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iUC2y-0007oX-7R
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 10:56:08 -0500
Received: by mail-wr1-x42a.google.com with SMTP id z10so9893602wrs.12
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 07:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GbP966E+hwFEzmq2/6UrRpVDI0sKbu40yL4hEe/FnB0=;
 b=ABDieHidUr+W/Ilp4/wtUODVnWNodQ87G3ZfNBZuVvsu7wyiLl53fgPFvVnYYZKPth
 KE9A2lb9XIPUQln6fJRC7jSeKuLRv5ISr1uqk6Uq+/rBhsg5wVPlN8DtYztwU2bjHZ3M
 IJEf/IfBx080mgXoftVLTAaToYqyZUkU/9mvKEBEALM9n4tZeJufIGFYBzE4xJcApSmP
 p+A+saSOMS5Dcpe2YIvxl8D1LRampS2/U5hC7G0sjRd3H3kGhmDtqISB1CxlQex6Eu5Y
 u24mYSxo8eyRN2k6aLp3q5losNDK1WdarLrRBPSnDkqylDXBhEM8Gjgc830JtJ5mLOR0
 SINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GbP966E+hwFEzmq2/6UrRpVDI0sKbu40yL4hEe/FnB0=;
 b=dXqFkvOo71ZbAJ/9b0Hk+t0FV60LDGvdEOmU+0k9UbQkaxR1KLoEiTuMBiMCiLOnbj
 xa+o/GNzNQbViXPnmNSCwRBhYR4JGqOHdWNFPMPWEe4RaNN0DrsDaxHCk0VFm2EeU7Gw
 2/Fq4FL4W3y0fmC+s7WjoXxO+XLYcDkVRo4rKFsz1dU0bMWhJj7B6+/LDEJAxGPulZlj
 rK8YPlL9vMLmytGlDgpQludBXhla0EbadDDi2p6fZm+TcsPU7npnsKtv4j9Uu+HbURsC
 +vFGhYXBNVERsGW1uXizBqIGxLxZOUBbuVwg98C5VXp96JVEWR7GL35zg56fmfxwDD7s
 JmwQ==
X-Gm-Message-State: APjAAAXxD3sp3qMRVHfZstoG/Orm5CmInv/8vZ/WONK2aP7ARaWVOpBe
 wPSrAGPWXw+xkSj/fOE7hrkS+mQOTdVT/A==
X-Google-Smtp-Source: APXvYqzrSab0iP0Vj8s9HMMhxc/ppHk6vfiiAqjU7T2v0KqGvXPXoNdB2jybzGRv6hRn0XlpjqXbTg==
X-Received: by 2002:a5d:5222:: with SMTP id i2mr21109546wra.271.1573487766862; 
 Mon, 11 Nov 2019 07:56:06 -0800 (PST)
Received: from localhost.localdomain
 (199.red-79-149-206.dynamicip.rima-tde.net. [79.149.206.199])
 by smtp.gmail.com with ESMTPSA id f19sm30023156wrf.23.2019.11.11.07.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 07:56:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/4] tcg/i386/tcg-target.opc.h: Add copyright/license
Date: Mon, 11 Nov 2019 16:55:49 +0100
Message-Id: <20191111155551.13885-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191111155551.13885-1-richard.henderson@linaro.org>
References: <20191111155551.13885-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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

From: Peter Maydell <peter.maydell@linaro.org>

Add the copyright/license boilerplate for tcg/i386/tcg-target.opc.h.
This file has had only one commit, 770c2fc7bb70804a, by
a Linaro engineer.
The license is MIT, since that's what the rest of tcg/i386/ is.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20191025155848.17362-3-peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.opc.h | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/tcg/i386/tcg-target.opc.h b/tcg/i386/tcg-target.opc.h
index e5fa88ba25..1312941800 100644
--- a/tcg/i386/tcg-target.opc.h
+++ b/tcg/i386/tcg-target.opc.h
@@ -1,6 +1,28 @@
-/* Target-specific opcodes for host vector expansion.  These will be
-   emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
-   consider these to be UNSPEC with names.  */
+/*
+ * Copyright (c) 2019 Linaro
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ *
+ * Target-specific opcodes for host vector expansion.  These will be
+ * emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
+ * consider these to be UNSPEC with names.
+ */
 
 DEF(x86_shufps_vec, 1, 2, 1, IMPLVEC)
 DEF(x86_vpblendvb_vec, 1, 3, 0, IMPLVEC)
-- 
2.17.1


