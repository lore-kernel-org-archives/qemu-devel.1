Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5C8C54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 06:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0899D20752
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 06:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsYy3OYb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0899D20752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYOlP-0006zj-5Q
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 02:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jYOjN-0005EJ-Fi
 for qemu-devel@nongnu.org; Tue, 12 May 2020 02:49:33 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44947)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jYOjL-00037g-Ur
 for qemu-devel@nongnu.org; Tue, 12 May 2020 02:49:33 -0400
Received: by mail-pl1-x644.google.com with SMTP id b8so4978139plm.11
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 23:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xSGfiUw4uxd3urW8/kCDLQ8nWqmY4QhnNHDTudHnzmk=;
 b=GsYy3OYbwtPmQMU7/y33Oj2dmP/ByzHA3rADvnlhHRC1M9b2KUqSLUXmildV6inRZv
 xY7i8jlIONkrqQ6JUq0prxyKRiI/LfeKxMyY5oyLlwrJ98+c1nXFm8MdfDHx91SsPLmJ
 a3UD3AH982in4ufld8sWY+otDE1T1GxnV1uofHNcF3R3ptN9CQBV99bvcMMR0ERd7Vii
 5axTAR26qR2eRIsKpHSOzXJa6LiODEUFjU2rJlYp8K7FIjJ2Y10FXy1qcjCS/nUep165
 42D6YS5AEYG1UFZLXzvz/iE7Zo5FlNd0p6WFgBEXbxTiHhndl00ERPKezm7uUJgdM3QA
 IY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xSGfiUw4uxd3urW8/kCDLQ8nWqmY4QhnNHDTudHnzmk=;
 b=rPwKnb9tsPM3AI3+9sQlKAZKwFSs35HVenEEGYgYRhFrb9Y45Evuc915bd/RjXj8L+
 Pwy4beF0nJ/b+KUOffU7B69eJu4ZHfvzFhbLBO1+13g6sWEBIMkFZPGKQ86Vr/MTY0w3
 9DK79wN6qMLziAv8mBIHYstySkPrF2hjnyGOjM1J2ljk1z2lt5SpRpxSmrKiFIkROL0K
 dlaOpQ+eZCyha8bepiUDcAGBNiH2e3AVSctPIpHp0j3YM0WVc07JoQbA5wyMQ97s1KL5
 qq6tibbNHHv/X371p1WPDds3pBAMxrSd3fU7yyxPJ7l7l0Vp9cl3hZLIAzDzM9HtQ59l
 BiUA==
X-Gm-Message-State: AGi0PuZNkoX8AmgMKqZfeL+vN8X48iKhiM1V0M/j+jax0Gxm3iG24bua
 vJCDLH0QNP+oe2dlS0+QZYg=
X-Google-Smtp-Source: APiQypLhwcp9vnCatKjAZthF1zVm1ShmGp2VJRX7WjrqyDF58a7SrP++86Abx3Asu5IafcI7gHJr/w==
X-Received: by 2002:a17:90b:198e:: with SMTP id
 mv14mr26819693pjb.69.1589266169897; 
 Mon, 11 May 2020 23:49:29 -0700 (PDT)
Received: from localhost.localdomain ([75.167.104.59])
 by smtp.gmail.com with ESMTPSA id j7sm11837286pjy.9.2020.05.11.23.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 23:49:29 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v5 0/7] dwc-hsotg (aka dwc2) USB host controller emulation
Date: Mon, 11 May 2020 23:48:53 -0700
Message-Id: <20200512064900.28554-1-pauldzim@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=pauldzim@gmail.com; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paul Zimmerman <pauldzim@gmail.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gerd, Peter, what do you think about accepting this patch series? The
only possibly disruptive patch is #5, which modifies the dev-storage.c
code a bit, the rest is all new code which shouldn't affect anything
else. Felippe Mathieu-Daudé has done quite a bit of review of the
patches, and has said he thinks it could be accepted now.

This patch series adds emulation for the dwc-hsotg USB controller,
which is used on the Raspberry Pi 3 and earlier, as well as a number
of other development boards. The main benefit for Raspberry Pi is that
this enables networking on these boards, since the network adapter is
attached via USB.

The emulation is working quite well, I have tested with USB network,
mass storage, mouse, keyboard, and tablet. I have tested with the dwc2
driver in the upstream Linux kernel, and with the dwc-otg driver in the
Raspbian kernel.

One remaining issue is that USB host passthrough does not work. I tried
connecting to a USB stick on the host, but the device generates babble
errors and does not work. This is because the dwc-hsotg controller only
has one root port, so a full-speed dev-hub device is always connected
to it, and high-speed USB devices on the host do not work at full-speed
on the guest. (I have WIP code to add high-speed support to dev-hub to
fix this.)

