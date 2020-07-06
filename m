Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321D7C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:58:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0075B2082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WB4Y+b1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0075B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsb08-0002In-8c
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 19:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jsaqI-0001O4-2Q
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 19:48:10 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:43122)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jsaqG-00011T-Go
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 19:48:09 -0400
Received: by mail-pf1-x434.google.com with SMTP id u18so2313135pfk.10
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 16:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dczlRWi7ZhKkrGTsLLmYfEd66aSo3puvzeQP9Y5BUgA=;
 b=WB4Y+b1TI0batxODqFZHNcz/F2QuEZaxomnGOkLPUkFIUM6eFO5KF3bIVYivdhs8rX
 w7v3Y0YDDzJ3tLoOp9ej5c1u8JQSOGrRhlIFje89pAeMYHJfM/3v6QLEKD/cyWMwzSvN
 gQUCwGM6hNAzx3l2rPe5HsgvCMx/OIT+mq1uJtAewQ9AlRHsBMXU7NfHHrO4TwDJeJ7u
 FQ2zN0NBVepbKHK6luEYcC+cFg0vsaTcc/MK+8xUVPSz2b1apMsOKXNRkCrsEItvWiCz
 UlNo0RToPOL3sPFiePGL/jN3aBjJG67F1TKIPeT9h0sUkWIT0H5KPWphdzEOkSEiVXX9
 ljNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dczlRWi7ZhKkrGTsLLmYfEd66aSo3puvzeQP9Y5BUgA=;
 b=tAp0tTxgNiDpU5WfOIDptOfQCoheaVuQDdxKb2hg258Mt24RrrYcsJPbl1u8ffXnfC
 Uag0DvQdzDbOY/R1bbgg3WhvjJkHheLppZ8FuS1iu0d1/H92nqpC7a2No9OzmEQccTHB
 GQhrPPGuI+eqp2EoAKMqTzsOgmqyKQQV1NLtfPauJkJIYWQPGjWeLiO3xFwv1xFCKe9P
 X8TEmVI9rKvjaQNLrBQBIYWbZlh0/v2QR7gceUmujPmunaMNa9zfScMU+S9GLFR69oa+
 1GfnU1DPCMGK27NM0MNe0ZGReAOxlSLZxCv8kOgYWV0MC+5oU5ylLzH3Wcz2r8wqRYAJ
 NqRA==
X-Gm-Message-State: AOAM530bsFXMtcHUY0r9wHaqtccCum/il+UJ6pRiFm8vnPq7va098Z2s
 GsBHpaCnOGYifrfSlulYWnIIeLeA
X-Google-Smtp-Source: ABdhPJzbzcmcqIbivC0PzlfVjI8xjxJjc2OkW0IAOhdzriPEBG5rAYBeHWv4eT71PMYeqZ2jz4oUOQ==
X-Received: by 2002:a63:141:: with SMTP id 62mr41164616pgb.366.1594079287147; 
 Mon, 06 Jul 2020 16:48:07 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id e15sm19647649pgt.17.2020.07.06.16.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 16:48:06 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/21] tests/tcg/xtensa: test double precision load/store
Date: Mon,  6 Jul 2020 16:47:34 -0700
Message-Id: <20200706234737.32378-19-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200706234737.32378-1-jcmvbkbc@gmail.com>
References: <20200706234737.32378-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pf1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add ldi[p]/sdi[p]/ldx[p]/sdx[p] opcode tests to test_lsc.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/test_lsc.S | 123 ++++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/tests/tcg/xtensa/test_lsc.S b/tests/tcg/xtensa/test_lsc.S
index 9d59c1815a9e..348822bdd359 100644
--- a/tests/tcg/xtensa/test_lsc.S
+++ b/tests/tcg/xtensa/test_lsc.S
@@ -140,4 +140,127 @@ test_end
 
 #endif
 
+#if XCHAL_HAVE_DFP
+
+#if XCHAL_HAVE_BE
+#define F64_HIGH_OFF 0
+#else
+#define F64_HIGH_OFF 4
+#endif
+
+.macro movdf fr, hi, lo
+    movi    a2, \hi
+    movi    a3, \lo
+    wfrd    \fr, a2, a3
+.endm
+
+test ldi
+    movi    a2, 1
+    wsr     a2, cpenable
+
+    movi    a2, 1f
+    ldi     f1, a2, 8
+    ldi     f2, a2, 16
+    ldip    f0, a2, 16
+    movi    a3, 1f + 16
+    assert  eq, a2, a3
+    rfrd    a2, f0
+    movi    a3, 0x3ff00000
+    assert  eq, a2, a3
+    rfrd    a2, f1
+    movi    a3, 0x40000000
+    assert  eq, a2, a3
+    rfrd    a2, f2
+    movi    a3, 0x40080000
+    assert  eq, a2, a3
+.data
+    .align  8
+1:
+.double 1, 2, 3
+.text
+test_end
+
+test sdi
+    movdf   f3, 0x40800000, 0
+    movdf   f4, 0x40a00000, 0
+    movdf   f5, 0x40c00000, 0
+    movi    a2, 1f
+    sdi     f4, a2, 8
+    sdi     f5, a2, 16
+    sdip    f3, a2, 16
+    movi    a3, 1f + 16
+    assert  eq, a2, a3
+    l32i    a4, a2, -16 + F64_HIGH_OFF
+    movi    a3, 0x40800000
+    assert  eq, a4, a3
+    l32i    a4, a2, -8 + F64_HIGH_OFF
+    movi    a3, 0x40a00000
+    assert  eq, a4, a3
+    l32i    a4, a2, F64_HIGH_OFF
+    movi    a3, 0x40c00000
+    assert  eq, a4, a3
+.data
+    .align  8
+1:
+.double 0, 0, 0
+.text
+test_end
+
+test ldx
+    movi    a2, 1f
+    movi    a3, 0
+    movi    a4, 8
+    movi    a5, 16
+    ldx     f7, a2, a4
+    ldx     f8, a2, a5
+    ldxp    f6, a2, a5
+    movi    a3, 1f + 16
+    assert  eq, a2, a3
+    rfrd    a2, f6
+    movi    a3, 0x401c0000
+    assert  eq, a2, a3
+    rfrd    a2, f7
+    movi    a3, 0x40200000
+    assert  eq, a2, a3
+    rfrd    a2, f8
+    movi    a3, 0x40220000
+    assert  eq, a2, a3
+.data
+    .align  8
+1:
+.double 7, 8, 9
+.text
+test_end
+
+test sdx
+    movdf   f9, 0x41200000, 0
+    movdf   f10, 0x41300000, 0
+    movdf   f11, 0x41400000, 0
+    movi    a2, 1f
+    movi    a3, 0
+    movi    a4, 8
+    movi    a5, 16
+    sdx     f10, a2, a4
+    sdx     f11, a2, a5
+    sdxp    f9, a2, a5
+    movi    a3, 1f + 16
+    assert  eq, a2, a3
+    l32i    a4, a2, -16 + F64_HIGH_OFF
+    movi    a3, 0x41200000
+    assert  eq, a4, a3
+    l32i    a4, a2, -8 + F64_HIGH_OFF
+    movi    a3, 0x41300000
+    assert  eq, a4, a3
+    l32i    a4, a2, F64_HIGH_OFF
+    movi    a3, 0x41400000
+    assert  eq, a4, a3
+.data
+    .align  8
+1:
+.double 0, 0, 0
+.text
+test_end
+
+#endif
+
 test_suite_end
-- 
2.20.1


