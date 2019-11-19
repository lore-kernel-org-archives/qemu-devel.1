Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A639BC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BAF522365
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8+bHlUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BAF522365
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX658-0003KE-3u
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 11:10:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iX63h-0001iN-Ia
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:08:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iX63g-0005zI-Fe
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:08:53 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:54362)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iX63g-0005yd-9f
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:08:52 -0500
Received: by mail-wm1-x32f.google.com with SMTP id z26so3791187wmi.4
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 08:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PcsaUmrFboxMwEL+NRAsGIRXtl2In4OwFymjzWGFU+c=;
 b=U8+bHlUHYZxRzHEX9tvkRrsVTooooZhGqRzcpDMT2j2m3uRVCj2JzHEJRhI+GxlT1Y
 vCRDHMBLDfSo5w9nGTXOkWYMFbSpqnFKlLTnzfWHqYR4dvUaPZw/sXgU39ise1Hav/Hc
 JJIbMEazJs0uEo4FsfDvq8TAuFEoDhIf0G/AZABhWN5pisxodcmAFYqujP5gwC5+/nEs
 dATzf7PRzFrSuBD6KmRdXiW5RDhFNxzRCIGqA5wPmVwtgVsHZPMeMmGrEgnEeWbMPa4p
 LIp90A51f/PpiNad7givuT6iGQqE415F8hKsYtKO+qwruWXN3YsE+TYOQ5e3fTi9DDkz
 qcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=PcsaUmrFboxMwEL+NRAsGIRXtl2In4OwFymjzWGFU+c=;
 b=WX7eTkUNkp2cO//zmg2mNJSlwLPUtI0TJg/Q9RoaSwrGLzBX8shFRoI1CJtMTbAfKz
 zXDIQGK6/zUVxl6XlbPoE1MhGvNcBgGx/8MqwZE1JoXOPxDjZB8o/dZF6H8zlD+XGlfh
 OIAdcdZnEUEg2e6dRwPKeVpaE4SSJb9NgT0N3FuN1Nj4BQ8JROUmyqS4PEbb42FUjlCl
 aYvdjTE+LJFfZvYyhY5KCiQO5uxJ1kHos3DLwfNPX0HYPpbSByoM07XuQJxHAzmXEtW1
 uBhksGx4F4GsYU76vyJ/YBdqW7DBv+tC2KikgbA6ANr7f8G97Vb0l/IPiZiALYE88k8q
 ip8w==
X-Gm-Message-State: APjAAAUiInFNL1GGjFwOgV9o8PBDxzG6lz1u0SRgLV1vuToCRopY2G0G
 Euh2oF3hpF70TwunR1kwXETAE164
X-Google-Smtp-Source: APXvYqxQU7cQFn4h275LOddHFelukwZKgNQpg2jhuZzIPERg8SpX/Ay/M0Hn2nYhzXr8p/zGPd6rZw==
X-Received: by 2002:a1c:ab0a:: with SMTP id u10mr7057935wme.0.1574179730301;
 Tue, 19 Nov 2019 08:08:50 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n13sm3442203wmi.25.2019.11.19.08.08.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Nov 2019 08:08:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/12] Misc patches for QEMU 4.2-rc
Date: Tue, 19 Nov 2019 17:08:36 +0100
Message-Id: <1574179728-35535-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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

The following changes since commit 369e8f5bbd8a5301bde6fae22b93fe9288c552a5:

  buildfix: update texinfo menu (2019-11-18 10:33:29 +0000)

are available in the git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 7a3e29b12f5afe0106a5713bb4db6e23dc66ef91:

  mc146818rtc: fix timer interrupt reinjection again (2019-11-19 10:02:13 +0100)

----------------------------------------------------------------
* microvm docs and fixes (Sergio, Liam)
* New processor features for Intel errata (myself, Pawan)
* Kconfig fixes (myself, Thomas)
* Revert mc146818rtc change (myself)
* Deprecate scsi-disk (myself)
* RTC fix (myself, Marcelo)

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      scripts: Detect git worktrees for get_maintainer.pl --git

Liam Merwick (1):
      hw/i386: Move save_tsc_khz from PCMachineClass to X86MachineClass

Paolo Bonzini (5):
      target/i386: add PSCHANGE_NO bit for the ARCH_CAPABILITIES MSR
      vfio: vfio-pci requires EDID
      scsi: deprecate scsi-disk
      Revert "mc146818rtc: fix timer interrupt reinjection"
      mc146818rtc: fix timer interrupt reinjection again

Pawan Gupta (1):
      target/i386: Export TAA_NO bit to guests

Sergio Lopez (3):
      microvm: fix memory leak in microvm_fix_kernel_cmdline
      docs/microvm.rst: fix alignment in "Limitations"
      docs/microvm.rst: add instructions for shutting down the guest

Thomas Huth (1):
      hw/i386: Fix compiler warning when CONFIG_IDE_ISA is disabled

 docs/microvm.rst              | 27 +++++++++++++--
 hw/i386/microvm.c             |  2 ++
 hw/i386/pc.c                  |  1 -
 hw/i386/pc_piix.c             |  8 ++---
 hw/i386/pc_q35.c              |  4 +--
 hw/i386/x86.c                 |  1 +
 hw/rtc/mc146818rtc.c          | 79 ++++++++++++++++++++++---------------------
 hw/scsi/scsi-bus.c            | 12 ++++++-
 hw/scsi/scsi-disk.c           |  3 ++
 hw/vfio/Kconfig               |  1 +
 include/hw/i386/pc.h          |  2 --
 include/hw/i386/x86.h         |  2 ++
 qemu-deprecated.texi          |  5 +++
 scripts/get_maintainer.pl     |  2 +-
 target/i386/cpu.c             |  4 +--
 target/i386/machine.c         |  4 +--
 tests/qemu-iotests/051.pc.out |  6 ++--
 17 files changed, 104 insertions(+), 59 deletions(-)
-- 
1.8.3.1


