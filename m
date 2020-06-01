Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F74C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:46:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C2CA20679
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyksAIv5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2CA20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfjpm-0001xe-R3
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 08:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jfjmq-00065G-Mr
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:43:28 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:38343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jfjmp-000551-OP
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:43:28 -0400
Received: by mail-wm1-x32d.google.com with SMTP id f185so11219656wmf.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 05:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=p1W8Wm+HcRLypwgt896EA55+QrHPVwIUetnM5p8Ah1g=;
 b=ZyksAIv5hDROuznTdDn78tyTfFj6FviYVq+nXj7bUIoyhrGTDzH9u82+NKlUshNXn3
 b23Xh+90CQIcY9GExugWyWzRdi4J9ZsoqfteAS/nm9rgRuOoiGe847B3VjVG1OH6kim+
 0CV2yqjkevTgJV3H9lxl8bkn3+0Q7gXBtcbtcMcrpg7RaMfnH7ukf7Tgu0plFDW4Wjuq
 iuql4YnjfAHDUwvUDYn4JzgwQBWBo0kbpO1T5nkXHb5jHmYx74Iv44zuQR21t+qFPm40
 yA4+pXXpMl6Q+/jCJHU/nIxW9MwU2zQzI/sXFPG7fXtl9ql5VjQI+L9fx+32PrHEjxTx
 5LzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=p1W8Wm+HcRLypwgt896EA55+QrHPVwIUetnM5p8Ah1g=;
 b=b6OAAfTEKRhlvXf38ek9dgBHQ03eQPIcg6WV/hqwfN9IUzmNj4pQ85DowVu/juDEys
 MAYahI7WfJbRcAJ9xIwsi/w7XXWmXoEoumc/tXuKsarJY82EyNh7NYK9TOsTSYlAW/Ht
 /3HHuvLW63Qa8ztgSL5JdZVWbKf8r+AzK6bvEXXcIjGqrQ3zMtSyCdEVm4GtrHg4oiiq
 KHN4lRAlvq0s2BiFTicMSAg/uT5W+eZKyn7ZgY7v9OLrXVp+uqJELs6HIq37bCAd+iJj
 mX6oEVUR4334a+l3lQXq8MYO5Fz7lMDHNlW/Z/GaOGkvi0DD0tXSCA/1TG2u2ZotyDs8
 2ndA==
X-Gm-Message-State: AOAM533vvZFdG6RjJRLcH6hWBn06RQO+yJmNnc5P7F2CR+BJwauv01tt
 P0J39czVciAsjxfvuD9lRBAcirkUb+0=
X-Google-Smtp-Source: ABdhPJynVjQ82lJqiTYLaODjzGcxzVcbQX+G2H8gtZmzDXjRl+PGkR0AH9IVQddYUmJqew2qi9NzOw==
X-Received: by 2002:a1c:a906:: with SMTP id s6mr22483385wme.171.1591015406112; 
 Mon, 01 Jun 2020 05:43:26 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id n23sm10948474wmc.0.2020.06.01.05.43.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jun 2020 05:43:25 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] MIPS queue for June 1st, 2020
Date: Mon,  1 Jun 2020 14:43:19 +0200
Message-Id: <1591015405-19651-1-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x32d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 4ec2a1f53e8aaa22924614b64dde97321126943e:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-05-30' into staging (2020-05-31 20:43:45 +0100)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-june-01-2020

for you to fetch changes up to a08d60bc6c2b6469368fff3d38dd5ddd16dd36be:

  hw/mips: fuloong2e: Set preferred page size to 16KB (2020-06-01 13:28:21 +0200)

----------------------------------------------------------------

MIPS queue for June 1st, 2020

  Highlights:

  - setting Fuloong 2E preffered page size to a different value
  - preparation for adding KVM support for Longsoon 3
  - other minor changes
  - a checkpatch warning is known and should be ignored

----------------------------------------------------------------

Huacai Chen (6):
  tests/Makefile: Fix description of "make check"
  configure: Add KVM target support for MIPS64
  hw/mips: Add CPU IRQ3 delivery for KVM
  target/mips: Add more CP0 register for save/restore
  target/mips: Support variable page size
  hw/mips: fuloong2e: Set preferred page size to 16KB

 configure               |   2 +-
 target/mips/cpu-param.h |   5 ++
 hw/mips/fuloong2e.c     |   1 +
 hw/mips/mips_int.c      |   2 +-
 target/mips/kvm.c       | 212 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/mips/machine.c   |   6 +-
 tests/Makefile.include  |   2 +-
 7 files changed, 225 insertions(+), 5 deletions(-)

-- 
2.7.4


