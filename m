Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F99C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:46:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 715F520774
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RXFRDDAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715F520774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLZb-0000nF-8b
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKyb-0006EJ-8b
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:07:49 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:32887)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKyX-0002JK-HR
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:07:47 -0400
Received: by mail-pg1-x541.google.com with SMTP id o25so4658191pgm.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4LjkfSy5vUY+saBETuGzU8Wtir4rrwiBPx84nJJQaXw=;
 b=RXFRDDAmLIBOa2Mehhypvg7Ktvw9uqr3mHDYZy4xbfYGz+KTKA3SGezRmB1Wx0UpWB
 mWTEWdGeMnMfVmj6HeLlSnfaC0n8rXTWyi7ctODOZA5VwejLO0dR6ovitmrZPjYRENNT
 AtJ0cOSgkshotdTl7sYcbGoROLRBle8DeH+XuTAuSyzqxaGRQVHMvcVEZ0tHlsZl2UaY
 8cIlay6aMQqy2/GDW3MXYACAlcWbx5CiEGZV/HKtQ0czjOkZ6XCFeuzoSBy6U1xPsCNL
 7oh3iPikmJws6ikCi9A+XoaFGY92zl7YwohJlKW/SngUFFMp2YWT/3ppyurg+joidS5M
 Fu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4LjkfSy5vUY+saBETuGzU8Wtir4rrwiBPx84nJJQaXw=;
 b=NV5RntE9Onjv3U1Wrq0clkNf6syPPc7Nd8LvkoJ7cL8arSU1XAS0QZ+bxwzSCnxP+1
 ppQp+Yx8tee95dXxRMCJGU0tFGI6cWoYoo4s1k06jRThwAdP3CK2b2MmZMuLWKWxfhXj
 Bqa12wXAjSl9D+0ZDnzxammpJA7b95zPIB+doJmNTtc6B6GQMkW2n+XTKNGVb+3nxWAG
 4qqQniYu+UJS6APmJnpDgup36e9ZgxgYaTHhGMKh+k64LUa6eC0VerL7wHVHznD8NVc8
 CXkDGrRYxfOxKuH/vNwOznZF5W8yLTnbeW3xJticItXLH2JA01dQNeoPeNiGGLl09ilm
 +WIA==
X-Gm-Message-State: AOAM5329c0Vi3hY6Po7Z460f/uWPYFdtRCqsE0PWWCjH2XSTwjlyNH/i
 xeaVMUipl4wEJs0p/OXgtK5zsjkf5tNWgw==
X-Google-Smtp-Source: ABdhPJxABaapATbD5BelF8yF2NOc47UFxlwEilH6ShOupI+Dlb1dpgvMupsaje81xN5iDKimprKAcA==
X-Received: by 2002:a05:6a00:1b:b029:13e:d13d:a101 with SMTP id
 h27-20020a056a00001bb029013ed13da101mr5288081pfk.29.1601406464109; 
 Tue, 29 Sep 2020 12:07:44 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:07:43 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 41/68] target/riscv: rvv-1.0: single-width bit shift
 instructions
Date: Wed, 30 Sep 2020 03:04:16 +0800
Message-Id: <20200929190448.31116-42-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Truncate vsll.vi, vsrl.vi, vsra.vi's immediate values to lg2(SEW) bits.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index cce1712af0..20b104527c 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1932,9 +1932,9 @@ GEN_OPIVX_GVEC_SHIFT_TRANS(vsll_vx,  shls)
 GEN_OPIVX_GVEC_SHIFT_TRANS(vsrl_vx,  shrs)
 GEN_OPIVX_GVEC_SHIFT_TRANS(vsra_vx,  sars)
 
-GEN_OPIVI_GVEC_TRANS(vsll_vi, IMM_ZX, vsll_vx, shli)
-GEN_OPIVI_GVEC_TRANS(vsrl_vi, IMM_ZX, vsrl_vx, shri)
-GEN_OPIVI_GVEC_TRANS(vsra_vi, IMM_ZX, vsra_vx, sari)
+GEN_OPIVI_GVEC_TRANS(vsll_vi, IMM_TRUNC_SEW, vsll_vx, shli)
+GEN_OPIVI_GVEC_TRANS(vsrl_vi, IMM_TRUNC_SEW, vsrl_vx, shri)
+GEN_OPIVI_GVEC_TRANS(vsra_vi, IMM_TRUNC_SEW, vsra_vx, sari)
 
 /* Vector Narrowing Integer Right Shift Instructions */
 static bool opivv_narrow_check(DisasContext *s, arg_rmrr *a)
-- 
2.17.1


