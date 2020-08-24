Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BA5C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 10:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF3942071E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 10:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tkAwyrGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF3942071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA9MO-0004Kh-2g
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 06:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kA9Ha-0004D2-9O
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 06:00:54 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:35406)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kA9HX-0006VZ-IH
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 06:00:53 -0400
Received: by mail-lj1-x244.google.com with SMTP id i10so8919996ljn.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 03:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3n8Wp2a8qSMeZ1oN4JeQX3v5twZlCa2C41KCZdHZhHo=;
 b=tkAwyrGJCWFJM7JqF8LNANs5jUuBOyprjsogtsGXfWLP/O5PEgO8moB2iJozZEB5uw
 E4HKiouL+rcggVl1UEQqDkDAZj0oHeGYjQ2bm474xL62nd8AUjKQmmIB9/ly0vmUOlXk
 Out0Bezqct7RG2aTfaj0xVw+95GvxkVJTQuCsnMLydYxh8hWtQcDbPkq/kDsYQFJC6Lt
 ddSZ/OUyGLFvL0/FNXcCQJH5viF3uH3HlD7CyJZ7CPEqpNY3Lv/jRh/dk9DIdSW81nxY
 QBwmzPWaiTycdNxaeG9sKuRMtveUCKhq9wuCAorg3ezrcJoGjdP2Yn5JHARKfYKNJyrG
 jomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3n8Wp2a8qSMeZ1oN4JeQX3v5twZlCa2C41KCZdHZhHo=;
 b=BBaLx4GHN/yc3YxBt+LcA7jys2KMhlEoC2Ow0tN8LY11e1uZLYFYA1AsZz82jJ0SJX
 L/HyL/3eTqYN7MBhZxU95d8iiipGV90nejWB+0g3VTOBKI4veKlFXIkc7YM7IcNI075C
 R5XwEyE7STJWc9PNOa71lAN+xwbE6hYkREsq6wWur7Hc+Uk+6fdGlPVi23n5JLY6cqu8
 iTm348c24N+uvcYHn5i+aOXPGHvrU3BrMQ7I347hc7erd81pImrpSYXwv8QGiXHyIEki
 hmqRq8+REeQyXnbbQPgVxmIeYyrjWp08FB6f7Py2lIVqxqv7TBDfu6BaGE1Bvyy9BsL8
 KSuw==
X-Gm-Message-State: AOAM530WfYgLWtFGWJYs4M3o7eid/PrxKCcH+KDw8VhsyfFIyLIIyBt3
 hfy4o2I17z+03JtB99LOzherOhndqlE=
X-Google-Smtp-Source: ABdhPJycRQuBIQzifqoG4ELJPq6yT/PIvIYp3Wrfjlp411ldcXV303RVqK2ngebpyasv5MmVhaJOsQ==
X-Received: by 2002:a2e:8710:: with SMTP id m16mr207687lji.244.1598263249827; 
 Mon, 24 Aug 2020 03:00:49 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id m13sm1927294lfl.30.2020.08.24.03.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 03:00:49 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 6/8] target/microblaze: mbar: Trap sleeps from user-space
Date: Mon, 24 Aug 2020 12:00:39 +0200
Message-Id: <20200824100041.1864420-7-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824100041.1864420-1-edgar.iglesias@gmail.com>
References: <20200824100041.1864420-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 16
X-Spam_score: 1.6
X-Spam_bar: +
X-Spam_report: (1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.724, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Trap mbar-sleeps from user-space.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 530c15e5ad..a96cb21d96 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1250,6 +1250,11 @@ static void dec_br(DisasContext *dc)
 
             LOG_DIS("sleep\n");
 
+            if (trap_userspace(dc, true)) {
+                /* Sleep is a privileged instruction.  */
+                return;
+            }
+
             t_sync_flags(dc);
             tcg_gen_st_i32(tmp_1, cpu_env,
                            -offsetof(MicroBlazeCPU, env)
-- 
2.25.1


