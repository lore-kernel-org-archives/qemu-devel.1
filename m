Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27683C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:43:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E0822500
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u8SqBZHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E0822500
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF2Ve-00009A-Pc
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 16:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2B2-0004oL-VK
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2B1-0005iu-T4
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:48 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:39078)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iF2B1-0005hx-N7
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:47 -0400
Received: by mail-pl1-x644.google.com with SMTP id s17so4329615plp.6
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 13:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0eIQzpvgKZ/1Z44eyY68s5331mz4V928vlgpASMp7Pk=;
 b=u8SqBZHcdak4pksG6lmbHjMDYyCYXa02XHd/hvU7IGun0TuXp6MJ6UMBqy5QmZIrMi
 jcy0MqGuiLqRnfNyhs/Tu+CkpQy/T6JlRq6Lfhj9pkbKSq5Qxzo8bYDgs3e7PKOQj3j/
 seRSYZHgdFTFo+F/Zo8Ka7qPo7bUguxXeS0Boi6Jd0LR6UYQ0Bj91uu1+qM8bme7oz+v
 yIEtuRTD8xg5r/ZALgs1SKIaZJmBfACcJEF/Mls8t7nZEeGBJIG/3O+WCr4jZRUPNxWN
 zzB0LfN1Vj/vuGog21nIsKyKz5eTbNDQMmGSLu0XxwaC68nWpGUx2i+q9XTatd6utPgC
 3Lbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=0eIQzpvgKZ/1Z44eyY68s5331mz4V928vlgpASMp7Pk=;
 b=a2hq/cjvNIlIFelnsJ0wkq7qgT1ZflwU94nFabVKB9uoGwb6Lk1rqNBnOeyt9E/JLW
 S6zHFCNM/JNoEhmCuavOMvAd51OG6fCg+CnMHTJoNvkEXN5aBtfDJ9sBN7X0gzgdqll4
 zdx2q9TNV+PFbBzDm7yh5c5JgHDOm/CdjuEja/6u7stzufcptenTIBznMz/3KyYym0fO
 0Z1bo0YVWaATVctOmSvu4/uv0QLkgg/wgCE/k/wZ1NIoUH7e8k+7LNepDQgrojnvOtZq
 TIL8h9BOmMLos0jRJYYAaMZepBp2xrq6E5esQZ3ZfgIt4W5yzn3qSMkRave+YOA45WNh
 J0kQ==
X-Gm-Message-State: APjAAAUJcw/gDlbA1NBV7+gGoXp9/30rCF5uc8Aq4U+7SvwrDv00fH+G
 k2yOzGH19VBALV/VnakV6sFbB93gPZc=
X-Google-Smtp-Source: APXvYqzAJtoyQfhO+jTPRBpMqsqfJuHAywBEeNEfRUAbMY8TZkVOGYmz7/JBD5xvTMRd/2iWqzQP8g==
X-Received: by 2002:a17:902:6bc5:: with SMTP id
 m5mr19093111plt.282.1569874906458; 
 Mon, 30 Sep 2019 13:21:46 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r28sm15336802pfg.62.2019.09.30.13.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 13:21:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 15/22] tcg/ppc: Enable Altivec detection
Date: Mon, 30 Sep 2019 13:21:18 -0700
Message-Id: <20190930202125.21064-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190930202125.21064-1-richard.henderson@linaro.org>
References: <20190930202125.21064-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: mark.cave-ayland@ilande.co.uk, amarkovic@wavecomp.com, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that we have implemented the required tcg operations,
we can enable detection of host vector support.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 8a508136ce..d739f4b605 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -3528,6 +3528,10 @@ static void tcg_target_init(TCGContext *s)
     have_isel = have_isa_2_06;
 #endif
 
+    if (hwcap & PPC_FEATURE_HAS_ALTIVEC) {
+        have_altivec = true;
+    }
+
     tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffff;
     tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffff;
     if (have_altivec) {
-- 
2.17.1


