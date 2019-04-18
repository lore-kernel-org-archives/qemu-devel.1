Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE09C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 04:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9932183E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 04:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x1fbTxBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9932183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35251 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGyJn-0002nP-N4
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 00:06:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1hGyIV-00021r-75
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1hGyIS-0001q1-Da
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:05:15 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44243)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1hGyIS-0001mF-7W
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:05:12 -0400
Received: by mail-pg1-x541.google.com with SMTP id i2so530494pgj.11
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 21:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=ipCTowXe446W73k2Vwrsnaf0r5pLUqeNQXv5HiqvNbk=;
	b=x1fbTxBp2La9EgVubLuqRwSWaJwdPyG2p+Eimg/8XdAFB7iFLkDn3tcNgfu2dUZprF
	N+IWduh4UUNW3BKCE2tYSKZkG2dvMIoMAUwxXZWtc/I//xV8/ytNpX4Y3I7+P9d+qt9+
	Pc1R53vDtFB+ab3NbN0TlmUKSSBtALeurPhHCFuAsDFyYH1M5hxXihzZ1UR5XIvLmnsd
	n78bsXLbJoULmzBPI+p2xyGJBLbyzFxXe+cWB6j7vO6K3U79zGjI9fBSM7hTFUSLhNNi
	RvJUYROBVt1B6eyLljPrJeQq8E95T7Yr29joF5yOI2z0TCYs8Bzin6u2LWDH7hTWH7xr
	fwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=ipCTowXe446W73k2Vwrsnaf0r5pLUqeNQXv5HiqvNbk=;
	b=Q69zLR6ZKWw4cU31vs2vOYTT4Tw3X+017YoNcxJZeFdJs7O/qribmCc7vN6jGf0mLm
	hZxEW4hK2CrUPM5qrxiMY5wY8ekAhnbsnGPZD6PVwk9d7h9Gtuh8NLMFFYTJ0mGUvhx4
	LvTR6E+fnI2Vr7kIyJBy+jXk8QOJIReyiZY9Zvi94mKqbFIHkEYtTFXDIqXNFkhmU0PP
	DbWhO+GOeoUwp2M00ru82SppZ4rklZUIO+BvZtX6cKyTnPs3qPJrdBIu2mqFOpwDyPxm
	lKYMwPM3S8zNNOsBSTfpYYFwcc9k4VN6la/hyXj1eH0+mbOPNb03Z0YoMxhMTn+0cO22
	JxpQ==
X-Gm-Message-State: APjAAAUMq+qNprHNcQ+rtKbMvm/qW09gO3aVnOY6nMZbf/HaXJnDmEEW
	hrv19of40Kh2t111BoJZ8Fo9gw==
X-Google-Smtp-Source: APXvYqxccMhP2WAe+QsEOWcLABKSfXKdYHIY80NfHX9ki+Yx8IMoiIpXhByrlnT9dB4xxo/qqLJWyg==
X-Received: by 2002:a63:5c56:: with SMTP id n22mr74890116pgm.108.1555560309080;
	Wed, 17 Apr 2019 21:05:09 -0700 (PDT)
Received: from localhost.localdomain ([38.106.11.25])
	by smtp.gmail.com with ESMTPSA id h8sm910688pfo.149.2019.04.17.21.05.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 17 Apr 2019 21:05:08 -0700 (PDT)
From: Hongbo Zhang <hongbo.zhang@linaro.org>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Date: Thu, 18 Apr 2019 12:04:49 +0800
Message-Id: <1555560291-3415-1-git-send-email-hongbo.zhang@linaro.org>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v7 0/2] Add Arm SBSA Reference Machine
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>, radoslaw.biernacki@linaro.org,
	leif.lindholm@linaro.org, ard.biesheuvel@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190418040449.TT-QMHW4afOd_uQe2ykzpJAW5uWCIitXKlHmA2--T2Q@z>

For the Aarch64, there is one machine 'virt', it is primarily meant to
run on KVM and execute virtualization workloads, but we need an
environment as faithful as possible to physical hardware,  to support
firmware and OS development for pysical Aarch64 machines.

This machine comes with:
 - Re-designed memory map.
 - CPU cortex-a57.
 - EL2 and EL3 enabled.
 - GIC version 3.
 - System bus AHCI controller.
 - System bus XHCI controller.
 - CDROM and hard disc on AHCI bus.
 - E1000E ethernet card on PCIE bus.
 - VGA display adaptor on PCIE bus.
 - Only minimal device tree nodes.
And without:
 - virtio deivces.
 - fw_cfg device.
 - ACPI tables.

Arm Trusted Firmware and UEFI porting to this are done accordingly, and
it should supply ACPI tables to load OS, the minimal device tree nodes
supplied from this platform are only to pass the dynamic info reflecting
command line input to firmware, not for loading OS.

v7 changes:
 - edit memory map for PCIE slightly
 - add another secure UART which can be used for RAS and MM from EL0.

v6 changes:
 - rebased to the latest QEMU tree
 - rechecked all the header files included
 - added the newly introduced system bus EHCI controller
 - removed the machine_done callback due to commit 5614ca80
 - updated block comments styles according to checkpatch.pl
 - use Kconfig to add new file
 - use private SBSA* types defination instead of VIRT* in virt.h
   since nobody else using them so they are in the .c file instead
   of a new .h file

v5 changes:
 - removed more lines derived from virt.c
 - designed a new memory map
 - splitted former one patch into two for easier review
 - cancled previous EHCI and new HXCI coming later separately

V4 changes:
 - rebased to v3.0.0
 - removed timer, uart, rtc, *hci device tree nodes
   (others were removerd in v3)
 - other minore codes clean up, mainly unsed header files, comments etc.

V3 changes:
 - rename the platform 'sbsa-ref'
 - move all the codes to a separate file sbsa-ref.c
 - remove paravirtualized fw_cfg device
 - do not supply ACPI tables, since firmware will do it
 - supply only necessary DT nodes
 - and other minor code clean up

Hongbo Zhang (2):
  hw/arm: Add arm SBSA reference machine, skeleton part
  hw/arm: Add arm SBSA reference machine, devices part

 default-configs/arm-softmmu.mak |   1 +
 hw/arm/Kconfig                  |   3 +
 hw/arm/Makefile.objs            |   1 +
 hw/arm/sbsa-ref.c               | 757 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 762 insertions(+)
 create mode 100644 hw/arm/sbsa-ref.c

-- 
2.7.4


