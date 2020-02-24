Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFDDC35DE4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 23:30:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24CA720732
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 23:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="g4huoNMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CA720732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6NAw-00038c-7N
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 18:30:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=316f2015f=alistair.francis@wdc.com>)
 id 1j6N9v-0001w3-Bt
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 18:29:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=316f2015f=alistair.francis@wdc.com>)
 id 1j6N9t-0003h8-Ng
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 18:29:06 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:4174)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=316f2015f=alistair.francis@wdc.com>)
 id 1j6N9t-0003gT-2C; Mon, 24 Feb 2020 18:29:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1582586945; x=1614122945;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6nlvhj4e2J6SSR0V7PBzO9S+jbx6jNBp6RnKq9ByxI8=;
 b=g4huoNMBKBHhFuGNtEfYISdDKGuHmOOfZ1w4+jcMXUiAVo2HnVSixCn/
 xvqE/0TwWuwrM5s3Fkxi8HZjltNmK68U/lsScCRGKKy5HbX2OktO/4OIR
 LRK+PT163n8/mVEit2vuJr/tvlpHQ3YTXRbG8zf386E/anD2q3DlwlcPm
 wyZB1BCWSU2cfgOxcTDk2YWeq34vZ0Gv7vf1/u96b3VX/fC3IHdlDTJ82
 nN6T3DW3Cp0biMppPVBKpZOWBfAr2ze+JnPmN4pDr8quOdlYEExq7OFaf
 MyVf7lT14cd4Hkb99NOOEFp1gBMGO9LYfs7SwvXaZXhTy9uqM0RsVSXDh A==;
IronPort-SDR: YvaWxmAo6d6lUymxWeeilcPt2RxTMtSLdCz5UC5GpSMTRSLA5eIh82Hqeo9xMEycefFubJnR9z
 EpZCM+REhL4qFlsthaOJz3c6YQOQMFQdPriANumTaNR0d/wR5gTPCElffXUGMQg4OrJQBmfb/e
 fLDT5w2fn73UemWVTvvG2+MVtZhfcX97ghURpIHy9KEp9W39xnL0hngEM4PykqLNL6QHO/b08K
 Iz+uLJomEcj5TKkqv+MezLTtIIogxr1C+HMkNOJXX+ixYJ6fr/9aJKj1/ndImvtLknnQoKqQkU
 ygk=
X-IronPort-AV: E=Sophos;i="5.70,481,1574092800"; d="scan'208";a="131148347"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 07:29:01 +0800
IronPort-SDR: YLBasxiRWBJjQH2lZDbw43QbKRxukazJ2n5z0V+MJJ24cUXkOQ+ES+Bu7U8wVMZeUJCjKhXR7c
 Pba3+ZzgUe5KPPE8orzzcp905v5p0WyYlBYqCXBl0npDcbx/tAzo0XegOupgYqbnxf1vyjE2yc
 CvD7XBl0ona7bvisxxhqs3dkqRckpFGf7VwzeuWuSnGN4MWX3Oa9mZna9EOzBYfkfVtmyb5/yq
 djAbrLGq3Ze7nDeGbwO0NkUZN9sKBcBHeM8ZtElB2/ivfYfCAYQMcZsbE0PrUX6XwsOd+yrbBM
 vldG0iTCZLEHOTEQ38x6nHm9
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2020 15:21:28 -0800
IronPort-SDR: pUEzuyVTCgJMD7WF13yAX0ry0CgN+85trRXeqKQnC0il+cYaG6YLzVXhn/zLtCQZV3eK2P6Zvp
 tfyb1uliQDp+XcPOWTNo6quyX2kb0f+zNN4SLVHkIQN+TliMeQcgKV9ucooFDmzlbtaUVpjWZS
 /ANQvbJQ88mUBWnXSBTgKalFW3GUftsTLzg2dqlXaO2KFrsdHFwRXRUK6aXKDdgc/tvqAQRCyd
 hTuNAgcZDhC/oZf7D25/l2F9gvs2r8In3Fqe7ABPW4awajKqBdqoQmDpXLr5/9pBs1BdRC57zj
 DE4=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2020 15:29:00 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org,
	laurent@vivier.eu
Subject: [PATCH v2 0/2]  linux-user: generate syscall_nr.sh for RISC-V
Date: Mon, 24 Feb 2020 15:21:52 -0800
Message-Id: <cover.1582586444.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

we need to make some changes to syscall.c to avoid warnings/errors
during compliling with the new syscall.

I did some RV32 user space testing after applying these patches. I ran the
glibc testsuite in userspace and I don't see any regressions.

Alistair Francis (2):
  linux-user: Protect more syscalls
  linux-user/riscv: Update the syscall_nr's to the 5.5 kernel

 linux-user/riscv/syscall32_nr.h | 314 ++++++++++++++++++++++++++++++++
 linux-user/riscv/syscall64_nr.h | 303 ++++++++++++++++++++++++++++++
 linux-user/riscv/syscall_nr.h   | 294 +-----------------------------
 linux-user/strace.c             |   2 +
 linux-user/syscall.c            |  20 ++
 5 files changed, 641 insertions(+), 292 deletions(-)
 create mode 100644 linux-user/riscv/syscall32_nr.h
 create mode 100644 linux-user/riscv/syscall64_nr.h

-- 
2.25.0


