Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D86C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 17:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FB69206D4
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 17:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhg6Xiby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB69206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ja12N-00024z-HB
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 13:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ja0td-0003WS-92
 for qemu-devel@nongnu.org; Sat, 16 May 2020 13:46:49 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:42719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ja0tc-0008RO-GC
 for qemu-devel@nongnu.org; Sat, 16 May 2020 13:46:48 -0400
Received: by mail-lj1-x242.google.com with SMTP id d21so5548914ljg.9
 for <qemu-devel@nongnu.org>; Sat, 16 May 2020 10:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lJgCSZt5mHFIRGTCzDEMalJcIzhFOtdVx1BtWwULXEk=;
 b=qhg6XibyvMwpVgyiHqkNSYJXLKS7OS9nkh+xzOj1rNqtaiIrEJ4KnWkeXIUaCW83hI
 dbQWn09cYEwAaSRo1GC61V3waxh1kouyfJ1uuo9AFIdLBml5369JjlN2GUxvvJfeF7ou
 mm6Lu7e0a6lLIwiA7Hk54GPtPKd7JFod/o+qq/oCJcphplHKYzHM+4Hiy6pYZn+6yvpb
 8ww10DW8eWl5OyB8ciVsJauCMGLcL6BZV9/BJZ+hRSjylwJtzV4j1lWfWn+SiaIQFsTF
 ao1HZdRyCC3vGf+yeG9dc+HpNLExmlrbo5xZ/WtcV+eI0djSR+EfclsIGMfXCxbs0Wna
 FEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lJgCSZt5mHFIRGTCzDEMalJcIzhFOtdVx1BtWwULXEk=;
 b=T1axjRU/d20R+H+Ydwj9hOMOT7seDoA4ChgJldzNQEUC8coJnV6+UAw0CEkAlO8zLB
 Cr3CJAr9WXZSMIxCJA3SNhMdfK2k1CsSGojjGj6LnA+nShZIVG2kSlNiKKULzqj4JQ61
 IOyB6nCkipvU+EWsFmuOs1tvjU7lD9my3YkkZZTsdFL0lwmqAHdRBnEm+ed6Blq4OX9G
 rQgZ80wJoFO2ypAkVW9Hh89P5lpMd4n3F/bB1AyGE9+7CwCCltGsPzN3HxT17k2XQNJE
 8Re5ZAKfEutjACosCpaWrVxYEb4TdXSRtXpjWQ7rEwvq9Xw5CYCVqd7Em3UMQBgTHg2I
 65aQ==
X-Gm-Message-State: AOAM532bZTXnTvVJZ4R+vtxGOje0t3dnYK8FOC06q2+iEKVWdr0fm+pH
 H0Y7HF6JedkzzV6KB7aNW3etYvlsFFs=
X-Google-Smtp-Source: ABdhPJzx0euEhH+kMlDXusXs3lbib1Z5xa9TFYOvhSThi1CRQNb5v6ubgINjHyELtRQ3Yls9EmF4Hw==
X-Received: by 2002:a2e:8018:: with SMTP id j24mr5758570ljg.246.1589651206867; 
 Sat, 16 May 2020 10:46:46 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id i1sm3024759lja.3.2020.05.16.10.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2020 10:46:46 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/18] target/mips: fpu: Remove now unused FLOAT_RINT macro
Date: Sat, 16 May 2020 19:45:44 +0200
Message-Id: <20200516174548.7631-15-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200516174548.7631-1-aleksandar.qemu.devel@gmail.com>
References: <20200516174548.7631-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.rikalo@rt-rk.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After demacroing RINT.<D|S>, this macro is not needed anymore.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index dae1331f23..56ba49104e 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1102,19 +1102,6 @@ uint64_t helper_float_rsqrt1_ps(CPUMIPSState *env, uint64_t fdt0)
     return ((uint64_t)fsth2 << 32) | fst2;
 }
 
-#define FLOAT_RINT(name, bits)                                              \
-uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,                 \
-                                         uint ## bits ## _t fs)             \
-{                                                                           \
-    uint ## bits ## _t fdret;                                               \
-                                                                            \
-    fdret = float ## bits ## _round_to_int(fs, &env->active_fpu.fp_status); \
-    update_fcr31(env, GETPC());                                             \
-    return fdret;                                                           \
-}
-
-#undef FLOAT_RINT
-
 uint64_t helper_float_rint_d(CPUMIPSState *env, uint64_t fs)
 {
     uint64_t fdret;
-- 
2.20.1


