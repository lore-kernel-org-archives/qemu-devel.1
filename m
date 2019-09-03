Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DAFC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:11:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92C7222CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RPtx0Bu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C7222CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5BOu-00034L-8D
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMi-0000xn-Gm
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMg-0003d2-JE
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:07 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42533)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BMg-0003cM-4Z
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:06 -0400
Received: by mail-pg1-x544.google.com with SMTP id p3so9387178pgb.9
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7UJaIX/+freOZ2GdMDK7ammoCcjV1M4dVe+L08Z47CI=;
 b=RPtx0Bu+FOJy74TnLekL5yY23SsqWsQOfZlovCmW+kWEKDdMzwpptwGzLNcW/8S1Zj
 gh57Wzeg2HUEnFMRKa20wZOjbFB2nej2P2Il/w7Jy0ejtDdfX7L4OPX4FpqF5Oh7tpQq
 3gVlC7haQhhwthYQE2T305xEJVotEVlqQaL47wBDggnjD9Ugt4ZnEx1kZ9VlB9bG610Q
 4WfrsqjINyCX1x5KZhWMF5XWvbcRTMr7jVhqdG5BjoBWq0erGNf+/Gvy8tTZvWiKGUlW
 GBG5eID1dPJwB4hXlEN3JhEo/QVYgBGXbLSGr0sYU5Oo5WsbMbq1iAxe9aFOYVTBT2O+
 NxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7UJaIX/+freOZ2GdMDK7ammoCcjV1M4dVe+L08Z47CI=;
 b=KRbjLrk+PlnOG4TRA4y942D7W54wDclljsUraOmjHGYkBCaS5VwouX+pH5YrphHoUa
 ZJj0yS02VAGC1jeKwQ969JvZ3mJ8gNfURKGgdcoARPS9mg6T/EGCkTWJ6WtPRY6g4mT/
 8SVE84Q+IrOMjaLZwn1FoEmdElLDfpXqVAhchfJ6Rx4IiIcc9cdyshYRLaOkrb81Icgt
 LeAgA1oEnWh6XJIO/hi/GxQBL867m9LswWI+zEUrAd/jVPyoDb5u1WH8u6IZRlRIyp0i
 I/Maz6oiJEXlpob6dow0KZrRZW2oTDltTmh7r/Whpj9q5h52asNOI935Ox9g3ltCzEC7
 lpBA==
X-Gm-Message-State: APjAAAUXVRGlWhmaN+Y9TLUckrSA4VdhgeXU4eYalV5L0B+345cWOojC
 YmUsHiEbe+CyCpZNQ0xoQ5PO8f68zBg=
X-Google-Smtp-Source: APXvYqyICjqrxZ+7jdnMY5E4EKSCgBzjlXTi36o2PIA7hyv8/q3zeedLrMSZLP24cxiiTKw3/qTHnA==
X-Received: by 2002:a62:60c7:: with SMTP id u190mr41653209pfb.54.1567526944588; 
 Tue, 03 Sep 2019 09:09:04 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:25 -0700
Message-Id: <20190903160858.5296-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH 03/36] target/mips: Access MemoryRegion with
 MemOp
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
Cc: peter.maydell@linaro.org, Tony Nguyen <tony.nguyen@bt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tony Nguyen <tony.nguyen@bt.com>

The memory_region_dispatch_{read|write} operand "unsigned size" is
being converted into a "MemOp op".

Convert interfaces by using no-op size_memop.

After all interfaces are converted, size_memop will be implemented
and the memory_region_dispatch_{read|write} operand "unsigned size"
will be converted into a "MemOp op".

As size_memop is a no-op, this patch does not change any behaviour.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <af407f0a34dc95ef5aaf2c00dffda7c65df23c3a.1566466906.git.tony.nguyen@bt.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/op_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index f88a3ab904..1f0e88364a 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -24,6 +24,7 @@
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
+#include "exec/memop.h"
 #include "sysemu/kvm.h"
 #include "fpu/softfloat.h"
 
@@ -4741,11 +4742,11 @@ void helper_cache(CPUMIPSState *env, target_ulong addr, uint32_t op)
     if (op == 9) {
         /* Index Store Tag */
         memory_region_dispatch_write(env->itc_tag, index, env->CP0_TagLo,
-                                     8, MEMTXATTRS_UNSPECIFIED);
+                                     size_memop(8), MEMTXATTRS_UNSPECIFIED);
     } else if (op == 5) {
         /* Index Load Tag */
         memory_region_dispatch_read(env->itc_tag, index, &env->CP0_TagLo,
-                                    8, MEMTXATTRS_UNSPECIFIED);
+                                    size_memop(8), MEMTXATTRS_UNSPECIFIED);
     }
 #endif
 }
-- 
2.17.1


