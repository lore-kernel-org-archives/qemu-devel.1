Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172C2C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 15:45:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2A8C2080C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 15:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A8C2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgWaR-0006BF-72
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 11:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32794)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hgWHD-0002RZ-Nv
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgWGz-000867-Uo
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:25:22 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:35341)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hgWGs-0006wO-EH
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:25:12 -0400
Received: by mail-pg1-f175.google.com with SMTP id s27so1181736pgl.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 08:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=CCTUA83WsmaGam2XV7hw8vEWvHgX2YXg8c48BvbdAho=;
 b=Ut8NElNL/vjp6H6pXcpYolFrMadSNU8muQgeby7sWG1OAj+LlL08iPopcEdTjWrGxk
 pniIofgE93Jri3W5HSRz4So6/luGqK44z0rJVPVCfJDEZwJlmZE/MqdJe3JwwL7wESfN
 vxW8gfC0nHW8LtVH8emAYl+05y+V7i11+328K388jAvq1QsTsHhrEYn0ycT5Zunnu4lx
 pkLCWZVWtzYlsFZbadxpCw/grCaOWRqFp5kdkspRiF9GvyVF/0eWDQlrLJtl8x87EE24
 P3tOYdvOH1f0tA4/J9OPYSnHZQX0h0AwDHhu3fbcxPoKfNzKFjb5UDEE258ypkG0WnVw
 3QqA==
X-Gm-Message-State: APjAAAWnZeb9Ws8KlOl3Uy0hatj/GWTY8HdPhYQBrlk4syQHfrP6cqr+
 kv1YNUoqUIFB0KwxMkSEgV+orw==
X-Google-Smtp-Source: APXvYqwdun/Pc4FDTZr4WsAuLyEp5dsBzZz48Gz4opJwCxarnmVLacjTq48APNlgcRfNTot7dUA/3Q==
X-Received: by 2002:a17:90a:a397:: with SMTP id
 x23mr6870749pjp.118.1561649041728; 
 Thu, 27 Jun 2019 08:24:01 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id f10sm2485802pgq.73.2019.06.27.08.24.00
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 08:24:01 -0700 (PDT)
Date: Thu, 27 Jun 2019 08:19:53 -0700
Message-Id: <20190627152011.18686-17-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627152011.18686-1-palmer@sifive.com>
References: <20190627152011.18686-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.175
Subject: [Qemu-devel] [PULL 16/34] target/riscv: Set privledge spec 1.11.0
 as default
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Set the priv spec version 1.11.0 as the default and allow selecting it
via the command line.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 17467c3d8705..ba1325f43533 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -111,7 +111,7 @@ static void riscv_any_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU);
-    set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
+    set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_11_0);
     set_resetvec(env, DEFAULT_RSTVEC);
 }
 
@@ -316,7 +316,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     RISCVCPU *cpu = RISCV_CPU(dev);
     CPURISCVState *env = &cpu->env;
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
-    int priv_version = PRIV_VERSION_1_10_0;
+    int priv_version = PRIV_VERSION_1_11_0;
     int user_version = USER_VERSION_2_02_0;
     target_ulong target_misa = 0;
     Error *local_err = NULL;
@@ -328,7 +328,9 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     }
 
     if (cpu->cfg.priv_spec) {
-        if (!g_strcmp0(cpu->cfg.priv_spec, "v1.10.0")) {
+        if (!g_strcmp0(cpu->cfg.priv_spec, "v1.11.0")) {
+            priv_version = PRIV_VERSION_1_11_0;
+        } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.10.0")) {
             priv_version = PRIV_VERSION_1_10_0;
         } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.9.1")) {
             priv_version = PRIV_VERSION_1_09_1;
-- 
2.21.0


