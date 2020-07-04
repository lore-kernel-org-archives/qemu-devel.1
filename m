Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7690C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 14:51:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94F302070C
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 14:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfCW80ig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F302070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrjVU-0003Qi-Qu
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 10:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUG-0000zf-HW; Sat, 04 Jul 2020 10:49:52 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:40885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUE-0003cw-UA; Sat, 04 Jul 2020 10:49:52 -0400
Received: by mail-wm1-x335.google.com with SMTP id f139so37072009wmf.5;
 Sat, 04 Jul 2020 07:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8Sd8UrNpAT6Q827DPYJ71GYz3qN5ijhu3T6adNwNx58=;
 b=VfCW80igCu05TRu6Kp/hRp0wwLcO25D00t+NwoIV0c8ix6mcQko2qSVKfN1H7cmL4H
 Vxhy0na0A3ZdoSWK98SpIoSITxwO50uXAKNvBj0H9USSoEJkOYekcVtX7qA8oey7Zq0C
 1gT9pIxDTb1SouD3jSFCjmRxh176pRqgb9NK+POT5ThziR0p2IFJM7o0Quc2x81CpA+g
 ifW/7fKRhTgTGZolZ71YooHseLeyWaonfI/a9QW1+3iYMgESDtL3KwrJ6MbXAJJc5tVN
 WBh2g+7GmdCH0HZbUKAJrDSTZ0YLZDtsbFuAgkRinU6RkXxKmgHpBNku6nt5HiABtxt8
 vQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=8Sd8UrNpAT6Q827DPYJ71GYz3qN5ijhu3T6adNwNx58=;
 b=fVhEkql0OMZdkVyzDA24feP3bCM3SUAmbXJTPU3P04P/xaaNIHrTOfId5od8E7AhL1
 W8Dse8qVIt9dteynmcJubk0+lgwDimCp4UDXtJJptjvIK/wlewInBCZ7d2HWDnqeOflI
 sU445mBjb59g46wjtQFLY+fXviGjLrl2vRPDuB382xLCO3/Ct5r/hZxrMdyPL41SmJMs
 zIzq2U2SOAdjsErKRlqVf5Ns8mPzhaPUBOOoooDwz8+JPYp9iFOdld0A80ojAWc+3hyv
 WUL4reNBAbd4GplOteSD2AkMRT5uGMHG6yoN1b+UjwEHuuwMSHwhhf1OsdWwCPg44+Zk
 Z/IA==
X-Gm-Message-State: AOAM533cwv7kpPfOGm4vxHuiUj+9pVW8bOC0kn3iN3fezr/NSInJ+C+b
 YhF5ekiiuGUqpb30UwperAp4cMgGCaI=
X-Google-Smtp-Source: ABdhPJyVXTn8bDCpfeNaz82C2B4sWvaeuwMMI0440OjK/Jj8KTAg5BtYB+Q0yPcpdr0q523zbyeuCw==
X-Received: by 2002:a1c:28c4:: with SMTP id o187mr27108566wmo.62.1593874187874; 
 Sat, 04 Jul 2020 07:49:47 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r10sm17135019wrm.17.2020.07.04.07.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 07:49:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 00/26] hw/usb: Give it love,
 reduce 'hw/usb.h' inclusion out of hw/usb/
Date: Sat,  4 Jul 2020 16:49:17 +0200
Message-Id: <20200704144943.18292-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Durrant <paul@xen.org>, Magnus Damm <magnus.damm@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Leif Lindholm <leif@nuviainc.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paul Zimmerman <pauldzim@gmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This is the second time I try to replace a magic typename string
by a constant, and Zoltan warns me this is counter productive as
"hw/usb.h" pulls in an insane amount of code.

Time to give the usb subsystem some love and move forward.

This series can be decomposed as follow:

 1-2:    preliminary machine cleanups (arm/ppc)
 3-13:   usb related headers cleanups
 14-15:  usb quirks cleanup
 16-18:  refactor usb_get_dev_path() to add usb_get_port_path()
 19:     let spapr use usb_get_port_path() to make USBDevice opaque
 20:     extract the public USB API (for machine/board/soc)
 21:     make the older "usb.h" internal to hw/usb/
 22-25:  use TYPENAME definitions
 26:     cover dwc2 in MAINTAINERS

Please review.

Phil.

