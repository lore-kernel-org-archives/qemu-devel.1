Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15302C4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 16:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F16C2158C
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 16:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgY+zuyy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F16C2158C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMZjH-0002dJ-9b
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 12:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMZiH-0002BM-Gv
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 12:39:49 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:40411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMZiF-0005Ik-U3
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 12:39:49 -0400
Received: by mail-wm1-x331.google.com with SMTP id k18so4287510wmj.5
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2020 09:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xkKLkV2QFqpLKsETiy7HeVVZWdnA7cUidIC9DnQ+r3E=;
 b=IgY+zuyy0uvB0EcTH3B5tfFyAe+AN+O3clZoLk8c8jzEmtpYuNQ72pZJHWy36MSLMG
 78LnQw3jdOS3XjLe12nmY7fn6wlR7nS4JXxXU2Nt7i4luDTX/XxdmmS5hqsmJuzNCHvA
 F2mdUROr7hwBBS+Aph2eYV2M/VsKm5DSdVe+6AohXG2dEBC0LF/fR0o1LktaxWhxXMTY
 e3+w2py22p8jaSbApZdC02MJ9xEbOnxlA8ROLA7HzW0OJyQs2uVnOSqa6Urdx3fz6uPm
 1iPitgFB3ZJsRkN3tUO+3ycKcqlHzH4vRJDeu1s5Ccvt7e6fF8Xg2L5/Pg+WNopwlkC9
 Wnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=xkKLkV2QFqpLKsETiy7HeVVZWdnA7cUidIC9DnQ+r3E=;
 b=WH+m4xZiY8mKvg1r/PEE3jXcJG3Pw0M19Akhf/UXMHdKJJdFm6A6CQNJTF0FnMLWcI
 MzlFtbjaYaV2DazyA67ARdre0/COV0cC9gJMqWKLRLlAl1y5dIKRvPOpfv86/lQgDNzj
 LmrlsokJrAZCbIyNlOsw1617txdY8vW0JBJUcFx1BgwtCmyrOB9y9pVePgf4vu0UGGjt
 RqZSzbD1J8aaqtSfuOjyAl28gwvx2YPzj9OkCMTD6PKzZ2lSWVAMLzhhDQtZHr5g8GhP
 tkhv1tk6Zsr6KpuiT7fu80ouSWJoF0ZO1dg/peAqhiyklszClcy1CiJe85OpLYnyx2/y
 dWGg==
X-Gm-Message-State: AOAM533yPaxOwmfYoWOvYTLXIAcAI65zwk7ONTg2L+PKXZ2ZfXcOOkW3
 hrUDNpsVRni8SXceUyhj9UnXDuzXEUw=
X-Google-Smtp-Source: ABdhPJx9pcM6Zjan8dLg9wGd/UpTkOYkdM7Ht7U7X4L5ZP43JGMmQRIcz9w+KkAf1WN3aIj6yLJ7wQ==
X-Received: by 2002:a1c:2cc4:: with SMTP id s187mr7480547wms.36.1601224785971; 
 Sun, 27 Sep 2020 09:39:45 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id m10sm5820184wmi.9.2020.09.27.09.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2020 09:39:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] hw/mips: Code simplifications
Date: Sun, 27 Sep 2020 18:39:41 +0200
Message-Id: <20200927163943.614604-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.078,
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Doing housekeeping on old branches older than 1 year.
Some patches are still valuable, so post them.

These patches should not introduce logical change,
they simply rewrite old style code using more recent
API/macros.

Philippe Mathieu-Daudé (2):
  hw/mips: Simplify loading 64-bit ELF kernels
  hw/mips: Simplify code using ROUND_UP(INITRD_PAGE_SIZE)

 include/hw/mips/mips.h | 4 +++-
 hw/mips/fuloong2e.c    | 3 +--
 hw/mips/malta.c        | 6 +++---
 hw/mips/mipssim.c      | 9 ++-------
 hw/mips/r4k.c          | 9 ++-------
 5 files changed, 11 insertions(+), 20 deletions(-)

-- 
2.26.2


