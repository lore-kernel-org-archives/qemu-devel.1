Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F97C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:17:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F35C22D2C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eCoTS1Kq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F35C22D2C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dzQ-0002eX-2F
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dTU-0005Cx-Tv
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:50:16 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:35721)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dTS-00089z-HM
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:50:16 -0400
Received: by mail-pl1-x62c.google.com with SMTP id r4so16675523pls.2
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6kkcYautSYvytvSbaEQJQyjXHNh36DVL7LgNPrrKZR0=;
 b=eCoTS1Kq8IRCCVg6erfCtL23hQzWqdQvZL0iteV1s8A4mAqF/Zk7A+1bb2K8TtBulp
 4F2KhN9uvcT/7LvMr2AuATZojggLa+MH4K9PRoPpFa/2fDli3rSBsY68tDRJi+pReRTg
 sP+DpM0lMKVr6+5frx98nZw3lLSvj/761C9rmPUEGQXejTbKfkZn/fyLTkrM2Zg0gdaG
 ndzbEmOFfz+mlW+7kZVT+4vQO6/mVyghZIVULeaGAC345zTFEHJ4DMH0Rga1KjbLOhZA
 ozivOAA2Zqv2DtK/GXRrXWx8KEnP4c3AdiYfkfGj3HVtY7XlX3hDjCdoeXTzRjD7oO2E
 Autw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6kkcYautSYvytvSbaEQJQyjXHNh36DVL7LgNPrrKZR0=;
 b=UyW/DoJAjZqDJbjVx8Xpc35fcFTD+OWiXa7MTwwauwm6HnF+jMFk1dMwyyK1t28Xpk
 kaAfQtpWEOU1Zq1YCT5PCoagw/6Vs6vSSbDqDrlzmNXSC5F//+RGHkUAkVImieLBih+y
 JYukObDejgX08bDnUVR4jP7i444KyVoKFSrI0ui/VdCV2OpvjbSkfc+6S/QPSVzSbfbg
 QwQsJN6Ln8U66o1p51CeoAzGIPBzGe0PGGJ4MpYxWzDb96+Y8OtNhFXQF79njy6Em9Cl
 WuSPh6xPOGqnOPijN8IdOKX/wBTo0x+MNchO1GW0POAQ4kM8YDp68F2Bf6n5WvDcv9kV
 ivkw==
X-Gm-Message-State: AOAM532ExpFMkeD6kOiIs5xnSXR6Mhxy3fNUoGVq/rYwNT0ld13cn1GU
 YM1tyhESa0YeGZZ0v0++fQAvsXOw4+o=
X-Google-Smtp-Source: ABdhPJzeqN9C5B5Zapl4bF8WpqKGNPOeFTpNGCKDHqrPp7NiJED4dPgNW5cORvu1ldO/Bd7yQ9Q42w==
X-Received: by 2002:a17:90b:4d0f:: with SMTP id
 mw15mr7596121pjb.174.1596711012884; 
 Thu, 06 Aug 2020 03:50:12 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:50:12 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 71/71] target/riscv: gdb: support vector registers for rv32
Date: Thu,  6 Aug 2020 18:47:08 +0800
Message-Id: <20200806104709.13235-72-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62c.google.com
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
 Greentime Hu <greentime.hu@sifive.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greentime Hu <greentime.hu@sifive.com>

This patch adds vector support for rv32 gdb. It allows gdb client to access
vector registers correctly.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 gdb-xml/riscv-32bit-csr.xml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/gdb-xml/riscv-32bit-csr.xml b/gdb-xml/riscv-32bit-csr.xml
index 3d2031da7dc..bb98b927995 100644
--- a/gdb-xml/riscv-32bit-csr.xml
+++ b/gdb-xml/riscv-32bit-csr.xml
@@ -248,4 +248,11 @@
   <reg name="mucounteren" bitsize="32"/>
   <reg name="mscounteren" bitsize="32"/>
   <reg name="mhcounteren" bitsize="32"/>
+  <reg name="vstart" bitsize="32" group="vector"/>
+  <reg name="vxsat" bitsize="32" group="vector"/>
+  <reg name="vxrm" bitsize="32" group="vector"/>
+  <reg name="vcsr" bitsize="32" group="vector"/>
+  <reg name="vl" bitsize="32" group="vector"/>
+  <reg name="vtype" bitsize="32" group="vector"/>
+  <reg name="vlenb" bitsize="32" group="vector"/>
 </feature>
-- 
2.17.1


