Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C98C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 23:41:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C35024672
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 23:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSS/OUyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C35024672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igzzM-0005ta-9L
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 18:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1igzuF-0006aS-Cq
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 18:36:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1igzuE-0002ho-EX
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 18:36:03 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:56075)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1igzuE-0002gF-8k; Mon, 16 Dec 2019 18:36:02 -0500
Received: by mail-wm1-x341.google.com with SMTP id q9so1074290wmj.5;
 Mon, 16 Dec 2019 15:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=naToarAXZe81gqVCr4Pwx0dIGqpD5gKSTaya0h/dQcM=;
 b=kSS/OUyM1IbWbDF2MPSc9wqgKjeBDqzh3nyHuyWKVOB6ikBXykqU2yMkDFP4yVaUsO
 UUQG4NBFYJLAnKUWqwiwHQib1S7LkidxAXnZcqfu4IKoQE4FGhB7norBUHejswpqS5jb
 T1VTaTHOF4oyaZnw9UkjEn5nQZ4IIdfJs+/NgXNNM3BFfUc6HGmPw+uI5pQCFvPiPBgz
 f3hapjJ/LgD38QWW7w5l+rRkto2qCP48X9IvpwR3wsfZWSJnL3MDci2d5DFSdEP98L7c
 GKSRjnoPMltCt8JMHgfoqRLjWbcNOa9BWYVxAKrvaNk0gm1YAyccShwvxrq4Sq4d64Go
 AHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=naToarAXZe81gqVCr4Pwx0dIGqpD5gKSTaya0h/dQcM=;
 b=ONlM5l07lciDAVFH8D2Vu24z+UW6LvFyhbyAb+HUTtF6T/sQSjDjdGIQZNAr3EIViV
 00IwSNe/sRSeQ1FawSCym+1j16gLk2i+NIbBkhkrlZlFNQbyFYbN/hE+8UFhfRNnYKdb
 ElH69fcCttroD/DDM5b1zwo0LIXPJhWXBlYv6l5fzmKBuSBdGVxo6ecigBY7XZu32OvZ
 M1PgvBj04Y9Jf2+zH/RnaRuIrNJQVriwEpvBGnAPC8UBwoRBHICZcyGvB3L2u8kNhowR
 j+TMe2rOC26iMGofqroC5erYHyDpbPe3Spp5qVAFSPodCXNqn2XgwXat64DsW60a+T8o
 eVCw==
X-Gm-Message-State: APjAAAVscDP2dCfFE4B8CsCPT2czvX6BuRoGwVuPMxBqybLWZHbetrB2
 +SeABApoQwoOZctFSlJvcf/5fPwI
X-Google-Smtp-Source: APXvYqzyvEwJJhJ+1etCJFn6NSfdQ3f2QKZNoBPlHzezojMNDZZ8BlSkXRi6Uv8BojJ7GfIugkOt1Q==
X-Received: by 2002:a7b:c847:: with SMTP id c7mr1690287wml.3.1576539361116;
 Mon, 16 Dec 2019 15:36:01 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id z83sm984501wmg.2.2019.12.16.15.36.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 15:36:00 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/10] arm/arm-powerctl: rebuild hflags after setting CP15
 bits in arm_set_cpu_on()
Date: Tue, 17 Dec 2019 00:35:15 +0100
Message-Id: <20191216233519.29030-7-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191216233519.29030-1-nieklinnenbank@gmail.com>
References: <20191216233519.29030-1-nieklinnenbank@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: peter.maydell@linaro.org, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After setting CP15 bits in arm_set_cpu_on() the cached hflags must
be rebuild to reflect the changed processor state. Without rebuilding,
the cached hflags would be inconsistent until the next call to
arm_rebuild_hflags(). When QEMU is compiled with debugging enabled
(--enable-debug), this problem is captured shortly after the first
call to arm_set_cpu_on() for CPUs running in ARM 32-bit non-secure mode:

  qemu-system-arm: target/arm/helper.c:11359: cpu_get_tb_cpu_state:
  Assertion `flags == rebuild_hflags_internal(env)' failed.
  Aborted (core dumped)

Fixes: 0c7f8c43daf65
Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 target/arm/arm-powerctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index b064513d44..b75f813b40 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -127,6 +127,9 @@ static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
         target_cpu->env.regs[0] = info->context_id;
     }
 
+    /* CP15 update requires rebuilding hflags */
+    arm_rebuild_hflags(&target_cpu->env);
+
     /* Start the new CPU at the requested address */
     cpu_set_pc(target_cpu_state, info->entry);
 
-- 
2.17.1


