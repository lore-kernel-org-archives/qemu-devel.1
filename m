Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97DEC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:36:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72CC52082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WCIbL0bH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72CC52082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUCAd-0003Ks-Hr
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUC2v-0001Vh-98
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUC2u-0006M1-Dc
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:21 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:41677)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUC2u-0006Lj-10
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:20 -0400
Received: by mail-pl1-x643.google.com with SMTP id d24so2419335pll.8
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 09:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NN/QLBosnfSE6MOjBuSmBLZSNupnPgsxwETGi0A5VuM=;
 b=WCIbL0bHsTglQoIoaV8dyoQZjDmKocpOyvRdoC8SvDDaqqiyH3LxUHNSqbZihRxZuC
 q0JK8p3wVhQJPrVsX5Pefqmom8aFFecProtRAdi2QBmdB2sZP7ynniCEtXAw26pshi3C
 TBW8Z01g73qysRU9zW3Wo1rPUirGki9f8KtM2fCHeywQFdrku07uUENIuNPlAEBNmEdO
 9VSXNkRaGYD7pxS7y8K2MUrHWcfr2zvB1xH3TmdNl2utAqy76LINo1eqp/nyYsdMg0y+
 2AsgpL6aMkVjfnVRFNf75IMDr7y6wihY4yQL2bfK6SaXyF/l7oaOsiay+uPhHa6qSS0W
 eisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NN/QLBosnfSE6MOjBuSmBLZSNupnPgsxwETGi0A5VuM=;
 b=XUgCryIH27SnXh0Rdijo/lW8EFQRLvqw4TCg5OCSAhb/wy42BJ4OEYqh+J8gmniARi
 +OMkEosDwQaFuWpUslp6TAEBV2jEEZKqLtB90/PUBI3tDOYOJoI6OE/5Igbv9zX1J5Uz
 YiFs9WS4zrNYbimUydJNEWPj5EzHQNDYCQ5qIWGscZq1xvunKxqpvBgnfv/NwTLb79Xl
 6Q0DM6XXW/Kf2IZiERaASBIp9zUIblUBj6mDM8e1yisInJo8mWqZ+8lES5XV6tLuoMPu
 x4bsJ4plmnK1MaIQFwxCGVNnPBi3MajMpVUdEAFVv2n6xweSqkHkJ93iGmQ67pPVaKcW
 14tw==
X-Gm-Message-State: AGi0PubvG3us572knfY3Nk2U3VNtA96WPer4qXsAQfQMuBeB0Zkv1ZDG
 0TWPqXraggZtdwwpSAsX6JEpzEwpLqE=
X-Google-Smtp-Source: APiQypKxTlpcwir3lVQyzL3kUuPn3bbW4QxX3SQFCoNPWkTXBJneR0D8mhIelE2MlQzEpjmEG7WHUA==
X-Received: by 2002:a17:90a:de8d:: with SMTP id
 n13mr3686027pjv.173.1588264098026; 
 Thu, 30 Apr 2020 09:28:18 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id j5sm243514pfh.58.2020.04.30.09.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 09:28:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 02/18] exec: Fix cpu_watchpoint_address_matches address
 length
Date: Thu, 30 Apr 2020 09:27:57 -0700
Message-Id: <20200430162813.17671-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430162813.17671-1-richard.henderson@linaro.org>
References: <20200430162813.17671-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The only caller of cpu_watchpoint_address_matches passes
TARGET_PAGE_SIZE, so the bug is not currently visible.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index 2874bb5088..5162f0d12f 100644
--- a/exec.c
+++ b/exec.c
@@ -1127,7 +1127,7 @@ int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len)
     int ret = 0;
 
     QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
-        if (watchpoint_address_matches(wp, addr, TARGET_PAGE_SIZE)) {
+        if (watchpoint_address_matches(wp, addr, len)) {
             ret |= wp->flags;
         }
     }
-- 
2.20.1


