Return-Path: <SRS0=qvFP=5O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8358C43331
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 00:19:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DF2B20732
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 00:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgXUp9Rd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF2B20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jILfS-0002k7-NI
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 20:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jILeC-0001yF-SM
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 20:17:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pauldzim@gmail.com>) id 1jILeB-0007BE-JA
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 20:17:52 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41102)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pauldzim@gmail.com>) id 1jILeB-0007AG-Bw
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 20:17:51 -0400
Received: by mail-pf1-x443.google.com with SMTP id z65so6625350pfz.8
 for <qemu-devel@nongnu.org>; Sat, 28 Mar 2020 17:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=noGAkGyb6RXLUdnhqr/eHBLPWB8Ct+PBFvOxIjwHTZw=;
 b=RgXUp9RdCX+ugBAD53L4mr/NTe3p0JpJ5P0/hlQOSjbGFLqgRQuECqo5hxHAbseYst
 KabuC8ZInJp1G/0NkVE9RIxQFbUlIzXktI7cdQJ7sEPvdFSEur2j1K6YLThjQwYLNioJ
 ECpBlIaEdW9rH63Skd0+F/TBUemeueNW6HqW9azR7cpP6y4RwTFALmuzoc3rT6xFbLJZ
 bvp6kKBiXsHyDsEo+Tvo1+pKotCsCcUtCTVuucIvcM053UNIQNnhpI4zGZGDmBByHpTc
 EA7XxSnoKsDtRD38G7WJ9EASqqrJzJl7Zsza75u0FGJbCyiy9ABsLmCa+ERmd7Ri/1hc
 jrhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=noGAkGyb6RXLUdnhqr/eHBLPWB8Ct+PBFvOxIjwHTZw=;
 b=q1Yfb5kB8Ue7j97F8kQu0ZzR6b9T0XiRVrfn5wbh3Z1+mbTvZGbJnVPZWea5hbkoOS
 SyMOwJ21dZLfZWQ/79yknzj01Ik1tUBc6LwYvzvERph4LSLPnOExLntnJ1emItTilPj7
 3JG5dT+pQD4440z+N+mcZM2Tdew4p2LhxL54QRbsNYIx8iTlFSqgti6A64RFlsxsoAsT
 EBlSijZyFZbe+Tdg8hSy4zpKcWgFzQwMcyZfur7f1v+gJhwv4bnGGAUOvsXOn/Ia37GP
 Ls79XtHo99NnSt2HPgcBY44s8q+Zd3Rmvci3ILQZpSqc24E+JaipthzL9KMMEm1vXniu
 odTA==
X-Gm-Message-State: ANhLgQ0vw983Jd50Bf3rgYPhrXbLwAIN16eYhuN9YIkIPWzywr48XIda
 Ld8anCoBPcoeGi5lu1LGAmY=
X-Google-Smtp-Source: ADFU+vsSXQLbANiHe/RX8ZVEHOcjbG9zr7ZhRM1bOLe9oaMsYFX7zqnlzcB9d+dPDXqHMUYBKkJ9cg==
X-Received: by 2002:a63:455:: with SMTP id 82mr6092516pge.197.1585441069650;
 Sat, 28 Mar 2020 17:17:49 -0700 (PDT)
Received: from paulz-G33T-M.Home ([75.167.220.149])
 by smtp.gmail.com with ESMTPSA id u14sm6626890pgg.67.2020.03.28.17.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2020 17:17:49 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 0/6] dwc-hsotg (aka dwc2) USB host controller emulation
Date: Sat, 28 Mar 2020 17:16:59 -0700
Message-Id: <20200329001705.15966-1-pauldzim@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Paul Zimmerman <pauldzim@gmail.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
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

I have used some on-line sources of information while developing
this emulation, including:

http://www.capital-micro.com/PDF/CME-M7_Family_User_Guide_EN.pdf
has a pretty complete description of the controller starting on
page 370.

https://sourceforge.net/p/wive-ng/wive-ng-mt/ci/master/tree/docs/DataSheets/RT3050_5x_V2.0_081408_0902.pdf
has a description of the controller registers starting on page
130.

Changes from v1:
  - Fixed checkpatch errors/warnings, except for dwc2-regs.h since
    that is a direct import from the Linux kernel.
  - Switched from debug printfs to tracepoints in hcd-dwc2.c, on the
    advice of Gerd. I just dropped the debug prints in bcm2835_mphi.c,
    since I didn't consider them very useful.
  - Updated a couple of the commit messages with more info.

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
 hw/misc/bcm2835_mphi.c               |  193 ++++
 hw/usb/Kconfig                       |    5 +
 hw/usb/Makefile.objs                 |    1 +
 hw/usb/dev-storage.c                 |   15 +-
 hw/usb/hcd-dwc2.c                    | 1301 ++++++++++++++++++++++++++
 hw/usb/hcd-dwc2.h                    |  180 ++++
 hw/usb/trace-events                  |   47 +
 include/hw/arm/bcm2835_peripherals.h |    5 +-
 include/hw/misc/bcm2835_mphi.h       |   50 +
 include/hw/usb/dwc2-regs.h           |  895 ++++++++++++++++++
 12 files changed, 2728 insertions(+), 3 deletions(-)
 create mode 100644 hw/misc/bcm2835_mphi.c
 create mode 100644 hw/usb/hcd-dwc2.c
 create mode 100644 hw/usb/hcd-dwc2.h
 create mode 100644 include/hw/misc/bcm2835_mphi.h
 create mode 100644 include/hw/usb/dwc2-regs.h

-- 
2.17.1


