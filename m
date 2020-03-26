Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98711C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:02:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B8DC2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DbJ8J4zX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8DC2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYiL-0001vc-Ed
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKe-0007B3-HR
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKc-0001mU-VX
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:23 -0400
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:44235)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKc-0001m4-RR
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:22 -0400
Received: by mail-qv1-xf42.google.com with SMTP id ef12so1652562qvb.11
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mmiRxRrUzc6n/Jyo9kUg5Bu0NCG0n21LS2Ois1y8SwI=;
 b=DbJ8J4zXgPvllhvqWxTxrIYv/oC0UGXUaJa5+YDuUb2MIqdbHA22OxTA7iD3g8xKx5
 kPzcKq6iVLMCQdazeNDVcbN8SOb24XAgcq69aSO+xhppucVL+c9fas6Je4Nn8+3vuaAD
 CrG0Eko4LRfXquB1c5f2a3rD5cqUnOYlh8z7UWzJFq+UaNh6+XRXbKMsze8NAp+FLFn1
 NQEWfj+DlNZolpdTOrUW2dvUwqaG4TQsY8+YHgib8jCXPV8DF5uHvAvLdWbpUqj6rq03
 C8KV/3cwCaEGc6/+TC2yeYO11Zn/+jAKghPbU6Rb+EBUd9MlpCT/7KOnvcKNKNJ6aWQg
 ACLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mmiRxRrUzc6n/Jyo9kUg5Bu0NCG0n21LS2Ois1y8SwI=;
 b=ZmA0q43PsGGp/FC+zvdlwJPVq9Mh0P7d1/8oHSCKI2k9H/byY5tJxsIqCptRukvqB5
 o8nw/2z4Lp94HodvJg5mpiU/Ow3Rnry5Ck4IZaBLzjmaNw2xinybUj/0JMTAleG00FHz
 5d/fT+fwD+vPeze7eUjVIje+wg9YcK9XQ/0XGQdOIdWjZ8uh7cfqZNWwged0fGDaGYnD
 4DPT2/ijn9i6xIXEOFOzplLh8tXBXA5uV7YNaXXNdsi2VCV8cvaww1d7CDNSHC/BM5uy
 Z/MhvF6oeMmdMKoDPEvuRM0YmVwz3Vx9y5/YB6N5xQNJx3meTge3Elr742J8L6ZHQb90
 4y3g==
X-Gm-Message-State: ANhLgQ1vtSA6pNoKRaRV0xPLsrBetT1HVsKnb4wXZJWdnUzIW5O1jjJi
 2U9SA+s7UU5yL5m9lcNya1qkpKnls/CCKg==
X-Google-Smtp-Source: ADFU+vtcg8mi+zdWBBigQSvqLGw0b48GKjevRGbUlFMldYmal73uW1j8Naqpwyp9Uozrt+YFjZdmhA==
X-Received: by 2002:a05:6214:70e:: with SMTP id
 b14mr9826831qvz.246.1585251501700; 
 Thu, 26 Mar 2020 12:38:21 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:21 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 35/74] exec: use cpu_reset_interrupt
Date: Thu, 26 Mar 2020 15:31:17 -0400
Message-Id: <20200326193156.4322-36-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f42
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
Cc: richard.henderson@linaro.org, "Emilio G. Cota" <cota@braap.org>,
 alex.bennee@linaro.org, robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index de9d949902..a379016693 100644
--- a/exec.c
+++ b/exec.c
@@ -752,7 +752,7 @@ static int cpu_common_post_load(void *opaque, int version_id)
 
     /* 0x01 was CPU_INTERRUPT_EXIT. This line can be removed when the
        version_id is increased. */
-    cpu->interrupt_request &= ~0x01;
+    cpu_reset_interrupt(cpu, 1);
     tlb_flush(cpu);
 
     /* loadvm has just updated the content of RAM, bypassing the
-- 
2.17.1


