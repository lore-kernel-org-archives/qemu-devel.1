Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89191C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 501312068F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OAMtUsSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501312068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyBLX-0007yL-EJ
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAxK-0007ZD-3r
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:22:30 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:41379)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAxH-0006Cx-Or
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:22:29 -0400
Received: by mail-pg1-x533.google.com with SMTP id g67so872942pgc.8
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=aUA4lJ98g9Mf2dTHcPIuDucVxVhO4/F5ZEHerwqnT8U=;
 b=OAMtUsSnc6L3K4q+z6BVT3ggR/EG5O3V6Yf4sKSE1AbSbLp09VcycOM44zxL+ylgCo
 WKCONK1cSLcNK/65GOGYNCAiXB3ItIb8Hg5BOYmXAXGnx5gtv9qgtV2lcNTxpQTniQBQ
 5TL7t3EBy8Vam1Pl6hIzpLjCDSocZ1EXT0OwbpLVEBZyzKCXlCSUz0aCgySn1u4EIGFn
 +jDcfCUFmNS2plNGFO8uu7Ef+7fX3s1ZcZhyMQQOy2j/+74eQ/GtjzXzbtpLDANxHInX
 XwCfqX8CeiDMz3F7HSj3jSiEY9XKx/QgYfXA34SGoEIBm0oqUlMNTK+/kTj0rdhV83om
 PDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=aUA4lJ98g9Mf2dTHcPIuDucVxVhO4/F5ZEHerwqnT8U=;
 b=dlY3EoBvAJ5XCUtP71K2+PfVzydNPoZHQFnQClLGIRl1zTEwPbubELD80jxVK8y/Wz
 RHnyChRgBRtG5sQaogtM5sK+Aa30ZXq5JpsmhIKHbNNlJmaMQcakB+9K34w/Z2geP4NT
 4ig5+L9o2MCZ4gj/mmJpeye9VNd1EAvVDaOt7vWrjmkMgVWnp37FICHkPeLuSf1D5bqO
 Wmps2nTyw4IU2NAf+Uc1Tx5OId3wI/7BUVSjIlpM8SRmYMMQA+UUbxWJfE3mysT7AvTL
 BQN7knRYE8+sv2/wRSeYtX1zw/XIYtyNmvaOhk6NJk+fFldv9dwn7FdghKjnws9c1cxh
 c5CQ==
X-Gm-Message-State: AOAM531GdGwUmXrsrJ/4iCMf6cdhQ2B2UVeP+mBhjihXm+exGy2hoEr7
 OrDOt/fQys9dFZ2nkyHpinQuQez4Yns=
X-Google-Smtp-Source: ABdhPJyVpZsoIkv7uEPQtv3e5A7FFrlxzAnvbDiiCWe50wopv9rhtKrM+sj/KX8i8GQtLdU6Gug+kg==
X-Received: by 2002:a63:140f:: with SMTP id u15mr24630217pgl.94.1595409746223; 
 Wed, 22 Jul 2020 02:22:26 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:22:25 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 69/76] target/riscv: rvv-0.9: floating-point min/max
 instructions
Date: Wed, 22 Jul 2020 17:16:32 +0800
Message-Id: <20200722091641.8834-70-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
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

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/vector_helper.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 49e6a91859..4c6755db97 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3857,28 +3857,28 @@ GEN_VEXT_V_ENV(vfsqrt_v_w, 4, 4, clearl)
 GEN_VEXT_V_ENV(vfsqrt_v_d, 8, 8, clearq)
 
 /* Vector Floating-Point MIN/MAX Instructions */
