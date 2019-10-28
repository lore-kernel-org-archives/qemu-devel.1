Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27FACA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:16:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACFE820873
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j5DjlpNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACFE820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP6kd-0001bu-5A
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 11:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iP6Us-0007Zb-4k
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iP6Uq-00046F-OV
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:54 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:41737)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iP6Uq-00045Q-5K
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:52 -0400
Received: by mail-wr1-x42a.google.com with SMTP id p4so10232656wrm.8
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 07:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YCOFi2fDpbUezaVnqe2fyjA9hZ1F82Ek3+HEANsqQro=;
 b=j5DjlpNdbceAhWM3wA+cq5w2SimbXwmz2a4Sz50xmpRAd69drjUKuzN8RKlJ/WvyOC
 AQeaDLHij8e63cBnpiqO2cMOYXlJI2Goe3yP2jsr/GugX3SPH4OauXtg3PaWLbw/PwbR
 3Xl56VmqGII+IXl6B3oT4hTpLSr2PLR1RC3byS/4RXuOnSXqkbZTQwxIWytLY2ygdPBV
 t+p0kMsN+o9RQbZu6PhmSVq4sld9QVYXGGtOH82CGq1D0LPZ+5kSq1oCZbiAQSX3/ivJ
 WwO1lFpGnll/OjXI+511EkkzIq273BDNagE2ZdIiaIH5K5mGImMw0WNGPmGsA0dngGMz
 xQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YCOFi2fDpbUezaVnqe2fyjA9hZ1F82Ek3+HEANsqQro=;
 b=T25vi5QatwNRI9Qm2VNAdsK8Awo/5S7fWE9Ah97y1wrkYEFyiugSCU3RkVd1uUvxOU
 j1XmzXC55p31jc8nnGct0iP6tWdAfCGhIWcSIoJUPolnh/i1D8auFxGy7swSNZrf0hyt
 dtf/FyNK4aMG1YvbDfODOCySOa+ITppE74/3B82SlAFP6ssKga7v9kL3mC6p9Xllnlip
 LkxH9NSLJTSvNVD5P9C0z9OW0bxStd04VFf6Afkhk0FnSc44Xo2sm8dQp0fdsmUu2XjM
 aKPYy6pTN7P/69uURqY6QeXuyTtPZPuqbc0VqClyh3eLytSTdEAGk37oWgSxM2akYGxU
 tnrQ==
X-Gm-Message-State: APjAAAWNnPnqFnoP9QnGFNOUtK3H0AnVdsWrX5nuAcuqXFBox/jtHG8c
 kXs7vpHX+1EL2XB6ko2s8Hh7+ykE9p2OGg==
X-Google-Smtp-Source: APXvYqysveOw659LnZ6DyKQaD1lci4xO3Sd3m6LYXSkiCiOlQzGbXHck56W+ynCVZCWY1NlfiHR87g==
X-Received: by 2002:adf:ee03:: with SMTP id y3mr15178137wrn.116.1572274789526; 
 Mon, 28 Oct 2019 07:59:49 -0700 (PDT)
Received: from localhost.localdomain (230.106.138.88.rev.sfr.net.
 [88.138.106.230])
 by smtp.gmail.com with ESMTPSA id 143sm14842876wmb.33.2019.10.28.07.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 07:59:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 10/12] cputlb: Fix tlb_vaddr_to_host
Date: Mon, 28 Oct 2019 15:59:35 +0100
Message-Id: <20191028145937.10914-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028145937.10914-1-richard.henderson@linaro.org>
References: <20191028145937.10914-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using uintptr_t instead of target_ulong meant that, for 64-bit guest
and 32-bit host, we truncated the guest address comparator and so may
not hit the tlb when we should.

Fixes: 4811e9095c0
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 6f4194df96..5eebddcca8 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1189,7 +1189,7 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
                         MMUAccessType access_type, int mmu_idx)
 {
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
-    uintptr_t tlb_addr, page;
+    target_ulong tlb_addr, page;
     size_t elt_ofs;
 
     switch (access_type) {
-- 
2.17.1


