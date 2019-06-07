Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A5DC28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:51:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC9F5208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cxnAAiEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9F5208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47650 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZBWf-0007MG-82
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 05:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42065)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAvK-000292-8p
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAvI-0004iI-8n
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:34 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:46959)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZAvG-0004ag-8v
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:32 -0400
Received: by mail-wr1-x433.google.com with SMTP id n4so1339528wrw.13
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s5wS2YCmNrWOpRGICG3GBDDb7iKA90ngEqstlnBtJU0=;
 b=cxnAAiEmIBVJHy3IBBaqTIJXzpehox8BHAdbLUseNY2SHCywMO9iIrziTu0Dg6AvY3
 Wo6h1RlO7zmqB2sXZ2+ALwUPUIEJATIIAV+RaO3zhNkCkvTynVVkC+Il2GR+YwloRB3W
 hPig/QDMKJCH7k94pYk6Tl/3dQJ3Y9ID7ufwxCwHeKFZWq9c2GZLXHoYLRfZY0S7oJ2p
 /hkkTz4Zv9ir+y/fyKnRv1wrLH6kyxbOLo2k+biq/nIj/i711G+1jHd2nPac8CofQ4kD
 s3gD/h8klzAOwZtv60oLUWWmb2PS7oWlWWxIZrRfXyPly+yHHywznPvB1yMH8ax9Mqb1
 CMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s5wS2YCmNrWOpRGICG3GBDDb7iKA90ngEqstlnBtJU0=;
 b=d8ACLAvPMQK4Ms691PrTXEG+jKbiQctFoyXxWAKdbSHfgJepMFymmLaWoOg2rd2/al
 9rQPDe37k+M3se8+AZHmS476Z8WvCUu4A5TmcCpdAhsfOBQ6R5BXyT8AJpnug5cQg4+M
 9kYjP3wCZcggGD6r1X9cki/ex5pIoAr2T0SLg6d6tON3u2mCcBQG9fqjrQr1aOAk9ldd
 i7A5G4gX1/hnXsCB7wV6ohnNLX8J+7f1+ovB+XGT32exY6UR2MGm+T56FxeLInedv3Ha
 gJzeCYhRMsKLLznW+M9fy8LaLBpn4GNewVXgHlPPUivdTQ+KlULLOyG4x2kUC516QPLY
 kKNQ==
X-Gm-Message-State: APjAAAW7bEMrLkplgryLcFRq4EBwugktgaV9Qc+hzGGjYKCAp89SF76x
 3DZdu4Oh+AfqwNztnPTZBl2JDw==
X-Google-Smtp-Source: APXvYqzlK9QbuCFj6EmFq4Kp9dGsEAcrBarrPAENGrHDo/iXDT0NZfQ/a+wOiMPBR4TXI9dWngNyXw==
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr31413845wrr.252.1559898747207; 
 Fri, 07 Jun 2019 02:12:27 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id t6sm1552335wmb.29.2019.06.07.02.12.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:12:26 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 939E21FF8F;
 Fri,  7 Jun 2019 10:05:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:31 +0100
Message-Id: <20190607090552.12434-33-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
Subject: [Qemu-devel] [PULL 32/52] cputlb: cast size_t to target_ulong
 before using for address masks
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Andrew Randrianasulu <randrianasulu@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While size_t is defined to happily access the biggest host object this
isn't the case when generating masks for 64 bit guests on 32 bit
hosts. Otherwise we end up truncating the address when we fall back to
our unaligned helper.

Fixes: https://bugs.launchpad.net/qemu/+bug/1831545

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Andrew Randrianasulu <randrianasulu@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b796ab1cbe..8f814a1a2c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1306,7 +1306,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
         uint64_t r1, r2;
         unsigned shift;
     do_unaligned_access:
-        addr1 = addr & ~(size - 1);
+        addr1 = addr & ~((target_ulong)size - 1);
         addr2 = addr1 + size;
         r1 = full_load(env, addr1, oi, retaddr);
         r2 = full_load(env, addr2, oi, retaddr);
-- 
2.20.1


