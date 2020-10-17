Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF49EC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 21:04:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50851207BB
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 21:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6W8/eeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50851207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTtN5-0000eC-Ad
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 17:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eafanasova@gmail.com>)
 id 1kTtLy-0007pP-Cz
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 17:03:02 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:33436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eafanasova@gmail.com>)
 id 1kTtLv-0007rU-QS
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 17:03:01 -0400
Received: by mail-lf1-x142.google.com with SMTP id l2so8055194lfk.0
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 14:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=abbpQpQ2dwOokkShpLvvUzUInvLn10GYqia35oQNlkQ=;
 b=R6W8/eeKar3pUhUX/+MU1a6xp6vIv6YLETIoFOJJ3TJiaawI2HfzC2Sb8DwEymmlm9
 Lir9RZgb08cqLVCnTCwCVbo/GrS6AHrz7XTiMkN3xKWRyNxrARIn6/9rNhZ98NU4Tk4Z
 Ixtpl9R+MjGSW2/kI8Be44nMQuXsLC3oHsthzu1drhYb8pbBKfVJN8yMm2t4ey2MtKxW
 4fn1hjKLQDb+tqg7UjYyLVFNRCUUCiifCZnuscr5qT0aSijpVdXmZLs5pklRLmpquRE4
 oSdNk9Ma2QEM0tzX/mTKHTHZOsmZZUOGkYKTmeNGVAtR22rVMP1IsJG8BWfXgpb3/QC6
 iwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=abbpQpQ2dwOokkShpLvvUzUInvLn10GYqia35oQNlkQ=;
 b=lNEJrEDdlI7TNdUO+r4nClDxP8+p/r9axn1cqXesmoIdqpg2LwWX5HAOvUa3qEULDP
 G8Zy1W+5mah6p7GuH/fcjZ0hq4yhcOlZZp0kslp1Elv7kpKdauYpnSYZ/gtmqVLjheAP
 6jA10s0QxG2hFPO9g14TJfEiwV5yJM0bht92vMxo2hz0h1VRp7rd1iLJBZhkDIcpOl05
 MlUS4pHq33DpdG7DYJc/XwIRw7LLcnibEcfq6io9F+kLG+vfEkl70o6gaGSCVFp3qkWg
 SwoP8BtqSc6MjBNxNwjbZ7kTXPYr4HsSmDapf++nycaJEcljBT+RyPYxroay24zbIAmE
 N5ug==
X-Gm-Message-State: AOAM532iWAeOztgRwpJfoxedDiXzriq3LXP4iQaQ4fM2fFKpBKq5k0hw
 3p0frbSPKwAIAlb4DJ7uJX4p6CXwdoMGJsxD
X-Google-Smtp-Source: ABdhPJyljq/2IPVCk0Eo1JliC3VmSyGPmGJN7xMAbr5+CGqQKAYUM4Odm/f3MANyETnzIj4SO9QdEg==
X-Received: by 2002:a05:6512:3132:: with SMTP id
 p18mr3245623lfd.218.1602968565462; 
 Sat, 17 Oct 2020 14:02:45 -0700 (PDT)
Received: from localhost.localdomain (37-145-186-126.broadband.corbina.ru.
 [37.145.186.126])
 by smtp.gmail.com with ESMTPSA id a17sm2414840ljp.129.2020.10.17.14.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 14:02:44 -0700 (PDT)
From: Elena Afanasova <eafanasova@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] accel/kvm: add PIO ioeventfds only in case
 kvm_eventfds_allowed is true
Date: Sat, 17 Oct 2020 14:01:01 -0700
Message-Id: <20201017210102.26036-1-eafanasova@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=eafanasova@gmail.com; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Elena Afanasova <eafanasova@gmail.com>, pbonzini@redhat.com,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Elena Afanasova <eafanasova@gmail.com>
---
 accel/kvm/kvm-all.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 9ef5daf4c5..baaa54249d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2239,8 +2239,10 @@ static int kvm_init(MachineState *ms)
 
     kvm_memory_listener_register(s, &s->memory_listener,
                                  &address_space_memory, 0);
-    memory_listener_register(&kvm_io_listener,
-                             &address_space_io);
+    if (kvm_eventfds_allowed) {
+        memory_listener_register(&kvm_io_listener,
+                                 &address_space_io);
+    }
     memory_listener_register(&kvm_coalesced_pio_listener,
                              &address_space_io);
 
-- 
2.25.1


