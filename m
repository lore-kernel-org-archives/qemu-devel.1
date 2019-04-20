Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3C9C282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:53:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A48D21479
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DS4tB6EW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A48D21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38315 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkoZ-0007Ic-Cj
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:53:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXI-0000ku-8P
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXD-0000I0-Ak
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:42 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkXB-0008W6-ST
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:37 -0400
Received: by mail-pf1-x441.google.com with SMTP id t21so3478344pfh.2
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=pqun8ODH+BipBhEXC50lCfhJUx093WlLNlb2HRBn9Eg=;
	b=DS4tB6EWM9gB0boq5JwaDI+1dKKq4nZiqPuTm2e+J23E00Ib006TXDMiz6ohJZJuQN
	lyhJGPbkO3XAYK2A9jEnqTRxoY3mdrQgIp9tEgvIHZNRr2ldYph35frWtwvriq9jhH1K
	gdgxybrqfyESTv2WiK/G0+qX1qj/QEhq1tM4lNsixIl9Huqmz7GjZeCmBT8/BElRzlrQ
	vI3tquo9tbbX2N4zLL5UK7xpVJB4+0rMmWEDmqE283vrKJvUxJi5ya7zBInkhVNb4iPx
	1sK1xnvx2mHRIxX2FtW4DBzehtOJBE/qIlOQGc7jUVWY1VLjvXVlED6VEwLO+7ynMoDt
	TgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=pqun8ODH+BipBhEXC50lCfhJUx093WlLNlb2HRBn9Eg=;
	b=MNx7nnFiiw112E9Y05TraSpgvkCkWkUdt89wHAAKaoaDvICLLLU94kMhHgx5NY8JOO
	DuALKkVZNCEcmYhgEH3PaCZQRVdBRLg75mXd/2TtznTCelcH2NYq9MMH/ffVu1xo7DEl
	EcxIj5ouCVE9d0RLa9L8GX1H5WoLh4k7usWpPTm8qhFiaNjCONi9ZE0+BQHxqVTq0z5t
	Vy369Kqd59YQwmIKVNnmPc9zhbyMbCE9W/HIqVURsWRNwnbU/IOV4ZGcbmex7UeQJn4K
	9Xkk6+rS2PXl2YDoYyZaGgSXMc8zSo85wtEuE/XpKIUhDtkOLZbefVREJGY0okZCqvPr
	FmMA==
X-Gm-Message-State: APjAAAWFWJRJbDsQIlL5m8zjDSLHOL2E3rg4dvHYXBxHDuTcTvZmvLCB
	wMcfgGrY03vikuYXRpMts+i9NoO4FeM=
X-Google-Smtp-Source: APXvYqznuYg6IgFeZUVoiellRammUI6C/wFdUt/DZK5F/mupe/ulSlJ+RYm599rlUHW1GzDrq6miAw==
X-Received: by 2002:a62:388d:: with SMTP id f135mr8555509pfa.103.1555745726081;
	Sat, 20 Apr 2019 00:35:26 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.35.24
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:35:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:29 -1000
Message-Id: <20190420073442.7488-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH 25/38] target/xtensa: Use tcg_gen_abs_i32
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
Message-ID: <20190420073429.zHuflu3VWBzpt6RvgEa4k2Itk-SwPxMirSONWydQXKs@z>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/translate.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 65561d2c49..62be8a6f6a 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1707,14 +1707,7 @@ void restore_state_to_opc(CPUXtensaState *env, TranslationBlock *tb,
 static void translate_abs(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
-    TCGv_i32 zero = tcg_const_i32(0);
-    TCGv_i32 neg = tcg_temp_new_i32();
-
-    tcg_gen_neg_i32(neg, arg[1].in);
-    tcg_gen_movcond_i32(TCG_COND_GE, arg[0].out,
-                        arg[1].in, zero, arg[1].in, neg);
-    tcg_temp_free(neg);
-    tcg_temp_free(zero);
+    tcg_gen_abs_i32(arg[0].out, arg[1].in);
 }
 
 static void translate_add(DisasContext *dc, const OpcodeArg arg[],
-- 
2.17.1


