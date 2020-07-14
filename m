Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8972DC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 20:21:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57FF7207DD
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 20:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCKGizuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57FF7207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvRR2-0004Zg-Hr
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 16:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvRQC-0003FL-7o
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 16:21:00 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54623)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvRQA-0006UN-K5
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 16:20:59 -0400
Received: by mail-wm1-x343.google.com with SMTP id o8so204621wmh.4
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 13:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B2Ny7O+ykV1iblyI9PC1sIxllEhp7uUHrlhklKUSIgQ=;
 b=jCKGizuA6vLAPe5MUMTnEsAK+nIxH7LxIQTAROpmfwYbDaOwzkRC/ngXtkYzoyZZVA
 EGkrH35dKi0iRjvozNiK9T2GFi1efuqu2ixOuDH+dZSVbkWejTEhhUjGEFROijU75dKb
 LC+CRf2llVQKDjZGV7Wmxho0X62MEDzMmGIm9393TBDFbdQ/xKtDl2F8/N6u0JlFRae1
 SPXVO14u1bYi/u9Wka8iEs5SEmqP68EpGURp0reQaO7tGs9myCHCBK8q3jFmAqIXHxTk
 QGI0z+T8JAsghfYlFBbgbyvaJ2hB6sXZ4w/WX50p+AsQG0jxRzsRFw8vt9MQner4YwOl
 Y8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=B2Ny7O+ykV1iblyI9PC1sIxllEhp7uUHrlhklKUSIgQ=;
 b=Anoy4b78mJ+KNs2yAiMlNKdX9Ef15go58x0j11p61sFAjC6le6h4biinBhwvqil+yK
 4+siGdxu4uad3JDrxmbHpNL+Biu1mJhN2ZErkE6cQEDeoWLE8rDSaHhHME7FHSAzoD9J
 5RPGUITaPGFU7xecHmwCIn7G4tW+C3Cvk+Tsm7SfyojzyuZWupiRZdNDfM1/GcLQTYXh
 FSvRwRNge48s94ItbKu5e8KCY9Hh5luy6CwI9YEdisK0rhEaW8zExVVJoHHBI1edXI75
 8GyMjw3IvpW1K+Y51b3UnkuQJWQEjrfgPc+wkTGFpNEAuONAmI31xwRP5AjIxf+mJKv1
 zkWQ==
X-Gm-Message-State: AOAM5301aVkSclUrWfNtRDPQ+/V5fQDj8zc872YewqtlfumKF+NaTTs7
 HsL36WWJdkkDxJg+g49Ue7u03/22KAo=
X-Google-Smtp-Source: ABdhPJwyZj3pvl+6GPmi7jNFDUa/PkLHrnca+Gz5FhuJHBs0yWmi/5luPf8z3rhN8iEgEjGH3Cy2DQ==
X-Received: by 2002:a1c:1d46:: with SMTP id d67mr5801409wmd.152.1594758056930; 
 Tue, 14 Jul 2020 13:20:56 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 138sm7245217wmb.1.2020.07.14.13.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 13:20:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] MAINTAINERS: Adjust MIPS maintainership (add Huacai Chen &
 Jiaxun Yang)
Date: Tue, 14 Jul 2020 22:20:51 +0200
Message-Id: <20200714202051.13549-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714202051.13549-1-f4bug@amsat.org>
References: <20200714202051.13549-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

Huacai Chen and Jiaxun Yang step in as new energy [1].

Aurelien Jarno comment [2]:

  It happens that I known Huacai Chen from the time he was
  upstreaming the Loongson 3 support to the kernel, I have been
  testing and reviewing his patches. I also know Jiaxun Yang from
  the #debian-mips IRC channel. I know that they are both very
  competent and have a good knowledge of the open source world.
  I therefore agree that they are good additions to maintain and/or
  review the MIPS part of QEMU.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg718434.html
[2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg718738.html

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <20200701182559.28841-3-aleksandar.qemu.devel@gmail.com>
PMD: [Split patch, added Aurelien's comment]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Acked-by: Huacai Chen <chenhc@lemote.com>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe8139f367..cdb5c6f171 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -222,6 +222,7 @@ F: disas/microblaze.c
 MIPS TCG CPUs
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Aurelien Jarno <aurelien@aurel32.net>
+R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
 F: target/mips/
@@ -384,6 +385,7 @@ S: Maintained
 F: target/arm/kvm.c
 
 MIPS KVM CPUs
+M: Huacai Chen <chenhc@lemote.com>
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 S: Odd Fixes
 F: target/mips/kvm.c
@@ -2743,6 +2745,8 @@ F: disas/i386.c
 MIPS TCG target
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Aurelien Jarno <aurelien@aurel32.net>
+R: Huacai Chen <chenhc@lemote.com>
+R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
 F: tcg/mips/
-- 
2.21.3


