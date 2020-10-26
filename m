Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDEEC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:31:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46671207F7
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjyO25H7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46671207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXBxy-00054y-0j
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 19:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXBw5-00037D-D9
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 19:29:58 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531]:40491)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXBw3-0000Go-UZ
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 19:29:57 -0400
Received: by mail-ed1-x531.google.com with SMTP id p93so1163742edd.7
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 16:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IPy8xSDiS043tJ1qMib/hHCsnldOT9q1j5PDtKMfWf4=;
 b=YjyO25H7f/AlgxZ5zvDpiKR2vl+Tonxb/fesN+Lhox3oU9iYqtExyvrDPb6UElb54C
 uB59d+9aximzMS544QjdpUTAE64RGtjMpV/NYUueabxJIAoMZxqpzdooiOewpcnOOPXZ
 EX9tNd7sBh8BbwVXO+JhAkwqO+n8AraQcnCblpA1NpAYrZTYTv23j0YBXcpYJWmPgI8v
 S2sS/oNWJYWhpBj6hrZ/uapW95jxDblqkBJeNrHmus9kRmQ9htoBsup/srj9mtmgywko
 w3hmwR2VymCvtLLMDE5eTlvwxHpXI4COkuLUQ8CHzYH5foaZ4faBHwtmJa/Y7t44lBuy
 1eXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=IPy8xSDiS043tJ1qMib/hHCsnldOT9q1j5PDtKMfWf4=;
 b=arZmaLlXXMRxDr1cTPO0reSIQG1OqCLzRozyr+y6dA6+YXN0W4W7/zmphfpGzt6WH6
 smdq+TWdHipYhznzjSP4ZJOxMjk4g0gLXAY+JuY0ulICWJu+U6DVo1w7EO6ZDE6T1WiH
 UUhtH1SNrJIPOo/K/t3cKTje4Gds/nxV9EBUCd0t9eOXoX0O5RnkYftKLKqNEOktQSX/
 4G8DLtm96NEAWCZ0CBDHObqVN/KrQhpqCdQ3/F4qL9igjhmk6Hj7xAtcot5DMMrXPoNO
 1rTI+YeELcIDVPCYH/DtZ/xItvytGDnwZdtWh1zuvRgMbhF/WUEM14nfXPC442QnMiUA
 LO+Q==
X-Gm-Message-State: AOAM530rjZvr+PVLWelKrRUZD6vmJuRwgNKsZuRYvt1Pif4pM1jgO3Zh
 nS4on6scw+NtV8ZpbRwH0v1aXSWtAH0=
X-Google-Smtp-Source: ABdhPJy8qozl7+BUfvRi4eLSqZDBe8zDdIX521ymCx58GbHStOofoFONEal03BDnOO4StkVlSAGnGQ==
X-Received: by 2002:aa7:c5c4:: with SMTP id h4mr18733480eds.379.1603754994405; 
 Mon, 26 Oct 2020 16:29:54 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id c5sm6003342edx.58.2020.10.26.16.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 16:29:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/8] hw/timer/sh_timer: Silence warnings about missing
 fallthrough statements
Date: Tue, 27 Oct 2020 00:29:30 +0100
Message-Id: <20201026232935.92777-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026232935.92777-1-f4bug@amsat.org>
References: <20201026232935.92777-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x531.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

When compiling with -Werror=implicit-fallthrough, gcc complains about
missing fallthrough annotations in this file. Looking at the code,
the fallthrough is very likely intended here, so add some comments
to silence the compiler warnings.

Fixes: cd1a3f6840e ("Stand-alone TMU emulation code")
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20201020153935.54315-3-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/timer/sh_timer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/timer/sh_timer.c b/hw/timer/sh_timer.c
index b09e30f9388..934daaa7dcc 100644
--- a/hw/timer/sh_timer.c
+++ b/hw/timer/sh_timer.c
@@ -122,6 +122,7 @@ static void sh_timer_write(void *opaque, hwaddr offset,
             if (s->feat & TIMER_FEAT_EXTCLK) {
                 break;
             }
+            /* fallthrough */
         default:
             hw_error("sh_timer_write: Reserved TPSC value\n");
             break;
@@ -135,6 +136,7 @@ static void sh_timer_write(void *opaque, hwaddr offset,
             if (s->feat & TIMER_FEAT_EXTCLK) {
                 break;
             }
+            /* fallthrough */
         default:
             hw_error("sh_timer_write: Reserved CKEG value\n");
             break;
@@ -147,6 +149,7 @@ static void sh_timer_write(void *opaque, hwaddr offset,
             if (s->feat & TIMER_FEAT_CAPT) {
                 break;
             }
+            /* fallthrough */
         default:
             hw_error("sh_timer_write: Reserved ICPE value\n");
             break;
@@ -180,6 +183,7 @@ static void sh_timer_write(void *opaque, hwaddr offset,
             s->tcpr = value;
             break;
         }
+        /* fallthrough */
     default:
         hw_error("sh_timer_write: Bad offset %x\n", (int)offset);
     }
-- 
2.26.2


