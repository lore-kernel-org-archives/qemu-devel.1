Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03995ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:58:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C724B2084B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OWJPvOmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C724B2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJy3l-0008LA-I8
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 06:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvO-0007KJ-9h
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvL-000654-EH
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:01 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36254)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJxvL-00063Z-82
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:49:59 -0400
Received: by mail-wr1-x444.google.com with SMTP id y19so19160229wrd.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4u0DAyRPQyWfOOgltou2F/pxj6T1sopcMhD6CsKad8c=;
 b=OWJPvOmU6vFfD4sBY0QJ9GlIZZOKF04Wio5sifydOP/5V9X5RGZyB+1jiPsshDX5QR
 zuTW2t5g3aV3LBSWzG3n1FQm8/sLgZjrU6F1O7s5yHT1VCzb1vaQHH6ZsIUW0sQreY3l
 Ohcr5plk8v/Wqixo4qHqUHegjFFN0LASpL+My4BaMKvByvJq3A/QMMxLdn9/+QygFXfP
 LWYUeVcHfMd6hXn3jzEx5lRuInnXlO/1zcTjRPb2IRzOyEsL14Rn/DkXb4r927xFiFOI
 WZi/4L6XxeRijepEEFZwIlZ+4o2WKatDWjnXt04u/sCCfWDPl/V0VmCBgmeW5U0fVdRD
 crhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4u0DAyRPQyWfOOgltou2F/pxj6T1sopcMhD6CsKad8c=;
 b=m3pVWXtpU0eQqdA9YI0mH4uqFZEOMx7veLihOj8Oc2KSiC/bxSYuBIZ/pF4pwU9Gdl
 oDaXFV/t7Q0FovCsAX+6nULXvaq/njQINtoh/3nagAnRSyPpe+yiqMzrXOAT6SJB0CKz
 aiTGx0oH+60efAmOAKbGQU8xmhSmhlBXlHwflZnX4+XGgsSw+y1xK5YrXf4n/AsHgYbF
 pk837qlwGemXHmtfVg++g8oRHVQTHWnyXot9YGqX/UyIzg+8qKdDgDBNebPwe49WG+Cw
 dr+9mP/239tmO8gWsio/K6kqHy/ggkkccnbcxWN6n+B+g95st2DkrMlUbcvTsbtLb9Z4
 dvuw==
X-Gm-Message-State: APjAAAWbZly3VDQsy2Bl7Bb1V7uookNXht9VGwRiTHIHBzNDgJAzBrqj
 OGPNJGORpl19Q/D5JApPEsT3rQ==
X-Google-Smtp-Source: APXvYqzuXImAeYcTFqNuberFTRm6X6s8y5X/ciX/01VjM6zSnSeDb+Mb2srQAodsu+1/XNwv+Os1mg==
X-Received: by 2002:adf:ba07:: with SMTP id o7mr26366823wrg.50.1571050197738; 
 Mon, 14 Oct 2019 03:49:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l9sm15311790wme.45.2019.10.14.03.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:49:54 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4D0891FF98;
 Mon, 14 Oct 2019 11:49:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 10/55] queue: add QTAILQ_REMOVE_SEVERAL
Date: Mon, 14 Oct 2019 11:49:03 +0100
Message-Id: <20191014104948.4291-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

This is faster than removing elements one by one.

Will gain a user soon.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/queue.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/qemu/queue.h b/include/qemu/queue.h
index 73bf4a984d..4764d93ea3 100644
--- a/include/qemu/queue.h
+++ b/include/qemu/queue.h
@@ -420,6 +420,16 @@ union {                                                                 \
         (elm)->field.tqe_circ.tql_prev = NULL;                          \
 } while (/*CONSTCOND*/0)
 
+/* remove @left, @right and all elements in between from @head */
+#define QTAILQ_REMOVE_SEVERAL(head, left, right, field) do {            \
+        if (((right)->field.tqe_next) != NULL)                          \
+            (right)->field.tqe_next->field.tqe_circ.tql_prev =          \
+                (left)->field.tqe_circ.tql_prev;                        \
+        else                                                            \
+            (head)->tqh_circ.tql_prev = (left)->field.tqe_circ.tql_prev; \
+        (left)->field.tqe_circ.tql_prev->tql_next = (right)->field.tqe_next; \
+    } while (/*CONSTCOND*/0)
+
 #define QTAILQ_FOREACH(var, head, field)                                \
         for ((var) = ((head)->tqh_first);                               \
                 (var);                                                  \
-- 
2.20.1


