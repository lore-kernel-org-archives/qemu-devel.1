Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619EAC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 13:25:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1D932072C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 13:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfKIX9DP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D932072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRxpg-00029F-S0
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 09:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRxke-0004qU-PF; Mon, 12 Oct 2020 09:20:32 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37501)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRxkc-0005Lv-Vy; Mon, 12 Oct 2020 09:20:32 -0400
Received: by mail-wr1-x443.google.com with SMTP id h7so19197748wre.4;
 Mon, 12 Oct 2020 06:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JY3Ndr1SwLa4aQQZxdcgHQ230u1S4q1Vxx6foe4GpMc=;
 b=UfKIX9DP7TdbRCKdltMfWLSqZVcuaV9jEDALi64LrB2vd/AZCJfsT7/t0Alf+/abJ5
 rSp+ZQ6HQcrSrHFUmJDVgvCBF+Zx/whxLcSZzcfcsmRob1bAPJEQsbGul99w/ixzwiF7
 zs4EpoAIsfXRmDcFH3Mz2sly0fEtcALfoDQP8PGDg5AUHS9NLyP5YZxbzevn3N8gA+Qd
 hSGpRXcEfiF73Fsy3tojxiCQl7vRXSYSWx0Zpq243Mh1bBrCnw3icwhEIWaoB5e9otAv
 d0sVlOdp65XKgUfOVtQUeDZ6fD/RlzVddHZZXbq/AYqIqm2c2QMss+R+v3B+S27i5E50
 y8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=JY3Ndr1SwLa4aQQZxdcgHQ230u1S4q1Vxx6foe4GpMc=;
 b=OR5Sv1iXDPy8sLBScrekkZEsHcdy/24pLTKyPdda1TvE4+fmFQDsStW2oPYJZ97dlp
 mo3GMOddPkLOoTY+PhayM7EsQm7iq/rmNqW8CN/fd/t7mCfgqny2HXE5/WVquBVsH3zr
 AlIWKkOom2fzXhUig//sBoBVtLoPJEEHYaBS16Vrcn949MeOoeFLpx42HldEPDedyaMQ
 i8hyU8tufnltNcLmeVeO2a38TggEPt/d2Yf1s5J+66TjIQb+YF/+F3COKo1ZOLF1poHC
 RyH4RcmIzlLMCDF78FHEaQhi0VyrHWONSfMxLWsPpT6dwd+ZNc4rbvhmo9NkjPyVT3ot
 EvZQ==
X-Gm-Message-State: AOAM533PNakzRvT0Y0P04ta9Ke0lIQXzLAYegFPOPwhyfHLi2Y80SkS+
 N5RG4+vo9rsJFWVH8kztjFwHPJeeOKM=
X-Google-Smtp-Source: ABdhPJxlJ5+SmRXQ6NUT6GWhDLb5a/5Azd/dn/M6f+cZh+THr/rzhNpfvScN2c9HMTr3Xl141DrgFA==
X-Received: by 2002:adf:f10e:: with SMTP id r14mr28581151wro.337.1602508828801; 
 Mon, 12 Oct 2020 06:20:28 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id e15sm24225544wro.13.2020.10.12.06.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 06:20:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/5] hw/pci-host/pam: Use ARRAY_SIZE() instead of magic
 value
Date: Mon, 12 Oct 2020 15:20:13 +0200
Message-Id: <20201012132017.3423954-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012132017.3423954-1-f4bug@amsat.org>
References: <20201012132017.3423954-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace the magic '4' by ARRAY_SIZE(mem->alias) which is more explicit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/pam.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/pam.c b/hw/pci-host/pam.c
index a4962057833..4712260025a 100644
--- a/hw/pci-host/pam.c
+++ b/hw/pci-host/pam.c
@@ -51,7 +51,7 @@ void init_pam(DeviceState *dev, MemoryRegion *ram_memory,
                              start, size);
 
     memory_region_transaction_begin();
-    for (i = 0; i < 4; ++i) {
+    for (i = 0; i < ARRAY_SIZE(mem->alias); ++i) {
         memory_region_set_enabled(&mem->alias[i], false);
         memory_region_add_subregion_overlap(system_memory, start,
                                             &mem->alias[i], 1);
-- 
2.26.2


