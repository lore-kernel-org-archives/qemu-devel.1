Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6C1C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 22:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62ECC20716
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 22:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Sm4ynYFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62ECC20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCWDc-0000A1-HB
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 18:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=33364f698=alistair.francis@wdc.com>)
 id 1jCWCb-0006Nj-Cz
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 18:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=33364f698=alistair.francis@wdc.com>)
 id 1jCWCa-0006tR-5v
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 18:21:17 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:2609)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=33364f698=alistair.francis@wdc.com>)
 id 1jCWCZ-0006lB-61; Thu, 12 Mar 2020 18:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1584051675; x=1615587675;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=GoZJQchoYXwF0R/sjN4Tl3zNom6stxJDG2pdHtkur7k=;
 b=Sm4ynYFaI1AOlrqHkmj/KAVbeboptylVAxBS791O+Lcntb2jMo9qgbP8
 SMrG8vdNfJZhISSTqxpkp3seNIh4dKH4X3jRnjzPvE7nTFN0sFHCLPw0J
 t3Z8NemihaBZNlIR0U+cp2vkRrh53Q0eAfwAiYHIjtLx9KjLCUf3pVsm6
 m/QwhprA+yXW8FmL0bZdrpc7TmLY0pgursg0wcLwxi/1tysHhEuSyEpfq
 VDVS6ZSNDIdRzmGkdgOzdB7kDXo4eR29nnMMds74zCa/UUjoToPuUKpZd
 hBdBKjXVVceePgZd8vKp8XEE84jgw16t+xLaK89+tiehDhM5Mmgzqgfhe w==;
IronPort-SDR: Lut0Vvo0Itg0meOTDwZySzO9m6Ka7HzS4MK20d2qibPBbG5pMsZV9RCeRLOqaB7Bc/GIdUGjz1
 pIOE7gsqFkdOiwOoJ0ACRFUoj4QsPBbe7C0cLTlo/mGqD3iNbEX+mbHmtwrqPl6olCxUfp4v3L
 XQDASxu+6cpxHxjLu9sn2P4DP6PlgH6TbBDjEkmx3VZVwItoNDh0a2q9EQcB/5ER32Oa6n8JQj
 oBqCkBFgHc1b8reFAmmTTWjx4SoQMi77ICSSsM4RwkTaJ9wO5LXVi4Cx4rH3aEqb76TMr2wJeA
 hqs=
X-IronPort-AV: E=Sophos;i="5.70,546,1574092800"; d="scan'208";a="132788028"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2020 06:21:11 +0800
IronPort-SDR: s1XmOwgL9Bkb433GEYu0UKihbalBwGFClMJJKKI7gZb6sCF+yE2Wmq3aWqeNP7Jz7FxKYgs76U
 V8ndd/ww4rrAZfd5t+A4qKKQfGoDsBK4kOqcXj1sYOa7IZx1MlgijUmV5WSIg3/Gr7mnkHiBYO
 4SpkosqkNl8B1+vaO6Xe4eDDzcfl4mK2yuLVdUzLKvggfFZ1hKgbRuubkMB0sHOtwEiQP95rfE
 a1ADYKp9ed2E1gdcI+xHke8Q7cYPKlTs4d3I6aZyho+dNoMoKa5viiRdk2Ef7NufGhY+abE2lU
 5qiMwxhVQrA+83f2uIsvcVD/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2020 15:12:47 -0700
IronPort-SDR: oWdRiyV84L1wDmfi0VGDCA6ns5Kvgki3TS1czE0nd50pSpEua5he7x0+eWcqywS0z5q6YJIEHb
 8MioLV+0E4orcU2oqdrv613EL5DIz0AeAyE5wmT+jbwA5GqHbzmHPkWy3KVeUc6j+Syn5KrHoL
 hAT3t6SBi5Scc6Cs8dV3Q6/hDfVj1mtRPM07buU7K/SjS/oF2SR09PjAaJs6xjxiU281+WTT4I
 lvqQ+ULkTHcvvGUnuV+fq6QRoNIv3UARksPijwcihNwP32GnLEtr7hsKLHUuO1FIUll2zdgosv
 UmI=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 12 Mar 2020 15:21:11 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Subject: [PATCH v7 0/4]  linux-user: generate syscall_nr.sh for RISC-V
Date: Thu, 12 Mar 2020 15:13:45 -0700
Message-Id: <cover.1584051142.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
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