-RVVCALL(OPFVV2, vfmin_vv_h, OP_UUU_H, H2, H2, H2, float16_minnum)
-RVVCALL(OPFVV2, vfmin_vv_w, OP_UUU_W, H4, H4, H4, float32_minnum)
-RVVCALL(OPFVV2, vfmin_vv_d, OP_UUU_D, H8, H8, H8, float64_minnum)
+RVVCALL(OPFVV2, vfmin_vv_h, OP_UUU_H, H2, H2, H2, float16_minnum_noprop)
+RVVCALL(OPFVV2, vfmin_vv_w, OP_UUU_W, H4, H4, H4, float32_minnum_noprop)
+RVVCALL(OPFVV2, vfmin_vv_d, OP_UUU_D, H8, H8, H8, float64_minnum_noprop)
 GEN_VEXT_VV_ENV(vfmin_vv_h, 2, 2, clearh)
 GEN_VEXT_VV_ENV(vfmin_vv_w, 4, 4, clearl)
 GEN_VEXT_VV_ENV(vfmin_vv_d, 8, 8, clearq)
-RVVCALL(OPFVF2, vfmin_vf_h, OP_UUU_H, H2, H2, float16_minnum)
-RVVCALL(OPFVF2, vfmin_vf_w, OP_UUU_W, H4, H4, float32_minnum)
-RVVCALL(OPFVF2, vfmin_vf_d, OP_UUU_D, H8, H8, float64_minnum)
+RVVCALL(OPFVF2, vfmin_vf_h, OP_UUU_H, H2, H2, float16_minnum_noprop)
+RVVCALL(OPFVF2, vfmin_vf_w, OP_UUU_W, H4, H4, float32_minnum_noprop)
+RVVCALL(OPFVF2, vfmin_vf_d, OP_UUU_D, H8, H8, float64_minnum_noprop)
 GEN_VEXT_VF(vfmin_vf_h, 2, 2, clearh)
 GEN_VEXT_VF(vfmin_vf_w, 4, 4, clearl)
 GEN_VEXT_VF(vfmin_vf_d, 8, 8, clearq)
 
-RVVCALL(OPFVV2, vfmax_vv_h, OP_UUU_H, H2, H2, H2, float16_maxnum)
-RVVCALL(OPFVV2, vfmax_vv_w, OP_UUU_W, H4, H4, H4, float32_maxnum)
-RVVCALL(OPFVV2, vfmax_vv_d, OP_UUU_D, H8, H8, H8, float64_maxnum)
+RVVCALL(OPFVV2, vfmax_vv_h, OP_UUU_H, H2, H2, H2, float16_maxnum_noprop)
+RVVCALL(OPFVV2, vfmax_vv_w, OP_UUU_W, H4, H4, H4, float32_maxnum_noprop)
+RVVCALL(OPFVV2, vfmax_vv_d, OP_UUU_D, H8, H8, H8, float64_maxnum_noprop)
 GEN_VEXT_VV_ENV(vfmax_vv_h, 2, 2, clearh)
 GEN_VEXT_VV_ENV(vfmax_vv_w, 4, 4, clearl)
 GEN_VEXT_VV_ENV(vfmax_vv_d, 8, 8, clearq)
-RVVCALL(OPFVF2, vfmax_vf_h, OP_UUU_H, H2, H2, float16_maxnum)
-RVVCALL(OPFVF2, vfmax_vf_w, OP_UUU_W, H4, H4, float32_maxnum)
-RVVCALL(OPFVF2, vfmax_vf_d, OP_UUU_D, H8, H8, float64_maxnum)
+RVVCALL(OPFVF2, vfmax_vf_h, OP_UUU_H, H2, H2, float16_maxnum_noprop)
+RVVCALL(OPFVF2, vfmax_vf_w, OP_UUU_W, H4, H4, float32_maxnum_noprop)
+RVVCALL(OPFVF2, vfmax_vf_d, OP_UUU_D, H8, H8, float64_maxnum_noprop)
 GEN_VEXT_VF(vfmax_vf_h, 2, 2, clearh)
 GEN_VEXT_VF(vfmax_vf_w, 4, 4, clearl)
 GEN_VEXT_VF(vfmax_vf_d, 8, 8, clearq)
-- 
2.17.1


