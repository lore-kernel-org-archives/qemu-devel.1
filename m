Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E68C4BA2D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 21:35:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 602B124679
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 21:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TQg2SU6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602B124679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j74Kv-0007ha-L4
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 16:35:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=318e6e5d7=alistair.francis@wdc.com>)
 id 1j74Jb-0006O1-4n
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 16:34:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=318e6e5d7=alistair.francis@wdc.com>)
 id 1j74JZ-00081U-Pq
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 16:33:58 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:40495)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=318e6e5d7=alistair.francis@wdc.com>)
 id 1j74JY-0007Rf-5t; Wed, 26 Feb 2020 16:33:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1582752836; x=1614288836;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/Yr+NsYahJv8yUruEV1ZVjd4qMjABf1iX16ytZnHrck=;
 b=TQg2SU6Gd+ZCSW3YU/LrDm/xj27h5c+Oq2IhKeHMP8JGiQ9gHsHK7g7u
 sk/xbW77Gcvjy2DfRaH9FIJDjSo1Cn+XrrOzX2wd+J/ioRQLByU7lYKRW
 B6Z5PZl5dP8T++CtUDw6q+Gl54L5+CwQklHt1SkicFM/hXL3Gyi/Opq6f
 FxjLPwRmRjWGrn68veInOOokbdVYHxdTH9vmU6TVcD4tk4cBWNmi1SaXp
 LbFa80fZOU3J4Q64bi1aOQjn+3k0B1F8HOsrHjYyBufkFZaS/cGbBjOv4
 O4lS+PQVh3ANYeqB4v+xZ5SLh3t4zOoOG8R1nOnKDD30mTiaLpQzZQI3/ A==;
IronPort-SDR: Pv/zKOQxSmLoupxcPa3Xla6PNDzBoO9PIf4zF+zC4Di8N8TBNXX6OGGEK5HqbquLwpbmKS4gv5
 VhF23Sdu3k5QhApLulAOY7In+9ZiJVEFey/+ITd9YXEzpfx30rkWYpVTAGBApfNbNzn1AlUpXS
 a7/IxO3OxdLKzzb5uRq1IavtcNGnRz43rRUFkBBGnoDI5jfN4Pf8l01fFqQq58DL3mBgwlkrSc
 EDmhOojnpfnUoVOoSTumaey5RVPuicfpzNxdgXZt+0v+LQc0woCIaJgOXqUOhDIbvPtezgGWSL
 wzc=
X-IronPort-AV: E=Sophos;i="5.70,489,1574092800"; d="scan'208";a="130835623"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2020 05:33:51 +0800
IronPort-SDR: YDjGRmrTA/7sesOnbLb70qP25q65n85tAWlmvMwf0Bfwx7Dz40ZXtjGr7G47yNK4gfCACEu3QX
 K5nx7BQDZbNgGsSAbFfrqSM5IjSNAKaBN622INL4LxdKmoV7nnG27j4Rp6PZl3/+oYoKsB3EmE
 /t27Nw6cwiE/Y2pPjHOkASSJSSwbaanPHYHNBJEgSQe5AbOuBymvCK/0lK3FP4FF0LAX252tJx
 KZmX1R4XS3Y0xKXHuFd29XdkEwv3Ng5q+NWzEsTDY7F61INDxAwPdd0mwlXZENjWsSo2cccjE6
 IkyheiOypzjVVjM9ZjCaG5uI
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2020 13:26:16 -0800
IronPort-SDR: 8ZfNIRpRN7nEllnj073SSzjQgkYMUHbnRPFP4Ge5Gpj7KQUs0uluFfTABNnLkKPT6ktL6mQu1m
 AIUfxaYHeoyS4Eq/87ROUuFQ+JcXSvVASTJ1FJha5xvpok4TGUK2quzlv74fVDz05xklBdTilj
 YIqIEsN9q8RT9Pm+k/uhx3yV41fNfofDkGOCiWjalMP9dWB1WSD3FZbtBy0CPgXbp2DHTtR5r6
 w9FC0j7G8oAC9uFSyizJu3wmq9ybt2d6fCpyIml6tU3FnucYyhlme/49uEWWrMJHvpW+pSRFMf
 Jb0=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Feb 2020 13:33:51 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org,
	laurent@vivier.eu
Subject: [PATCH v3 0/2]  linux-user: generate syscall_nr.sh for RISC-V
Date: Wed, 26 Feb 2020 13:26:41 -0800
Message-Id: <cover.1582752329.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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

we need to make some changes to syscall.c to avoid warnings/errors
during compliling with the new syscall.

I did some RV32 user space testing after applying these patches. I ran the
glibc testsuite in userspace and I don't see any regressions.

v3:
 - Fix RV32 syscalls
 - Fix #if around safe_wait4

Alistair Francis (2):
  linux-user: Protect more syscalls
  linux-user/riscv: Update the syscall_nr's to the 5.5 kernel

 linux-user/riscv/syscall32_nr.h | 314 ++++++++++++++++++++++++++++++++
 linux-user/riscv/syscall64_nr.h | 301 ++++++++++++++++++++++++++++++
 linux-user/riscv/syscall_nr.h   | 294 +-----------------------------
 linux-user/strace.c             |   2 +
 linux-user/syscall.c            |  20 ++
 5 files changed, 639 insertions(+), 292 deletions(-)
 create mode 100644 linux-user/riscv/syscall32_nr.h
 create mode 100644 linux-user/riscv/syscall64_nr.h

-- 
2.25.0


