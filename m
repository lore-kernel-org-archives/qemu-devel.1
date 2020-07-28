Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD344C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:41:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7939F20775
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OlJ6NVki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7939F20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0N2b-0000zD-PG
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 06:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0MzY-0004jL-HP
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 06:37:52 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40082)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0MzV-0002lR-HS
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 06:37:52 -0400
Received: by mail-wm1-x343.google.com with SMTP id k20so10012154wmi.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 03:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/bGogmBOowbkONqYneJGFJtVLrSbRoaKe0N7wLYTf/0=;
 b=OlJ6NVkiQSwExgifMKmYk67neBN1l31lN+qVJvlg4x8Vr7AUViAKA6o+p6NOn/B9/m
 MyWzGbFrFmekS3KGM+4MjNlZCnzAMW7BA8aYss9QCIwsGtSHPcqYdK+gqLWkBPowvjm+
 loBV/Q7oNxXmN4kGc2jUj4Ay4H09XUh0QceHmyZucwaXy8G3IKReqFXCLv0mrvWJubl+
 m4KAnnaUJPBbKHVfI2R6ZfNZaFxx0i1LeKAIeYCP+kwLFAKBWNiWC6vn2VOFXZMoKISM
 Sq7JceRC5Yec5VoZhuJMheoR42W6TKm9b2C37R6K8MiyHwsQTGYXoWSfMxiSIUGYFHuU
 EeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/bGogmBOowbkONqYneJGFJtVLrSbRoaKe0N7wLYTf/0=;
 b=XHj7/tKE3rEBsy+Zl+BFQkZAj6k/jPi6V00KDcidSJprhzXmK1Hq+sPzRscLkNXL6g
 DMjpIWKMOGmwqBeecYt8b8hiZsPrpK2LXhNKyWwu1BJcTCtaKWkswa7ZTjLBAcGkqGDG
 up+w3oZqm2qlApmDbKD3mvmucI07Qq4eDJfLK9gXATyj9Nw1oVMeij2ONytIlFSfVtcG
 thh0AM2kt1oTsPMPC6Wro3rHpiDBmCTILc20PLtQE2pVh0+iBkrpf6WfeSMoSpcv4GuE
 LpBtzz9/DiF1ev5O5ufxUvvwcETRsmJYXZoiVB9bIBU1yKprr0zxe8ic7oMkH7mIFuz8
 hLiw==
X-Gm-Message-State: AOAM530pn/DZdYR9VwMAIqpuPOjCcOh2WKl8c+fovp7rx38AsNsuLYN4
 46yq1wxKPtCO+VYN2nc43dE5/w==
X-Google-Smtp-Source: ABdhPJxpWMylPz8fioMKcx1c4ELM+ZRRXxaUhJzhUp2PZPf196o8y1QQI/KwwXZbKnbHZ68H44IT+A==
X-Received: by 2002:a05:600c:21cd:: with SMTP id
 x13mr461600wmj.155.1595932667939; 
 Tue, 28 Jul 2020 03:37:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w16sm18634657wrg.95.2020.07.28.03.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 03:37:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-5.1? 1/3] include/hw/irq.h: New function
 qemu_irq_is_connected()
Date: Tue, 28 Jul 2020 11:37:42 +0100
Message-Id: <20200728103744.6909-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200728103744.6909-1-peter.maydell@linaro.org>
References: <20200728103744.6909-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Mostly devices don't need to care whether one of their output
qemu_irq lines is connected, because functions like qemu_set_irq()
silently do nothing if there is nothing on the other end.  However
sometimes a device might want to implement default behaviour for the
case where the machine hasn't wired the line up to anywhere.

Provide a function qemu_irq_is_connected() that devices can use for
this purpose.  (The test is trivial but encapsulating it in a
function makes it easier to see where we're doing it in case we need
to change the implementation later.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/irq.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/hw/irq.h b/include/hw/irq.h
index 24ba0ece116..dc7abf199e3 100644
--- a/include/hw/irq.h
+++ b/include/hw/irq.h
@@ -55,4 +55,22 @@ qemu_irq qemu_irq_split(qemu_irq irq1, qemu_irq irq2);
    on an existing vector of qemu_irq.  */
 void qemu_irq_intercept_in(qemu_irq *gpio_in, qemu_irq_handler handler, int n);
 
+/**
+ * qemu_irq_is_connected: Return true if IRQ line is wired up
+ *
+ * If a qemu_irq has a device on the other (receiving) end of it,
+ * return true; otherwise return false.
+ *
+ * Usually device models don't need to care whether the machine model
+ * has wired up their outbound qemu_irq lines, because functions like
+ * qemu_set_irq() silently do nothing if there is nothing on the other
+ * end of the line. However occasionally a device model will want to
+ * provide default behaviour if its output is left floating, and
+ * it can use this function to identify when that is the case.
+ */
+static inline bool qemu_irq_is_connected(qemu_irq irq)
+{
+    return irq != NULL;
+}
+
 #endif
-- 
2.20.1


