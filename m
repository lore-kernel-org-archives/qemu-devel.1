Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1CCC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5979A206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCNHk9R/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5979A206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD4P7-0000Gv-F7
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 07:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD4Nu-0007RU-7L
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 07:23:30 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD4Ns-0007Lo-Hx
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 07:23:29 -0400
Received: by mail-wm1-x341.google.com with SMTP id u18so759910wmc.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 04:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zP3IEywFUeS5C8gvagLA5xd9b2pUw/aPOxuFN7Mi328=;
 b=hCNHk9R/a298qcCMH1uXvY868Pzb0DqdwMb/nvg/0pkrCSAfcDv56qFdAvegsVC+AQ
 vjwirOyhtukkda9gKH1QAJr9xl7tLS8LrKLnnin6hBLL8/0653Hcnm8NFWwgrNtg8ZQh
 HLH+a3k7dMqpqguQOec7lTmp2/utLw8WoM24JxtcdNlcl7gy9S1e+SXEDW7Jd/S8KuLL
 1ExspJTPa8M5df2UIDoOeYGbI9BGMA3GX/eSSb5Hm+C3o4Jp32ZI8hFE53CcVXcSAS/W
 utw/GIquBzu3XeJJtxb2trJfCho9XAosltQVMpup92pQNSmyXCuDZe9bWFgilcoyomg6
 bGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=zP3IEywFUeS5C8gvagLA5xd9b2pUw/aPOxuFN7Mi328=;
 b=DKM94AnZOCi6rv7syNBmj5a6CIZ+WJGdP2FSTarBU/TctXiKhCw3j/vWuuUnrG8509
 umHjW/TxCkGkBKUmNNvnz7lyzY8NhCbTYapAO5laFTxhYmRZZOq57YM99DLqGdBFbNgV
 H4wDYf7m+6CngdXFBhxTwpvBes8cIuzWv8Ns2le3GFEko/Lie8E84Jl5cCks7Y6o3Peh
 jhyimxyuyE3WruK24waplu4tpmaH+rCh82E305mNGtNCH8DXdtNEzfYuq3vkBO+KA7X6
 lg0bfHVvSGKiAavAGq7YC7r0nRt/bhnC9aVjdoLBukvQ/31f3e4cW9sW6yIlmsPa+8o6
 Tq/Q==
X-Gm-Message-State: AOAM533qw9CUdX8TDo4YShEvtp0aeIe8euuq5zjiTLPcOHdtud0RIWbW
 /+FcGQydASLKBNiZVo+NO1HIrGOKYzw=
X-Google-Smtp-Source: ABdhPJzHMwlfI2qMUnXGL8M8PbQoza3Wm/kL5dHI9qYeaZvEHi8rzCphEZX2okb4XMtSsFnp+ZVePw==
X-Received: by 2002:a1c:3584:: with SMTP id c126mr1392522wma.13.1598959406725; 
 Tue, 01 Sep 2020 04:23:26 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id n11sm1769124wrx.91.2020.09.01.04.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 04:23:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] cpus: Do not dump CPU state when calling hw_error()
Date: Tue,  1 Sep 2020 13:23:22 +0200
Message-Id: <20200901112323.94969-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901112323.94969-1-f4bug@amsat.org>
References: <20200901112323.94969-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Claudio Fontana <cfontana@suse.de>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already have cpu_abort() to dump CPU states and abort.

Restrict hw_error() to peripheral errors, hoping we can completely
remove it by proper functions from "error-report.h" in the future.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 softmmu/cpus.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index a802e899abb..c96a04d7f18 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -913,16 +913,11 @@ static void stop_tcg_kick_timer(void)
 void hw_error(const char *fmt, ...)
 {
     va_list ap;
-    CPUState *cpu;
 
     va_start(ap, fmt);
     fprintf(stderr, "qemu: hardware error: ");
     vfprintf(stderr, fmt, ap);
     fprintf(stderr, "\n");
-    CPU_FOREACH(cpu) {
-        fprintf(stderr, "CPU #%d:\n", cpu->cpu_index);
-        cpu_dump_state(cpu, stderr, CPU_DUMP_FPU);
-    }
     va_end(ap);
     abort();
 }
-- 
2.26.2


