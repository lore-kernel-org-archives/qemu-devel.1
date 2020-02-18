Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E69DC34033
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:37:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DC6F20836
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnzRxtQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC6F20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3wVA-0003DD-Ct
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 01:37:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3wSX-000803-VX
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:34:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3wSX-0007C5-0F
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:34:17 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:51176)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3wSW-00078s-Hk
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:34:16 -0500
Received: by mail-wm1-x329.google.com with SMTP id a5so1545346wmb.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 22:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=frPN5dFAaj2MWYJF/kX/45dwUwTy4qTt8SEaHdZJjwE=;
 b=KnzRxtQ8DHdX58TnhtxZyzWQsX6LWzAokCYtHrmvbKZSCWMEXk3MIWTrSJVST5/KE1
 45nBFwPLGDZl1Bhf59sv53kDn2LRVFsTRtERG0QbCe5SonMvd75yuQJNKftd130+12Ar
 /CM6yo9xwD6yVLk128hmx886o5oA9kyLuFwoAsHA8fGeb2uomd+kIzSYBy1TSdQFh0sC
 9mchya3r3tjqlftzr21w5Dh+DYvdY9wN2Kb9TE8lKhydZGHPemW8tdj0Hwr48YvSebGC
 MExACgKXMyobr91VGejDskGCEEERsw/AMhd5PHJtMl+Q1DhiF7YPjBvMOMqymLG1Olaa
 dmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=frPN5dFAaj2MWYJF/kX/45dwUwTy4qTt8SEaHdZJjwE=;
 b=uD56hzwGlFcf1KxXpmj02HhL41oS6xdgJQjdUsqjhfU8clJdZW8qi49EZXX6P6E/Y0
 S3wJI6rVqYEy8pfHN2ZPTQerEnTgbF7nGCU1JyKAaqJd/E/avUGc9rAX0IoyopYaPM2g
 wAS2NkIX25B34qXdMXYr/f3RCmceqFlge/7RrdVox+3QcVigmTImCSWkZim/YUQeKSfI
 9n9Giw2O6Ku8bCGMqGwAxkhyear6Ym3aPdZ3Qs8DIVKzvtv5fMKcHyzokwEC9aW0Og39
 qyJ7HEln4QiG4AWCOSbsFmm8izzm+ayjKQ9TC99fIrtKYFZd7SQjGrYy1oNDBzlAIlmq
 zURw==
X-Gm-Message-State: APjAAAVdgdAr8w044Gn3liUI+5kdWCaARCZcEeroQnfcNtwVtYkKr7Cg
 bcnA2fWo6dkDH4dNPgdcspo=
X-Google-Smtp-Source: APXvYqxIf2oKkm04Tz7S8RiLaFH34IKcn/sDWdi+Eq3FFVxhq443G4FD6Cf3O8WAGIzeLfPXDqILQg==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr1080177wmb.174.1582007637526; 
 Mon, 17 Feb 2020 22:33:57 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id y7sm4374683wrr.56.2020.02.17.22.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 22:33:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v2 0/4] hw/hppa/dino: Fix Coverity 1419387 / 1419393 / 1419394
Date: Tue, 18 Feb 2020 07:33:51 +0100
Message-Id: <20200218063355.18577-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Easy fix for the overrun reported by Coverity.

Since v1:
- Fixed description to cover CID 1419387 (reported by Peter)
  (no code change)

Supersedes: <20200213234148.8434-1-f4bug@amsat.org>

Philippe Mathieu-Daudé (4):
  hw/hppa/dino: Add comments with register name
  hw/hppa/dino: Fix reg800_keep_bits overrun (CID 1419387 1419393
    1419394)
  hw/hppa/dino: Fix bitmask for the PCIROR register
  hw/hppa/dino: Do not accept accesses to registers 0x818 and 0x82c

 hw/hppa/dino.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

-- 
2.21.1


