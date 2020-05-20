Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8225EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 23:54:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E9D4206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 23:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOYCBv4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9D4206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbYY5-0002IL-Cf
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 19:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jbYXS-0001TK-V8
 for qemu-devel@nongnu.org; Wed, 20 May 2020 19:54:18 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:50507)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jbYXR-0008T8-HY
 for qemu-devel@nongnu.org; Wed, 20 May 2020 19:54:18 -0400
Received: by mail-pj1-x1042.google.com with SMTP id nu7so2086249pjb.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 16:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vpWHo8G/b8BTIu+utqk6m5alRRBCTaBVKFKH63T3sXE=;
 b=mOYCBv4EgOMqwqyt6ry8/dS6u3v+0bbcfSSw9aPFfAU9/eT8uAUBs/stPaLeYwkuOA
 KDnJFYecaz+CWMsh3oDF9sBV8CyjoCw8rcRJoa6E7D1zjuiqlDOU9JRyB8VlmW1fTyhY
 2Qt2sxsBpKXO0Yvi8W39SsqpO8OOfDwH+wzaCV72QoJQicF5VFJcCvORcL2LYiHibTxM
 3jW4QAKkF4zjbKGxw6Z/4mEB6gS/rvLIUtrS37zZyQdjDu/0FWF9m1fzRNLM/yILYfuf
 XY6o+Afvu1BII8UqQCagXO6LPn3zavarxatKgXJe7j4uOnbpHdLOSc09rNYLoSPxUeDk
 RvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vpWHo8G/b8BTIu+utqk6m5alRRBCTaBVKFKH63T3sXE=;
 b=tvhopjcUT6XDvrhyhwM0jwQUisa6ppLXbjEihnOInR4x0/Kh9+scTfYncHbyAX18U5
 gwdmW++rsC0+v2c1ekXNYCWOxZTCpeQcbW/J/DIPBjw6prLB2AO6zh90hQ1w0NlLzUnH
 puApFEv4fpXPOw01oAC+GnChfUJ9jtZDBEPosveON7kkq0jWjVa6zE/ObmZP2SJlMUno
 pZjLf50Nl0AE/NCpBw8zJu2ZI4ptYVUpTpDonS9dVbocvsE4LRVk9KgECPmecMX22FNJ
 xPs6XrtBZt5OXY3c1UafOKckJGRKpNYxy4EXx50EiYIu+bJVfwXYEmPPesNqM8VbW0M3
 1xPA==
X-Gm-Message-State: AOAM533Q23zjpQ8G7f3mKlrgHrt+8MTN5G9V4tU+iQKNDlmQ0RS4sNKj
 PB4iP9HBjLLo1p4MjJCwa8o=
X-Google-Smtp-Source: ABdhPJz5kq2yEzt1zAMliz3iOKMdFMsjNhKzkJ+tJhtpjojan8J5AGnuD2Kb+ZTxzpK60bxKyLflbw==
X-Received: by 2002:a17:90a:d598:: with SMTP id
 v24mr7344552pju.167.1590018855484; 
 Wed, 20 May 2020 16:54:15 -0700 (PDT)
Received: from localhost.localdomain ([75.167.104.59])
 by smtp.gmail.com with ESMTPSA id d20sm2761882pjs.12.2020.05.20.16.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 16:54:14 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v6 0/7] dwc-hsotg (aka dwc2) USB host controller emulation
Date: Wed, 20 May 2020 16:53:42 -0700
Message-Id: <20200520235349.21215-1-pauldzim@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=pauldzim@gmail.com; helo=mail-pj1-x1042.google.com
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

This verion fixes a few things pointed out by Peter, and one by
Felippe.

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

Changes v5-v6:
  - In bcm2835_mphi.c, make mphi_reset() do initialization of the device
    state, per Peter M.

  - In hcd-dwc2.c, replace fprintf() with qemu_log_mask(LOG_GUEST_ERROR),
    and add qemu_log_mask(LOG_UNIMP) for the TODO functionality, per
    Peter M.

  - In hcd-dwc2.c, switch to using 3-phase reset, per Peter M.

  - In dwc2-regs.h, change comment style of first line to Qemu style,
    and add a note about which Linux commit the file is from, per
    Felippe M.

Changes v4-v5:
  - Changed MemoryRegionOps to use '.impl.[min/max]_access_size' and
    removed ANDing of memory values with 0xffffffff, per Felippe M.

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
 hw/misc/bcm2835_mphi.c                 |  191 ++++
 hw/usb/Kconfig                         |    5 +
 hw/usb/Makefile.objs                   |    1 +
 hw/usb/dev-storage.c                   |   15 +-
 hw/usb/hcd-dwc2.c                      | 1417 ++++++++++++++++++++++++
 hw/usb/hcd-dwc2.h                      |  190 ++++
 hw/usb/trace-events                    |   50 +
 include/hw/arm/bcm2835_peripherals.h   |    5 +-
 include/hw/misc/bcm2835_mphi.h         |   44 +
 include/hw/usb/dwc2-regs.h             |  899 +++++++++++++++
 tests/acceptance/boot_linux_console.py |    9 +-
 13 files changed, 2856 insertions(+), 5 deletions(-)
 create mode 100644 hw/misc/bcm2835_mphi.c
 create mode 100644 hw/usb/hcd-dwc2.c
 create mode 100644 hw/usb/hcd-dwc2.h
 create mode 100644 include/hw/misc/bcm2835_mphi.h
 create mode 100644 include/hw/usb/dwc2-regs.h

-- 
2.17.1

