Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C72C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:01:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DCCF206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sghoYMdz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DCCF206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYhJ-0000Nf-NT
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLE-0008GQ-LI
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLD-00028R-ME
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:00 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:37734)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYLD-00028F-I0
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:59 -0400
Received: by mail-qt1-x842.google.com with SMTP id z24so5299625qtu.4
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3+dDYhOsrCzCqoW7z+RZ/sAylJhW5dwNkVTgxwH+p1I=;
 b=sghoYMdz86LO2Hy5B+1LuEwfrk1FPwMEUvptutJ0pBrj6NvvBzHSdNdzbpmPCfh8hu
 F+so31ao33JJHSDk5CDHVxIgNJOnZkZomGuruWcbr5tY4DbcLqQEpQxQ9rDxMumrZC8V
 +yV3MKyM//dJkfwSG5a92TIi5yuoGra2kX6CS6+KgXg3gmmVMo+H8G8srYY7F7vyP4Qi
 YVbJXbRRFnNoYs63HRH8hY2p8n1Po7rDoigPj/sxQYOOT8D/s/9/alDRy6IyUJZfXLP6
 zlejRs3ExCg/1DX0Axm3y0RTsFoKtUHAQwEZ64F0FXb/81IPhv35DfXnV4GTfsawaghp
 Jzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3+dDYhOsrCzCqoW7z+RZ/sAylJhW5dwNkVTgxwH+p1I=;
 b=MahSj656nCNPERFbGsOHSSjgs4XswjE0U9id8u2bb24GmZdSJYU46tRggiMwuk+PbS
 U2e3SF3XsthTilTnBpCPed9LCj51RYYFpVuKLEdfzwd+S5T05+XYtXOpJmjGvF/NZDqT
 LPDzmbeu+AlK1hTF1SA53aB/V7pkcq0abnKV5LOZBF33c+3xOuKCEXJUjSZfR68pQ3BH
 fwvxcTcqm3Wau4bo0w+5Bz9UpB7fJN+iKAjVNR+7mTQZIZgiP5c3+VB7hkQjegbZoUtF
 BZfbi4z6P6/AA+6gafNyw74nKHsDkUXn7P+K1++jKJLqUvS87mzf/e6LY6R+C0Yp4JN9
 JqAQ==
X-Gm-Message-State: ANhLgQ2I+lio7VzKES6/kjQcJ2HaAqFq9hEny2Oreih2ga2d+OpZ1wgS
 WKrbZ1ZhBc/bSlMg7+E4uJqRuM22QABhlQ==
X-Google-Smtp-Source: ADFU+vtkbuMwTCvdNgfe5+aY/CkHym6TI6zrX1RWWO6+qrf3JLd/eehIrmlx8zOWuaYFsQCzAcwmuw==
X-Received: by 2002:ac8:369d:: with SMTP id a29mr10653729qtc.338.1585251538730; 
 Thu, 26 Mar 2020 12:38:58 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:58 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 61/74] cpu: convert to interrupt_request
Date: Thu, 26 Mar 2020 15:31:43 -0400
Message-Id: <20200326193156.4322-62-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
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

This finishes the conversion to interrupt_request.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 hw/core/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 01091d0623..16caa6c589 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -271,7 +271,7 @@ static void cpu_common_reset(DeviceState *dev)
         log_cpu_state(cpu, cc->reset_dump_flags);
     }
 
-    cpu->interrupt_request = 0;
+    cpu_interrupt_request_set(cpu, 0);
     cpu_halted_set(cpu, 0);
     cpu->mem_io_pc = 0;
     cpu->icount_extra = 0;
@@ -411,7 +411,7 @@ static vaddr cpu_adjust_watchpoint_address(CPUState *cpu, vaddr addr, int len)
 
 static void generic_handle_interrupt(CPUState *cpu, int mask)
 {
-    cpu->interrupt_request |= mask;
+    cpu_interrupt_request_or(cpu, mask);
 
     if (!qemu_cpu_is_self(cpu)) {
         qemu_cpu_kick(cpu);
-- 
2.17.1


