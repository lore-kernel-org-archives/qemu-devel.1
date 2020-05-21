Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139DDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:10:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7A9220759
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SZCbqRKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A9220759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboi7-0007yb-Vc
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJ4-0004Kf-EO
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:30 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e]:41254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJ3-0006hP-Kg
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:30 -0400
Received: by mail-qk1-x72e.google.com with SMTP id n11so2380437qkn.8
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TvYnAkjAppdRPxTCTiIdH7gnvDHcZXb4SiVpZ+2G8IY=;
 b=SZCbqRKnD6kX2rklKe58WjtOJUKa76jLfuo0z0tviYcxZkVDslo0k7VXSOPiRp6/lS
 Fx1wFNgogr6K1FDXtyargnSC2hM+KJ/dRp2Tv4BoJUF2C76hsl2+JWsajjz/DANcOwdz
 wSUslRyV+NfonoiDOs2888qJ5Gqu6AGRb4dyPO3B05gO86Nso093Yg/LHdoRZnXhzF2Z
 QY6karxwYVutqUJ7sWmP6Vhuru6bREsJxnaEJVnr6WPWT1Ai2uM8fPV+s2r30DvbiqnV
 OEZfcN9QOdH6nhfHdekjn7SCOxO6CkLHyFuQjZaKdsOa5GDHZFHHEVZNKtNmUXGSmLA/
 p5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TvYnAkjAppdRPxTCTiIdH7gnvDHcZXb4SiVpZ+2G8IY=;
 b=rFkT60pBXXoSKgsw/nJpOYXbQnNNyNzrMYOvLe4T5ytiS6mYa25ltuKOQfW9fWp/5j
 nNt1e7DzgsNx0RCL83i11PXkJR6wxz2JtgTC8+9UdJb8nc4JbNdv9AuhvyvZOS5zRQaj
 MKqKbiew4LBnfi4G7kyBUhwj3gi64uprZrJAJ+Pi2cso6JcyQ5rkhtQ3reKcJdHt0U7R
 7CVsmIxlhx3pUwwNhZ836q9sSVJE27OPMl0qHTJNBggx1U3ycUcKhkN5Tz2WBm2fTTic
 9KfAnKRS/iHxHfQyum8lShP7WzW7H80lqXsW4/J9JGgqpE9mR/NDuNUwZCHWu1vcb9lD
 7uOA==
X-Gm-Message-State: AOAM533igwHPB8RR09uxfE//EHvC8U435LmvCVknABvRk/9BpBhgpBzc
 2Zk7PfYymt2kNzaP2Jbs0lIeB32GgjX7Jg==
X-Google-Smtp-Source: ABdhPJzTqVkDF+TGfwNvb8OX8JY4NnECGsH7Gf7K5rpeHojDhksTuYShrgNosEBooR9WBT/hRN3zSA==
X-Received: by 2002:a37:a1c7:: with SMTP id
 k190mr10996168qke.166.1590079468173; 
 Thu, 21 May 2020 09:44:28 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:27 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 55/74] moxie: convert to cpu_interrupt_request
Date: Thu, 21 May 2020 12:39:52 -0400
Message-Id: <20200521164011.638-56-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x72e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: robert.foley@linaro.org, Anthony Green <green@moxielogic.com>,
 richard.henderson@linaro.org, cota@braap.org, peter.puhov@linaro.org,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Anthony Green <green@moxielogic.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/moxie/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
index 6e0443ccb7..f823eb234d 100644
--- a/target/moxie/cpu.c
+++ b/target/moxie/cpu.c
@@ -32,7 +32,7 @@ static void moxie_cpu_set_pc(CPUState *cs, vaddr value)
 
 static bool moxie_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & CPU_INTERRUPT_HARD;
+    return cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD;
 }
 
 static void moxie_cpu_reset(DeviceState *dev)
-- 
2.17.1


