Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0159BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 748AD2087E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aaJfPbVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748AD2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRzsC-0000Om-E7
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzq8-0006Vw-RX
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:20 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39086)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzq6-0007Ec-Q3
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:20 -0400
Received: by mail-wr1-x441.google.com with SMTP id y12so14319489wrp.6
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sKzcEV9wkONoPB+ynBHsD63nfFrJQCqRKP35Nd+BbUw=;
 b=aaJfPbVX5qvkCUMpehoCvXStKyYH/TeJxcxt4vtP2dARW40Ki8TJndq6nJhn0lQig5
 IyZGhvR0TjpYLIe28G6N5CwXIPDtNh/NY6DLIVVVnzpJw7CWWekqhRIoSTkB6jPx6Y/D
 K1XUpLabtImzLy4nMI+jS4CY8EdVvGcXr7l9DTWFfB8Hj3KQdYbq/h2K2fPDeOIv+Sxg
 PrQdPF2LukI3Ahw0/NT5WnekczWwsL5wPkRkvS7KchGaiWyoko1bhq4dsp3f7kb5OLIX
 czQEqmLmqKTCuqZlGnwmomMbGiQrH0wQummw4CTjcdyNN3HxRZLHBFpTas3z+Ax8NlYG
 0yTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sKzcEV9wkONoPB+ynBHsD63nfFrJQCqRKP35Nd+BbUw=;
 b=rfWcA5Kkvt1vF3hSTPM3z0olYUkp/fLWDLlpZBSIUKLmqZADl6zHmbNsR78hJEdB5c
 7sXeCUCKAAe0WcUsm0slESA8UDUCZBmyvYg50BWDGcpVE9mu6j7wzkKcmf9dUI9FZjDf
 ng8DtMimAsFDjczRoLOKCeeXBViEkDhzMoJZ5Mk0lQPzUiwfhPW/ykPoASQ0b/KXeUJm
 HtyzJp1cskG6ASpYwX96Djki2B3XyGQRRy4WU6csvDv+wGbzJMzEH4RlwedZQWmonqYs
 cYeaA5e/78lcrTnjeUxWVGcJzMEA7U2/u1y+HJcvjtP7SwmI0NGiveVyTKPOvZ+/UkSS
 vaOw==
X-Gm-Message-State: AOAM530bDa3lG8CPNITHxRx12M99Z/sXDWxEa8sAxLEU0XPXn8er6/Yt
 VkBMNO5lT38EZDFDNZKYrYXiTQ==
X-Google-Smtp-Source: ABdhPJzpBO7F8dZGqBQSx9hknkMP1vlsCgNOrMi6Bdab7zvBhOpT0zmOhCRJSgx/C+oR3tLafLmy2g==
X-Received: by 2002:adf:bbd2:: with SMTP id z18mr32721774wrg.166.1602516857554; 
 Mon, 12 Oct 2020 08:34:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm19675284wrq.73.2020.10.12.08.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:34:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH RISU] arm.risu, thumb.risu: Add v8.2 DP and FHM insns
Date: Mon, 12 Oct 2020 16:33:29 +0100
Message-Id: <20201012153408.9747-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012153408.9747-1-peter.maydell@linaro.org>
References: <20201012153408.9747-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add coverage for the v8.2 DP and v8.2 FHM insns in the Neon extension
space.  (We already had the v8.1 VQRDMLAH/VQRDLSH and the v8.3
VCADD/VCMLA, so this brings the risu coverage into line with what
QEMU has implemented so far.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I added these patterns as part of testing for the first part
of the Neon decodetree conversion and forgot I'd never sent out the
risu patch for review.

 arm.risu   | 18 ++++++++++++++++++
 thumb.risu | 18 ++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arm.risu b/arm.risu
index c16d245..f8b6deb 100644
--- a/arm.risu
+++ b/arm.risu
@@ -861,6 +861,24 @@ VQRDMLAH_s  A1 1111001 q:1 1 d:1 size:2 vn:4 vd:4 1110 n:1 1 m:1 0 vm:4
 VQRDMLSH    A1 111100110 d:1 size:2 vn:4 vd:4 1100 n:1 q:1 m:1 1 vm:4
 VQRDMLSH_s  A1 1111001 q:1 1 d:1 size:2 vn:4 vd:4 1111 n:1 1 m:1 0 vm:4
 
+#
+# ARMv8.2 extensions
+#
+@v8_2_dp
+
+VUDOT       A1 1111110 00 d:1 10 vn:4 vd:4 1101 n:1 q:1 m:1 1 vm:4
+VSDOT       A1 1111110 00 d:1 10 vn:4 vd:4 1101 n:1 q:1 m:1 0 vm:4
+
+VUDOT_s     A1 11111110 0 d:1 10 vn:4 vd:4 1101 n:1 q:1 m:1 1 vm:4
+VSDOT_s     A1 11111110 0 d:1 10 vn:4 vd:4 1101 n:1 q:1 m:1 0 vm:4
+
+@v8_2_fhm
+
+VFMAL       A1 1111110 00 d:1 10 vn:4 vd:4 1000 n:1 q:1 m:1 1 vm:4
+VFMSL       A1 1111110 01 d:1 10 vn:4 vd:4 1000 n:1 q:1 m:1 1 vm:4
+VFMAL_s     A1 11111110 0 d:1 00 vn:4 vd:4 1000 n:1 q:1 m:1 1 vm:4
+VFMSL_s     A1 11111110 1 d:1 00 vn:4 vd:4 1000 n:1 q:1 m:1 1 vm:4
+
 #
 # ARMv8.3 extensions
 #
diff --git a/thumb.risu b/thumb.risu
index b8afa59..357b791 100644
--- a/thumb.risu
+++ b/thumb.risu
@@ -449,6 +449,24 @@ VQRDMLAH_s  T1  111 q:1 11111 d:1 size:2 vn:4 vd:4 1110 n:1 1 m:1 0 vm:4
 VQRDMLSH    T1  111111110 d:1 size:2 vn:4 vd:4 1100 n:1 q:1 m:1 1 vm:4
 VQRDMLSH_s  T1  111 q:1 11111 d:1 size:2 vn:4 vd:4 1111 n:1 1 m:1 0 vm:4
 
+#
+# ARMv8.2 extensions
+#
+@v8_2_dp
+
+VUDOT       A1 1111110 00 d:1 10 vn:4 vd:4 1101 n:1 q:1 m:1 1 vm:4
+VSDOT       A1 1111110 00 d:1 10 vn:4 vd:4 1101 n:1 q:1 m:1 0 vm:4
+
+VUDOT_s     A1 11111110 0 d:1 10 vn:4 vd:4 1101 n:1 q:1 m:1 1 vm:4
+VSDOT_s     A1 11111110 0 d:1 10 vn:4 vd:4 1101 n:1 q:1 m:1 0 vm:4
+
+@v8_2_fhm
+
+VFMAL       A1 1111110 00 d:1 10 vn:4 vd:4 1000 n:1 q:1 m:1 1 vm:4
+VFMSL       A1 1111110 01 d:1 10 vn:4 vd:4 1000 n:1 q:1 m:1 1 vm:4
+VFMAL_s     A1 11111110 0 d:1 00 vn:4 vd:4 1000 n:1 q:1 m:1 1 vm:4
+VFMSL_s     A1 11111110 1 d:1 00 vn:4 vd:4 1000 n:1 q:1 m:1 1 vm:4
+
 #
 # ARMv8.3 extensions
 #
-- 
2.20.1


