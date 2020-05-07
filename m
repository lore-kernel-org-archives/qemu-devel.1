Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8456AC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:24:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D9BF207DD
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tA4kRQCA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9BF207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWiNh-0007CF-GD
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 11:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jWiIA-0006qg-0Q
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:18:30 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45919)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jWiI7-0002a7-Qw
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:18:29 -0400
Received: by mail-wr1-x444.google.com with SMTP id v12so5538687wrp.12
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 08:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=vioako13Dvzx/Jm/iy/nxXyf/pJdnFia47obSP+g2Vw=;
 b=tA4kRQCAuxDZeQ/ikR0O6QGZBanbZtMM9KaJjzSKpMlU2PD5pMJY39HtK8G66EnBD+
 2HZ7ncr8G9ZCcHwE1nrz/FA77U1fB+/FHXDZo3ukj3eJUtGyTc7N0b2IHRp6QIUPXMmx
 l6+rXcmMBM4nx7t0qtSzpex2zDuDgyxx/6tlOhfgAXvYOnpumNwv+lrcMOUCdOjNOtUa
 BwV3qbqkAL6lciNubpcgeO9R9VAZTuviy3R0wxnwm2OYRa2CJCKBVQ/j97BNM0DTvVjv
 mVSL6XMjbttHXFQOvShL29u6aOm7M5SzZ4AApCSxxRI6nRtcADJ+rus6MMP7FGJ4GBg/
 Jyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vioako13Dvzx/Jm/iy/nxXyf/pJdnFia47obSP+g2Vw=;
 b=rgZCEUQWiBu2jPCljzbfbDMXLDPMtH5zH0iULJilhfkdMkkkERmRbdB9VnaysCR1Kd
 nk+AzASLM8Gger2sc2xNUVEL6Q0sTW3UwzLfDLruWKC77+SyTviv45Y87Ec5X/p027r1
 XY2rtBjfkXLHoiV++GCKC8sLn1rem0/Jep5Wz4yeMSomTlLErq7spMU43VguThahh2KY
 HKSU/Blb1LN05sZwpsEp6BtFWP9OrLyT+r6YUsqaqBaueBKC35KWXL9FrcFmxJ9wWhsA
 lpPmwgP5V+rMkmOaL+tpfXB0CHJyFqB0P3Y0/YAEeqxxnnUgSeD4k11mz1PF6wSdao4K
 JrHQ==
X-Gm-Message-State: AGi0PuankkKQlviR30ib9td7fhSGgGFPoPXC2j/DU6rbro12YFEanBuD
 Z+9tNUgxUNHid/z2M+89liAdIg==
X-Google-Smtp-Source: APiQypIakWemzGJbPkWvjtKSci7YHJ9zL6m64cx8ZBIGzfq+7GhpNTmm/T165OmBZxecT5lGVRHddQ==
X-Received: by 2002:adf:f041:: with SMTP id t1mr15994767wro.346.1588864706413; 
 Thu, 07 May 2020 08:18:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q74sm961246wme.14.2020.05.07.08.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 08:18:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 3/5] docs/system: Document Arm Versatile Express boards
Date: Thu,  7 May 2020 16:18:17 +0100
Message-Id: <20200507151819.28444-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200507151819.28444-1-peter.maydell@linaro.org>
References: <20200507151819.28444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
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
index d1196cbe01c..4779293d731 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -73,6 +73,7 @@ undocumented; you can get a complete list by running
    arm/integratorcp
    arm/realview
    arm/versatile
+   arm/vexpress
    arm/musicpal
    arm/nseries
    arm/orangepi
diff --git a/MAINTAINERS b/MAINTAINERS
index 1f84e3ae2c6..74cff1c3818 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -826,6 +826,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/vexpress.c
+F: docs/system/arm/vexpress.rst
 
 Versatile PB
 M: Peter Maydell <peter.maydell@linaro.org>
-- 
2.20.1


