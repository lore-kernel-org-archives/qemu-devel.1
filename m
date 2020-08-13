Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDB2C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:03:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 484AF20829
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VUo6PZG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484AF20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6JRp-000889-HS
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 16:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6JR3-0006zb-HC
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 16:02:49 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:41565)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6JR1-0002uZ-OF
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 16:02:49 -0400
Received: by mail-pg1-x52b.google.com with SMTP id s15so3355590pgc.8
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 13:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KVn3nGhh7KMqG6Zigevl8e3IKHdTBlKvT4d+P+M6n0o=;
 b=VUo6PZG2dgKTdZg32MX6kp098HvvlPLU42CQeD++akfPUB2Vd9zX3TYF6bMLIFoQrl
 cySqA5K1OsBzFUVW/j8i9EE7bqZpX69gPCYd2YN47midvJyvujJbMl/RLa5hblJ7Ngjq
 i8AR+E2LIf+6ZAGEIngqjaY2M25ToZYHOmoo3mFz3L34DQtETQSdZspHQV1GJs+xYxLt
 DP7HMexfNN+eki4Lbneeh5aoi+XFO/CCG17cLGyInwF4ql30f37hE2BSiqAN8cEwATTI
 mJxI7YWei6vvxv6KAyA6PFscQfcY/sMpTlXbKwpl2X7Q65m0rWvdxyhIIKN8WDEz2ftI
 b5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KVn3nGhh7KMqG6Zigevl8e3IKHdTBlKvT4d+P+M6n0o=;
 b=adnT7hF7jvbnKPXevfnKAcHq0Zl+vkznvOeyizFrVFniGsO90LHRquP1J85IM5XkDl
 3u17VUGk152a7O8OqzgY5IOWdnuJPf01gpcRR+sOWtQWsNYw+brRdx77SVYDNhvuFRIA
 UL0NqcGfx8Wj1MXXFszXeK5ILEN9ocGzknPDAsQD3rP7F8D+YIRr0TJ/A0PKGdXqR5q8
 rab466wIxhh+oJsh2jfYo4u9SBrBIbAoywGSAjqobLO/LB0zVkBUI7dVeAAjPvrTVNfU
 C1sQ69VEWLHtXSAcBZhcHsLZzyMlazoSFMaWrlBhSvtEYLyJ74lmMIR2o9VLhizZlYSF
 JncA==
X-Gm-Message-State: AOAM533ISFip/UC9kmUa/R7kQZCYuCpTK5SsNt3Y4psfr7ugaXkFVoZ2
 V8Qdnp13d5vTPGtjYjvpOCcwaumxHdg=
X-Google-Smtp-Source: ABdhPJzwb2cQtvj457LaX6hidM5ZqZnDbQ/LMM4RcU+qryp6ecCX8b+1iGat+4BV+8y6grkcyQYMlQ==
X-Received: by 2002:a63:1b0b:: with SMTP id b11mr5258791pgb.447.1597348965666; 
 Thu, 13 Aug 2020 13:02:45 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id h12sm6871103pfr.143.2020.08.13.13.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 13:02:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] target/arm: Implement an IMPDEF pauth algorithm
Date: Thu, 13 Aug 2020 13:02:40 -0700
Message-Id: <20200813200243.3036772-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: mark.rutland@arm.com, peter.maydell@linaro.org, drjones@redhat.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The architected pauth algorithm is quite slow without
hardware support, and boot times for kernels that enable
use of the feature have been significantly impacted.

Version 1 blurb at
  https://lists.nongnu.org/archive/html/qemu-devel/2020-08/msg02172.html
which contains larger study of the tradeoffs.

Version 2 changes:
  * Use boolean properties, for qmp_query_cpu_model_expansion (drjones).
  * Move XXH64 implementation to xxhash.h (ajb).
  * Include a small cleanup to parsing the "sve" property
    that I noticed along the way.


r~


Richard Henderson (3):
  target/arm: Add cpu properties to control pauth
  target/arm: Implement an IMPDEF pauth algorithm
  target/arm: Use object_property_add_bool for "sve" property

 include/qemu/xxhash.h     | 82 +++++++++++++++++++++++++++++++++++++++
 target/arm/cpu.h          | 25 ++++++++++--
 target/arm/cpu.c          | 13 +++++++
 target/arm/cpu64.c        | 64 +++++++++++++++++++++---------
 target/arm/monitor.c      |  1 +
 target/arm/pauth_helper.c | 41 +++++++++++++++++---
 6 files changed, 199 insertions(+), 27 deletions(-)

-- 
2.25.1


