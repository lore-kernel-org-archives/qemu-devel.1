Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B6CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 00:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4280C206E9
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 00:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DU5sz4rt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4280C206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgGqu-0001IP-FR
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 20:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgGnx-0004yo-Hl
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 19:58:49 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39410)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgGnw-00025K-QV
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 19:58:49 -0400
Received: by mail-pg1-x544.google.com with SMTP id w20so424668pga.6
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 16:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8qc6oDN4Zl6MEuNRZIzxS7SMNWB7rYpnfgGgJ3Ds2L8=;
 b=DU5sz4rtCbebQK0q4bEaxfBpZbqrAJJIAyftte2qhxPl+tzbBSllL5RNyZ9ZH3luBo
 5Irihe1G7+XNviQc8F9iPiZ0UwjEx5rgMF/c0autWhMsVEWiv3+pw60G4jAQs6xJBVwQ
 pTzrw+aZBdAtKAVpqCTjGNLHKb08suaPveBOXA2EFozKRYMZCq7REdHMdKL4GHHsF4+B
 1N6DYpvkimEdkMaa5oyiJRqoZNrE6ioFRVe2FgFOtRA1jg+69Qnywql5Stuhc1daZxxj
 mh/REqpD29FIGD4H36v0Yd217ux4uK6NK3Rnl+xLUAj+Lb4ccatYRMaM91BWZvjniC4v
 PfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8qc6oDN4Zl6MEuNRZIzxS7SMNWB7rYpnfgGgJ3Ds2L8=;
 b=JRlKaOoA1CjQKzctvM30c6vHpZkEezGZSM6qqDISK2e1+i4mtEheEDVdTb06ylceTG
 aXPRWkeG3K512//2NTrgwz8L30Js4aenkxXB4KPhci2+gbVOst6dWwG3uMSwXd2UCokR
 PSFaWAREkz02sz/g+kV6N0pW9ljETiU71jnXiH4Nf/UONLtisPtGjXI58X3Jze3qSlTV
 XboUztb6bRhcLuom7qvGc1A8S5z08qW2/KrBr+TOJChyHfmPKqmRpINEMKCUUXPU4CuA
 tRa0yLv31/M2lfF5KJZr3y5IqoaPZCck5Q1/gQAElAGYZzIvbHqhYZx5QCB1+bwTK7rA
 siWA==
X-Gm-Message-State: AOAM531JBm4I30J2P5PadqWnLD3tR6IMNpuZY14A4cZ66VGfpqGFN51M
 Ks44pCOgnCAN/Hif2uIAVIplogvpZ1I=
X-Google-Smtp-Source: ABdhPJzjORF75TTK2JejTrlU6aKs6Yh8l+gDx/4lkny/0yOAasQlUABh6jIso4mhutDVUN0vLdE5UA==
X-Received: by 2002:a05:6a00:50:: with SMTP id
 i16mr3897493pfk.25.1591142327284; 
 Tue, 02 Jun 2020 16:58:47 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id k101sm182201pjb.26.2020.06.02.16.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 16:58:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 8/8] target/arm: Use a non-overlapping group for misc
 control
Date: Tue,  2 Jun 2020 16:58:34 -0700
Message-Id: <20200602235834.470345-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200602235834.470345-1-richard.henderson@linaro.org>
References: <20200602235834.470345-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: peter.maydell@linaro.org, philmd@redhat.com,
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


