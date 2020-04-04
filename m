Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FBEC2BA16
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 08:30:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A070F206F5
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 08:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwmXuLVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A070F206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKeBz-0006xK-Mx
	for qemu-devel@archiver.kernel.org; Sat, 04 Apr 2020 04:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arilou@gmail.com>) id 1jKeB6-0005j7-R6
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 04:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arilou@gmail.com>) id 1jKeB5-0001tI-G7
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 04:29:20 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54820)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <arilou@gmail.com>) id 1jKeB5-0001sE-86
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 04:29:19 -0400
Received: by mail-wm1-x342.google.com with SMTP id h2so1455939wmb.4
 for <qemu-devel@nongnu.org>; Sat, 04 Apr 2020 01:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Srf7i30Ku8smhkHYNpy3IFa6BKpkll1EVMIgxQH4lSc=;
 b=MwmXuLVMeuSeh6y91ALypxjigkpq7Y6PsMViaUNm1hY0VASQxtTBWaH62S6y9DBHOJ
 Ca20fQLRm9O50jxVdoNX7/FnjPB+ABkg2GmFRzgqJgOM4bCBadB8kDDrv6et6Jdr1dZS
 4ZtySwmXg19OMTbsDmZ+gle7yxenRxx3+ke0dzzOrq/7d8QyA8m/GvJnHZe2WxqcL+Rz
 RwpCbD7lylD6HVM9XO3TKhmUPkV0RQrU/qcWhLQhiW9T3Rq0X9xg+wwuqztFesBGsxej
 sb4EFd/+cqE1GRmuoescSQvfs0DMoN1Agu/wrUKSxyQVqm6Ws/sKFsT7RNUiFSYopniR
 yuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Srf7i30Ku8smhkHYNpy3IFa6BKpkll1EVMIgxQH4lSc=;
 b=Hic4VO/RLd6A4XzoBazHqgyRGW49K7rQDeOH4EMeL2eiPQK64dz6sQ5H4QbdUa0pq5
 q1ZacsVQydPpQaSygFc4AmarijRt36as1nf7VUVpgUW7z2CiJeDuoM+Vn4supGwUEd8+
 VAvLmdGth8Osl7cCLuNFChO1EJdtc/dKEvnoIRZ8e2uBizz1S6xSn6cEY6m0ZNY7dGVQ
 pgpOcYGcJDoo9fC/TSc3GtfUNfRaubjBGVmgrVvtUKhLfyC7eXwtqIwRZArQBPn4WZkb
 TnR9wY4JqB2TwyM3csqRSmZZ3HKIMXo/bf20rDKt42/6m5dHNMVGyghHn3YBofh8unC1
 3RaA==
X-Gm-Message-State: AGi0Pua1jrhVPVikFF1Cg3w3uYWJA2McK4/f0G4nzxPsIS8sGSM3vL4o
 EQWoIQ4UWNjoklbaA/YYi18Wna9Uhfxtsg==
X-Google-Smtp-Source: APiQypKFn0uuZFlwmzJGmxtlot02mblcChAJtWovyTtlLPiTfNtgc8KHlWipt4PIYmUU79yrQps6Rg==
X-Received: by 2002:a1c:5410:: with SMTP id i16mr12667153wmb.150.1585988957489; 
 Sat, 04 Apr 2020 01:29:17 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-155-40.inter.net.il. [84.229.155.40])
 by smtp.gmail.com with ESMTPSA id
 a10sm15884778wrm.87.2020.04.04.01.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2020 01:29:16 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/7] hyperv: VMBus implementation
Date: Sat,  4 Apr 2020 11:28:53 +0300
Message-Id: <20200404082900.33711-1-arilou@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: mail@maciej.szmigiero.name, eyakovlev@virtuozzo.com, ehabkost@redhat.com,
 rvkagan@gmail.com, liran.alon@oracle.com, pbonzini@redhat.com,
 vkuznets@redhat.com, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a rebase of the old patchset from Roman for HyperV VMBus
implementation.

How to use:
-device vmbus-bridge

Later on new paravirtualized devices can be implemented on top of it
(Network/SCSI/etc.)

VMBus is a collection of technologies.  At its lowest layer, it's a message
passing and signaling mechanism, allowing efficient passing of messages to and
from guest VMs.  A layer higher, it's a mechanism for defining channels of
communication, where each channel is tagged with a type (which implies a
protocol) and a instance ID.  A layer higher than that, it's a bus driver,
serving as the basis of device enumeration within a VM, where a channel can
optionally be exposed as a paravirtual device.  When a server-side (paravirtual
back-end) component wishes to offer a channel to a guest VM, it does so by
specifying a channel type, a mode, and an instance ID.  VMBus then exposes this
in the guest.

More information about VMBus can be found in the file
vmbuskernelmodeclientlibapi.h in Microsoft's WDK.

Jon Doron (7):
  hyperv: expose API to determine if synic is enabled
  hyperv: SControl is optional to enable SynIc
  vmbus: add vmbus protocol definitions
  vmbus: vmbus implementation
  i386:pc: whitelist dynamic vmbus-bridge
  i386: Hyper-V VMBus ACPI DSDT entry
  vmbus: add infrastructure to save/load vmbus requests

 Makefile.objs                    |    1 +
 hw/hyperv/Kconfig                |    5 +
 hw/hyperv/Makefile.objs          |    1 +
 hw/hyperv/hyperv.c               |  250 ++-
 hw/hyperv/trace-events           |   18 +
 hw/hyperv/vmbus.c                | 2778 ++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c             |   43 +
 hw/i386/pc_piix.c                |    2 +
 hw/i386/pc_q35.c                 |    2 +
 include/hw/hyperv/hyperv.h       |    3 +
 include/hw/hyperv/vmbus-bridge.h |   35 +
 include/hw/hyperv/vmbus-proto.h  |  222 +++
 include/hw/hyperv/vmbus.h        |  230 +++
 target/i386/hyperv.c             |    2 +
 14 files changed, 3510 insertions(+), 82 deletions(-)
 create mode 100644 hw/hyperv/trace-events
 create mode 100644 hw/hyperv/vmbus.c
 create mode 100644 include/hw/hyperv/vmbus-bridge.h
 create mode 100644 include/hw/hyperv/vmbus-proto.h
 create mode 100644 include/hw/hyperv/vmbus.h

-- 
2.24.1


