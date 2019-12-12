Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74875C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:18:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4684A214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="do9EW8VU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4684A214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifT2O-0002TI-R6
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:18:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifSH9-0005DQ-SG
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:29:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifSH8-0003vj-Ij
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:29:19 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35278)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifSH8-0003uG-C1
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:29:18 -0500
Received: by mail-wm1-x343.google.com with SMTP id p17so3476263wmb.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 09:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=zGrhjuKLKINlntV85KOX8PlaXtCg/M0M2UPFX50JWfc=;
 b=do9EW8VUyvlaMdMe3sxKVqhjF8PI5Z23x2E9li/IVUVebukJ7X741mph+5E/twuWEu
 16jjgXq/f4OFehXBny+XpSely36PERQwQaXd8kFIXjxX/CbsTAmLoGOIM6QBXTJ4i6sd
 lxQvzbbF3wv/mfFF6i4pTYH9Y1bLHx13bNzl6GLqAL+2K8Rj8xDHKyWlziNz3PSDvJZ9
 YracWj1gFljKprl2QYMSkznURoFoFUlAdwS1jh78wRyMwPIo2kXn30qRJNhPlQu6dGwo
 XCzX2zS2chUvba7n6bf6H92ocgpqXOYOAvhAfMRNNrOa3ohOb3UFqpNvvDh6BGWgYwsG
 GPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=zGrhjuKLKINlntV85KOX8PlaXtCg/M0M2UPFX50JWfc=;
 b=Xr5JymAzpsSjED8kIiJ12ucl+7EaIiBFRTxYBw3lnSnU+JOuXZP/NXGwC3I9H1UmYb
 RYx5lEynaynfKRiQzbPot+1E5b/h74OV3ZPnxqdYUWWEoxLMtHWNuuCxxuI5Q34BuZf0
 4YlHzD0rpSaTvBu66EeGmlv2BDSzpqrWxqTjL4xjOKEMnljWOgCwVDlH084oCrMaaCId
 KmpK17v9MieNa6K6OIpAs9l1QHOuTSZpKE5c3+ZBqpLbTjlETYSAujiTyFcRbMdcbyZR
 gIG8X2GurwJdiJ9RWEX7o3amZlMBUHP6bKnR5jFdYA/9IZCSkMouPOrEuTgnDJWOEnMc
 dvWw==
X-Gm-Message-State: APjAAAXh1wP7apETcIbQWboMrKNhLIF0rhr1drVQQnJvh7hQZrPn6Kb6
 JBWd9gRZ4EG879WJKqkr0MXZ3pYG
X-Google-Smtp-Source: APXvYqzbPJhLAXrizTNazXFAPHse/mT2gHY2IjHxctscYk1/Tf1m5cTarqmZKC/gcK7CAN8QOnfi8Q==
X-Received: by 2002:a7b:c407:: with SMTP id k7mr8175212wmi.46.1576171756712;
 Thu, 12 Dec 2019 09:29:16 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id 2sm6810130wrq.31.2019.12.12.09.29.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 09:29:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/8] x86: allow building without PC machine types
Date: Thu, 12 Dec 2019 18:29:06 +0100
Message-Id: <1576171754-45138-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

In fact I went one step further and ensured that microvm could build
without pc.h even. :)

Paolo

v1->v2: more thorough cleansing of pc.h (new patches 3/7/8) [Sergio]
	move SMM property to X86MachineState (patch 5) [Sergio]

Paolo Bonzini (8):
  i386: conditionally compile more files
  fw_cfg: allow building without other devices
  hw: replace hw/i386/pc.h with a header just for the i8259
  pci-stub: add more MSI functions
  x86: move SMM property to X86MachineState
  x86: move more x86-generic functions out of PC files
  acpi: move PC stubs out of stubs/
  pc: stubify x86 iommu

 hw/acpi/Makefile.objs                              |   2 +-
 .../pc_madt_cpu_entry.c => hw/acpi/acpi-x86-stub.c |   0
 hw/alpha/alpha_sys.h                               |   3 +-
 hw/alpha/dp264.c                                   |   1 +
 hw/hppa/hppa_sys.h                                 |   3 +-
 hw/hppa/machine.c                                  |   1 +
 hw/i386/Kconfig                                    |   6 +
 hw/i386/Makefile.objs                              |   9 +-
 hw/i386/acpi-build.c                               |   1 +
 hw/i386/fw_cfg.c                                   |   8 +-
 hw/i386/fw_cfg.h                                   |   2 +
 hw/i386/kvm/Makefile.objs                          |   6 +-
 hw/i386/kvm/i8259.c                                |   1 +
 hw/i386/kvm/ioapic.c                               |   2 +-
 hw/i386/microvm.c                                  |   4 +-
 hw/i386/pc.c                                       | 153 +--------------------
 hw/i386/pc_piix.c                                  |   6 +-
 hw/i386/pc_q35.c                                   |   2 +-
 hw/i386/x86-iommu-stub.c                           |  34 +++++
 hw/i386/x86-iommu.c                                |   1 -
 hw/i386/x86.c                                      | 151 +++++++++++++++++++-
 hw/input/pckbd.c                                   |   1 -
 hw/intc/Kconfig                                    |   2 +
 hw/intc/apic.c                                     |   2 +-
 hw/intc/i8259.c                                    |   2 +-
 hw/intc/i8259_common.c                             |   2 +-
 hw/intc/ioapic.c                                   |   3 +-
 hw/isa/i82378.c                                    |   2 +-
 hw/isa/lpc_ich9.c                                  |   1 -
 hw/isa/piix4.c                                     |   2 +-
 hw/mips/gt64xxx_pci.c                              |   2 +-
 hw/mips/mips_fulong2e.c                            |   2 +-
 hw/mips/mips_jazz.c                                |   2 +-
 hw/mips/mips_r4k.c                                 |   2 +-
 hw/pci-host/bonito.c                               |   1 -
 hw/pci-host/prep.c                                 |   2 +-
 hw/pci/pci-stub.c                                  |  27 ++++
 include/hw/i386/pc.h                               |  31 -----
 include/hw/i386/x86.h                              |  23 ++++
 include/hw/intc/i8259.h                            |  12 ++
 include/hw/isa/i8259_internal.h                    |   2 +-
 stubs/Makefile.objs                                |   1 -
 target/i386/kvm.c                                  |   5 +-
 target/i386/machine.c                              |   2 +-
 target/i386/monitor.c                              |   1 -
 45 files changed, 307 insertions(+), 221 deletions(-)
 rename stubs/pc_madt_cpu_entry.c => hw/acpi/acpi-x86-stub.c (100%)
 create mode 100644 hw/i386/x86-iommu-stub.c
 create mode 100644 include/hw/intc/i8259.h

-- 
1.8.3.1


