Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D41FC433E4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17FDE206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZoZhNXrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17FDE206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyAyc-0001t1-8K
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAtI-00072z-Da
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:18:20 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:41603)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAtG-0005Kn-So
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:18:20 -0400
Received: by mail-pl1-x631.google.com with SMTP id d1so645945plr.8
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1cl9gO8y/icELzV9+Mdcow3ZzOPLl80F9cpANs41GGE=;
 b=ZoZhNXrY1v1CX3TdbURkvJBepuybqmKdHEDpXXmzsrtlnloSj9sJrOfEKOR1o7OUOS
 vvkOiJIJKphU3PkjRtcfyC8ouwKF0bYbbI0NIz28/4fVL619qgBNS0WQPAI9r63/I/xA
 GsCLHpqiASFPKdBN4TmELaoh0y8OjllGhVnaqF1YlPdL8KVHKeDa6HvcNkD1xC0mIPXD
 q/fKb39tQJxVzcssO5855uH3yZHuumnlMDYLKQ0Y4Db3JRRaeCT/IALt7VfAdgIljIih
 oCsWvcLZpy5xlxe03gmF/1h4ULY2ypc20mSKz36YziCxXKPiAuTFvf++XnT/doHaTPeL
 dDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=1cl9gO8y/icELzV9+Mdcow3ZzOPLl80F9cpANs41GGE=;
 b=QpdY3YGhgZLdlFpt8WknaUbqrpdHidSTGSBREE8c5TpcLQ/4Bcz+jSsJxoqx7c7eDw
 1QJcOBrs6L1HIGI8ex58LDFFvhKCGEPbfiFIqEfzK2F8VR3x+W2HAKm69A23M/ZcpE7v
 bm0PKnCOlqn9WL3WWDgX8U+F2FgoyAcQAwfKT5va0/JVlVMNBmMK4tpaf4vmo3fYYyds
 knJ+uUFFAl81B2eAciEXRGOEFzxuQKQf6vrd+OMwpAPACM4kbMb90F4p72c61No57M7q
 uzvQ93zrJvSQgX19rrMzAGR0Kury0vzVF6mQgf9Ul72v/UC3IAej9tKLIYZhJbKUaC1w
 5k1w==
X-Gm-Message-State: AOAM532jh9J+W+FXUi/5bqO8J7zqZrXF+GzTHgyWf47s4oBJpw0IOcgA
 DnZDQrNNLSbHyApKyZI21Ypfd/X2Za4=
X-Google-Smtp-Source: ABdhPJwCRpCllYGI8icT9GL9/mX+HeXCZ6B4BO4a4mKC6laQ6RzlfFKT5wdGhinwhKQbCwMy8vXqCw==
X-Received: by 2002:a17:902:9b83:: with SMTP id
 y3mr25242309plp.271.1595409497490; 
 Wed, 22 Jul 2020 02:18:17 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:18:17 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 11/76] target/riscv: rvv-0.9: remove vxrm and vxsat fields
 from fcsr register
Date: Wed, 22 Jul 2020 17:15:34 +0800
Message-Id: <20200722091641.8834-12-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Remove VXRM and VXSAT fields from FCSR register
as they are only presented in VCSR register.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/csr.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ab4a4fc132..33c77be06e 100644
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
 
@@ -183,10 +179,6 @@ static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
     env->mstatus |= MSTATUS_VS;
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


