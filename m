Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5A2C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ECCE2146E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L2h7WkGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ECCE2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49960 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK4fL-00048q-CZ
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 13:29:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aa-0000Ak-Bg
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aZ-0007Kw-2d
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:44 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK4aY-0007GO-S7
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:43 -0400
Received: by mail-pf1-x444.google.com with SMTP id j11so2024176pff.13
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=s+lfsXhUEsggZv7QGs1XHx6DsIQr/qtfxf0ZchCRrog=;
	b=L2h7WkGwnsPynm5YDKUVvrNH417QIFDzw6uhOvM9SMkqAza62HC97DPc73TO742flP
	SI6r88iKmIkBoG3r4UdrZAH+Rm9QK4SyGIO9kI3ADm4Jbfxkb05QYdVYHAR2Y77xZsdP
	wAWOv2V8VT+a4oJhxT2Ka19PG6O0H0isKjSejB52qh6ebbQn05PlidHf4GGiRlTMJgRD
	fbXlKv9k3zFwERwJoiU9sodO74KcEf5mYNiXokiBHgvWxnsGiXkKyo+YUCMaklljg6Rq
	Ia5NOqyddu/MfQq0al8Ei8CkIHP3+G3tu6GX9/IcN0ihQvjqHedfrrLZdmuyUNON7Yyu
	aELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=s+lfsXhUEsggZv7QGs1XHx6DsIQr/qtfxf0ZchCRrog=;
	b=O8C/KJWI4EymQm+1zxcrejaEXdJS6bgKHih7ZBCYx09olmP4dbStyk60UU4EWciHRe
	r3cugWVldBVJs1LfmMUG5gKgxn3GeCPWhmnP+eyV7JSd5lufDIibL/jwXUAZ6FHPWS/e
	2m0TjHMCRMuRC+U9mdAXWBYjmUVsNeDsRq8+7QtnWo9bwo/jjobRr7yyTQQ5SXF3uSGv
	HK6YH/1kbZYbEPiUxHKFVubA7OTKd2pSmTu43CdTbtYqLvZczqqB26x5a7JRFk/qgaM/
	1zhf+dsj46iVEXZbsTGxh3TaFGSyRWeYt4J1Ok6B/al9//L/p85TSFIGh3lZWxXtSOzF
	4GTA==
X-Gm-Message-State: APjAAAW401NyrNRHpXYUt/ri7B6FqGJ/sH1fNmfsK2B6sHlZDbxfzXGP
	0Uik2Z1RigEkkmtt8vEBAlfJXKmxgf4=
X-Google-Smtp-Source: APXvYqx5fXyKGlQukByXvHk3q+ubOL5D9Vsczi+FFSBJ1q+gHSEoi9Xm1Eb9PA0Oqjk8cbtmvHl99Q==
X-Received: by 2002:aa7:925a:: with SMTP id 26mr2855571pfp.152.1556299481627; 
	Fri, 26 Apr 2019 10:24:41 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	j5sm7901762pfg.186.2019.04.26.10.24.40
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 Apr 2019 10:24:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 10:24:21 -0700
Message-Id: <20190426172421.27133-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426172421.27133-1-richard.henderson@linaro.org>
References: <20190426172421.27133-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PULL 15/15] cputlb: Fix io_readx() to respect the
 access_type
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
Cc: Shahab Vahedi <shahab.vahedi@gmail.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426172421.aBLpYdCY9aNpZNJAM2Nu7VRTbaHT_hb6I_805-QvPy0@z>

From: Shahab Vahedi <shahab.vahedi@gmail.com>

This change adapts io_readx() to its input access_type. Currently
io_readx() treats any memory access as a read, although it has an
input argument "MMUAccessType access_type". This results in:

1) Calling the tlb_fill() only with MMU_DATA_LOAD
2) Considering only entry->addr_read as the tlb_addr

Buglink: https://bugs.launchpad.net/qemu/+bug/1825359
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Shahab Vahedi <shahab.vahedi@gmail.com>
Message-Id: <20190420072236.12347-1-shahab.vahedi@gmail.com>
[rth: Remove assert; fix expression formatting.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 88cc8389e9..f2f618217d 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -878,10 +878,11 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
         CPUTLBEntry *entry;
         target_ulong tlb_addr;
 
-        tlb_fill(cpu, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
+        tlb_fill(cpu, addr, size, access_type, mmu_idx, retaddr);
 
         entry = tlb_entry(env, mmu_idx, addr);
-        tlb_addr = entry->addr_read;
+        tlb_addr = (access_type == MMU_DATA_LOAD ?
+                    entry->addr_read : entry->addr_code);
         if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
             /* RAM access */
             uintptr_t haddr = addr + entry->addend;
-- 
2.17.1


