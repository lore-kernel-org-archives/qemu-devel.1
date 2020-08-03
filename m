Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA90C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 19:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A4922BF3
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 19:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ugy0lGIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A4922BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2gGo-0004Xr-Ep
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 15:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2gDr-0001Ou-Ts
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 15:34:11 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37110)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2gDo-0003ZK-PV
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 15:34:11 -0400
Received: by mail-wm1-x342.google.com with SMTP id k8so685743wma.2
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 12:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=4vDGqZ2ldUksfvaG7R4N/0YfoKdcIGpfPr3KnIZ9SRY=;
 b=Ugy0lGItCz3Nm6a3O/KpSLAhDFACL8+BtOQZ5re6E/LR9EM0fObTM4gz5QGNn+/Dss
 LT314GOx3WqTCIV41akU5UFovcU0Uot0sKcGuD64Z11CGajsNor2Rlawe0vNDJ7YfYL4
 ErN/OoBKKSxRehStevX6EI5VeEGkbbv76QzKEeZn7NLnvzT7SyUbgN4nJsLziXcvh0dE
 jW/qi/FrzuzRQ4X0wLjW3Jm5KUk6XdxXVS8I37iAqzmbiiP0PHopS17t3M9mMXAuLgwU
 9OhbemoxOFplTu/KlcJNLlffe1SYLtvrbNel39+gmUH/9lB9tMXgav8i7JCnzlFyx1xn
 gY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4vDGqZ2ldUksfvaG7R4N/0YfoKdcIGpfPr3KnIZ9SRY=;
 b=gRGUTEs/BlBi3zdQnh5LlwotBzmC2g9xjwG+XS0Xsh1ixAfM0NZobTsZnudbgzZOnR
 HT6Ba36VR+h3Wabc7wY39pWd/UxXsTDkhza3Xg2RcpsQlCNxLHcbNsWjUUEEopUxPx5q
 CC+oQkRQFnNS398B4CMUk/Mg+yFQqAIA1wO8alwOA0hMgxP2tf6z6JFc2pyqD3EHNXeZ
 P+AW27OGvkaO/tJcxGlF3/UNS3izyxOaxEovnF8WI41Od27OpxKN/WSQ1XbDgpXqE212
 ipVite7k1prTJqFM8VpGgXYv7CHJqE6+bojNT67DNuZnl3eS68mZyjMfGKGlicrJ66aL
 Ji1g==
X-Gm-Message-State: AOAM533XG7d9FeoPMbh98mGldM2hENIlZTfycgCK2VmCGYYSbbETP9Ge
 QVzMNypuNCtRu/KPuT+xx0YA03EWkHTuiA==
X-Google-Smtp-Source: ABdhPJydnLk7uj5DcidOAm072wFtsVKMEul6iuuy2pwYGAssaOKcMO8V9v1rYtMynLT3GECC3RSJww==
X-Received: by 2002:a1c:e008:: with SMTP id x8mr626549wmg.75.1596483246200;
 Mon, 03 Aug 2020 12:34:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r206sm985565wma.6.2020.08.03.12.34.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 12:34:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/8] include/hw/irq.h: New function qemu_irq_is_connected()
Date: Mon,  3 Aug 2020 20:33:53 +0100
Message-Id: <20200803193359.12936-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200803193359.12936-1-peter.maydell@linaro.org>
References: <20200803193359.12936-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200728103744.6909-2-peter.maydell@linaro.org
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


