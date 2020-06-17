Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABECC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:29:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8634320786
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8FTmBWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8634320786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlSVQ-0001g9-Qj
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlSSG-0004eR-OJ; Wed, 17 Jun 2020 03:25:52 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlSSF-0002ax-8x; Wed, 17 Jun 2020 03:25:52 -0400
Received: by mail-wm1-x344.google.com with SMTP id l17so805589wmj.0;
 Wed, 17 Jun 2020 00:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FBTuMSOiLwpA4yPchfEYPLFdnrdZHjpXEDQDsJPN5pY=;
 b=H8FTmBWPbuT0503K0fu/NHESlWV/tf1E2Bn6iZCOF8zkK+oYDEm4Thz9NxkIuC7nkc
 j5cMmDjh+TZPlB/wb4e+0Fgrz9Im4VEXu5WtXk2K7qKf2vtHEpAn7gzg64nwdPQPTQ8/
 +Uh5TUxhbAd9uuyLMmrsvYq+avoKx+Yb8cvv8F+/5amvBNQrYuawdIQutWzG96iLWlCo
 HKJnbM1+gSFojWBMzXkHwYCtwqP5jGL7x0IYWznRg22CBmbg5oAKJUDI3bVQq8Ybqfws
 11nuV+n9UlCxExP6xcc+iTY9RZn6nPfoU7F3KlVXsBuFGbT7XNxI1qiHVdIPLKEiMx2Y
 f5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=FBTuMSOiLwpA4yPchfEYPLFdnrdZHjpXEDQDsJPN5pY=;
 b=KQoW7MIge+FQcgTLwWpxQSwtnHohqpxDF+a/4EK4NMo0S3DfW2pjNVD3Ggoa3cjA8E
 Jc1yVvrRwKdABtijJOrtZygiWLKdYhsNsyLCDQqb7WKY1kdh0EJewZQSxPVDUwra4y3k
 C5Cn8Div/Sh6uF4qCu6ezupHn5Am8RL2fz+9v2K2SwixsU3tnF1eMuk9lgAaZPeD3i6N
 gkk5ia/pSGwyd0GU9NRR42Pb7OFruTYjqJPHNKY3R+P3G8D0CUe5ewRgsp6Ws/X3tQmb
 7D3XtGFfySuDHONGvqQ+MsgSaPn4F9r0fLr9XagCWcIzJJrDCxyJiKpChsXZTKIuXSvS
 nfnQ==
X-Gm-Message-State: AOAM530zCjJ6oP0G8lRfeREJ4K9w7BPmZH40tHTLrFtA7D7+9AoXV/mb
 i4cxGQRKLuXts5mAMcW9FVTt0TcU
X-Google-Smtp-Source: ABdhPJzLKLe0Dv9AstnCvvf/J1mslVxLbjSV0F3J+2Q+02jD1dlcVRwsL4QzK2/hzEil84ctLKXoVA==
X-Received: by 2002:a1c:e355:: with SMTP id a82mr6997164wmh.1.1592378749441;
 Wed, 17 Jun 2020 00:25:49 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id j5sm32894781wrq.39.2020.06.17.00.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 00:25:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/14] hw/arm/mps2: Rename CMSDK AHB peripheral region
Date: Wed, 17 Jun 2020 09:25:32 +0200
Message-Id: <20200617072539.32686-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200617072539.32686-1-f4bug@amsat.org>
References: <20200617072539.32686-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Esteban Bosse <estebanbosse@gmail.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To differenciate with the CMSDK APB peripheral region,
rename this region 'CMSDK AHB peripheral region'.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/mps2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index ee555f919d..4fe5cc8622 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -212,10 +212,11 @@ static void mps2_common_init(MachineState *machine)
      */
     create_unimplemented_device("CMSDK APB peripheral region @0x40000000",
                                 0x40000000, 0x00010000);
-    create_unimplemented_device("CMSDK peripheral region @0x40010000",
+    create_unimplemented_device("CMSDK AHB peripheral region @0x40010000",
                                 0x40010000, 0x00010000);
     create_unimplemented_device("Extra peripheral region @0x40020000",
                                 0x40020000, 0x00010000);
+
     create_unimplemented_device("RESERVED 4", 0x40030000, 0x001D0000);
     create_unimplemented_device("VGA", 0x41000000, 0x0200000);
 
-- 
2.21.3


