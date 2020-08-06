Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05DEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:24:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A5A1204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cH0w0KVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5A1204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dSZ-00032d-Df
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 06:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dR4-000195-OP
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:47:46 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:39812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dR3-0007iy-0z
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:47:46 -0400
Received: by mail-pg1-x533.google.com with SMTP id z5so26492863pgb.6
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=k7FPEdwKL5TcJ2QO4kxjdWjPEj2ygDvdF/U1WZ5UNA0=;
 b=cH0w0KVYQkgoJKXj0IFvdADuFYoceyEebzRokQ90iS26Xr+7ahHPYfD4tzxz9ffWbX
 Wy3tZiGZfN2lwabo4icL+LzcQ5NwB9qpICLKspvzica/xL3kQYu3JPmQz4mFcD7gCRxI
 wew7TeMoewWwtNXIeRkeiL8QyR/yO90XrSYWFGgr/bqAmImx10awH5pkk14sAjbVierb
 tM8NKePCRP8bDfsq4zUZqRKcm/W8Ug3ZmM6zcqiWMUOCv47sKcapMkscVal9FefRMJwP
 HctriXVEPIyBdz9TQvA5Tfx+ch5Qx5kwpi/bkBCPba0ZZmcG9bitHIOnpfbY+4GVGX8I
 +KIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=k7FPEdwKL5TcJ2QO4kxjdWjPEj2ygDvdF/U1WZ5UNA0=;
 b=L7CPnKEQidfo9g6yx+iyj5Y9y+PGiFaLhQJDBMy1MPRvPVlUOfmaXwqHS19296K9Yo
 WFyzJxHa12BiYTnJYlST9NxTsjEAF0L6gTM0ubFLe6OpQQ4bun9yQggAyQAYg2IV1rIl
 NBK722hWz9rYiGAdFv/Ar7PsbQB4A9GttJvVAB6k3+8SnOpHZwd0q7ct9jXXJloiTj5X
 Ldt2QIi88VQfflc02Eo6qzscUSKbn4g5PiWHwb6VoWryhBXP0HP7ZoAVOylNBJC9Nxem
 YY96nAumqmk5m1zE1gCNbGsdge9kj2Fa5EdluooZjklFiGU0IaMLrTQghzkLLQQ28eoH
 7XlQ==
X-Gm-Message-State: AOAM530+yFA5GkQ8P2iaRDdB4+wed3cmke/xxotMavmHC1NWq+tRmYGQ
 EwWOCd63m10/7nI3MpGpAww2Oeutazs=
X-Google-Smtp-Source: ABdhPJzGta7S/sWXFMYq7LmHM0K2XM4Xv21ufvRdgeo42B9J9cgbaUOG0bkLBfTTxyeVCqgjyF0zDQ==
X-Received: by 2002:a63:c252:: with SMTP id l18mr1931843pgg.349.1596710863448; 
 Thu, 06 Aug 2020 03:47:43 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:47:43 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 09/71] target/riscv: rvv-1.0: add vlenb register
Date: Thu,  6 Aug 2020 18:46:06 +0800
Message-Id: <20200806104709.13235-10-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x533.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
index ca85a54a0f1..11ce6d4576a 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -188,6 +188,12 @@ static int read_vtype(CPURISCVState *env, int csrno, target_ulong *val)
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
@@ -1292,6 +1298,7 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_VCSR] =                { vs,   read_vcsr,        write_vcsr        },
     [CSR_VL] =                  { vs,   read_vl                             },
     [CSR_VTYPE] =               { vs,   read_vtype                          },
+    [CSR_VLENB] =               { vs,   read_vlenb                          },
     /* User Timers and Counters */
     [CSR_CYCLE] =               { ctr,  read_instret                        },
     [CSR_INSTRET] =             { ctr,  read_instret                        },
-- 
2.17.1


