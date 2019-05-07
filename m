Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109C5C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:08:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0B9A205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yHqgs6Gi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B9A205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45707 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNytF-0004ub-4e
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 08:08:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNyls-0007es-FY
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNylr-0003tY-Ay
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:32 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:50237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hNylr-0003sk-2w
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:31 -0400
Received: by mail-wm1-x335.google.com with SMTP id p21so20096483wmc.0
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 05:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=4X9sIu0YHhUgKH1JkMRhAu/b2BTcREHijf9rjBQvr1M=;
	b=yHqgs6Gin2rh9sgOlzbNyzAKEozyhGUduxcLnaVx1ixK/fZpHp63Zgi7YYCc4lE/FH
	M12euWCVPrzIt8W+XWf2NXdaihoCWD+llKBNCknbY6qkFdcqJrtx819qYCbeTN003LSF
	+w9uInyLEz1Du1NKwQrtdUSV3nLnXQtdn5EqqySjcTYNR3U+XT8AywqYs0Zb2lbZZcUv
	jljHZQXpZS9rcdUdOB2VyUlwWTyoVxnXo2x4k6M2OEvJSORhSpfIxPV+3G1rwDzz44SN
	paO5H2/G26Y3DVqnZ+fW89HOEmcPb+2S+N3cKMKazwJ7CPrFoTGAIAg8n4M+GECq0xw6
	WXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=4X9sIu0YHhUgKH1JkMRhAu/b2BTcREHijf9rjBQvr1M=;
	b=Q1lKfTbiPvyMaN07gVqIGkvrDr1CP58aXpTSDco+qm3LWT11Olwz5garr/a1QT4/iD
	XRJ4p195gt3tf+faY3rDpF6WXsLZFSZxUtPR+JkEKE8E9XH7qmw8t/C8QUwFu+kjnZDf
	53WNhgHavL9AIsVScZc41/v1GzjDW+EKvNprVXtH/gOAGoizoppltRUv5PKIz9p5dunk
	JAg6AjCvEUV/4TTiY+Ewp9JORtHMe5Ilgy2gVme6bIBndol9NAN52wEfTf/HJKNefXVX
	u+A7TmTv9CZmqqgePS5WfTL8lQU4fB6AhKJh1cCdiJ3kY6NVbnHbUr+PVeN9ADLrmT9+
	T4Lw==
X-Gm-Message-State: APjAAAWSwArHIWrkx2hAllSp9GkAwFcTuJRvbYYNFXVIra9JXRuQ3CxI
	ovPSUJS3JEotk+20TbUlHHsVTP1AY2s=
X-Google-Smtp-Source: APXvYqwirlip1MywsFoQJkk5J+gaPhAmLOMCw+fC1p6us/PuB8dwFB+I+ZTfP8ccIvjG3gVkpmBa8g==
X-Received: by 2002:a1c:5f42:: with SMTP id t63mr19473242wmb.94.1557230429767; 
	Tue, 07 May 2019 05:00:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id g3sm12348596wmf.9.2019.05.07.05.00.28
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 05:00:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 13:00:07 +0100
Message-Id: <20190507120011.18100-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507120011.18100-1-peter.maydell@linaro.org>
References: <20190507120011.18100-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::335
Subject: [Qemu-devel] [PULL 11/15] hw/arm/armv7m_nvic: Check subpriority in
 nvic_recompute_state_secure()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rule R_CQRV says that if two pending interrupts have the same
group priority then ties are broken by looking at the subpriority.
We had a comment describing this but had forgotten to actually
implement the subpriority comparison. Correct the omission.

(The further tie break rules of "lowest exception number" and
"secure before non-secure" are handled implicitly by the order
in which we iterate through the exceptions in the loops.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190430131439.25251-2-peter.maydell@linaro.org
---
 hw/intc/armv7m_nvic.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index fff6e694e60..131b5938b9a 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -213,6 +213,7 @@ static void nvic_recompute_state_secure(NVICState *s)
     int active_prio = NVIC_NOEXC_PRIO;
     int pend_irq = 0;
     bool pending_is_s_banked = false;
+    int pend_subprio = 0;
 
     /* R_CQRV: precedence is by:
      *  - lowest group priority; if both the same then
@@ -226,7 +227,7 @@ static void nvic_recompute_state_secure(NVICState *s)
     for (i = 1; i < s->num_irq; i++) {
         for (bank = M_REG_S; bank >= M_REG_NS; bank--) {
             VecInfo *vec;
-            int prio;
+            int prio, subprio;
             bool targets_secure;
 
             if (bank == M_REG_S) {
@@ -241,8 +242,12 @@ static void nvic_recompute_state_secure(NVICState *s)
             }
 
             prio = exc_group_prio(s, vec->prio, targets_secure);
-            if (vec->enabled && vec->pending && prio < pend_prio) {
+            subprio = vec->prio & ~nvic_gprio_mask(s, targets_secure);
+            if (vec->enabled && vec->pending &&
+                ((prio < pend_prio) ||
+                 (prio == pend_prio && prio >= 0 && subprio < pend_subprio))) {
                 pend_prio = prio;
+                pend_subprio = subprio;
                 pend_irq = i;
                 pending_is_s_banked = (bank == M_REG_S);
             }
-- 
2.20.1


