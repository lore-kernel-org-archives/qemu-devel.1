Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F54C3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68EE62072D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CUTpNhKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68EE62072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9wcT-0003Xt-Fz
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 14:57:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=32645a587=alistair.francis@wdc.com>)
 id 1j9wbT-0002Se-8Z
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:56:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=32645a587=alistair.francis@wdc.com>)
 id 1j9wbO-00084j-FD
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:56:19 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:34391)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=32645a587=alistair.francis@wdc.com>)
 id 1j9wbN-00082A-PE; Thu, 05 Mar 2020 14:56:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583438174; x=1614974174;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=o3vESU61BoXDEjtVVgudRMtMIPsVP5OUrgAJ+d5WuPI=;
 b=CUTpNhKvyVcGcIrzeQCaCJB3vgcEayIKxG6O1B8sKomFydZ/zZI3EhJU
 AkAkOL45kh59OswzwCEO1Np38RNcxow3nusV8rgQbNRMWTyOaYGmd848/
 LgCwPCvdqJFNe4kXUxyLT7TCQv1uInl7JnQCM6ArcNp4w95SsnY11CJgp
 ywfqIG7TCD5QcgvdNsGwnya+vyCAu7Z1q4wUxO38/dk5yuXcsLuAgKZtg
 Q8PCtuqC2dj6mAtwF+bL5bTalkI/zGYa2jVdqKvPkOw2Dp5FyKprsA1TT
 qZ0SJvRvZqwWrIYn9OblVZU8J+9SiI3A+28NNglyQZaT8WzLWfzcdrzp1 g==;
IronPort-SDR: jQ8wGOvJPMozPRdELj53HBOpyAVHs0Fix1byd/YxPz4AclVpDn7ZPmgTTZ3+EMAmr3gTOgDunl
 Alc3Jg0TDZxxg0QvNHoLNoh1n2BtW7+vi/226zZWto1dK/ygAgUWi8/w6FXVgPdSiOEEkmx4dr
 xmAUNvvAxIzfAeIdrvgwbFUVD/but1IT4vW04jP9zyabalTD2tUY6EvEKzZAsjY8txw4TP3F5g
 aZyBUE91qmyvAwlMQHPLPvNaYytr9GbXS4cPtyJgvAk59B4PGfDFhE6VMPt+pjsbwgEtXtAUn9
 AdM=
X-IronPort-AV: E=Sophos;i="5.70,519,1574092800"; d="scan'208";a="133083875"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2020 03:56:10 +0800
IronPort-SDR: JyZb+VsUMAd7OuvWEmraCkrSOIFusLaV6cWfO22dU7mlKEwvVviuoSWo0s9aBGsustjgeZtOO0
 bvddhbpIYDAemfCc6CfQ+XlXGPmYLBJLmqwsaz33SdRfRaKJwV0eN827eNausfqjW1IJau7P8x
 KfLvINKjhINxufUGXsf9rT+/KxwxEUGEEFXS7Xjgr3jTT2jpDkXC9ZXeS1sya6pYtWo45nMivF
 fjGVnHAF7+iAwGFzmYRNJkNBmo7GIpHETKpTSeRI2dKLJlhQvoTtPlaGOb/1eXWu7PEVKRtUvw
 TkL9Z6ksD/kHKrQ8Amn23ctq
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2020 11:47:57 -0800
IronPort-SDR: hT79s1OkpTje5B8f6Rzt4c/m6ZgyQRPZ6bzlkhSn6Y5qMxC4DulW8x7gM51Lj4jc20BK983T6q
 iBIN3XRug6nMgUS6xNibPS38vxXojjHTvkZhVek1Jx1pOX7IQM5lOwrOHCwXIKXqtpPbq8ADHY
 1T2kORBTibIoP9pJ/6KD48ZA8OmgPIz/nUmcDRHW86hxSEcMCzPmUABHCuFU0NzQfnyItLAtrV
 zjZu4v+QjlqBesr3lvJCO+406+MvJSv+KGx1lO/wx3qTO7jyrmA6Sg/Ja+CMdCFvJtr7vdmSh9
 trk=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 05 Mar 2020 11:56:10 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, aleksandar.m.mail@gmail.com,
 laurent@vivier.eu
Subject: [PATCH v5 0/3]  linux-user: generate syscall_nr.sh for RISC-V
Date: Thu,  5 Mar 2020 11:48:53 -0800
Message-Id: <cover.1583437651.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.45
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series updates the RISC-V syscall_nr.sh based on the 5.5 kernel.

There are two parts to this. One is just adding the new syscalls, the
other part is updating the RV32 syscalls to match the fact that RV32 is
a 64-bit time_t architectures (y2038) safe.

We need to make some changes to syscall.c to avoid warnings/errors
during compliling with the new syscall.

I did some RV32 user space testing after applying these patches. I ran the
glibc testsuite in userspace and I don't see any regressions.

v5:
 - Addres comments raised on v4
   - Don't require 64-bit host for * _time64 functions

Alistair Francis (3):
  linux-user: Protect more syscalls
  linux-user/syscall: Add support for clock_gettime64/clock_settime64
  linux-user/riscv: Update the syscall_nr's to the 5.5 kernel

 linux-user/riscv/syscall32_nr.h | 295 +++++++++++++++++++++++++++++++
 linux-user/riscv/syscall64_nr.h | 301 ++++++++++++++++++++++++++++++++
 linux-user/riscv/syscall_nr.h   | 294 +------------------------------
 linux-user/strace.c             |   2 +
 linux-user/syscall.c            | 116 +++++++++++-
 5 files changed, 713 insertions(+), 295 deletions(-)
 create mode 100644 linux-user/riscv/syscall32_nr.h
 create mode 100644 linux-user/riscv/syscall64_nr.h

-- 
2.25.1


