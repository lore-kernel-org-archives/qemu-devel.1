Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F63C04AA6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 13:16:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E200205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 13:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q1AiOBUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E200205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47147 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLScp-0002So-6g
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 09:16:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLSar-00010e-0H
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLSap-0002Aw-Vu
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:14:44 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLSap-0002AJ-Pa
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:14:43 -0400
Received: by mail-wm1-x341.google.com with SMTP id w15so3791786wmc.3
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 06:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=U/R8O7Qr7W3Gev40Mu9XCs2DcqDhxle1cGlCTNhZ1V0=;
	b=Q1AiOBUhsGvl0IcKOiLai/mtenqy4Kr17qXwXw5RbT+iBk1OYQnlLt6o4LpTxPzjSd
	td87MSU842aTbeQWtWHjklKn2qP8eIJlXdswud2xVGarUy+9Jx9RtuZOcsSp1NuB3mBu
	Xf9rcgYwhP8dqWpJtLvI37VjX9iGENpCNK139NHnpcvrQ33h1tu0eJIFGmMVSyeYkTXn
	RA0nPQtup+N08tvyskTvCxzpDHGiqvUaIhTXOk67RGuNOLaLPP4pWyQpKtQnjfof3lkN
	w71P9TLydNHwbUIdZKgg6H4jvm3lmgReNUmuBa63j8NiqFJurb/Z9PFQ7UeB/w86ll0J
	ZeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=U/R8O7Qr7W3Gev40Mu9XCs2DcqDhxle1cGlCTNhZ1V0=;
	b=DhqKi1pSZEvY4cFXZ1L6nq7K6ZOk3h3oKoJbkGDt7Uk6mm5pOWUBXQRRQRKiZvWb/7
	PSAUKJHB/eQmUL4NMUk0qWnFaTNcscXZk85a08XZqVq0UX9r631CTnMlxNXjvwhCXjJt
	veq2p4qlC5lJ7uvrBJ1ztfCeawlifY56m4j52NqWYzNMlpsAV3LcV3BLFKai0VgJjP3/
	ApKu47HLqhVL9cx2aFmNgB/1uQzkH1nJBYrBvFSe9xMKdCgEsaRI7EIwdwyX3qPxfAw/
	Dk9esSYpSFiCcTC5B8lLL+8ewQmUPTNxnnrHWQmJceP7MQi447uaOSDaNMlu7eUR1Z+G
	Czfg==
X-Gm-Message-State: APjAAAWF5a65RzQHH0RbeC+LfwTBbiwsPLgCljpB2tEQ9UKZwhet++YH
	8ZsK4B4UTEIZyKYHi3kt66AYmA==
X-Google-Smtp-Source: APXvYqyW0sTuY6hcViJsEKypB8BM3Se7PQcuwyHwAntt6B5e2zeRE2VOzjATSx+EZivodfsBsMGsGg==
X-Received: by 2002:a05:600c:2506:: with SMTP id
	d6mr450717wma.106.1556630082710; 
	Tue, 30 Apr 2019 06:14:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	a12sm16557460wrh.46.2019.04.30.06.14.41
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 06:14:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 14:14:36 +0100
Message-Id: <20190430131439.25251-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430131439.25251-1-peter.maydell@linaro.org>
References: <20190430131439.25251-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH 1/4] hw/arm/armv7m_nvic: Check subpriority in
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190430131436.ah3XjLFVDwPWPXG-PqFMNix44M47L7HUMMDVs7b_0Kw@z>

Rule R_CQRV says that if two pending interrupts have the same
group priority then ties are broken by looking at the subpriority.
We had a comment describing this but had forgotten to actually
implement the subpriority comparison. Correct the omission.

(The further tie break rules of "lowest exception number" and
"secure before non-secure" are handled implicitly by the order
in which we iterate through the exceptions in the loops.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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