The patch series also includes a very basic emulation of the MPHI
device on the Raspberry Pi SOC, which provides the FIQ interrupt that
is used by the dwc-otg driver in the Raspbian kernel. But that driver
still does not work in full FIQ mode, so it is necessary to add a
parameter to the kernel command line ("dwc_otg.fiq_fsm_enable=0") to
make it work.

I have used some online sources of information while developing this
emulation, including:

http://www.capital-micro.com/PDF/CME-M7_Family_User_Guide_EN.pdf
which has a pretty complete description of the controller starting
on page 370.

https://sourceforge.net/p/wive-ng/wive-ng-mt/ci/master/tree/docs/DataSheets/RT3050_5x_V2.0_081408_0902.pdf
which has a description of the controller registers starting on
page 130.

Changes v4-v5:
  - Changed MemoryRegionOps to use '.impl.[min/max]_access_size' and
    removed ANDing of memory values with 0xffffffff, per Felippe.

  - hcd-dwc2.c: Changed NULL check of return from
    object_property_get_link() call to an assertion, per Felippe.

  - bcm2835_mphi.c/h:
    * Changed swirq_set/swirq_clr registers into a single register,
      per Felippe.
    * Simplified memory region code, per Felippe.

Changes v3-v4:
  - Reworked the memory region / register access code according to
    an example patch from Felippe Mathieu-Daudé.

  - Moved the Makefile/Kconfig changes for this file into this
    patch, per Felipe.

  - Fixed a missing DEFINE_PROP_END_OF_LIST() in dwc2_usb_properties.

Changes v2-v3:
  - Fixed the high-speed frame time emulation so that high-speed
    mouse/tablet will work correctly once we have high-speed hub
    support.

  - Added a "usb_version" property to the dwc-hsotg controller, to
    allow choosing whether the controller emulates a USB 1 full-speed
    host or a USB 2 high-speed host.

  - Added a test for a working dwc-hsotg controller to the raspi2
    acceptance test, requested by Philippe M.

  - Added #defines for the register array sizes, instead of hard-
    coding them in multiple places.

  - Removed the NB_PORTS #define and the associated iteration code,
    since the controller only supports a single root port.

  - Removed some unused fields from the controller state struct.

  - Added pointers to some online documentation to the top of
    hcd-dwc2.c, requested by Peter M.

  - Reworked the init/realize code to remove some confusing function
    names, requested by Peter M.

  - Added VMStateDescription structs for the controller and MPHI
    state, requested by Peter M (untested).

Changes v1-v2:
  - Fixed checkpatch errors/warnings, except for dwc2-regs.h since
    that is a direct import from the Linux kernel.

  - Switched from debug printfs to tracepoints in hcd-dwc2.c, on the
    advice of Gerd. I just dropped the debug prints in bcm2835_mphi.c,
    since I didn't consider them very useful.

  - Updated a couple of the commit messages with more info.

Thanks for your time,
Paul

---

Paul Zimmerman (7):
  raspi: add BCM2835 SOC MPHI emulation
  dwc-hsotg (dwc2) USB host controller register definitions
  dwc-hsotg (dwc2) USB host controller state definitions
  dwc-hsotg (dwc2) USB host controller emulation
  usb: add short-packet handling to usb-storage driver
  wire in the dwc-hsotg (dwc2) USB host controller emulation
  raspi2 acceptance test: add test for dwc-hsotg (dwc2) USB host

 hw/arm/bcm2835_peripherals.c           |   38 +-
 hw/misc/Makefile.objs                  |    1 +
 hw/misc/bcm2835_mphi.c                 |  184 ++++
 hw/usb/Kconfig                         |    5 +
 hw/usb/Makefile.objs                   |    1 +
 hw/usb/dev-storage.c                   |   15 +-
 hw/usb/hcd-dwc2.c                      | 1372 ++++++++++++++++++++++++
 hw/usb/hcd-dwc2.h                      |  173 +++
 hw/usb/trace-events                    |   47 +
 include/hw/arm/bcm2835_peripherals.h   |    5 +-
 include/hw/misc/bcm2835_mphi.h         |   44 +
 include/hw/usb/dwc2-regs.h             |  895 ++++++++++++++++
 tests/acceptance/boot_linux_console.py |    9 +-
 13 files changed, 2784 insertions(+), 5 deletions(-)
 create mode 100644 hw/misc/bcm2835_mphi.c
 create mode 100644 hw/usb/hcd-dwc2.c
 create mode 100644 hw/usb/hcd-dwc2.h
 create mode 100644 include/hw/misc/bcm2835_mphi.h
 create mode 100644 include/hw/usb/dwc2-regs.h

-- 
2.17.1


