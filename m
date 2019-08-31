Return-Path: <SRS0=aRDT=W3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E30C3A59F
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 07:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 649232343A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 07:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649232343A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3y7x-0002iM-If
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 03:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <th.huth@gmail.com>) id 1i3y4r-0000yo-SN
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 03:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1i3y4m-0005Xv-6C
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 03:45:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37770)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1i3y4f-0005NX-SC
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 03:45:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id z11so9054846wrt.4
 for <qemu-devel@nongnu.org>; Sat, 31 Aug 2019 00:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XMYAb+ZZ+ZAPuvq982+60p+qjmFpGmPb+BpB3dw68dU=;
 b=b40wgO3vwvU2O3g7x+ibqNmdSu4Ncs+/HXk6L6IvvobVo+DJAouggQRI5vwnATxX4X
 TMJgFttA0/ZJD5aUf2CjwHVc/oSDgyRnrCPqHFCpp2qOTuXK6CF95vMtUL4Da0KNjXa4
 GtfOGRyhVPHHNTKcsTvnxeqj+6plYMX3pFlFSuFxfmVelOZL9AMAT2ivqQQ2+xTEsIwT
 3py6TKdOuWUq7o5UCps8qJSqecy5w1T3IgkSrFLFvc2XuEYsQYkqx7HTQiieS7YQShas
 U4tkKf7G4S6YK/ChPYI51KapBrdy+qCC66xvakOgkY6OwUvirdzP0ZhLYe6axJtaydUT
 Eeow==
X-Gm-Message-State: APjAAAUQfP6hsKksvu6OgOt3XgfsV23cSAERhbxpyCOS6Lt9hsPc0GWP
 i0zehjhQN8JtIUzlsxu43tvDaQ39gqk=
X-Google-Smtp-Source: APXvYqxL6nHcTuSIuhZDEs+bUgkr8MoWfcwwSbbeIGwbgeK1tGVCoMIWlSQ5Xft+BF+t6Dxc0RPWpg==
X-Received: by 2002:a5d:68cd:: with SMTP id p13mr15791767wrw.18.1567237528376; 
 Sat, 31 Aug 2019 00:45:28 -0700 (PDT)
Received: from thl530.multi.box (pD9E83624.dip0.t-ipconnect.de.
 [217.232.54.36])
 by smtp.gmail.com with ESMTPSA id w1sm7546650wrm.38.2019.08.31.00.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Aug 2019 00:45:27 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org
Date: Sat, 31 Aug 2019 09:45:13 +0200
Message-Id: <20190831074519.32613-1-huth@tuxfamily.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: [Qemu-devel] [PATCH v5 0/6] m68k: Add basic support for the
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
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

v5:
 - Rebased to master (fix the #include statements after Markus' rework)
 - Removed some more disabled/commented code fragments
 - Added Reviewed-bys and Tested-bys from Philippe
 - Mark the KBD device as unmigratable (m68k CPUs can not be migrated, too)

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

 MAINTAINERS                      |   7 +
 default-configs/m68k-softmmu.mak |   1 +
 hw/char/escc.c                   |  30 +-
 hw/display/Makefile.objs         |   1 +
 hw/display/next-fb.c             | 146 +++++
 hw/m68k/Kconfig                  |   5 +
 hw/m68k/Makefile.objs            |   1 +
 hw/m68k/next-cube.c              | 978 +++++++++++++++++++++++++++++++
 hw/m68k/next-kbd.c               | 291 +++++++++
 include/hw/char/escc.h           |   1 +
 include/hw/m68k/next-cube.h      |  47 ++
 tests/boot-serial-test.c         |  12 +
 12 files changed, 1514 insertions(+), 6 deletions(-)
 create mode 100644 hw/display/next-fb.c
 create mode 100644 hw/m68k/next-cube.c
 create mode 100644 hw/m68k/next-kbd.c
 create mode 100644 include/hw/m68k/next-cube.h

-- 
2.21.0


