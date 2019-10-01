Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C9BC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:40:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0F8D20815
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJa4Sz8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F8D20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFINq-0001HS-SZ
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 09:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFIKR-00064n-61
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFIKP-0001ch-6b
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:36:35 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40937)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFIKP-0001bh-0o
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:36:33 -0400
Received: by mail-wr1-x441.google.com with SMTP id l3so15558078wru.7
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 06:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id;
 bh=DHCHcqIqGJk6cHzGkqP+o7recsStMxcRNs8vdRlSlTc=;
 b=tJa4Sz8R0EEo1eOZaQQQMs5ajlkYgbSAznay0uRlEuIWcJehIHyiYnPLleC7Hgj/vQ
 BE8OsagPnSP3lQFAxwUMO1RVN/o0VkKnoyfNtWoVpQu/cfROLbfapAiPTtjghbc0SnI9
 7SyMVNP8rZMPwWfypReHe0MTzES9JYusSEkMTwQvhRITUm5NR+u+PFXQSCfzEKG411OJ
 4JkXaUrMXh8DDYiHxFgGKdz0DAEO1NQDQaXpFbv9AbLGopNKyfFHiB6UKYj+ribBRZ5+
 /2SthTzECntfAIqHjWECEWREJf/w6LvidGu/h78I7edDMfcyQGctru5FIkkuRiIRZNld
 lCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id;
 bh=DHCHcqIqGJk6cHzGkqP+o7recsStMxcRNs8vdRlSlTc=;
 b=uUGuEwaE3u+GUNU/pDWjFGz1BmN/9rljmMu8ocvOHzZjdYgS+fDq2IXKsYiRGVbDkk
 IUijuIgTamGcBGL9i+GKglOoL3Ol6fk55SXUjpDLwxfGTLUFs/QjdMFDmLQ4ewgSa0ve
 nZBD2Tm2JDwdkWYe/LoBETiGYUxbMYyaehUY+c6Znvkx1uvQd3PzhRvj+lHBHd/XnnIa
 MK9/ie7aJ08yUyVYKIW4jmoBcGV+YBEpwbS8T2iPGiaFh+J7zurMEEhjXeFopP1BFf2I
 mUrb30YyAMnb+Hoya7m8Ed28WDCie3rm+48PBIwnbHhqijOwHG4K5veeInfpHKHehqb4
 kGKA==
X-Gm-Message-State: APjAAAU76LuZNnH514+3nw7kxjhjV/f6a2V30L15AR7El3xP6GcuRh+X
 sDtGaT2Or5inywL0Lc+PSGOdKUw9
X-Google-Smtp-Source: APXvYqwasaPgNZsnMpIBnLDe4efaE3Bzh3vfBmY1OoVJ8YwS9NDku6ZrUsaeffVlXN8OnlflULiNpQ==
X-Received: by 2002:a5d:6951:: with SMTP id r17mr17113013wrw.208.1569936990936; 
 Tue, 01 Oct 2019 06:36:30 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q192sm4424575wme.23.2019.10.01.06.36.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 01 Oct 2019 06:36:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH ci-fix 0/8] fix various memory leaks (but not all)
Date: Tue,  1 Oct 2019 15:36:20 +0200
Message-Id: <1569936988-635-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all, the asan and docker-clang@ubuntu tests are failing due
to memory leaks, mostly in instance_init but some also in
realize.  The former are caught by device-introspect-test,
the latter by boot-serial-test.

This series fixes the simplest ones.  ARM and aarch64 failures
remain so I'm disabling LeakSanitizer tests in CI with the last
patch.

Paolo

Paolo Bonzini (8):
  ide: fix leak from qemu_allocate_irqs
  microblaze: fix leak of fdevice tree blob
  mcf5208: fix leak from qemu_allocate_irqs
  hppa: fix leak from g_strdup_printf
  mips: fix memory leaks in board initialization
  cris: do not leak struct cris_disasm_data
  lm32: do not leak memory on object_new/object_unref
  docker: test-debug: disable LeakSanitizer

 disas/cris.c                | 59 ++++++++++++++++++++++-----------------------
 hw/hppa/dino.c              |  1 +
 hw/hppa/machine.c           |  4 ++-
 hw/ide/cmd646.c             |  1 +
 hw/m68k/mcf5208.c           |  2 ++
 hw/microblaze/boot.c        |  1 +
 hw/mips/mips_int.c          |  1 +
 hw/mips/mips_jazz.c         |  2 ++
 hw/timer/lm32_timer.c       |  6 ++---
 hw/timer/milkymist-sysctl.c | 10 ++++----
 tests/docker/test-debug     |  1 +
 11 files changed, 49 insertions(+), 39 deletions(-)

-- 
1.8.3.1


