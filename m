Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22C8C2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 05:53:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E76520747
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 05:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnO82JAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E76520747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLhAX-0005j7-Kc
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 01:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arilou@gmail.com>) id 1jLh9j-0004Y8-2Z
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 01:52:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arilou@gmail.com>) id 1jLh9i-0002UF-2S
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 01:52:15 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41950)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <arilou@gmail.com>) id 1jLh9h-0002To-Su
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 01:52:14 -0400
Received: by mail-wr1-x443.google.com with SMTP id h9so2370125wrc.8
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 22:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Q15iIjtIW/s1mxdsOFedtcSl+7MWn1XWqmIP6Tyxwyo=;
 b=PnO82JAUmBjFagfKmdbkZ6map3GbzkKLPg7+6+BJd5t75nL9/L5mktOs0bilwK8e0Y
 i/uVjI48GEvolEF7bwp4GyaXhzUtJIDEM8XSgnh4HYryt6yNjxWtfGAOURdb0G2nftGm
 3kIuxb/nEjozioHIguTDHQvaufwX4R6ef+OrZgRwqAsRtc/0U4qrs4EyYz/e71dAFzvP
 6R3TJNiHbAT16siL1kxVukBA0+ek/ucIzOawD9q5fUEOfmYLEQdo20TJ/Etq13Vg44OH
 i3ikRtQK9IAS7at9+thH1sn9Q7pwybf77vmwsbIL4AAzhYo90wFxUL+gb414wD12kLFs
 4v6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Q15iIjtIW/s1mxdsOFedtcSl+7MWn1XWqmIP6Tyxwyo=;
 b=iiqkLbIg6Lq/fZiVi6+RfQejksCFlQYDpC00APNLiE+B5Yu/Pq8XTpMCbqq+QqcUtn
 +HqbqnI+zM5lE7X6wHpRvdD1pAR852fH48duXw1y1FtVR6ocr3CG+kYp2Ry13cKlrhm5
 umTA50E/oIjwPyiiE3xLfFzsfsheUAknrdKLfq8swMlsPsgBr10fnQ8vdQXWqD11xGmU
 3/xfwVOR03BlaZqPRFR7h19qJDZ3ThbK7TSJPQAhQbfjHl0xcDtrb3j8jP00SYmW/K3w
 ikO3OdaaWFglVnGdx+tm0XbeXUDcti7vJqOP38uUhB83rsOLOyMkTWAXhL1J1QJWoA/1
 HONA==
X-Gm-Message-State: AGi0PubakLaI/Y3PqoJPAveouWRYor76YopzuFqFLmwP74AmxFHDmRSr
 sgfza5i1uLOlz/NtdIKAG4TxsXoQa/Q=
X-Google-Smtp-Source: APiQypJxGSt+sX16XE/N2jeiOLPN6Ta4xsnx8rfNdbqmoSv8kAHDBO7iW/Gr0fh751ahC10oUehgEQ==
X-Received: by 2002:a5d:6143:: with SMTP id y3mr755365wrt.242.1586238732499;
 Mon, 06 Apr 2020 22:52:12 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-155-55.inter.net.il. [84.229.155.55])
 by smtp.gmail.com with ESMTPSA id
 n11sm32271007wrg.72.2020.04.06.22.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 22:52:11 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/7] hyperv: VMBus implementation
Date: Tue,  7 Apr 2020 08:51:49 +0300
Message-Id: <20200407055156.137249-1-arilou@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

v3:
Fixed an error asan

v2:
Rebased on top of latest patchset from Roman and Maciej

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


