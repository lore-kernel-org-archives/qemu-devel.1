Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F2BC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:17:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 869CF207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ve643H7V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869CF207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqhC-0004PD-Jm
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqg1-00021K-Ba
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:21 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43146)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqg0-0000P9-89
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:21 -0400
Received: by mail-wr1-x443.google.com with SMTP id i15so7731385wrx.10
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=CcIe3RQsnYbg8g+NInxK1LG4Wd7si9pCUTbnuZRw2Kg=;
 b=ve643H7V7zDSjRdar8kSOyH7SUt/JzrJN8nfsYVm8H5yIsVCL7xC4jeog31S2bRNqb
 jBqdMT4qlJ4VY9rga7RP/NTyRTjGwwKGuZ9wQ9w3KzDwKc6ctsF+6rvn4AHrn8EJTcVh
 2zXq7DUt3MrgsYMmBdzbcF5htSo9R6s+E56Gx1oRA9GHAMwByqIZSs1TVP8E7nJLP3Sy
 mRA2nuXxqzd66JtPewzMpuDqcM4UyxS0SZ0idB++7nKDx3qEk4j3hGGzxcg3fqc6jQsl
 BU48clPzL301O889DYV+DPWvD7eN9+WjuZXZyqNuyTM7F0gQUrVke+6jtUeFqk3EBNvp
 GO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CcIe3RQsnYbg8g+NInxK1LG4Wd7si9pCUTbnuZRw2Kg=;
 b=f8MP36Uy38APvAu7jba8fd6ya46LliHjWhBn4ktNMxbVmzif3zV8Lz2oHOoGo4fyGl
 vaiQnoQNQJYGJnsJxFi6Qj41oua5j0w972MYdvlWfkJ7uitoX9hl8N01gut8xunO9Ihh
 wsikk875ABkOiYWGxbmidDKttxPPrNFgBatiEd46iMVNAWn/FLdAYw3eN2Q0gEywAZEL
 hLEK7csZt4fBYt93yFKL6cKXSHx2Rtrh6yFUyZf4GTvpgaAKL7cL5iKodNgKKwXUz4n7
 rRnyO+200nvju0wA8ebAXEccsz1adNfYcVSr721nmzSUtDtBo1PEfqMIBuVjccVbaVtm
 9jnw==
X-Gm-Message-State: AOAM533WsJhs6nNcjQubBh4+P4qcAfoC4n/dWopzrh+ZdaR/QvIZ1g09
 tJSOHJeJss9ydDDAzWA9M3odmfnodWkMwA==
X-Google-Smtp-Source: ABdhPJyOxlZbKJ6UhIi86q3LQVZK4qrt0A5FPf7UIhAUWbxjA3JWATjUcfzzbN/8ZEII85FRw94GSg==
X-Received: by 2002:adf:f601:: with SMTP id t1mr87334wrp.207.1590088578531;
 Thu, 21 May 2020 12:16:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z124sm7335100wmg.20.2020.05.21.12.16.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:16:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/29] docs/system: Document Arm Versatile Express boards
Date: Thu, 21 May 2020 20:15:45 +0100
Message-Id: <20200521191610.10941-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521191610.10941-1-peter.maydell@linaro.org>
References: <20200521191610.10941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Provide a minimal documentation of the Versatile Express boards
(vexpress-a9, vexpress-a15).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200507151819.28444-4-peter.maydell@linaro.org
---
 docs/system/arm/vexpress.rst | 60 ++++++++++++++++++++++++++++++++++++
 docs/system/target-arm.rst   |  1 +
 MAINTAINERS                  |  1 +
 3 files changed, 62 insertions(+)
 create mode 100644 docs/system/arm/vexpress.rst

diff --git a/docs/system/arm/vexpress.rst b/docs/system/arm/vexpress.rst
new file mode 100644
index 00000000000..7f1bcbef078
--- /dev/null
+++ b/docs/system/arm/vexpress.rst
@@ -0,0 +1,60 @@
+Arm Versatile Express boards (``vexpress-a9``, ``vexpress-a15``)
+================================================================
+
+QEMU models two variants of the Arm Versatile Express development
+board family:
+
+- ``vexpress-a9`` models the combination of the Versatile Express
+  motherboard and the CoreTile Express A9x4 daughterboard
+- ``vexpress-a15`` models the combination of the Versatile Express
+  motherboard and the CoreTile Express A15x2 daughterboard
+
+Note that as this hardware does not have PCI, IDE or SCSI,
+the only available storage option is emulated SD card.
+
+Implemented devices:
+
+- PL041 audio
+- PL181 SD controller
+- PL050 keyboard and mouse
+- PL011 UARTs
+- SP804 timers
+- I2C controller
+- PL031 RTC
+- PL111 LCD display controller
+- Flash memory
+- LAN9118 ethernet
+
+Unimplemented devices:
+
+- SP810 system control block
+- PCI-express
+- USB controller (Philips ISP1761)
+- Local DAP ROM
+- CoreSight interfaces
+- PL301 AXI interconnect
+- SCC
+- System counter
+- HDLCD controller (``vexpress-a15``)
+- SP805 watchdog
+- PL341 dynamic memory controller
+- DMA330 DMA controller
+- PL354 static memory controller
+- BP147 TrustZone Protection Controller
+- TrustZone Address Space Controller
+
+Other differences between the hardware and the QEMU model:
+
+- QEMU will default to creating one CPU unless you pass a different
+  ``-smp`` argument
+- QEMU allows the amount of RAM provided to be specified with the
+  ``-m`` argument
+- QEMU defaults to providing a CPU which does not provide either
+  TrustZone or the Virtualization Extensions: if you want these you
+  must enable them with ``-machine secure=on`` and ``-machine
+  virtualization=on``
+- QEMU provides 4 virtio-mmio virtio transports; these start at
+  address ``0x10013000`` for ``vexpress-a9`` and at ``0x1c130000`` for
+  ``vexpress-a15``, and have IRQs from 40 upwards. If a dtb is
+  provided on the command line then QEMU will edit it to include
+  suitable entries describing these transports for the guest.
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index d459efb3d20..1c759aa1a08 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -78,6 +78,7 @@ undocumented; you can get a complete list by running
    arm/integratorcp
    arm/realview
    arm/versatile
+   arm/vexpress
    arm/musicpal
    arm/nseries
    arm/orangepi
diff --git a/MAINTAINERS b/MAINTAINERS
index 1e006c98fab..6a9280c1b03 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -828,6 +828,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/vexpress.c
+F: docs/system/arm/vexpress.rst
 
 Versatile PB
 M: Peter Maydell <peter.maydell@linaro.org>
-- 
2.20.1


