Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B65C54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:36:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6DD820700
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjWCgy7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6DD820700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRxZc-00065H-PW
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 08:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arilou@gmail.com>) id 1jRxXq-0003Ug-Pc
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <arilou@gmail.com>) id 1jRxXq-0003cV-84
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:35:02 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34623)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jRxXp-0003SW-GI
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:35:01 -0400
Received: by mail-wr1-x444.google.com with SMTP id j1so10610155wrt.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 05:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AYduD8BFucHITVXns6NONWWuT+ECorIb4Ylboy8K0CI=;
 b=rjWCgy7sMtWspYq2ap2B3w3O32Ao/7lgbJHtMq9KZPAU3MuvvUkT+wHXKljxfzzDIr
 4mCpu9M5cytMOx/DCqJbLFBrdgqY8LjyhDqOODYD0BTh95/3918riLlTR8xehbz2EolJ
 5M8lq/f0DKtEAMhst1kgNo/qYZ3wq9FIOOuoBvi/RAg0x/R/Q0NGqByPAAzwC9s1S8dK
 37Ep2bSwyFfqtgeM2Axfh3X6hKKjzIG8s7jk2mZQrPv2lnmK4JhDRKPYqqQAG3hw8uqI
 I23ag1gF//jVFyqctIkLwPB+ioFwrRe8LIwBvxPxeivBz4rID92Sb7wYJqAWPwJooBJv
 +iSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AYduD8BFucHITVXns6NONWWuT+ECorIb4Ylboy8K0CI=;
 b=ZVLf1IfwNwiNC+rHzBh7EE1LFQoLh8cFGD08d8Bz3f2BvhuRP599lsJHr3XcgArDV0
 A4G0PN5QGn3xhC5iW7yml/woKB10FGhQzBZpkJW0fVKVjYZxAONXWOCjPEjamoUyqRjY
 fG00FlxVDAiG82X83PFrBfv0abcUYhvA/As4aGtmgY9iwWqOZoTs8JGVAfFKLNkVsUD7
 v0OzioUwX4eTPl0xj7CJ3U6VA+mtbDuIg9rHPEBKGafppOScupEhLb8OB0km7Jm4pvp0
 S+hKF/om1nMLvqQvRyK+XRrgNK/gXbmI+rZKhP9/XCbMoYHoXo4bZd4PguaRK3OR/V6N
 d/hA==
X-Gm-Message-State: AGi0PubQFIq3YkDdR7mUIKuEgGeUUPXxc14rLPJiwi+qZ5Mt9jq2wWS9
 +ZthbX8KCdrKPfEAaT/fBs0yPEKsR0Jzvw==
X-Google-Smtp-Source: APiQypIGWNzGQfERwd0pvyHSbg6Ef1zaboFZ6fFaD8faxgd+Eoh8zhVyNMzyZw5LAUGe46YzwnVyKw==
X-Received: by 2002:adf:e9cb:: with SMTP id l11mr10706492wrn.24.1587731699001; 
 Fri, 24 Apr 2020 05:34:59 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
 by smtp.gmail.com with ESMTPSA id
 91sm8462859wra.37.2020.04.24.05.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 05:34:58 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/6] hyperv: VMBus implementation
Date: Fri, 24 Apr 2020 15:34:38 +0300
Message-Id: <20200424123444.3481728-1-arilou@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=arilou@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::444
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

v4:
Decided to ditch the patch that envolves handling of EOM as there is
still a discussion going on with it in the KVM mailing list.

v3:
Fixed an error asan

v2:
Rebased on top of latest patchset from Roman and Maciej

Jon Doron (6):
  hyperv: expose API to determine if synic is enabled
  vmbus: add vmbus protocol definitions
  vmbus: vmbus implementation
  i386:pc: whitelist dynamic vmbus-bridge
  i386: Hyper-V VMBus ACPI DSDT entry
  vmbus: add infrastructure to save/load vmbus requests

 Makefile.objs                    |    1 +
 hw/hyperv/Kconfig                |    5 +
 hw/hyperv/Makefile.objs          |    1 +
 hw/hyperv/hyperv.c               |    8 +
 hw/hyperv/trace-events           |   18 +
 hw/hyperv/vmbus.c                | 2778 ++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c             |   43 +
 hw/i386/pc_piix.c                |    2 +
 hw/i386/pc_q35.c                 |    2 +
 include/hw/hyperv/hyperv.h       |    1 +
 include/hw/hyperv/vmbus-bridge.h |   35 +
 include/hw/hyperv/vmbus-proto.h  |  222 +++
 include/hw/hyperv/vmbus.h        |  230 +++
 13 files changed, 3346 insertions(+)
 create mode 100644 hw/hyperv/trace-events
 create mode 100644 hw/hyperv/vmbus.c
 create mode 100644 include/hw/hyperv/vmbus-bridge.h
 create mode 100644 include/hw/hyperv/vmbus-proto.h
 create mode 100644 include/hw/hyperv/vmbus.h

-- 
2.24.1


