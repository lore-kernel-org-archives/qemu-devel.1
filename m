Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B35BC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 664D1206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wl0dVZXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664D1206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYsh-0002Jq-LH
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLA-00081k-Ck
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYL9-000268-81
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:56 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:37530)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYL9-00025z-3e
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:55 -0400
Received: by mail-qk1-x741.google.com with SMTP id x3so8184607qki.4
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NQ/BbjaNmbkm5KQOy7Vv4O17R/NYOg7qZF+hAsl6NgU=;
 b=Wl0dVZXvjbKeAqvAIepWlW6UGUJHBBBX3TFq91rHyH0sCpz3c5NNTs/jprrcR5e5Li
 CTZV0Xp3oAcrEGbueiOsGBPfCQ+Nz1wt/ZsweApDXjbz62g+Q/aHuJBhB1cM76ZHEGBQ
 XHb9tVGii55HuEDP83tTBNT1ILWi3BzHaRYiVSAyQVur/B7PU+y87MOMHm6BFpL2bRp5
 J1tiFb6S6DmTbUf5NLQ7RJFAMQCMb2ditMkPNwOnx1JFA3jaIcyIE35YDeUTluyGRKkm
 CQgjhB9PbF6oUKVuBZnA2ZMUWk2Ex2vdow8AxPKdCR5ylAC2AvVAkYtP+p8t9ue6HNl2
 AC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NQ/BbjaNmbkm5KQOy7Vv4O17R/NYOg7qZF+hAsl6NgU=;
 b=Da1eBm6YZbeXff0LaatCOwGujwtBj5dSFBfBsvHhV8OWnjTycaSZszz+kB+jPZx4gT
 eyfzTljVfoJ60K7xYTK9vGDrV2Borm33HEBFsRkXHkEeeMBh4RYybkEiYCFy/btf3snx
 8x9dDqu0cMqVswDtykgncIQeb3E8gQH0hqo4M4Ee7rZjkNWRVOvucnRgEM3cY+R2i1gC
 9zigCu2rMVwmI9tbs9FrdZ/32x8fkuhIEKJNjlADbwsAWPpBaWxwKv66IxaOKk68liiB
 o6mw2GYRM5jrjO7eXz0Enis9COWGa707/QSN86dOeEY0vNeQCI028/iPbmuynvSf552U
 xKoQ==
X-Gm-Message-State: ANhLgQ0uy3Jl8uvWBINF3cUO++6Z5XzbMe+ST0sYm+5YPnDPXI3MwTPx
 iSoB0b0B24jEPzdydrGc8K3b5g5Q0Z00eA==
X-Google-Smtp-Source: ADFU+vtHIOcXKCAWTck51vO9zfKYJg6CXsej8gn8cz+AmNy73S9454EsGfWHt95GNnoIprlYOpp4rQ==
X-Received: by 2002:a37:a0c1:: with SMTP id j184mr1276310qke.351.1585251534343; 
 Thu, 26 Mar 2020 12:38:54 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:53 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 58/74] unicore32: convert to cpu_interrupt_request
Date: Thu, 26 Mar 2020 15:31:40 -0400
Message-Id: <20200326193156.4322-59-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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
 "Emilio G. Cota" <cota@braap.org>, peter.puhov@linaro.org,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/unicore32/cpu.c     | 2 +-
 target/unicore32/softmmu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index b27fb9689f..06bf4b4b63 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -27,7 +27,7 @@ static void uc32_cpu_set_pc(CPUState *cs, vaddr value)
 
 static bool uc32_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request &
+    return cpu_interrupt_request(cs) &
         (CPU_INTERRUPT_HARD | CPU_INTERRUPT_EXITTB);
 }
 
diff --git a/target/unicore32/softmmu.c b/target/unicore32/softmmu.c
index cbdaa500b7..9660bd2a27 100644
--- a/target/unicore32/softmmu.c
+++ b/target/unicore32/softmmu.c
@@ -117,7 +117,7 @@ void uc32_cpu_do_interrupt(CPUState *cs)
     /* The PC already points to the proper instruction.  */
     env->regs[30] = env->regs[31];
     env->regs[31] = addr;
-    cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
+    cpu_interrupt_request_or(cs, CPU_INTERRUPT_EXITTB);
 }
 
 static int get_phys_addr_ucv2(CPUUniCore32State *env, uint32_t address,
-- 
2.17.1


