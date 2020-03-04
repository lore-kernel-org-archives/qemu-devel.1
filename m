Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7F9C3F2C6
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 00:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B9F020675
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 00:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="APhWaKh7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9F020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9IHj-0003ki-F8
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 19:53:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9IGd-0002MF-K5
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 19:52:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9IGc-0003rx-9e
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 19:52:07 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32343)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9IGb-0003oR-ED; Tue, 03 Mar 2020 19:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583283125; x=1614819125;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Hlg8DJS04VgDpDw7IoezSh/cg0dJmfuauTvaMCX9uQ4=;
 b=APhWaKh7G585bKP8DKBCxKzsRhKvsPB+3D2HM6bh8Xsc0Bzj3p4NVs8D
 clWPGXiWWkLY4R1PpABHk0Vy3rtzL9xkR4qaUUL27D+0HC1bQhK3i02i8
 S7EQFfOS9U+PHXqkMptKTUha7c95X58mWRD9sJrF0djLJqZ3wc8x4GKqk
 GqJ7hQBXOAr0IA9X+8T7K9r54sz9tGldtE2YJoJV2If6tZpxuXCA9dmvu
 pLDcxzpVdpUL9Jfv8BZ4+ama3TORlFrUt638Y6nP6ivXiP27rEYT68bRM
 hwW3hQMuo/WinvSJIjClccnawx09cUzQfvrn5HApTMTBDjRAP4l9OznR5 Q==;
IronPort-SDR: Kzhd6rv4ebbrfW28bbeUQVWcBr9P+iCPR14oBzn1QyARz6F6vN5UJrBqTwJaKe2gWXmbmDrgUj
 B/Z9q7DgaTINKJTDp8HEkDwpSsGPxfhmOXVRgh7+caHdqtIuuKFmIAVLIIZQqZkRzd/cpuPyMd
 zLNMePS7xQ0q0lO/Zj5VU76Z0O18gMzHKd2ndZI10rQ9uQVOndJVS2yHEKOx3P/ULH9VpzUsPq
 HkdaiFOLJzDujKqn89x4gIKJZiA7WUlmCyJOKfjhHtoS6mhe/y0ATMXzmGHAGdpE33zMFtEskI
 544=
X-IronPort-AV: E=Sophos;i="5.70,511,1574092800"; d="scan'208";a="131861934"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2020 08:52:02 +0800
IronPort-SDR: NwMvrosOHkq9tpzzG12Cd7ldJ3wjrfjgJXOAl3MgB6TwIC1ABVphRjE9Hhyt5rnICs/ZSrAEVt
 iIl4FnjfxRSiJY0TvwTzpOjqZo0Vtio8lellm/DL/djHmvgMQd+q3OPqwKNXbCiUc985kxzYuq
 GlS6QoqrWSJbUcabuFm8UMDqZ9W9k7tVrmFfCfR8MFX1uhPLOjGjjMyowS+eegy3nenPEKwqFm
 6hn0iAw3EG08V+ggPiffKVkI8oNzyexXuAqlawz/XgMkZt/8oZLxVGbzBlJC452XpJN2z6iGOI
 mTQ8lKBm2HbuNSTwQN6F9RqU
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2020 16:44:16 -0800
IronPort-SDR: 6ppMV3z5c+1dCBMUL+6LtHz9XFn9a4Fksvh+gj1srkdolU2wbBqbYgBNDQz3vSvNDLt2TmIE5l
 6vkX09Oq4+FsHgcEmneaBRihRk0Ghi1occMEvThnRjJMM1FJ2vSBZ6tOMUi7BliyRJCVj+HPlp
 40oyrWxGe8yNQpJOxl/iYEMMSR5tTnNYpO+jTiYiUzDSiwn1IePsrQwrFNDP+KJnetbAVMQyTM
 bC0bRhx3q0OKK6BC5dhkKwWQnJN5q/Wr19HWrg/O1UbDM7VULkHO8aTmKOhg9I5ybtJhOWaQtp
 X98=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Mar 2020 16:52:02 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org,
	laurent@vivier.eu
Subject: [PATCH v4 0/3]  linux-user: generate syscall_nr.sh for RISC-V
Date: Tue,  3 Mar 2020 16:44:48 -0800
Message-Id: <cover.1583282640.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.144
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

Alistair Francis (3):
  linux-user: Protect more syscalls
  linux-user/syscall: Add support for clock_gettime64/clock_settime64
  linux-user/riscv: Update the syscall_nr's to the 5.5 kernel

 linux-user/riscv/syscall32_nr.h | 295 +++++++++++++++++++++++++++++++
 linux-user/riscv/syscall64_nr.h | 301 ++++++++++++++++++++++++++++++++
 linux-user/riscv/syscall_nr.h   | 294 +------------------------------
 linux-user/strace.c             |   2 +
 linux-user/syscall.c            | 120 ++++++++++++-
 5 files changed, 717 insertions(+), 295 deletions(-)
 create mode 100644 linux-user/riscv/syscall32_nr.h
 create mode 100644 linux-user/riscv/syscall64_nr.h

-- 
2.25.1


