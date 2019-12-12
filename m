Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EC9C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1449220663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9e6fkZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1449220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifPWH-0007SA-UB
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 09:32:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifPU8-0005im-6L
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:30:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifPU3-0008Cg-E1
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:30:31 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:38952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifPU1-00086v-Rl
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:30:26 -0500
Received: by mail-wm1-x330.google.com with SMTP id d5so2737781wmb.4
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 06:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=kmRqd/13hZnlFAZxCGECJRhCSuJOvoQsqZ3JU1fNSWs=;
 b=N9e6fkZAicGPV6try0V+6u8olMiAuBOXomzn3eCZSk4o0N68w4mQk8eJ8xmzy+FqmL
 GQp1je8X5HKsUW+ykNgLzIrW++txGzpBp1efgG7So3J3egajeS5/EjKI4WNdZVjjXpP+
 PIpwZDbpiRwA3Dg5NYyQ/aAI4k8SzpCMiDX2OAw4cQ2Ixbjafb08lnZXYWcnnLSx+rLu
 VCkuM7MVI4l45a8E3uRWRpNdf/oatp0+jrasCYTDge++teGj9wYR1VynpQbHUmihg8eG
 uXiosSu66JtLgaqjkEMgWFcAhc8HnkpCZ60ja0R2FQAzEISMcUSv8kGrwn9B216zGs6S
 8rtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=kmRqd/13hZnlFAZxCGECJRhCSuJOvoQsqZ3JU1fNSWs=;
 b=cc5GkARJeRDB4+gPFnD5Kozytq+Jm8DmToT9Q+NoWWVV/lm4oMiInU1O5Hqly0cu34
 2NeUQdoUxUW83g2s06EoSV9vxbbai6mqCs0VGDPKb2ZCXpLXHFWZGYTzPQP0TuCgBi3y
 RuDqU+aUQwRAnhFUk7dZxy2lcQ0pnMi2KNeuOIYHs1ui5NoSq5xszUsOFdVsC81EecVR
 zY2XxAayzSQb6kV6Ec493hCDPFs6/1CcxN5MgBueU9DVnI0VK9i7hQQrizD3JAWz+/iv
 nmtj+BbR7nsDSyaMczzLRvTJHdu1T/ADgpyRR2P0hEokLWDzC+jEVu83YSZhjidkGxnf
 IVpw==
X-Gm-Message-State: APjAAAUHX7MEoN5Hwk319uQYHjTjnuNS35GBjiCbTgKodeKeNQYmqa/u
 HKc6LTRZCOw7r2vHcMCe10s9Yrbc
X-Google-Smtp-Source: APXvYqwjH9a3jm0AkhXKWx/F+pe/olZW/lrUxFR5N+oDfil5mqlXkPQHd7I5Tn6CTJDiQX2OLeHIqQ==
X-Received: by 2002:a1c:4b0a:: with SMTP id y10mr7320355wma.78.1576161023246; 
 Thu, 12 Dec 2019 06:30:23 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id c9sm6140505wmc.47.2019.12.12.06.30.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 06:30:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] x86: allow building without PC machine types
Date: Thu, 12 Dec 2019 15:30:16 +0100
Message-Id: <1576161021-5359-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
Cc: philmd@redhat.com, slp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With this series it is possible to build QEMU with this configuration:

   CONFIG_MICROVM=y
   CONFIG_SERIAL_ISA=y
   CONFIG_VIRTIO=y
   CONFIG_VIRTIO_BALLOON=y
   CONFIG_VIRTIO_BLK=y
   CONFIG_VIRTIO_NET=y
   CONFIG_VIRTIO_RNG=y
   CONFIG_VIRTIO_SCSI=y
   CONFIG_VIRTIO_SERIAL=y
   CONFIG_WDT_IB700=y
   CONFIG_I8254=y

Thanks,

Paolo

Paolo Bonzini (5):
  i386: conditionally compile more files
  fw_cfg: allow building without other devices
  x86: move more functions to X86MachineState and x86.c
  pci-stub: add more MSI functions
  kvm: check before accessing PCMachineState fields

 hw/i386/Makefile.objs     |   6 +--
 hw/i386/fw_cfg.c          |   7 ++++
 hw/i386/kvm/Makefile.objs |   6 ++-
 hw/i386/pc.c              | 101 ----------------------------------------------
 hw/i386/x86.c             | 101 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/pci/pci-stub.c         |  27 +++++++++++++
 include/hw/i386/pc.h      |  12 ------
 include/hw/i386/x86.h     |  13 ++++++
 roms/SLOF                 |   2 +-
 target/i386/kvm.c         |  11 ++++-
 10 files changed, 166 insertions(+), 120 deletions(-)

-- 
1.8.3.1


