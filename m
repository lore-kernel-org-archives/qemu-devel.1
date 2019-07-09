Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE2FC606D7
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 07:35:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 538F521707
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 07:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538F521707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkkea-0005qZ-At
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 03:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46724)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <th.huth@gmail.com>) id 1hkkcQ-0004FM-Sx
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:32:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1hkkcP-0001MW-JQ
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:32:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33475)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1hkkcP-0001Lb-C4
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:32:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id h19so1724087wme.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 00:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=634kfAdvYH6+WYhsLU+dr9F8BcNBxJvCSB0Zguss3ww=;
 b=bX34RdGZI/Zq3cFenkNc1dWlGbDoRSmknN/5XcXnV1Pv+qgX+izAHwqsXdCfZULKTK
 mRSPSTuWngdRMvfDQjB+cuLnMAqjUT7PGpeNgJ4+4ChAzGeePKGgqCoxX/522t3z97ae
 QC319dbTsbtvWqItJ9NZ0w8/XT08LMjMSudBCWsJpTLYI7fAnnHkkqLlf+cB4ueM4cm6
 r9nGtO783CEs9IqbJw9qpop4VTgpbGKSsWmpMlcEec5I82acdVE9nk1A8q2LWU4okDoK
 99uIlFw8loOx7yapnpflBonKWHL9nP610DZWmmZM3bEhwpAacoWIUeIZs5TYQyKBIukb
 iqeg==
X-Gm-Message-State: APjAAAUhFvS8C4EV4Lno2cze0srIz/AZCTcMO/+VQn44R4wInmZaLGio
 NALbGDqcyHrJtoWqyC2dCm4csP9yILk=
X-Google-Smtp-Source: APXvYqy6onJq4Z4oGHdQOQBienoAD7Zow53yuxTfRh4ajGMdU7UP9Y/BBbVBYJ4g183bl7PfQf+zUQ==
X-Received: by 2002:a05:600c:2102:: with SMTP id
 u2mr16477228wml.105.1562657571335; 
 Tue, 09 Jul 2019 00:32:51 -0700 (PDT)
Received: from thl530.multi.box (pD95752BD.dip0.t-ipconnect.de.
 [217.87.82.189])
 by smtp.gmail.com with ESMTPSA id l2sm1529208wmj.4.2019.07.09.00.32.49
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 00:32:50 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 09:32:16 +0200
Message-Id: <20190709073222.26370-1-huth@tuxfamily.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: [Qemu-devel] [PATCH v4 0/6] m68k: Add basic support for the
 NeXTcube machine
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

During Google Summer of Code 2011, Bryce Lanham added the possibility to
emulate the NeXTcube machine in QEMU, e.g. see these URLs for some details:

https://wiki.qemu.org/Google_Summer_of_Code_2011#NeXT_machines_system_emulation
https://lists.gnu.org/archive/html/qemu-devel/2011-08/msg02158.html

But since the machine requires a 68040 CPU and this was not included in
upstream QEMU in 2011 yet, the patches have never been merged to upstream.

Then, during the last years, Laurent completed the full 680x0 support in
upstream QEMU, so we could finally merge the NeXTcube support, too.

The QEMU interfaces changed a lot since 2011, so I had to modify the
sources quite a bit, but with the attached patches, it is now possible
to boot up to the firmware monitor again.

Note that boot device emulation is still missing (network and SCSI),
so you can not boot any operating systems with this machine yet. I have
the patches for these devices in my brach here:

 https://gitlab.com/huth/qemu/commits/next-cube

... but they are not quite working yet, so I'll submit them later once
they have been fixed and the basic support patches of this series have
been merged.

v4:
 - Fixed the "bmap" memory region with its alias - the error messages
   about wrong DIMMs should now be gone.
 - Managed to wired up the ESCC serial device (after including Laurent's
   "bit_swap" patch)

v3:
 - Don't connect the devices to the sysbus from the device files themselves,
   do it from next-cube.c instead.
 - Adjusted some values according to Philippe's review comments
 - The MMIO region at 0x820c0020 is now correctly initialized as alias
 - Some more clean-ups here and there

v2:
 - Don't use memory_region_allocate_system_memory() for the framebuffer
   device anymore
 - Turn the keyboard device into a proper QOM device
 - Put the global variables in the third patch into the machine state
   structure
 - Got rid of the "//" C++ comments

Laurent Vivier (1):
  escc: introduce a selector for the register bit

Thomas Huth (5):
  m68k: Add NeXTcube framebuffer device emulation
  m68k: Add NeXTcube keyboard device
  m68k: Add NeXTcube machine
  m68k: Add serial controller to the NeXTcube machine
  m68k: Add an entry for the NeXTcube machine to the MAINTAINERS file

 MAINTAINERS                      |    7 +
 default-configs/m68k-softmmu.mak |    1 +
 hw/char/escc.c                   |   30 +-
 hw/display/Makefile.objs         |    1 +
 hw/display/next-fb.c             |  145 +++++
 hw/m68k/Kconfig                  |    5 +
 hw/m68k/Makefile.objs            |    1 +
 hw/m68k/next-cube.c              | 1007 ++++++++++++++++++++++++++++++
 hw/m68k/next-kbd.c               |  284 +++++++++
 include/hw/char/escc.h           |    1 +
 include/hw/m68k/next-cube.h      |   47 ++
 tests/boot-serial-test.c         |   12 +
 12 files changed, 1535 insertions(+), 6 deletions(-)
 create mode 100644 hw/display/next-fb.c
 create mode 100644 hw/m68k/next-cube.c
 create mode 100644 hw/m68k/next-kbd.c
 create mode 100644 include/hw/m68k/next-cube.h

-- 
2.21.0


