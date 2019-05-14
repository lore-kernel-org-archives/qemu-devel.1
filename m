Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F90C04AA7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA6F20862
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CNs0bde5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA6F20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36666 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQL4G-0006Lm-LY
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 20:13:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQKyp-0001pI-FA
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQKxg-0003s9-65
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:07:31 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:35783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQKxd-0003lk-UZ
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:06:27 -0400
Received: by mail-pf1-x433.google.com with SMTP id t87so8077720pfa.2
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 17:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=1kgfuF1MVun7P1d0mNatwqAFUCrmFPWnRVb1dwFf54w=;
	b=CNs0bde5VHPTPuHdyT+g0uPXyOQVWb/md047xu6VtaJrB1MEpkLQb9pFDedkQpKvgT
	HAx5OUCQF8d5avFy6SjnVSyF6yUlNDcZKeqTaxGCVDQjNP+EIFBVUTlxqijTLEiKimVR
	iLiPo3QWo9cad0mhwMCbwtYM0f4LLWQr1R/80vXKURUm0GO7j3Xc8GnF9leyiarDJkG7
	hSzgCkiAfDVf5rSR9kNtqIJtNwQ6Z+2Wbfc/3FQDTsz7fQzlEZHxnGbLj2KD6nbtzAXt
	sCq/bdfcJ+7tra0yM4Zzf9rjPF2UKl7BzmX9turuqwEsSw+gWTcUefGb932Uh+rCFcTv
	vj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=1kgfuF1MVun7P1d0mNatwqAFUCrmFPWnRVb1dwFf54w=;
	b=A6aXkmQZVxaiKMTQOrdpVj4eSG5GGU0nB2qZzJvhe3yYgAe0Z3GeGughAGqiuLXLg7
	lP68nCF19BMzOPne+NQY5Au2ell3JdPNEfdYKQcfBu4HBm7yekX5tl8HlCAYR6rz63tW
	tUhnlCgQFJlPkUSN7FRIER37ykDlJ0Uvd1SG7D2y25QeJFjbSQ1KKofh4A7JbjPqTsTQ
	K4KpCC6H3gcKQWg2NF2BL32RXGwz9nsS6TbbGxIbijhtozVhvUnXmm9uKcL99gsBj1Wc
	auYVy4REFfGDc0XsRg0DibTCjXYLH6jr69yqfwqDygXujq2Wr09ZJ/FyYA6LS99Lk4Bn
	8A9w==
X-Gm-Message-State: APjAAAUmXEDAhpq4qIdF1GhBGnC4BQJ6fxd1DE+LtT3AvSBNYBQ9uUwa
	QyKlaWgCgLhBW+e3/ijjqlylA9+verY=
X-Google-Smtp-Source: APXvYqwv0l1e7tiu3eE0I1xoJdaY3G+U7DWY1QrkmTdlWQxufDYZI7UFLdq7NoY3HU/6ANwFICgWhw==
X-Received: by 2002:a63:754b:: with SMTP id f11mr35176034pgn.32.1557792382497; 
	Mon, 13 May 2019 17:06:22 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id u3sm238151pfn.29.2019.05.13.17.06.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 17:06:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 17:05:40 -0700
Message-Id: <20190514000540.4313-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514000540.4313-1-richard.henderson@linaro.org>
References: <20190514000540.4313-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::433
Subject: [Qemu-devel] [PULL 31/31] tcg/aarch64: Do not advertise minmax for
 MO_64
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

The min/max instructions are not available for 64-bit elements.

Fixes: 93f332a50371
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 1248dfd04c..40bf35079a 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -2333,16 +2333,16 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_sssub_vec:
     case INDEX_op_usadd_vec:
     case INDEX_op_ussub_vec:
-    case INDEX_op_smax_vec:
-    case INDEX_op_smin_vec:
-    case INDEX_op_umax_vec:
-    case INDEX_op_umin_vec:
     case INDEX_op_shlv_vec:
         return 1;
     case INDEX_op_shrv_vec:
     case INDEX_op_sarv_vec:
         return -1;
     case INDEX_op_mul_vec:
+    case INDEX_op_smax_vec:
+    case INDEX_op_smin_vec:
+    case INDEX_op_umax_vec:
+    case INDEX_op_umin_vec:
         return vece < MO_64;
 
     default:
-- 
2.17.1


