Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E8DC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:20:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2568A207DE
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uov3iGyE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2568A207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFnr0-0007ek-8i
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnI-0007gP-9G
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:00 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:41034)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnG-0002AU-PT
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:16:59 -0400
Received: by mail-pg1-x541.google.com with SMTP id w186so724283pgb.8
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8mf4rmkmBN5Xe+gj6aRnmRXtibnvJ52kCblqiE5PJ2w=;
 b=Uov3iGyEo83AFDFSHE6JOF+AjoBcjQn2vZVkFJ92pt0M8qWG29EukUSaFImRrfZX11
 dU9BmPj+1mZtZS0Su7i2AQ3/sBNoi4VkBIoiyjoXbmQ34HByFzuY8yc/ZP+Iwwlwkbe0
 IUpc5gJ8+B1VwMTX4MrlQFaB0vK5RC+k9LVa+C1U42EGW0xB2Gf/NNNrZ6QLLwySBRbI
 XV5fZCxjUs9EKAdv27deRKqf0YskaIF4mraoWxQhV3fEAa0KYRMJvYizrbb2us+sMpNu
 WKQt/GvJotYRlPs4jIaSA7wgRivmplK/WPO1K1/B7F+hTUq4SYzRpwdjAfFcmf8rp7UJ
 Y8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8mf4rmkmBN5Xe+gj6aRnmRXtibnvJ52kCblqiE5PJ2w=;
 b=TSjY6hruh5+5tr7ElDF1OA4hwVLsjTzd3GeUUO+oJEW33ITaRqLKKnzJ7mbrZsrP4K
 AytcIJrRSVC6Bd7axKsj5gzrSFNdebFlJvAxql2Ia2Gufr824FmgwWg8bRA5MDuc/PX6
 bhfmTxKsbVrwd53SxKZfU8qLvFVJJxQy+F8SjIsO4TPhD6DrKImRJnMfvrV9mlYwWPFU
 bcD6RPlmBRT+PRuHpnR0IH2TDvcEDQMeJXoiAnIDfREVaLTLVKrW2MWumRX3QPXzGV6S
 n+HdnGZTKY/ZttUbCD9bncHZ4O+o5VCGBgGqaxU1K0zsNcCrFMR0C1dP52dhyv040+ck
 pZfQ==
X-Gm-Message-State: AOAM533Z/1gcoEN3zq6jIqB1jqGVdhFBlnoynOskl7lYIblgKQYBTDFR
 2t8lMlISa3X6HFYk6EFhtn5NDKZH+NHgaA==
X-Google-Smtp-Source: ABdhPJyB3H/mLdtlr06OydnOIOhadxyAn5v0zf1H8RDUVjK1YYnPKyg7W4w2FlC6iMWL6C5yapeHmw==
X-Received: by 2002:a63:1c18:: with SMTP id c24mr998097pgc.30.1599610617177;
 Tue, 08 Sep 2020 17:16:57 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.16.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:16:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/43] tcg: Remove TCGOpDef.used
Date: Tue,  8 Sep 2020 17:16:10 -0700
Message-Id: <20200909001647.532249-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The last user of this field disappeared in f69d277ece4.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index e8629b58c8..8804a8c4a2 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -1015,9 +1015,6 @@ typedef struct TCGOpDef {
     uint8_t nb_oargs, nb_iargs, nb_cargs, nb_args;
     uint8_t flags;
     TCGArgConstraint *args_ct;
-#if defined(CONFIG_DEBUG_TCG)
-    int used;
-#endif
 } TCGOpDef;
 
 extern TCGOpDef tcg_op_defs[];
-- 
2.25.1


