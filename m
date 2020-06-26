Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F84C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:33:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 641BF2080C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bThhGxWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641BF2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqM4-0001Ec-Gv
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4F-0002kY-5X
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:03 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52629)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4D-0006Wj-Bh
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:02 -0400
Received: by mail-wm1-x344.google.com with SMTP id q15so9160623wmj.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=qsOodnm1qeB+KB+yqVxO1rsPzGD5oxJ366HcOjFmYxY=;
 b=bThhGxWpM5LrXTuqeCmS/UersBa4sqSxfaHVpgv6LfMWv8X51cQy+5JXnCW1BhMKo3
 ueToEZ5USep9XA9lei5pn83/l1D7nCjiMRyFF0Baz6W1WP9bptMjvhqO59T772F49qMl
 vearV8hib7mmCRPsBK5SFnJROWCwqoiWBGaZyMuQE7x5e4ZQwsCCAXEHVoSbawzBi7o1
 vheRdiUx73rdLlRHjvAT2gG+UTg+Mj+yI1hpzWS2Y4x7p4AgJFFv5k3eN8v72Fv0RNpw
 xQrbFg1u/3SmMNa5clfEb6WF6HcHZutLxXWx9TzK3PV3I7sHWNGfLdJfoqPlgYsdF+N8
 KZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qsOodnm1qeB+KB+yqVxO1rsPzGD5oxJ366HcOjFmYxY=;
 b=amp5d0z7HDZDH/yNO+V+rv7HTGG4zaXIIT+kB8/Qt0LnImJYbp2SQeVrDCSEknOiVn
 hI9J40DkZ7G7k6CHX4X/gRGoliXmrFJWaCLkkth4P4i3EmH809waUesW7Cks9UnCLuGF
 qjUKFFU77M9LmQFcWLi+COjl6vVJkF8hdq6e49RY2XINDe85Xah4osFBZqCxkt1WPs1b
 60ZjPCQ89irm39oR8GE+vsuw7PBbxJJ19c5oPl5omj3MYtssO7UDmNaz6cFSk6m84nnF
 0c8FjHej8b0gKf/ySajAPfcFrPRfTLXgBDRQcAvd9z+YFJEJw/VW+xT51wZuoeIad67P
 134g==
X-Gm-Message-State: AOAM532N2dGYOLTSloXYvg+L9ipBw8s6jJMOzsrxkR5E8kAgtoqGn6fS
 db6v7UDAtzi4yWocIVe6vahJ6eWnsQ1zrA==
X-Google-Smtp-Source: ABdhPJxukKEVUD5jKt18MHY9Xel6dYaVewsO36brKK7DNB8WNcQLbzRg9tqWkun7l16BKOvdxuikpA==
X-Received: by 2002:a1c:2d54:: with SMTP id t81mr4249439wmt.154.1593184499755; 
 Fri, 26 Jun 2020 08:14:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.14.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:14:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/57] target/arm: Restrict the values of DCZID.BS under TCG
Date: Fri, 26 Jun 2020 16:13:56 +0100
Message-Id: <20200626151424.30117-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

We can simplify our DC_ZVA if we recognize that the largest BS
that we actually use in system mode is 64.  Let us just assert
that it fits within TARGET_PAGE_SIZE.

For DC_GVA and STZGM, we want to be able to write whole bytes
of tag memory, so assert that BS is >= 2 * TAG_GRANULE, or 32.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200626033144.790098-18-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d9b8ec791ed..d9876337c05 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1758,6 +1758,30 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 #endif
 
+    if (tcg_enabled()) {
+        int dcz_blocklen = 4 << cpu->dcz_blocksize;
+
+        /*
+         * We only support DCZ blocklen that fits on one page.
+         *
+         * Architectually this is always true.  However TARGET_PAGE_SIZE
+         * is variable and, for compatibility with -machine virt-2.7,
+         * is only 1KiB, as an artifact of legacy ARMv5 subpage support.
+         * But even then, while the largest architectural DCZ blocklen
+         * is 2KiB, no cpu actually uses such a large blocklen.
+         */
+        assert(dcz_blocklen <= TARGET_PAGE_SIZE);
+
+        /*
+         * We only support DCZ blocksize >= 2*TAG_GRANULE, which is to say
+         * both nibbles of each byte storing tag data may be written at once.
+         * Since TAG_GRANULE is 16, this means that blocklen must be >= 32.
+         */
+        if (cpu_isar_feature(aa64_mte, cpu)) {
+            assert(dcz_blocklen >= 2 * TAG_GRANULE);
+        }
+    }
+
     qemu_init_vcpu(cs);
     cpu_reset(cs);
 
-- 
2.20.1


