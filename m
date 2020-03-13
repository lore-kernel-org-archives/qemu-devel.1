Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD5EC10DCE
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 00:05:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D642074E
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 00:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Lm+Qu8Xr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D642074E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCuIn-0003OB-Ua
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 20:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=335a9ddda=alistair.francis@wdc.com>)
 id 1jCuHq-0002Kh-Lm
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 20:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=335a9ddda=alistair.francis@wdc.com>)
 id 1jCuHp-0002OG-DD
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 20:04:18 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:59684)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=335a9ddda=alistair.francis@wdc.com>)
 id 1jCuHo-0001nP-N2; Fri, 13 Mar 2020 20:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1584144272; x=1615680272;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BA949ONjqslxDLdDXXQETbLrZFzbaBvwbmBFsMoheIE=;
 b=Lm+Qu8XrQ5TQq0n1RiIJwt9PW3fsk7EknbNnbaZhYaMTChBqlRf6bUBL
 sIkq/zsSp5YPS5tWjAvGMLoL1NxecVOzwCWtnOwHa+I40H76m55rdfngg
 3gtNKxkG4jqThzhQvwggb7bgL7Z/13H7luyKoxoIUTLXDpdYn4sR/GfsF
 SqlP8vbYlIFqejgiGWzkk9I2cM6pFNKmpZ6ddW3ooeA2DHDk6mh/Hqqw/
 g/WHe0I0WMG+cRS9NtrKSMzXujFQxKStsfPg15WXbo+cbq7fErimRZ1HG
 HO4fQvGXFg+1cKZHZ7bygxuTzsXq5V73axhpsSUUmnl2rIZJyQE4Gc6ff g==;
IronPort-SDR: +DuUN8/TaHIlIrgKhJmON+h8j/ja2iAdmSmEx+9HbFvS6tA7Ui4a7QKL8pIheg2OWefgSroMof
 8TmNoEAT514nuD1zyVaym8qi87ONyzF/MbwUgapIWuiIuQbGVL9rq4vrC4FzFjG/hEK0hCcjm3
 lczLtnk5il9Y+WZShJLLWF2xSibC2LS9PIH6o4LgpMVSOhha3q3LGf/p5BK6WDTFIu7+Hlr7rz
 8RB4cjk/EvFXNuw/g9s6vwriM0qk2j5r3TAW1BgCkRvmzIi00REmLhV/OHGzN0zij5xiGO/Nov
 d4E=
X-IronPort-AV: E=Sophos;i="5.70,550,1574092800"; d="scan'208";a="234512340"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2020 08:04:26 +0800
IronPort-SDR: Bnj/4CrGem5zmlGnefp00k5mvZ+ubM8CoO+Y6PbBDW17dJESs9hz41JBKx/yuU8+hg3M3qlbTx
 +6C+AD29mt1veuO9lmp+EZVC9UALAHUoQYGTpkB8HgtlgXql6ZHX4h9/mUHaKKAb8mvhJUjz4S
 u4heb0TKH7VlXtHKFdhIpKW7h5MSxEdg9Th/qaZ1LrATvm3rUmYRxpkaln6Qs6zQUneH1J/dKz
 C88TA4CT9yhEavmUVEBa0mPamct6ycHnVEUJTokoUAl9xMrHqZWMfZ6PCKyNMmp3woaqq6eo64
 HrHlVFU5Bc7YghjRh5eBzanR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2020 16:56:10 -0700
IronPort-SDR: do9pklDcTVONtt3Ttkx2h6vBFHADIsIAif4CCB5QDlN+o/p6M+q/C1FckioLzjSWNz0U36SnLS
 NhPKL2bBRfeosFdyBAy5TeHWwfhqEEzMztmAvMj4gGJ1DigLDcUtsAbz8+zQ6Oxg8NHGJGoQT2
 YBlEOQ8g29JsUZGcDm9LldIjeafU76kfgH3fnutCiPIZvNxoPZJn+dmNjC/bKN67v3bR5e8r3q
 3K7X2yec3FozD/cse42XhWDikvzCAMC3K+OfNC6d0cg5qs/dQtwCdSo/4CIXk6HmUWheSEQLLy
 S6E=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Mar 2020 17:04:14 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org,
	laurent@vivier.eu
Subject: [PATCH v8 0/4]  linux-user: generate syscall_nr.sh for RISC-V
Date: Fri, 13 Mar 2020 16:56:46 -0700
Message-Id: <cover.1584143748.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.143.124
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

v8:
 - Add a g_assert_not_reached() in do_sys_futex
v7:
 - Update futuex_time64 support to work correctly
v6:
 - Split out futex patch and make it more robust
v5:
 - Addres comments raised on v4
   - Don't require 64-bit host for * _time64 functions

Alistair Francis (4):
  linux-user: Protect more syscalls
  linux-user/syscall: Add support for clock_gettime64/clock_settime64
  linux-user: Support futex_time64
  linux-user/riscv: Update the syscall_nr's to the 5.5 kernel

 linux-user/riscv/syscall32_nr.h | 295 +++++++++++++++++++++++++++++++
 linux-user/riscv/syscall64_nr.h | 301 ++++++++++++++++++++++++++++++++
 linux-user/riscv/syscall_nr.h   | 294 +------------------------------
 linux-user/strace.c             |   2 +
 linux-user/syscall.c            | 247 ++++++++++++++++++++++++--
 5 files changed, 834 insertions(+), 305 deletions(-)
 create mode 100644 linux-user/riscv/syscall32_nr.h
 create mode 100644 linux-user/riscv/syscall64_nr.h

-- 
2.25.1


