Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6708AC43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27DB2206BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YzwRBDUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27DB2206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52010 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMo3H-0006qU-CJ
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 02:21:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMncE-0008AW-7u
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMncD-0004ic-Bj
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:42 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMncD-0004hs-5y
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:41 -0400
Received: by mail-pf1-x442.google.com with SMTP id v80so3978159pfa.3
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=tIygHdppWS7z7SV8q8qHfD/88HKRxXbhxr5Q11UfKw4=;
	b=YzwRBDUYyI+7OdmU7QWnzA4M4wRPWQyiLe2O8wSSwfTw8LxY76XYNpjWlY9BkmfwU1
	cLy8SeYKaaJIzj99LMDkUi+2QhQkffw6SupnlwL7pZ96OxuriY/geZ1S87s/tPdAryKl
	/n1EuKMP1I1VCJB6pvWAvBkruTHt3zd27pRnUXUmjQXMxbUW7q6afQn5FkK3WcVfajsY
	FjuchkqNJyuTvw+XXUV/CQVO5lMgJKiNUqgGNfA3eEoPxnOjD8Faf5K59yJFXNA8/G02
	cuJ48NO6Zq3heGCYQ9yGGmkGdDi9jkuQGkEoVdnRUO01JIpu7ssk1NodBA2ygZq1ach7
	mC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=tIygHdppWS7z7SV8q8qHfD/88HKRxXbhxr5Q11UfKw4=;
	b=bsis/6pV//bQ9hJzMNVMlUKytyaNpCP1W1tTGMcomNC5PGAbHHW3dYIWcEnvYgkvn2
	KZud5AMT8gD7OuOW/Yjt0JZ1j0jV0L8Q+LUM4s2wcdgE2qLNy7JkDsxaegZuV1pjT+WM
	KuYC14T6bdFYqoe3fRNeo1RyBf5uNeDUbY0q1rQpPDQKkgfcpDbKphYCx3CFYyhsmr6c
	GdBhueU3oE40zgCwWJaWp2no69QKnKoibnWgy1dDmCCbD+1HzabgXbOpemv9/VXythrn
	z7Z+MyAOw65Si530YBYldm4dVEjTa6x8TpzZh1A2ERhZO8WwoQLBnJVj0jeqpXFHrW37
	4idA==
X-Gm-Message-State: APjAAAUqLxzIVvVF2VNbBND/d0Jj+Ko+iLuIFbyNNJamwTbkLfrOO+5B
	83sq+KSPG5g5lBrVhIEASB7AMVergN0=
X-Google-Smtp-Source: APXvYqxh19wuvR6rP7psaInMqUXBHZgKd6YuAJ9tXLJzRzhl9Q0RkI1LvKeZQvS8Sq8UHN0D+HCrxw==
X-Received: by 2002:a63:e004:: with SMTP id e4mr16248223pgh.344.1556949219880; 
	Fri, 03 May 2019 22:53:39 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	15sm6680423pfo.117.2019.05.03.22.53.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 22:53:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 22:53:00 -0700
Message-Id: <20190504055300.18426-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v3 31/31] tcg/aarch64: Do not advertise minmax
 for MO_64
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190504055300.Yq1XoJDOMFye9BX94nyLPzmg9wb44pEijWjPdQAOhX4@z>

The min/max instructions are not available for 64-bit elements.

Fixes: 93f332a50371
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 5684b39e1f..e13960711d 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -2332,16 +2332,16 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
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


