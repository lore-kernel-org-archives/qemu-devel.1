Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7FCC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:09:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC8F120759
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w6ewQJaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8F120759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbohP-00061V-4c
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJH-0004ab-SH
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:43 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:33301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJG-0006n2-Ms
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:43 -0400
Received: by mail-qk1-x743.google.com with SMTP id z80so7921281qka.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Gn2vKDOISxQzKy44RYpzzeOAg/5NGEBTOA6wtcYZvN4=;
 b=w6ewQJaVNHlfqxUwmcl94B40fhD4pjmyTDUwV9aACZqsZay3ux3wsq6a9AedtIdZ4O
 9TBgFrhwzNqBYP8y1lISG4kf3zfd6vpiBY11hAFTCoTPzeCEVCDriJ7s2PnBKZszu1Gz
 PFOKQi8J4XEkujUsy4qrCyJbW/Qachj+BP4hUAD3Rx0KOghPOIVK6hcPjW7ag9+FKIW7
 y7reI1ZjXcm3+QnH3IpHMc+YdbWNN2+v/TIbR1vVP/JwLe7SL4qvvrDjAoGUwQ2clk7Z
 pVnDGNF+Wwwlji3Z+xE1CpSPz9N3b98mgXi0YqUCl47NyHLOqMN2jpxK8CflPflZ1xoz
 UT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Gn2vKDOISxQzKy44RYpzzeOAg/5NGEBTOA6wtcYZvN4=;
 b=JDCrlwHu6nngK9OgD/CeifUm+MPmPzxShbf2BwOzgY567Bzu8g1miikzTuUzOR4C6I
 RkX29sP36m8tnwjFi3s/2IrzF5ytVblBkqLytQTot4lmtOVS2VS9hwCnxmvgj4F+JLal
 ulcuNy4MBJ4Cdb6ClLAFNvcs6YSDAu9asVR/FK1hqiwq/nwltwZHaYOw/jOWw+RqLv1R
 YbyNW6vmJDleGLsbG1S8SZfOCxy/mCf19sdwQQKLNW8xxk1kbrDmYwPY1fxwr0oQt2Wz
 P9A/ilvk9NQXDyMQR0Gj4LeZXryFRZNzQi/2x2/bxIQWJ06Lf7vvJfI3tEVOyQ4eRazJ
 QOrA==
X-Gm-Message-State: AOAM533HSRgAEbf2f2U54h2vJrynjmYavU68v2ZEVQcIDCWIeMXQmc7E
 nXEkOfXHb6LQFri7CsuVdzHQsAPcNfoa3g==
X-Google-Smtp-Source: ABdhPJxUOFG5AU32hHpb9iIRytixrzjcqFY3Ps0ryUK3ULJpyzY+5i0HLTIM22K4qI8eeSzfb8JyVA==
X-Received: by 2002:a37:a42:: with SMTP id 63mr11126690qkk.399.1590079481587; 
 Thu, 21 May 2020 09:44:41 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:40 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 65/74] mips: convert to cpu_has_work_with_iothread_lock
Date: Thu, 21 May 2020 12:40:02 -0400
Message-Id: <20200521164011.638-66-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x743.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, cota@braap.org,
 peter.puhov@linaro.org, alex.bennee@linaro.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Soon we will call cpu_has_work without the BQL.

Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/mips/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 761d8aaa54..ec9dde5100 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -58,6 +58,8 @@ static bool mips_cpu_has_work(CPUState *cs)
     bool has_work = false;
     uint32_t interrupt_request = cpu_interrupt_request(cs);
 
+    g_assert(qemu_mutex_iothread_locked());
+
     /*
      * Prior to MIPS Release 6 it is implementation dependent if non-enabled
      * interrupts wake-up the CPU, however most of the implementations only
@@ -193,7 +195,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
     device_class_set_parent_reset(dc, mips_cpu_reset, &mcc->parent_reset);
 
     cc->class_by_name = mips_cpu_class_by_name;
-    cc->has_work = mips_cpu_has_work;
+    cc->has_work_with_iothread_lock = mips_cpu_has_work;
     cc->do_interrupt = mips_cpu_do_interrupt;
     cc->cpu_exec_interrupt = mips_cpu_exec_interrupt;
     cc->dump_state = mips_cpu_dump_state;
-- 
2.17.1


