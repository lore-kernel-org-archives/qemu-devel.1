Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AAEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 11:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00AC7204EF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 11:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Odh7tpqH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00AC7204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgRWX-0007YP-7T
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 07:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgRVt-00072U-8N
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 07:24:53 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgRVs-0006GM-24
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 07:24:52 -0400
Received: by mail-wm1-x342.google.com with SMTP id g10so1539343wmh.4
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 04:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jnj2c7tchtxxtkXbmzqQYHYZ9zjghpz3ssXi/A1ffqE=;
 b=Odh7tpqHxLvJfH9MW37FvMQcSwov0UQyawvJ/ioRoMEhZ3JuLVWhwq5mAHx8+G5gew
 9sXZhe4sw/eDJUHIW8L9Tjsdj5yQP8EGV+aDLC3Q8+qVh8V9MZ6JdJ0iESX5m9gT1wgm
 PP2Cqt3UFVfiL+GRzeitHLV7IrV5g1Vdi5DYhpL1R7cu7ecaagFOvbHHcWoLO9ObZ989
 zfSpfzebbSEGqbmR0T8Z8F0+LfKvjCfRMlP6V68jdEriX6GhTijGed6DWkPyyqm1XhSZ
 KnogbgZBCZbXTP+vlVmbtT3kaHTtPGPGYonq1jsw3tSwpwjyVUidkDjzws7ubHpU2nrU
 U6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jnj2c7tchtxxtkXbmzqQYHYZ9zjghpz3ssXi/A1ffqE=;
 b=LqsOAw9zNdBcDV9/4Nqj3AjvHmEr8aVqApFjxXxDk0vA9ogFBkFwRsWygB4YfQ6eZI
 l6VHh6p26YJWGwGGelcNT19kDJTuhKTwV8TXMziuhtbFxsnRacn3vii4ViC4Jqme8UCW
 UHoiD26Zm8UFVlJfNNxIQ2U7+w4Oea8MoNZILCgvSXXF/KnDhsEohePaLnIjKAVO5CfW
 WCBYvQ1JPYHIznIJbd2xm8xz4kh6rlEkEsyPdxpjVtb+H+J00coV1tH33l3/9pfkYgQf
 QA9kNMLoa6vtyND8X9vj5p6X2LoPPo5mUE2rivGyTraOhzAc5ZrW9bnT8GJL09CDoPw8
 zjxQ==
X-Gm-Message-State: AOAM531M23YFFw5CHDLOCh8nVV2PukZdN2s2OakJE7vMdu9Ha48F4h2l
 tzQlOI3eYg1nnrDN8oZP7DMjng==
X-Google-Smtp-Source: ABdhPJwBipX803FUamox5gGKkpGojEvTd7cMcoRwogDKHR2K/qCNhC0pWRIpM2dSyE1AyaUlPXf/9g==
X-Received: by 2002:a1c:2e4d:: with SMTP id u74mr8640854wmu.145.1591183490216; 
 Wed, 03 Jun 2020 04:24:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i10sm2886446wrw.51.2020.06.03.04.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2020 04:24:48 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C221C1FF7E;
 Wed,  3 Jun 2020 12:24:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] exec: flush the whole TLB if a watchpoint crosses a page
 boundary
Date: Wed,  3 Jun 2020 12:24:42 +0100
Message-Id: <20200603112442.22833-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no particular reason why you can't have a watchpoint in TCG
that covers a large chunk of the address space. We could be clever
about it but these cases are pretty rare and we can assume the user
will expect a little performance degradation.

NB: In my testing gdb will silently squash a watchpoint like:

  watch (char[0x7fffffffff]) *0x0

to a 4 byte watchpoint. Practically it will limit the maximum size
based on max-value-size. However given enough of a tweak the sky is
the limit.

Reported-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use cleaner in_page = -(addr | TARGET_PAGE_MASK) logic per rth
---
 exec.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index 5162f0d12f9..65a4376df37 100644
--- a/exec.c
+++ b/exec.c
@@ -1036,6 +1036,7 @@ int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
                           int flags, CPUWatchpoint **watchpoint)
 {
     CPUWatchpoint *wp;
+    vaddr in_page;
 
     /* forbid ranges which are empty or run off the end of the address space */
     if (len == 0 || (addr + len - 1) < addr) {
@@ -1056,7 +1057,12 @@ int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
         QTAILQ_INSERT_TAIL(&cpu->watchpoints, wp, entry);
     }
 
-    tlb_flush_page(cpu, addr);
+    in_page = -(addr | TARGET_PAGE_MASK);
+    if (len <= in_page) {
+        tlb_flush_page(cpu, addr);
+    } else {
+        tlb_flush(cpu);
+    }
 
     if (watchpoint)
         *watchpoint = wp;
-- 
2.20.1


