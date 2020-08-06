Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22538C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED8FA22CF6
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cduUhIFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8FA22CF6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3ddy-00078P-FM
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dQz-000122-BV
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:47:41 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:53875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dQw-0007i6-H8
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:47:40 -0400
Received: by mail-pj1-x1032.google.com with SMTP id l60so6450179pjb.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=U5RnSvr84lN+WWcwRTJMnMd/JFwx/9zDtnmGShOgnxk=;
 b=cduUhIFL8hYFvKFug/FdCsB3D1P5dlr8qQhsQZv/I2oxUEKgzOzgRkGGTzIHhGzXZy
 diDLeDtjtmN8fSJM9XNZgjflUrbD6xvoEy0Rg2gTnM+9pPNWS8Vuo+tZ0VvqAqc+Di1p
 6MUeGd7h440FUD0gGoCE8qV6K9ykBDD57KTycChg63pZvaxJc6kpPcCPcLZyJdHEVNK9
 7nc1haS8Po6EJnTfpdppgdFWVkFpWXb68JHMo1K7017/ve/DWeF1gHyeJ17C2qrBXmsC
 UdEt+ICK+CF3I0b+2xREBe6g68AbxJ/8HKjaqQb2fJTFcrRqxgHAN+ab8hSFEC17vPo7
 T4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=U5RnSvr84lN+WWcwRTJMnMd/JFwx/9zDtnmGShOgnxk=;
 b=b2Zf/zEzR7YCUVS0FCkR9p7i3CJVie6IJ/jd5TFg3uOgS3aAk4ou58V+CXc+zLv06B
 D4qKZSCCNdcrZ7MHr8TH9Wgf/SyqPlOtwQ7WGbzMJelYIeDN6b/eQD7yIQZZxYHya0Yd
 r175L32CbiY5XK/pVblMhsXQNXHqpi3QUiDCn0eurcgiHhHR4buASs6EgZprSCnyzf/L
 EtPTWFSiDWVqP89UFwCZScoiQHrcwH+T7aMgAZaKaubHscGy9DRU/8Op3TQXjqIN8Dl2
 uvTxxXX0ILuRWjfZUfB5N0W5URRthWlySmuvvjdSA6d/1QPC3VO1f07KpMI+lJ7y867E
 HZXA==
X-Gm-Message-State: AOAM533NLk7o5Tzy5Lt9Vy4/6sdbY0j511Pef851VZWIOmO0rEpTgK0X
 rYbuR+HVPasD66lCJqArc1EYVVS2NdY=
X-Google-Smtp-Source: ABdhPJzquORTFE+noBEFWuVxN2s+2OHdnzBLthHxdFlbnF0Meu1PPBx4W7qdeXO8LvKWrdiC0zjIdw==
X-Received: by 2002:a17:90a:fa94:: with SMTP id
 cu20mr7808910pjb.145.1596710856959; 
 Thu, 06 Aug 2020 03:47:36 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:47:36 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 07/71] target/riscv: rvv-1.0: remove vxrm and vxsat fields
 from fcsr register
Date: Thu,  6 Aug 2020 18:46:04 +0800
Message-Id: <20200806104709.13235-8-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1032.google.com
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Remove VXRM and VXSAT fields from FCSR register as they are only
presented in VCSR register.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/csr.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 7f937e5b9c8..34c951d5d4b 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -166,10 +166,6 @@ static int read_fcsr(CPURISCVState *env, int csrno, target_ulong *val)
 #endif
     *val = (riscv_cpu_get_fflags(env) << FSR_AEXC_SHIFT)
         | (env->frm << FSR_RD_SHIFT);
-    if (vs(env, csrno) >= 0) {
-        *val |= (env->vxrm << FSR_VXRM_SHIFT)
-                | (env->vxsat << FSR_VXSAT_SHIFT);
-    }
     return 0;
 }
 
@@ -180,13 +176,8 @@ static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
         return -1;
     }
     env->mstatus |= MSTATUS_FS;
-    env->mstatus |= MSTATUS_VS;
 #endif
     env->frm = (val & FSR_RD) >> FSR_RD_SHIFT;
-    if (vs(env, csrno) >= 0) {
-        env->vxrm = (val & FSR_VXRM) >> FSR_VXRM_SHIFT;
-        env->vxsat = (val & FSR_VXSAT) >> FSR_VXSAT_SHIFT;
-    }
     riscv_cpu_set_fflags(env, (val & FSR_AEXC) >> FSR_AEXC_SHIFT);
     return 0;
 }
-- 
2.17.1


