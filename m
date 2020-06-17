Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31BBC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B71E02080D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tmQ+zuW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71E02080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfeD-0006Cm-VV
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEY-0004EO-D3
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:34 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:41177)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEW-0000MG-QV
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:34 -0400
Received: by mail-qt1-x842.google.com with SMTP id w90so2750781qtd.8
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ljUyAp0qqYElrS8vzQ49pxqGCe+fOWSwI5BjIxDRmqQ=;
 b=tmQ+zuW2eIVChtJ/OEnskHJxF3k9ShXoaMhKG9DVleoTY8AIwCy/Vn0caSyLKfWerP
 mRH0n0/uYybOYJVOvCwQTIKX8l39KMEr15B7loh/wkwXaiArqt152Tjxh3utng+J8zdt
 CGMfyvNZFGCSmsS7QsAZi+zxOcIFLqKKhPQhpAqz8yzzvjyaFmLurXfCQmgElH+vhZeb
 p8tmWYJNU4n8yrMx/zy/d/z3Nz8FQefdOrkRxsG/SWJBZKn/cJ2u80RGdrstMzojix7n
 gwyl2Q9RVpErRixBXV2eEl+n6nUqBn7CpgaMMbPTXEpVX2zpSAycKgja3R3YPKPF505r
 clIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ljUyAp0qqYElrS8vzQ49pxqGCe+fOWSwI5BjIxDRmqQ=;
 b=TbokHBMiS51AC2ZQmvavrtPbljkM3T2kU6ZkXDNCP8S4G8WtTpVWr5VMDGdReVIJGi
 LZZ29U+fT5l7Pul2SGiW8Ge12zlVxgdTp5+08HsANfmM5DdjKOQptiBHo7cuy68Mwov3
 x+vbMXWRwa/Fbwn+gHbgJ6/7jm2iJCPZoVOU7kZ9mEoSG3U/dNkiSMDa+lLvwo/PEt5/
 GDk5lk7EewCORtdfI0RoOAmhPEpvCPt/p9oZ5VVg0uX9StgdhUyYy4+7feOGqxU1obni
 +n6WhD1kDUS6HHQT3ULv98+3xVufG8l4t6D7FyUc8OG6lHGWv3A5WwyR1hGKDR1fFyv9
 KXhQ==
X-Gm-Message-State: AOAM533Q1u+hRuARgX1JuPyzVFZ+f9qMq4+GU/KYvmPbvDTdB53r/4Qc
 gLUvaAetTmABtMMIwOX2rtqr4PQTTR5LJA==
X-Google-Smtp-Source: ABdhPJxLhoeZFFmzEkj2Ldj9fFwsS3NFgUzySG+UBwp1WNlfgsYAzAe5/A1CqV5Wocohb9eYOR822Q==
X-Received: by 2002:ac8:6bc1:: with SMTP id b1mr1116070qtt.65.1592427871693;
 Wed, 17 Jun 2020 14:04:31 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:31 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 52/73] s390x: convert to cpu_interrupt_request
Date: Wed, 17 Jun 2020 17:02:10 -0400
Message-Id: <20200617210231.4393-53-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x842.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, robert.foley@linaro.org,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 cota@braap.org, peter.puhov@linaro.org, alex.bennee@linaro.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 hw/intc/s390_flic.c | 2 +-
 target/s390x/cpu.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 46ec8272c0..964cb41b4c 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -191,7 +191,7 @@ static void qemu_s390_flic_notify(uint32_t type)
     CPU_FOREACH(cs) {
         S390CPU *cpu = S390_CPU(cs);
 
-        cs->interrupt_request |= CPU_INTERRUPT_HARD;
+        cpu_interrupt_request_or(cs, CPU_INTERRUPT_HARD);
 
         /* ignore CPUs that are not sleeping */
         if (s390_cpu_get_state(cpu) != S390_CPU_STATE_OPERATING &&
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index d7a98bd52b..d157dbb7a9 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -65,7 +65,7 @@ static bool s390_cpu_has_work(CPUState *cs)
         return false;
     }
 
-    if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+    if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
         return false;
     }
 
-- 
2.17.1


