Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4AAC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 08:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DCED2074D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 08:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaHkPBdo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DCED2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6V5w-0005FB-TT
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 04:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6V50-0003Qd-At; Fri, 14 Aug 2020 04:28:50 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36072)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6V4y-0004Ln-Oj; Fri, 14 Aug 2020 04:28:49 -0400
Received: by mail-wr1-x441.google.com with SMTP id 88so7615255wrh.3;
 Fri, 14 Aug 2020 01:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VnW0TLuLRs1VPgIa6dWC3fUE/qf9+L14BI+kE1SJ29k=;
 b=LaHkPBdogkwIArgaMSjCGx/cCOkHzDolzNfcML1FUy5zrUzahrXzdfFruP+4bUO6Ru
 /vjIsRJdF/D+wAqIOSeNVLTZTPTdBOApt6XdYJW10KpRvTmdRnmUpb/tRZJqFMd6xZve
 veLsT7935zM6eCkrLXmK3Fli3t48GnCukov3IZ42NQEejUIF/wu4rPqp5QVoygqQ9auX
 nTwygxLp9ggpl1lR5eXCu+H94vCElFvRDONxcfJYyM7ckRqyXxy4sx0SYePtDnzl0DUM
 2DsujdMruiYr7hktUb3aaaWKeeigiqVTQ9n3ShqqbSPDcb/0YkfrxbNOY+vIv2HzygyP
 rSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=VnW0TLuLRs1VPgIa6dWC3fUE/qf9+L14BI+kE1SJ29k=;
 b=ZYQu0gAlyH302zlcaNkn6TIn2EQfqrgy3hvMI5UIRtgL2GVMwtj+75cU55ACz1yog1
 KbNhbh774YjEH2T3TYCGPOIa2plC7AeAlFkap2AfwwFsjHBimMDeCNuVVbttcHa4GjQH
 +imrpZ9jTnuSF/fqk5EBlkN/IqQnoolk3yBXkiCeL8tAgzOwLrRUIbSMCFw9E8+mWnSe
 uUVQ9zuAjK7oeHrEMRe4tk/Gi098psW2qCXbRAUMxOWfvth2lI4/x/arCOFJBBH19t3D
 FJ7kyXNaBKx2/oEw8wmAw7j7t286C5bE+a1gvbMlq6wqArmZykj1cfIRrXinkz5koFJv
 epyQ==
X-Gm-Message-State: AOAM533k0mYN2zLmc5f2pQOd7q+60wtXmXg/IIrR+hGICcPY+qjtH8Zl
 +ZrmHYuyKJ4UE5p5wQRuoOPEExRZudY=
X-Google-Smtp-Source: ABdhPJw4ynOOZHcv7Uj1tKwDHntI06BNHOPgMZRnTJEehFIIYzF4XEziSFXpjEDm4u+cAit2pM35wQ==
X-Received: by 2002:adf:bbca:: with SMTP id z10mr1596169wrg.425.1597393726386; 
 Fri, 14 Aug 2020 01:28:46 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id d14sm14668107wre.44.2020.08.14.01.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 01:28:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/7] hw/ide/core: Trivial typo fix
Date: Fri, 14 Aug 2020 10:28:36 +0200
Message-Id: <20200814082841.27000-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200814082841.27000-1-f4bug@amsat.org>
References: <20200814082841.27000-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/ide/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index d997a78e47..f76f7e5234 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -709,7 +709,7 @@ void ide_cancel_dma_sync(IDEState *s)
     /*
      * We can't cancel Scatter Gather DMA in the middle of the
      * operation or a partial (not full) DMA transfer would reach
-     * the storage so we wait for completion instead (we beahve
+     * the storage so we wait for completion instead (we behave
      * like if the DMA was completed by the time the guest trying
      * to cancel dma with bmdma_cmd_writeb with BM_CMD_START not
      * set).
-- 
2.21.3


