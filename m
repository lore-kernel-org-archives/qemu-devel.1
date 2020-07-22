Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCA8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:22:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A718206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SNzqu0ly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A718206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyAxT-00078o-9W
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAtR-0007R5-Co
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:18:29 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:43038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAtO-0005OL-LC
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:18:29 -0400
Received: by mail-pl1-x62a.google.com with SMTP id x8so642594plm.10
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9s/mCdEXcnjGeiJgQX1HftAI7OdnPJqUitl4kMdTekI=;
 b=SNzqu0lyWObzHrj0E0r99mmFkq32mfMVg/WMhcRciVL+MMjYsC9Wd4MjHOXyA5UZLu
 /djeK+l3asXlhqbT/tIbfrcdBnoQdnCkm/KOTyUFRPR69GxOW9z5GZdj/ha2G8IYZAUh
 p2FVKpQCzJ0Tu0bDNYUx9SYxivmpue9TMmZRtIsKHQVwc7VWKwUj0vYBrw5FrrCz9M1v
 /w7MP8BE0D5LOLmqenoUOPOE0N0gN9tv6xpU3TfQgTg9hcfyGj86eLnWeLDP2ju+pHF6
 wJhC05KWY0U2O+459BeWftaMkN92kjMihUTTdqcOwOO9VsSM6EtgzjklQa2/kEmX6Ay/
 8E1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9s/mCdEXcnjGeiJgQX1HftAI7OdnPJqUitl4kMdTekI=;
 b=sfy9ROnKigU8lpY4GiC+zOKL7ujk5n+oSZ9JmS/gS8tTcV8IA9+ZliLLDXY6SwkjfS
 3J2NkpnVD0BPQVqYkIwnvVGFCg9EwUa5ANjhJjNxUGPY4ruvjTPMddpbV9jUJaMJasRG
 ezKNlQSbYa5OmwpbJVJ3CrE8mCWT8G662I3BtdGZ1vmVDxIvCFIYX+Lx/66MVTNAvNBh
 V+cFuOQ/3l/NdjQBly5/kqp1kbtoNrNO9ga5xiOg8Qn6gC/btlYyxV1gZ1oK3M7HpRjG
 UpBEgSbackNHqtF9WPwOuGnLx6u67S/yf9YOqKT38OBMJjR3wZwZTGqkaMUxmnTTZPRr
 q/RA==
X-Gm-Message-State: AOAM532DaBkTegq0yXDpYTbjs+8J9QO54OqoXaE1tYhZIPPQk+K2OA3V
 hIy6nkBd9ekVpC2JwiNVDW3NIWYItGQ=
X-Google-Smtp-Source: ABdhPJx+x/HWmQicVH9D+U7mCuKDnrujBzumWKrcukO4RoW98Ruw5qr/xg3zRVhIbIvqTE+9LZMsmg==
X-Received: by 2002:a17:902:654e:: with SMTP id
 d14mr26593240pln.60.1595409505161; 
 Wed, 22 Jul 2020 02:18:25 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:18:24 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 13/76] target/riscv: rvv-0.9: add vlenb register
Date: Wed, 22 Jul 2020 17:15:36 +0800
Message-Id: <20200722091641.8834-14-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Frank Chang <frank.chang@sifive.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Greentime Hu <greentime.hu@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greentime Hu <greentime.hu@sifive.com>

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu_bits.h | 1 +
 target/riscv/csr.c      | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 7afdd4814b..fe055b67a6 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -63,6 +63,7 @@
 #define CSR_VCSR            0x00f
 #define CSR_VL              0xc20
 #define CSR_VTYPE           0xc21
+#define CSR_VLENB           0xc22
 
 /* VCSR fields */
 #define VCSR_VXSAT_SHIFT    0
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index e05acb5a24..cdf6198d8c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -189,6 +189,12 @@ static int read_vtype(CPURISCVState *env, int csrno, target_ulong *val)
     return 0;
 }
 
+static int read_vlenb(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env_archcpu(env)->cfg.vlen >> 3;
+    return 0;
+}
+
 static int read_vl(CPURISCVState *env, int csrno, target_ulong *val)
 {
     *val = env->vl;
@@ -1293,6 +1299,7 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_VCSR] =                { vs,   read_vcsr,        write_vcsr        },
     [CSR_VL] =                  { vs,   read_vl                             },
     [CSR_VTYPE] =               { vs,   read_vtype                          },
+    [CSR_VLENB] =               { vs,   read_vlenb                          },
     /* User Timers and Counters */
     [CSR_CYCLE] =               { ctr,  read_instret                        },
     [CSR_INSTRET] =             { ctr,  read_instret                        },
-- 
2.17.1


