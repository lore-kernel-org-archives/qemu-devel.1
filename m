Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3608C1975A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 22:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D522072D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 22:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcTOxIH6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D522072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG95k-0005o8-9r
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 18:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jG94o-00059F-Rk
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 18:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pauldzim@gmail.com>) id 1jG94n-0001cF-GT
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 18:28:14 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44530)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pauldzim@gmail.com>) id 1jG94n-0001bz-9S
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 18:28:13 -0400
Received: by mail-pl1-x641.google.com with SMTP id h11so5036749plr.11
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 15:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=NDHJSzP5NOcwT1NTKIfMITBQqNyugeG5p2lPR/cvk/A=;
 b=OcTOxIH6zgDAHk1oOKyNgY04KNvq4cDpxB3VKIhKyja5Y/hxOMT2awxbK8zRMQDPSz
 XpHhkVt1WudqCjFCpza2fH5DV7+i4gHN14iTwuY7pfmDHAJWAmXTbz2/thz/YPhd1Dji
 B1c+7DEF07aoF/Z16zHWuXeTMBwjnX0rioWmlsj0vQydusto5CmiVWim2qThfyG/Tfvk
 iPXEJd+V1gBdQD4QCy2oJQNt4mCAJlwKSCvBCBjN37Pkyw+z+H0ieiQfVh05JSmnhGSu
 rndhq77hU5zcNb+hGZbXY/mZgLouPJ3xtbiFPRAGrjiWbmQ/DrM/kdWQvge1BMDbQeJa
 Kc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=NDHJSzP5NOcwT1NTKIfMITBQqNyugeG5p2lPR/cvk/A=;
 b=fCA9xIKoY04tGRvDZFfK3zLN9nA7c9Iw4fpQHS9r96NgbWFWiPzLnc4xFBOe4zmhJs
 YWA7KxzY7JfJZhS9gZMLZ0K9Bp1C1AgPZk3uuIFxvPIj5Ds8S0Ukub2zyd8UaLzBcwZ+
 Z6HrnmZb2A1Akvia5YtbyVYEsKGx4QzESaF3mCZXe1TiNobiNOTddVHyXITZcNo1h9AQ
 KYI8gevv+P/gaz8FaM1c6j5e24vMWt//+yjGa09MHtqg5vgMBefdJWuKPJaBDV6QeIB0
 oHq2ZqD/pE3nt5zpkNd4MKCyTzXiotAyoBtYkeBOW9zpBwmOoEKWqLBqlm/QF/xGmEAk
 pjiw==
X-Gm-Message-State: ANhLgQ1i9DI+1weZdjLRI0qzc/DfQ+5tgeGL0EZ/VMp+ZV5Fq2sVF3Ft
 D/lKFoUgIbX5SswPzmHRQF4=
X-Google-Smtp-Source: ADFU+vu7shO1wAt0qaVz72bAH8yk+nE9payV1nRWqc1H+Eexzmd/L12+2C+40YXVeKHdndCodtIXZA==
X-Received: by 2002:a17:90b:24c:: with SMTP id
 fz12mr2110072pjb.85.1584916091741; 
 Sun, 22 Mar 2020 15:28:11 -0700 (PDT)
Received: from localhost.localdomain ([75.167.220.149])
 by smtp.gmail.com with ESMTPSA id e10sm11440315pfm.121.2020.03.22.15.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2020 15:28:11 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: kraxel@redhat.com
Subject: [PATCH 0/6] dwc-hsotg (aka dwc2) USB host contoller emulation
Date: Sun, 22 Mar 2020 15:27:20 -0700
Message-Id: <20200322222726.10244-1-pauldzim@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: peter.maydell@linaro.org, stefanha@gmail.com, qemu-devel@nongnu.org,
 Paul Zimmerman <pauldzim@gmail.com>, jsnow@redhat.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series adds emulation for the dwc-hsotg USB controller,
which is used on the Raspberry Pi 3 and earlier, as well as a number
of other development boards. The main benefit for Raspberry Pi is that
this enables networking on these boards, since the network adapter is
attached via USB.

The emulation is working quite well, I have tested with USB network,
mass storage, mouse, keyboard, and tablet. I have tested with the dwc2
driver in the upstream Linux kernel, and with the dwc-otg driver in the
Raspbian kernel. One remaining issue is that USB redirection does not
work, I tried connecting to a USB stick on the host, but the device
generates babble errors and does not work. I will continue to work on
this issue.

The patch series also includes a very basic emulation of the MPHI
device on the Raspberry Pi SOC, which provides the FIQ interrupt that
is used by the dwc-otg driver in the Raspbian kernel. But that driver
still does not work in full FIQ mode, so it is necessary to add a
parameter to the kernel command line ("dwc_otg.fiq_fsm_enable=0") to
make it work.

Some open questions:

1) I have used printf-based debug statements while developing the
   code, and have not implemented any tracing statements. I'm not
   sure if that is considered acceptable for new code?

2) I have imported the register description file from the Linux
   kernel. This file is licensed GPL-2 only, is this OK?

3) The emulation does not respect the max-packet size when
   transferring packets. Since the dwc-hsotg controller only has
   one root port, and the Qemu USB hub is only full-speed, that
   means every device connected has to run at full speed. That
   makes mass-storage devices in particular run very slowly. Using
   transfers greater than max-packet size alleviates this. Is this
   OK? I think the EHCI emulation does the same thing, since its
   transfers seem to run at greater than real world transfer rates.

4) I have only implemented host mode for now. Would there be any
   benefit to implementing gadget mode as well? It seems it could
   be useful to emulate gadget devices in Qemu, but I am not sure
   if Qemu currently offers any support for that?

Thanks for your time,
Paul

---

Paul Zimmerman (6):
  Add BCM2835 SOC MPHI emulation
  dwc-hsotg USB host controller register definitions
  dwc-hsotg USB host controller state definitions
  dwc-hsotg USB host controller emulation
  Add short-packet handling to usb-storage driver
  Wire in the dwc-hsotg USB host controller emulation

 hw/arm/bcm2835_peripherals.c         |   38 +-
 hw/misc/Makefile.objs                |    1 +
 hw/misc/bcm2835_mphi.c               |  215 ++++
 hw/usb/Kconfig                       |    5 +
 hw/usb/Makefile.objs                 |    1 +
 hw/usb/dev-storage.c                 |   15 +-
 hw/usb/hcd-dwc2.c                    | 1353 ++++++++++++++++++++++++++
 hw/usb/hcd-dwc2.h                    |  180 ++++
 include/hw/arm/bcm2835_peripherals.h |    5 +-
 include/hw/misc/bcm2835_mphi.h       |   50 +
 include/hw/usb/dwc2-regs.h           |  895 +++++++++++++++++
 11 files changed, 2755 insertions(+), 3 deletions(-)
 create mode 100644 hw/misc/bcm2835_mphi.c
 create mode 100644 hw/usb/hcd-dwc2.c
 create mode 100644 hw/usb/hcd-dwc2.h
 create mode 100644 include/hw/misc/bcm2835_mphi.h
 create mode 100644 include/hw/usb/dwc2-regs.h

-- 
2.17.1


