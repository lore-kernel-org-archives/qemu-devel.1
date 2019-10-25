Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FEDCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:41:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97B5D205ED
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oNf1gFR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B5D205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNuEC-0003HQ-9i
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtpw-0004bl-RT
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtpv-0007CR-Jo
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:40 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:40483)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtpv-00079s-Cx
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:39 -0400
Received: by mail-wm1-x335.google.com with SMTP id w9so847836wmm.5
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 00:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cjhNljTqxQ/Ky0zLZM+uPTgv6SRPxcnS2TkxZBhdmPA=;
 b=oNf1gFR5duTDlT5RDMLSpVO44tj0vJQJgB4HN8RuN0SnPNkCtG1j1YkDXe2Yw4fY0V
 Cf00WkY1H5WMp+g7jAkDjBcds5ERu+6HV6XyFB0OM/43uW7n1XyjI+67pXPaWfkV4H6S
 Y0+Cc0/5nvgQKgAaj9NsmAjAdg/qlRs83OarP94vlY/xVAN00wVRgjaoZifVY7y1c2C9
 liyjBCBT04loKEVcjzMQfOYDAAObYrEgUqxDBK5vVmMIotpmD+fxluTNClUtLN4Tacme
 r8b8UlxVlGVbEvOXJ1sspa3vgAKrnjMUV92keM5572OmKn2fFwJ16xKIyaNuQaSBSgG0
 BPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cjhNljTqxQ/Ky0zLZM+uPTgv6SRPxcnS2TkxZBhdmPA=;
 b=i4Zc+40s7gXymliWLmNwfvLlPHnoTJuI0b53cKWSSuJbt4ypAC0CS0oysDsHcVAXIa
 Vg1SMmVVuXpVaIcbhnqkgRKbyd2TrR2oX/w+P/6URt6XWJfXatnmuAZtHAIh9Cuqpaa+
 LR0fiUP75ff/0RebV59FjZzDSWr6xMCXAM8dXqzG+DZBFuA7pw38MXWL3QoAxtvo27hP
 pOnCI3NcQSldkW65tUBZfhS7tCLFASZuFoVF/P0RFGXdiA22YmpgJfAM7nuk/k5JOFZm
 JF8DObnIAggb/oVZ6El/tS7dnLR1kKWcL53qTnLXGPdedkykrCZzaVvjuJ3EYSrthwVz
 ghCw==
X-Gm-Message-State: APjAAAUx8QZLfjQ8Eg6owavoVXnCMBF4x7eUIEQUKi74dRE0WKnLga6m
 0R02YzLZroZULsZ695eKDV1zdA==
X-Google-Smtp-Source: APXvYqwfKpNlyNsrO26cN+Ek1Y/+aCtPLqeGgXmQumfm7LfgnjyAoajZwdsocJQXosjtBWsZByvpTw==
X-Received: by 2002:a05:600c:410:: with SMTP id
 q16mr1972360wmb.169.1571987797190; 
 Fri, 25 Oct 2019 00:16:37 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h3sm1188235wrt.88.2019.10.25.00.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 00:16:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E43B51FFBA;
 Fri, 25 Oct 2019 07:37:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 33/73] translate-all: notify plugin code of tb_flush
Date: Fri, 25 Oct 2019 07:36:33 +0100
Message-Id: <20191025063713.23374-34-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Plugins might allocate per-TB data that then they get passed each
time a TB is executed (via the *userdata pointer).

Notify plugin code every time a code cache flush occurs, so
that plugins can then reclaim the memory of the per-TB data.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 0a08fcda3e8..6d1b0ecd69f 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1231,6 +1231,8 @@ static gboolean tb_host_size_iter(gpointer key, gpointer value, gpointer data)
 /* flush all the translation blocks */
 static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
 {
+    bool did_flush = false;
+
     mmap_lock();
     /* If it is already been done on request of another CPU,
      * just retry.
@@ -1238,6 +1240,7 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
     if (tb_ctx.tb_flush_count != tb_flush_count.host_int) {
         goto done;
     }
+    did_flush = true;
 
     if (DEBUG_TB_FLUSH_GATE) {
         size_t nb_tbs = tcg_nb_tbs();
@@ -1262,6 +1265,9 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
 
 done:
     mmap_unlock();
+    if (did_flush) {
+        qemu_plugin_flush_cb();
+    }
 }
 
 void tb_flush(CPUState *cpu)
-- 
2.20.1


