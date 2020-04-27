Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7588EC4CECC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:26:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4366020775
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uHlTD92V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4366020775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT8Sc-0007Q3-5e
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 14:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jT8JQ-0000CS-5L
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jT8JP-0005Hj-BO
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:16:59 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:41585)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jT8JO-0005GM-T3; Mon, 27 Apr 2020 14:16:58 -0400
Received: by mail-lf1-x142.google.com with SMTP id u10so14659234lfo.8;
 Mon, 27 Apr 2020 11:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UNhPRqE1nqM4y1sMRPefC6bxgbHFZMPLnBTiv+uklco=;
 b=uHlTD92VaQz/k/B6CD1gSoDVYGcZbaZ7ZkIYbOznXMIfBOoBcTExAYuLxKpdHFd3VY
 UCzyOxZf7Np5Mugl1jCDxRc98f6Yd4zdewOeKFnogXQl4cm42eG36YcWQdmnSeVfC00q
 R3oYq4ELvPGOQ08QLMulygkRXSjRSviYK+jnhLtGPVY+4YPYhS7jyN7trWH1U3QHhQkz
 DxAEEv0vrSNOA5C8K2R8UsgYr34R/3UTzDRIYKgrKMQLMobFJXPNIuJkP+CpvzbWhK03
 VU1GI9n0iHq/LUJ1vdi+L6zsoq7wHNRcDTVH4Y717gLMd5yyZCSN/0dai+1ksXnbY1Mi
 iXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UNhPRqE1nqM4y1sMRPefC6bxgbHFZMPLnBTiv+uklco=;
 b=lajyGt1a5hOsyNJ29Lz3b4kKvrPZaxiQVNwB9Fa5NpsLo4HAjrFuVCadtg/na+avL3
 oXpXjI+914i7GN87Fk4sbLe8i89YB9Cm0VOJC88eBqzc8wxMmeUYTVapR6sFw+gWgT0S
 mPlzIOcayjGcnZt3KX1JDsjsT3M+n2fLHgxPLI1541dDFi3HzJ3IF7OpAfE+OaJMDJlE
 KZtfmCIdvnhst6m/kCpOTmjBC3Hp2kn7SXvr3lS+7hSKH7TvXncTvSav9gBHD/V4CnpA
 6FbMduI8H2Ww8Zw9U0XBozLfq8dxxySZe6ezcLYoK7c8FkWtHmKa+L4ZUFW1ODFGshfj
 GEOw==
X-Gm-Message-State: AGi0PuZTZ5MiKP5YQ+iBtS6Y/hO94Ct6TFVwIrr0xZsjxdU8//yoTZck
 ClxI4Hl2zZrG7YD2azrKuaVDHwBF/Bg=
X-Google-Smtp-Source: APiQypKKsct6xjcjElAwdNZ20duT+s+lAXq/i1V1O0u/M8IsDiJW/J98YsbjG2kdukLoUPsdCvTnhA==
X-Received: by 2002:a19:48c3:: with SMTP id
 v186mr15971977lfa.194.1588011413208; 
 Mon, 27 Apr 2020 11:16:53 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id m13sm11905209lfk.12.2020.04.27.11.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 11:16:52 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 02/11] hw/arm: versal: Move misplaced comment
Date: Mon, 27 Apr 2020 20:16:40 +0200
Message-Id: <20200427181649.26851-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200427181649.26851-1-edgar.iglesias@gmail.com>
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::142
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Move misplaced comment.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/arm/xlnx-versal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index c73b2fe755..cc696e44c0 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -36,7 +36,6 @@ static void versal_create_apu_cpus(Versal *s)
 
         obj = object_new(XLNX_VERSAL_ACPU_TYPE);
         if (!obj) {
-            /* Secondary CPUs start in PSCI powered-down state */
             error_report("Unable to create apu.cpu[%d] of type %s",
                          i, XLNX_VERSAL_ACPU_TYPE);
             exit(EXIT_FAILURE);
@@ -49,6 +48,7 @@ static void versal_create_apu_cpus(Versal *s)
         object_property_set_int(obj, s->cfg.psci_conduit,
                                 "psci-conduit", &error_abort);
         if (i) {
+            /* Secondary CPUs start in PSCI powered-down state */
             object_property_set_bool(obj, true,
                                      "start-powered-off", &error_abort);
         }
-- 
2.20.1


