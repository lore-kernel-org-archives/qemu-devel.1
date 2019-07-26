Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1533C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 23:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 800042173E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 23:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800042173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr9du-0001bI-KB
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 19:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44940)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hr9dl-0001D6-0B
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 19:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hr9dS-0006cF-7t
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 19:28:28 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:40107)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hr9dM-0006ND-Gu
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 19:28:22 -0400
Received: by mail-pg1-f178.google.com with SMTP id w10so25453565pgj.7
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 16:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=Axm7ivFjIrAfDYo1sQiW0wWkU7rzfGqUzIpwsnxrpE0=;
 b=ZwMvqm57aNG2v2Lzk+NYLJHYUbY3TjqOsTqzcx79NjUO/7kOqamC5FimhQZjIrKp6D
 4ZBEPiicZFmGnaMlGn9ibVSSqLzmqpuZeJXTWP9lC6GhddKKwSCyIX2e3aRXtXbCU44U
 DJnknRioheB1C2R2egCaxPjlapp0LnZwJyuLT4LZowwfl8Io247R5zrbeCKFYfgzHnpT
 0F0jkJEsHWATEzfunKdk6cmD530pjxlsp/08tR5fPoDxGVJ+ppLDerBQR2MWDrSCbWZN
 ZgGXMZyerr9e7z6lTvapGiLw+gUsPmFlM2BEc732cJGCcjrHL4+KM0S82zvhWzIQ2+mh
 c65Q==
X-Gm-Message-State: APjAAAUH5oK9bruf8Hgk2L8W67/kzh6h1OKPpnbWYf5q9WE9wzcez06W
 KyC+qOkhIurYRpTDm2yNuI3BioCw
X-Google-Smtp-Source: APXvYqxr9EYC/coCqPGVVRoacy8HSgNwV5h/e0RjZcQFfAcqhm2aNvKfekerW+sp2OA0LtASrw6w5Q==
X-Received: by 2002:a65:4b89:: with SMTP id t9mr24433808pgq.55.1564183671227; 
 Fri, 26 Jul 2019 16:27:51 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id w3sm46899489pgl.31.2019.07.26.16.27.50
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 16:27:50 -0700 (PDT)
Date: Fri, 26 Jul 2019 16:27:30 -0700
Message-Id: <20190726232731.28572-1-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.178
Subject: [Qemu-devel] [PULL] RISC-V Patch for 4.1-rc3
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit bf8b024372bf8abf5a9f40bfa65eeefad23ff988:

  Update version for v4.1.0-rc2 release (2019-07-23 18:28:08 +0100)

are available in the Git repository at:

  git://github.com/palmer-dabbelt/qemu.git tags/riscv-for-master-4.1-rc3

for you to fetch changes up to 75ea2529cf09aa4630c5357f9814f04b6697e8b7:

  riscv/boot: Fixup the RISC-V firmware warning (2019-07-26 16:03:48 -0700)

----------------------------------------------------------------
RISC-V Patch for 4.1-rc3

This contains a single patch that fixes the warning introduced as part
of the OpenSBI integration.

----------------------------------------------------------------
Alistair Francis (1):
      riscv/boot: Fixup the RISC-V firmware warning

 hw/riscv/boot.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)


