Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC8BC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:15:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 111982074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAMmVWiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111982074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEBYX-0008EL-8G
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 09:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kEBXf-0006Ti-9H; Fri, 04 Sep 2020 09:14:11 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54195)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kEBXd-0002Z9-MM; Fri, 04 Sep 2020 09:14:10 -0400
Received: by mail-wm1-x341.google.com with SMTP id u18so6042753wmc.3;
 Fri, 04 Sep 2020 06:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U5Nf/dsZpglT/fNEe0BRVA0EwoDYwFpAKvTQELhkWw4=;
 b=KAMmVWiH0poKB9PnqGwd+tjUHSvmueCm+6am8OJxcwedZtKRAsfzUZMnQbLSoDMD45
 VhsfaSjOzSyf1MbjQgBOnDxMipDNNdxKtoPFwI3moFBR+fMNsIFLtUJbCIRWnTZzisuc
 qx1Awuik+C7kIOFJ7ufhCexGCUHwbVi7thw4xvZREmpCRcuNP2oaZHZoEPVkQWmX7Ui5
 HlORwErw9oiGE6QIv1dymPd+MSu3ptXulCdjB22RD4SdtdGp+3i95t9LZvKHBeRlPzJy
 AHnYKftmfEnvL/WRz6jDp2AOaPJNKr7k2BrSeuoxaR/Kh875oOxm5r+xX01buk88gQHM
 tRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=U5Nf/dsZpglT/fNEe0BRVA0EwoDYwFpAKvTQELhkWw4=;
 b=RVggC94apX1b5OxhdT0pyQy33+Rju3dA191U0JseaEg2dSrzd32Bw+qMtzLqqg75MI
 yR1BC4AqE7GzsqGU9fT41FYM1w7TTvVgC440NvHm51Nus65hhdlZeWDKV032qvskQsEK
 Gj6+BVsnwZJ8T5TwJ4K4U9XYij8zP994f2l4MxH4lI/Gk5gLcU05tYd4U4jE21YKbZA6
 vxbvZZ1PckpeHMI6DE3uJFVFfHSIsPKOgPzlaSWg/xaqS6u0SmFHCc8cbhAvo0LAfG+l
 B+ctVxXasfE5dOPgK1IcW4gyp/toRs/P05jS4V6rYNZTKBSqC2DKlwmHxTcl3Lq6sJhd
 IKvw==
X-Gm-Message-State: AOAM5325iNJaoJ2gKQGhD9Ww7tF7pvT2EMPDtuISQwptSY2HhH/NPs7p
 NsEsKIF8o/YB01q33kVPf2jmA0aDF1A=
X-Google-Smtp-Source: ABdhPJz/7kZSdD5rrx50dbwD7r+e+fFO+u6K2DTvGPgX0raKlN4ET7nL7jY044irKs3XMBfD1DrSkg==
X-Received: by 2002:a1c:b703:: with SMTP id h3mr7474239wmf.131.1599225247743; 
 Fri, 04 Sep 2020 06:14:07 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id b1sm11923559wru.54.2020.09.04.06.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 06:14:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/net/e1000e: Remove duplicated write handler for
 FLSWDATA register
Date: Fri,  4 Sep 2020 15:14:02 +0200
Message-Id: <20200904131402.590055-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904131402.590055-1-f4bug@amsat.org>
References: <20200904131402.590055-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The FLSWDATA register writeop handler is initialized twice:

  3067 #define e1000e_putreg(x)    [x] = e1000e_mac_writereg
  3068 typedef void (*writeops)(E1000ECore *, int, uint32_t);
  3069 static const writeops e1000e_macreg_writeops[] = {
  ....
  3102     e1000e_putreg(FLSWDATA),
  ....
  3145     e1000e_putreg(FLSWDATA),

To avoid confusion, remove the duplicated initialization.

Fixes: 6f3fbe4ed0 ("net: Introduce e1000e device emulation")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Noticed after looking for other cases of the previous patch.
---
 hw/net/e1000e_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 5170e6a4563..bcfd46696ff 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -3141,7 +3141,6 @@ static const writeops e1000e_macreg_writeops[] = {
     e1000e_putreg(RXCFGL),
     e1000e_putreg(TSYNCRXCTL),
     e1000e_putreg(TSYNCTXCTL),
-    e1000e_putreg(FLSWDATA),
     e1000e_putreg(EXTCNF_SIZE),
     e1000e_putreg(EEMNGCTL),
     e1000e_putreg(RA),
-- 
2.26.2


