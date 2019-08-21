Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7FAC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:16:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951B8216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPxbKe9r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951B8216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0SLN-0001zg-Eh
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 11:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SG4-0002uB-Lj
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SG3-0003iO-IK
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:44 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42925)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tony.nguyen.git@gmail.com>)
 id 1i0SG3-0003hE-Cm
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:43 -0400
Received: by mail-pl1-x641.google.com with SMTP id y1so1475597plp.9
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ujKrPsuHk32r3CHV81dhZOO77B/mJJvkyhEgOa7WSFI=;
 b=PPxbKe9rs3eYtGNVw2+/Zak24XYlrWMivX0hLy8xffk16Ak/bq8cB8fq93rcaD5h2e
 qX0j51YpNdyiTdygy8CKsI4migS6y3hwiKR0HWwKHEsKJCdimRXeq5lxa8ofbo8dhrof
 1/D7LjHSJ7gzaasmTeDX6qfKqU2qexQ3pOMaSGPHoVdE3bcTE6QAhYZfliy+vgIb0rwc
 qdVH1lTg2lUBC9j+0HOt45CvjE6jF0iMT9xe4Vg44FJ5DYZykm6dhqOfMP7pL3OH/1Di
 Swdn27XsdLsezFTsuBfDhY3y7MEXqaNcaRut2fcyAnDhFwVwxU56aAtxFASelafT4hi2
 dfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ujKrPsuHk32r3CHV81dhZOO77B/mJJvkyhEgOa7WSFI=;
 b=YmvRhuCLLtNefuxQKFmtmx2BKJ3uKKFtImYs5jk7tjcyZTyCBF2uH3EVnuYk8dG5k6
 2yR23xI5vfNpyEipS8c+ta/yfC5jmAL5wF7qNq2IXex+r6My1EyZJIuiavI/CZWeCHSv
 QUVSFDfKxUSzDOs9TbxEvWPDbA/UCnaGLk4/xdzCoOkoKGil9ltw9TWBkwBDLWA05Ity
 W+XxNItpyBwADJhlOlOLGQO5CLkDic5HhrVOC46IturStt4kkWDXIid87NiVetmsYgmO
 5kBLcdJ2wGrWqyEN00nQKVufnj/ewRtSoVR5cpocH2DzdIBVxdF5+BffX9yDW5M6oMcr
 jtZw==
X-Gm-Message-State: APjAAAWCZZjZ66iPhA5aT0LUmRCDtW0KtcvTjfexwvZYZGYKofJh6myY
 +zkW5o4rxcm2G195lCT21pKB20vNRwc=
X-Google-Smtp-Source: APXvYqxCo7va33WSmmoLm7Dv67ucgIzycaEPWNvesnpOiPNHybkGc3VB9r2rF5q3bbKEVO3NgNkdVQ==
X-Received: by 2002:a17:902:d717:: with SMTP id
 w23mr16633995ply.321.1566400242248; 
 Wed, 21 Aug 2019 08:10:42 -0700 (PDT)
Received: from localhost.localdomain ([58.173.98.68])
 by smtp.gmail.com with ESMTPSA id e19sm5887633pfh.114.2019.08.21.08.10.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 21 Aug 2019 08:10:41 -0700 (PDT)
From: Tony Nguyen <tony.nguyen.git@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 01:09:12 +1000
Message-Id: <2c13e85942fa740953fd5ceee6f65f854dc9b8de.1566397711.git.tony.nguyen.git@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566397711.git.tony.nguyen.git@gmail.com>
References: <cover.1566397711.git.tony.nguyen.git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v8 18/21] cpu: TLB_FLAGS_MASK bit to force
 memory slow path
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
Cc: Tony Nguyen <tony.nguyen.git@gmail.com>, Tony Nguyen <tony.nguyen@bt.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The fast path is taken when TLB_FLAGS_MASK is all zero.

TLB_FORCE_SLOW is simply a TLB_FLAGS_MASK bit to force the slow path,
there are no other side effects.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 536ea58f81..e496f9900f 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -331,12 +331,18 @@ CPUArchState *cpu_copy(CPUArchState *env);
 #define TLB_MMIO            (1 << (TARGET_PAGE_BITS - 3))
 /* Set if TLB entry must have MMU lookup repeated for every access */
 #define TLB_RECHECK         (1 << (TARGET_PAGE_BITS - 4))
+/* Set if TLB entry must take the slow path.  */
+#define TLB_FORCE_SLOW      (1 << (TARGET_PAGE_BITS - 5))
 
 /* Use this mask to check interception with an alignment mask
  * in a TCG backend.
  */
-#define TLB_FLAGS_MASK  (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO \
-                         | TLB_RECHECK)
+#define TLB_FLAGS_MASK \
+    (TLB_INVALID_MASK  \
+     | TLB_NOTDIRTY    \
+     | TLB_MMIO        \
+     | TLB_RECHECK     \
+     | TLB_FORCE_SLOW)
 
 /**
  * tlb_hit_page: return true if page aligned @addr is a hit against the
-- 
2.23.0


