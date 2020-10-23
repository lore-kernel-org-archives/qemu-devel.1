Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB64C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0514521527
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rsCp6/QT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0514521527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzTN-0004o7-Ut
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVyyp-0004D3-U1
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:27:47 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26168)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVyyn-0001Xq-DE
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603466865; x=1635002865;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=RLFX80Xpql0C4xhJ9t67Cmi2z97fy3kDvnRc3xd7dGI=;
 b=rsCp6/QTAPl0ns/ow9pEZq0rDyBY1+EGUyS+DHVJsG4xB7zRPNwk4v1T
 yBtzDePlf9b+kDYs4OMtOUQ26ePp8ufES4MzjPB3f54EKrfMfXxbQoMoq
 Cu4GyDfzmRcZ7QJjwxgui+xIu5zZV0MJZyAgfoagP+HM8hpCk4kogJ6dP
 LoR9vARxtv37tPGeraOvENB5qUV3BNo1UzVjhfREhdNmn4kCRYseRt1kf
 D5FsyuTpvNfflVKUUOm30tlg8Lk3rfVICmJu6snUgi9jlzWjp3O6i8tiu
 ShXhWlvbYaaenCE2iVmsCPQllX6nF3x/2hk4ctNrVDR9yH/e5rjJIUhIy w==;
IronPort-SDR: pYsSo0YeZWKdu4Q6JlyILJRg0dAjh7TmZcCKIyFUq4maUjX4CT2nL2LOTNnxhHr5DS59c/SigX
 aG+rEfm6T/FsaT6NN3o2BIPY807F77uHa80mFfoE9BBu0AQG8N6cfXAm+9i5H61CWd7mbkfmB3
 iHp27CbXNG9jC5iM3/UJiyWtQFaxZHRuMCqNFIDoh/6qpIGBADNk5e4UgERzMkFamITqTCPB94
 kcUt3YRSTUrTJdYxZusFPLDQN1cK8masUl5RwKX05XEGhD4Jj1d6xN01V4C+Nj42YqhA5w0bs3
 SJ8=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="150652316"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:27:42 +0800
IronPort-SDR: nPCrzbyJBOf0HfLRdCKnwQZxhJiGjyQGKPxMwc4DtMi1XqUxZssoq3DokUcjHs94iRtvAzpdAS
 4azunCXmSz6lNzPKnkp67m51fXEM+tqxA9Ws2NWLLfWJp7e24VcC4DGZct4UCfNYHFL0OntKTd
 kGFvQZRnpz5K/0c5+yGXA7zxU+Ms+PNYbc+3zEc6ZdtMR564aqriDeWaXzQDP35Gmqj6toeRIG
 G8WVB4XXcQo2S4o0KoLb7eesrXAG6Nlj6kcYrJDcb3HaIDSnEE8nrtEYMkh0es95o7AzFSOzCH
 4zvEmintiQPRomQsOM3ovrkU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:12:57 -0700
IronPort-SDR: hw8s0of+U4APhC+odBxKjrQniUGkqy3jjHeJDt1lBl2ARSNTBp/1wkQElTj92yLZ1pnS/LixTP
 yZTzwQ1YfJm7tpD1ftro4pWzjvM3MnHOUKKIJKy13bYjAGoPxpZf2C5h2xPbcObN8AvMuwrpuk
 JehLccy++dT57wrAyrgqrFWSAB1mDe4j2q51I9QKvK1FlNCguIvDRZ+8xww9kqx2b+8Zy6jozm
 iFE+RNzFijvP7KgUFGRFHItL/zFE4KDssBfQzmwNaOg1OpJ56V5fyMON5YQXDXmHrLauem2QkB
 liY=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Oct 2020 08:27:42 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 00/12] riscv-to-apply queue
Date: Fri, 23 Oct 2020 08:16:07 -0700
Message-Id: <20201023151619.3175155-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:27:42
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 4c5b97bfd0dd54dc27717ae8d1cd10e14eef1430:

  Merge remote-tracking branch 'remotes/kraxel/tags/modules-20201022-pull-request' into staging (2020-10-22 12:33:21 +0100)

are available in the Git repository at:

  git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20201023

for you to fetch changes up to 51b6c1bbc3dd1b139a9e9b021d87bcfd7d82299e:

  hw/misc/sifive_u_otp: Add backend drive support (2020-10-22 12:00:50 -0700)

----------------------------------------------------------------
A collection of RISC-V fixes for the next QEMU release.

This includes:
 - Improvements to logging output
 - Hypervisor instruction fixups
 - The ability to load a noMMU kernel
 - SiFive OTP support

----------------------------------------------------------------
Alistair Francis (5):
      riscv: Convert interrupt logs to use qemu_log_mask()
      hw/riscv: sifive_u: Allow specifying the CPU
      hw/riscv: Return the end address of the loaded firmware
      hw/riscv: Add a riscv_is_32_bit() function
      hw/riscv: Load the kernel after the firmware

Bin Meng (1):
      hw/intc: Move sifive_plic.h to the include directory

Georg Kotheimer (3):
      target/riscv: Fix update of hstatus.SPVP
      target/riscv: Fix update of hstatus.GVA in riscv_cpu_do_interrupt
      target/riscv: Fix implementation of HLVX.WU instruction

Green Wan (2):
      hw/misc/sifive_u_otp: Add write function and write-once protection
      hw/misc/sifive_u_otp: Add backend drive support

Yifei Jiang (1):
      target/riscv: raise exception to HS-mode at get_physical_address

 {hw => include/hw}/intc/sifive_plic.h |  0
 include/hw/misc/sifive_u_otp.h        |  5 ++
 include/hw/riscv/boot.h               | 13 +++--
 include/hw/riscv/sifive_u.h           |  1 +
 target/riscv/cpu.h                    | 10 ++--
 hw/misc/sifive_u_otp.c                | 95 ++++++++++++++++++++++++++++++++++-
 hw/riscv/boot.c                       | 56 +++++++++++++++------
 hw/riscv/opentitan.c                  |  3 +-
 hw/riscv/sifive_e.c                   |  3 +-
 hw/riscv/sifive_u.c                   | 28 ++++++++---
 hw/riscv/spike.c                      | 11 ++--
 hw/riscv/virt.c                       | 11 ++--
 target/riscv/cpu_helper.c             | 50 +++++++++++++-----
 target/riscv/op_helper.c              |  7 ++-
 14 files changed, 238 insertions(+), 55 deletions(-)
 rename {hw => include/hw}/intc/sifive_plic.h (100%)