Philippe Mathieu-Daudé (26):
  hw/arm/sbsa-ref: Remove unused 'hw/usb.h' header
  hw/ppc/sam460ex: Add missing 'hw/pci/pci.h' header
  hw/usb: Remove unused VM_USB_HUB_SIZE definition
  hw/usb: Reduce 'exec/memory.h' inclusion
  hw/usb/desc: Add missing header
  hw/usb/hcd-dwc2: Remove unnecessary includes
  hw/usb/hcd-dwc2: Restrict some headers to source
  hw/usb/hcd-dwc2: Restrict 'dwc2-regs.h' scope
  hw/usb/hcd-ehci: Remove unnecessary include
  hw/usb/hcd-ehci: Move few definitions from header to source
  hw/usb/hcd-xhci: Add missing header
  hw/usb/hcd-musb: Restrict header scope
  hw/usb/desc: Reduce some declarations scope
  hw/usb/quirks: Rename included source with '.inc.c' suffix
  hw/usb: Add new 'usb-quirks.h' local header
  hw/usb/bus: Simplify usb_get_dev_path()
  hw/usb/bus: Rename usb_get_dev_path() as usb_get_full_dev_path()
  hw/usb/bus: Add usb_get_port_path()
  hw/ppc/spapr: Use usb_get_port_path()
  hw/usb: Introduce "hw/usb/usb.h" public API
  hw/usb: Move internal API to local 'usb-internal.h' header
  hw/usb/usb-hcd: Use OHCI type definitions
  hw/usb/usb-hcd: Use EHCI type definitions
  hw/usb/usb-hcd: Use UHCI type definitions
  hw/usb/usb-hcd: Use XHCI type definitions
  MAINTAINERS: Cover dwc-hsotg (dwc2) USB host controller emulation

 hw/usb/desc.h                             | 11 +++++
 {include/hw => hw}/usb/dwc2-regs.h        |  0
 hw/usb/hcd-dwc2.h                         |  5 +-
 hw/usb/hcd-ehci.h                         | 24 +---------
 {include/hw => hw}/usb/hcd-musb.h         |  2 +
 hw/usb/hcd-ohci.h                         |  4 +-
 hw/usb/hcd-xhci.h                         |  4 +-
 include/hw/usb.h => hw/usb/usb-internal.h | 50 ++-----------------
 hw/usb/usb-quirks.h                       | 27 +++++++++++
 include/hw/usb/chipidea.h                 |  2 +-
 include/hw/usb/usb-hcd.h                  | 36 ++++++++++++++
 include/hw/usb/usb.h                      | 58 +++++++++++++++++++++++
 chardev/baum.c                            |  2 +-
 hw/arm/allwinner-a10.c                    |  2 +-
 hw/arm/allwinner-h3.c                     | 10 ++--
 hw/arm/exynos4210.c                       |  2 +-
 hw/arm/pxa2xx.c                           |  3 +-
 hw/arm/realview.c                         |  3 +-
 hw/arm/sbsa-ref.c                         |  4 +-
 hw/arm/versatilepb.c                      |  3 +-
 hw/arm/xilinx_zynq.c                      |  2 +-
 hw/display/sm501.c                        |  3 +-
 hw/i386/pc.c                              |  2 +-
 hw/i386/pc_piix.c                         |  5 +-
 hw/i386/pc_q35.c                          | 15 +++---
 hw/isa/piix4.c                            |  3 +-
 hw/mips/fuloong2e.c                       |  5 +-
 hw/ppc/mac_newworld.c                     |  5 +-
 hw/ppc/mac_oldworld.c                     |  3 +-
 hw/ppc/sam460ex.c                         |  6 ++-
 hw/ppc/spapr.c                            | 13 +++--
 hw/sh4/r2d.c                              |  2 +-
 hw/usb/bus.c                              | 40 +++++++++-------
 hw/usb/chipidea.c                         |  1 +
 hw/usb/combined-packet.c                  |  2 +-
 hw/usb/core.c                             |  2 +-
 hw/usb/desc-msos.c                        |  2 +-
 hw/usb/desc.c                             |  3 +-
 hw/usb/dev-audio.c                        |  2 +-
 hw/usb/dev-hid.c                          |  2 +-
 hw/usb/dev-hub.c                          |  2 +-
 hw/usb/dev-mtp.c                          |  2 +-
 hw/usb/dev-network.c                      |  2 +-
 hw/usb/dev-serial.c                       |  2 +-
 hw/usb/dev-smartcard-reader.c             |  2 +-
 hw/usb/dev-storage.c                      |  2 +-
 hw/usb/dev-uas.c                          |  2 +-
 hw/usb/dev-wacom.c                        |  2 +-
 hw/usb/hcd-dwc2.c                         |  8 ++--
 hw/usb/hcd-ehci-sysbus.c                  |  1 +
 hw/usb/hcd-ehci.c                         | 13 ++++-
 hw/usb/hcd-musb.c                         |  4 +-
 hw/usb/hcd-ohci-pci.c                     |  4 +-
 hw/usb/hcd-ohci.c                         |  1 -
 hw/usb/hcd-uhci.c                         | 21 ++++----
 hw/usb/hcd-xhci-nec.c                     |  3 +-
 hw/usb/hcd-xhci.c                         |  2 +-
 hw/usb/host-libusb.c                      |  2 +-
 hw/usb/host-stub.c                        |  2 +-
 hw/usb/libhw.c                            |  2 +-
 hw/usb/quirks.c                           |  5 +-
 hw/usb/{quirks.h => quirks.inc.c}         |  5 --
 hw/usb/redirect.c                         |  3 +-
 hw/usb/tusb6010.c                         |  4 +-
 hw/usb/xen-usb.c                          |  2 +-
 monitor/misc.c                            |  2 +-
 softmmu/vl.c                              |  2 +-
 MAINTAINERS                               |  7 ++-
 68 files changed, 294 insertions(+), 185 deletions(-)
 rename {include/hw => hw}/usb/dwc2-regs.h (100%)
 rename {include/hw => hw}/usb/hcd-musb.h (98%)
 rename include/hw/usb.h => hw/usb/usb-internal.h (92%)
 create mode 100644 hw/usb/usb-quirks.h
 create mode 100644 include/hw/usb/usb-hcd.h
 create mode 100644 include/hw/usb/usb.h
 rename hw/usb/{quirks.h => quirks.inc.c} (99%)

-- 
2.21.3


