Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2917BC4724C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:18:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC4AD20735
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Byl2ZXHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC4AD20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVWIa-0006qD-SH
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 04:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWHb-00050e-86; Mon, 04 May 2020 04:16:59 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53447)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWHZ-0000zf-NX; Mon, 04 May 2020 04:16:58 -0400
Received: by mail-wm1-x342.google.com with SMTP id k12so7355790wmj.3;
 Mon, 04 May 2020 01:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ILNecMKwT7NnH838aIVBv5o4DLlabJdcuHDw22DvLUc=;
 b=Byl2ZXHA9wjQyTIDWo2zgagmqvgzRhKOFKJkHkLgBAGzm1kMHnNw08hDn1oP96zxVx
 OlE6/ud4FP4Jy36fYvNjTHJJ2ZxxKTHnPPTOMyQgcB1sA/V6ppH5awyeOrfcRIVYRbwR
 h96hi0qQsCgXdbVDMlVt2KKydx71L4VUudwkbSQ0aRYDlopAvWi9CAls1/+B4PtyZxzZ
 hXglSsWWjprvLrn1KbiaPX/woWdamZekd3gT37iABLpoeN3yqAw+LUY73dIDA97o7o6o
 cm4sJ6+GCAGJB2KrSA1HFyvrjtK1zlDxEZkLVgqUpymoLpNTRrV8IBeEBmGuYgOYMTtE
 2s7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=ILNecMKwT7NnH838aIVBv5o4DLlabJdcuHDw22DvLUc=;
 b=KQ8DDg4wcFg5Ex7VCPKJwFMKV0gR08b4CaMvr1yPCh89DwcrcMhWA5JYBlo/1kAGgv
 WBTuZc+T9+1gtlRB6LyorShZaL7j4xmZcyX9yLFezSv2zZxcyCc3yz92SKsY8o7zT3Fz
 RIgVx9KXvp0Aj98Wp8baQuLSc7+KF4zmdyVWyw/BHgwaRLOszO1ykBpQNt78aScJdBF/
 dEGshIe2Ie9RI0L3KBnICCvaJ36HA8pUCgas1sxI/uqAXOcQbxSTEWpC9yw7IK/JjlNl
 yw85X1vaQaMq/CtPBd/+64h0o8UkIhE3MPpLNtvtTzwUX4QJHE5BxEe7NrNW3an+HlcD
 Ving==
X-Gm-Message-State: AGi0PuZ610nLcwyXMada1/lVsRvLyfth0TLwT1RZRvQk7Ml9+a/PFfIu
 gFoGzpzWf0hlnYxW/XR/P3o34eX4
X-Google-Smtp-Source: APiQypKHGoPEbQ0n8cxzTjTdB1jaBymVwVP0cF/Al9BGyR2ZHEWaha4/iutw1qhfC9zZ10iHu033SA==
X-Received: by 2002:a7b:c931:: with SMTP id h17mr14209375wml.105.1588580215688; 
 Mon, 04 May 2020 01:16:55 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id r15sm5092972wrq.93.2020.05.04.01.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 01:16:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] hw/sh4: Trivial cleanups
Date: Mon,  4 May 2020 10:16:50 +0200
Message-Id: <20200504081653.14841-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Magnus Damm <magnus.damm@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some SH4 patches worth salvaging while doing housekeeping.

Philippe Mathieu-Daudé (3):
  hw/sh4: Use MemoryRegion typedef
  hw/sh4: Extract timer definitions to 'hw/timer/tmu012.h'
  hw/timer/sh_timer: Remove unused 'qemu/timer.h' include

 include/hw/sh4/sh.h       | 12 +-----------
 include/hw/timer/tmu012.h | 23 +++++++++++++++++++++++
 hw/sh4/sh7750.c           |  1 +
 hw/timer/sh_timer.c       |  3 ++-
 4 files changed, 27 insertions(+), 12 deletions(-)
 create mode 100644 include/hw/timer/tmu012.h

-- 
2.21.3


