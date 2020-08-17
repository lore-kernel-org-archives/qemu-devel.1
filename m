Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496F6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 08:57:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 117FB207DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 08:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mfqqCDS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117FB207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7axC-0002Cn-9g
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 04:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7aqj-0006IW-Uh
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:50:37 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:38192)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7aqe-0004uq-KC
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:50:37 -0400
Received: by mail-pl1-x631.google.com with SMTP id t11so7170965plr.5
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=E/uK3uNkD3knoDFN3MKZLCq2PoSkYYQM5DTZqlrftWw=;
 b=mfqqCDS8/ZkC2p4L2yabQH0aH3KiQX4vqfpPBi1usOFh5rM2WUMb5uNGUdsRD0a+wi
 IDez1PcsclB3V1sFcYnfxgLt7Nbo5iccXph0JPaT7zbp1tqJJDJXPXf0dSUKmBxz7D7z
 yW7P2tS1tTv6J4b+14/5/c8aPSH0r+/XIy1H36cxG0sGNKdNkG8ZIvqJCBFAxe4o+Rp+
 hhqlgqKA4apnOgJLiSGg2CpygnQknMb7BEkFH7edGsjRgoJfdfsN6da0Sk4oICZr5yTF
 4IRbaARfSTGfUaKnKrDQ39rQlamo7q1I5fqsFiWNsZDCkyV3Qc+5mS95PymH4Dz632fv
 ftVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=E/uK3uNkD3knoDFN3MKZLCq2PoSkYYQM5DTZqlrftWw=;
 b=fGSd376b2HwOe+AJnQw1SP4mWqxgqTVm+1ML03K2//ujwbzw0BJGR4gHXAIPtagwAK
 /8UHkEw0DfVuWNDDDTX4Ff1zMfjrTMooTN1ZmDYTwnG+m7eRfgovh7NCmN4HDS8tqei2
 GCpBSiyWl1J0rulr4tpPbiqpqTFZVqihc33K01X7Stk2mLJ20SLUb7wDIZ+zasmK4aJF
 biPzxZiII89PHdPgYxbBpWpmlsjpujiWUY+ECX19mxybC+0VTqc0tO0zUu4d+0SXc9v7
 b8/p175sHiTLEFz8+XbOmxohbOCRhPy45shjWpBKTbH6HZOLZwv0JYerAmRnLn337KbS
 QewQ==
X-Gm-Message-State: AOAM533n8cH2CWiC3VDo7ELf2CsaYt5jyIqs/9FxQD9a+5MAugA0gYhf
 oyqKzuuWWQLz1sTX9NE0bORUzMSbcUpFpA==
X-Google-Smtp-Source: ABdhPJyuyXBXD0P6VRo6s1PE/gj8jDwfYUi9Ih9iqx7/Zt3YdL5431Qya4RkHr5vNsXX2RtEaEWbWw==
X-Received: by 2002:a17:90a:4fe2:: with SMTP id
 q89mr12430352pjh.70.1597654231154; 
 Mon, 17 Aug 2020 01:50:31 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:50:30 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 09/70] target/riscv: rvv-1.0: add vlenb register
Date: Mon, 17 Aug 2020 16:48:54 +0800
Message-Id: <20200817084955.28793-10-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x631.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu_bits.h | 1 +
 target/riscv/csr.c      | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 7afdd4814bb..fe055b67a6a 100644
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
index c87f2ddbf7d..6379718e1b6 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -184,6 +184,12 @@ static int read_vtype(CPURISCVState *env, int csrno, target_ulong *val)
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
@@ -1288,6 +1294,7 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_VCSR] =                { vs,   read_vcsr,        write_vcsr        },
     [CSR_VL] =                  { vs,   read_vl                             },
     [CSR_VTYPE] =               { vs,   read_vtype                          },
+    [CSR_VLENB] =               { vs,   read_vlenb                          },
     /* User Timers and Counters */
     [CSR_CYCLE] =               { ctr,  read_instret                        },
     [CSR_INSTRET] =             { ctr,  read_instret                        },
-- 
2.17.1


