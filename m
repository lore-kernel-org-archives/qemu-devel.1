Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C51C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 03:46:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0389205CB
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 03:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tidE/WKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0389205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jggpT-0006z7-01
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 23:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jggoi-0006Q7-8h
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 23:45:20 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45607)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jggof-0006BN-CP
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 23:45:19 -0400
Received: by mail-pg1-x544.google.com with SMTP id n23so2896799pgb.12
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 20:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=48Nkai7QMgm5/xgRcH8NnoLnhaSYi6y1dsmgIS3rtNE=;
 b=tidE/WKWWfdPw8vK5onzay1Ndvv8EU/4damO6kGYKVi7UohY7acKMnFsu9IP7mPn4E
 9HAAdlEMFbSzOJmE/M+/youR95y5tD+Y/5dKMB15GZMoK7KgChLIfsc/5XlU5JYYvd6v
 2m5JobX1bP5V6N5euMr2Pk13sersrdloOJP5NzKe8LGYLjLIP9XforlAMfy6nA5vvXtB
 GBBSyWtYJEBDU7jzHBB8vmFGVQ3v27fWLS6K8IpAyHTUj09i9zQ4R+ygAilXcjs8kpuJ
 W1S23Kb6jnBf78fGRcR5g0PclOVAhmw1l0fBV2AgLVwDem+zBKNPYf8YUSd/Q20RqJsH
 /50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=48Nkai7QMgm5/xgRcH8NnoLnhaSYi6y1dsmgIS3rtNE=;
 b=DVFDbVUhD9E0dAKs6WwPhRKfOwxhhFCfa1rGDD55ch1GrGOHQWCUSHpnEEo/jJwrcb
 Ok6Sd+q8TYOLlMEcE/huY2PJ5g4vqk8eTnMzd6vHbniDsnNRKTAEX6u72XqhL4M224po
 1XsAumxk4amVw0aVKz3vxOiP52ZWGnXF95/62UA/yyuM8QuCObOCqsbEk4Qvy3Ii08iI
 IOW89h5EIGXjxDuV9w6817EL2RFurEHrzneIPksQmHY7yGYhC4JLOjaEK/Zz3c9oDYRz
 hNFPJ7kHkLKyLHmAatLfbhl7iX7KjGg5mouhPH1ZwkRalu/JHMpfTnswr5jXaJyryRNe
 03gw==
X-Gm-Message-State: AOAM53389ouFbDMVR6b1oIxaLkrlWbrrwIVsU1KPFH4kKXnYsAc4yo8r
 mAr2/gNkZ0diXM63t90X5ye6PBRPZ/E=
X-Google-Smtp-Source: ABdhPJw51Ys+fpjriGBqeZxuX/Xsrq+aSoigbcjgs6etkNmPcue7XLhyFQRZUGUL9xZoxc09iZmZfA==
X-Received: by 2002:aa7:8d8a:: with SMTP id i10mr2234912pfr.193.1591242315345; 
 Wed, 03 Jun 2020 20:45:15 -0700 (PDT)
Received: from f32.twiddle.net (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id z11sm3131220pfk.141.2020.06.03.20.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2020 20:45:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: Disable -Wtautological-type-limit-compare
Date: Wed,  3 Jun 2020 20:45:13 -0700
Message-Id: <20200604034513.75103-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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
Cc: thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Clang 10 enables this by default with -Wtype-limit.

All of the instances flagged by this Werror so far have been
cases in which we really do want the compiler to optimize away
the test completely.  Disabling the warning will avoid having
to add ifdefs to work around this.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure b/configure
index f087d2bcd1..693f01327f 100755
--- a/configure
+++ b/configure
@@ -2009,6 +2009,8 @@ gcc_flags="-Wno-missing-include-dirs -Wempty-body -Wnested-externs $gcc_flags"
 gcc_flags="-Wendif-labels -Wno-shift-negative-value $gcc_flags"
 gcc_flags="-Wno-initializer-overrides -Wexpansion-to-defined $gcc_flags"
 gcc_flags="-Wno-string-plus-int -Wno-typedef-redefinition $gcc_flags"
+gcc_flags="$gcc_flags -Wno-tautological-type-limit-compare"
+
 # Note that we do not add -Werror to gcc_flags here, because that would
 # enable it for all configure tests. If a configure test failed due
 # to -Werror this would just silently disable some features,
-- 
2.26.2


