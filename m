Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F75DC282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 08:02:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C812087F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 08:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vDULNkCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C812087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38447 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkwj-0006GG-Cm
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 04:02:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXY-00012g-Dc
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXW-0000n9-Dt
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:36:00 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkXW-0000HX-6Y
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:58 -0400
Received: by mail-pf1-x444.google.com with SMTP id 10so3469324pfo.5
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=6wY+MX9gb/NGFl8f/7Ms1g+8OImy6UwT9MWlwo8Wb2o=;
	b=vDULNkCEVDAEy+8uXRYHenNyq/KPXhdCOJ3lrZFI20hgHAtRTlH7kGiNyRof7ozS4Q
	NPHHvzUakzyQzr4B8GH7ydiLHfQ8waw7OF1JntO0EP0R/qC1XqTLNNnUGKBKn7r1UKB5
	8MZkEk7Wk9Jp91DlXm+Jr7qbv/E0wI8Uy2jFwyldJN9DgCRfyU2nPafHXC6QLiCQLrDA
	ywIjTEypuG9Ktp6MgKks6tISpWil9Ai5z3sqAtC2RfS03UuyOvNdiTbgBK8B+IVKBMhG
	Bysz7Da3uI3Iv49GK21bvj/G5CJ42KjH9KsYgF3bJhTfUflP82A/kYal3viogs0Qxxhq
	BRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=6wY+MX9gb/NGFl8f/7Ms1g+8OImy6UwT9MWlwo8Wb2o=;
	b=axu9eZIReIiG9Vn4CXW4qLLS0JYWNQNc6r55ni24mvHYOuS8Pb1qM6w4nuhwRsQFGi
	tZkg2g2USaMsKMPsxgMJQzxTJtS7i0qZXtwgbyStmTDxgX5j7qflawf+3G4XXEQzHFS1
	Gib1N0uBXDgffWiUgn1+VqlCBNqv/DZGhCV5vbDhrExDyeAJe1aUm13HT0ktLsUVR7It
	ibPAG0I5mg65BxSrvlifVAbEX2yeULHdhEPtiV9mLliHEIxJmVSZywrfzAzRRSw2TqK4
	ebSDN/2OC1h7wNOfAAJGzhcq64o8ALMkpX2ZgPnNxKvumUpwU0JxT+L2EF6K8jDQQogw
	qsIw==
X-Gm-Message-State: APjAAAVo9jzQ5PRwtHsK3NA9aXFw0cSLdOBawInNnbSURV8vyiiMFIDJ
	bEedKa8omYdf5gpKb65I5v3Jk+bfwZI=
X-Google-Smtp-Source: APXvYqzDTbHYGE+VpuCEipdw08Q84+/H5R5ektpgf7UBk6NTwlGwz8JrZ+jNBUudHkKi7RtREL3XGQ==
X-Received: by 2002:a63:fa46:: with SMTP id g6mr8134255pgk.382.1555745738114; 
	Sat, 20 Apr 2019 00:35:38 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.35.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:35:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:37 -1000
Message-Id: <20190420073442.7488-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH 33/38] tcg/aarch64: Do not advertise minmax for
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420073437.fei-6hbzl956OisWLIEjBYeTNRWkCSv4p-mAOAV4zTM@z>

The min/max instructions are not available for 64-bit elements.

Fixes: 93f332a50371
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 84d402acd8..e68e4de08c 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -2348,16 +2348,16 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
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


