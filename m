Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EEEC388F7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 09:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F66C20759
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 09:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiGYwuhK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F66C20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaFDh-0001J1-AR
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 04:36:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kaFCj-0008Rw-Bc
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 04:35:45 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kaFCh-0003vA-Pl
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 04:35:44 -0500
Received: by mail-wm1-x341.google.com with SMTP id v5so1693375wmh.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 01:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4AhUjeQiN0LcEfpx9fUA0RoRAgGVy7D+433bMg8WIoY=;
 b=MiGYwuhK4bBAXxdeMn4u87pmsXL3PJjESP2bna9x91x/I8QrOTJCWapDuj7bhXASK/
 tiipDW+vkv1FNRk5slRDB4WD+LmdgrUR/NYDScqx98W06aE5H7nV64PzdCn0PfM2LyC4
 K0ORHkzb1OXar2SCl3sSj4Ji/C8gIQfHnBdlwRWyMsHyf+oXUb/1eN367ztbqTunLYES
 Na6sAyGVLycGmRY0IuAC+ZkBytfkyBIfKjaSr82TfHD9x4MInKyD0zVCjenlSEaLVWHI
 Aivu8BnbOAicQ4rlUdQjgZlssdfCQJ3lkAEWalilvFfJl2sJCZzPXqkZLoIebcOZCjbI
 NKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4AhUjeQiN0LcEfpx9fUA0RoRAgGVy7D+433bMg8WIoY=;
 b=HQrJU25F2zTx27K/r6eCRXAaeM5JbVKRR3A+hCPlaDX8FOjh+fjqFr2ZPk7SzR2nCH
 26y+t/2tWh8zctlTZq+noQJuDXBjbw8Q9RSJII7rGbURbDh8wGzPFgwd3F0pO1pbNR/3
 nyaQWVyoHQjzwpZjj5cvsc6x4VWWH3z+GkzaxuZvxpN1kyViFI+4LqTp9g1rhoXUfyTV
 pRIx+JKBirt+HkSlTVN0qIgTDQPonqbzPgsnGrFVQ24I2vG8e7+IYGwciZ6g5ZEooP6G
 4vWF2laFgU7ID/qQLlbnc2xoY6xQivY1o3lDsrbJFxArkdZP6Z9C92hu+JMTmdIfLg84
 BD3g==
X-Gm-Message-State: AOAM533463sEQMBNjimERR9al6opjAkQddlvLuxWIf+IyrB3C/Pt5hRH
 VzreGMe9O1NwvOe+ESMpEV/80VD7nbI=
X-Google-Smtp-Source: ABdhPJzkWSP7lIgkSDvBwGpprX90shpPVzibsZhma2tGLUU8tMY56+QQGb023emfOGnLLcVcbaoKjw==
X-Received: by 2002:a1c:96cb:: with SMTP id y194mr3469929wmd.62.1604482542378; 
 Wed, 04 Nov 2020 01:35:42 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id f3sm1880884wrw.81.2020.11.04.01.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 01:35:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] MAINTAINERS: Cover exec-vary.c (variable page size)
Date: Wed,  4 Nov 2020 10:35:33 +0100
Message-Id: <20201104093534.3064440-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201104093534.3064440-1-f4bug@amsat.org>
References: <20201104093534.3064440-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add exec-vary.c to the 'Overall TCG CPUs' section.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dd16606bcdc..466898d3dbd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -117,6 +117,7 @@ R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: softmmu/cpus.c
 F: cpus-common.c
+F: exec-vary.c
 F: accel/tcg/
 F: accel/stubs/tcg-stub.c
 F: scripts/decodetree.py
-- 
2.26.2


