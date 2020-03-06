Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B430C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 18:33:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 461232067C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 18:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eFvoepmd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461232067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAHmm-0000jP-6C
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 13:33:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=32724e9af=alistair.francis@wdc.com>)
 id 1jAHlW-0008EG-HF
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 13:32:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=32724e9af=alistair.francis@wdc.com>)
 id 1jAHlV-0003Rf-8V
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 13:32:06 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:47137)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=32724e9af=alistair.francis@wdc.com>)
 id 1jAHlU-0003Db-GI; Fri, 06 Mar 2020 13:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583519531; x=1615055531;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hnhaF5RvT9lzfI/K64BjONUKPQNqcdgYEwIREUbIPfc=;
 b=eFvoepmdeNNbYv75p4la56g/AnmMsCO8rTcRq4ijEr2kU1exymWMhh8c
 8kqCovmj4gFuTpknEGrg7gUg2O/kfoRnjRHdm1kBfhwDypUM4ZVv3tQf2
 qd4sh8ON2h/ZcjTLLEMcTAfPP1ZqqehsCeqgaIlupZ/OHKcCR8qt8KAtx
 Kyb6ubhLpBv3JtzerWlgHzfrVCK5l7Ip39g2DOQ2dfgWcTtckJq8yegEi
 h20XNAJF8n904wwyYpCIUTxHUsVsCe/mhLW9JShO7Y+L909wQ0u0GOJf/
 p5MNPF+ifj7KcvXioUdKApiQ433jKCEXHiRbTw3p53MXMVWbgSKZF8D5Z g==;
IronPort-SDR: XLoFDld+QX8fV8L4XOaoBo+U2sqFDfiklP7ZNmubDgJeArfXxSLSpDzfPaKLzIFCrddnyqj1NF
 2ARLOe57Eu/0tNwxEA/1qafy5CgysfRG0FweCqkMqXyjo/0HZvFcY/whZ+c7XhgBkFa108UjgP
 jeI7D506JHeedzzSH3bE1OzMu55H4R2hP7XIIK1dCthwGqWgmlTnMTVL9hzKubnya60Lp/zPmH
 E4lbP0CjQWbKfoKg8m+b0+KCD79CBQkH5dC8Xobamtzrg4zAhTQ6oXLjiu7eIvrggBFAkVddMI
 N3s=
X-IronPort-AV: E=Sophos;i="5.70,523,1574092800"; d="scan'208";a="233755468"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2020 02:31:51 +0800
IronPort-SDR: j+HM8K4WqY9KXAIgMOlCYnuMfWCHcNXXqOLQDc13uOknI2i2AqO9ZkxYWZE5p7NqMdis3qkl8y
 2TzC6ZSIf0/q/B/ivnGofn3NQXCCFrw9mkls0aNtuA285Y6f1yowTWYiU8Z0CDNUCMxNsKi0nl
 SC7ombC/ru8+BaodkbItpnPwQjBPiPoyWVE18zFbi0QA94+fy/LvluDNTQJ/xW4epkJuBbAS4p
 YsvDw9R8SVm99tdgV+u2P/MA7AWyMPfSTK1+h7PDTT0hdi1IN6JeZAEMuXXEJK1YMMF2iljLNd
 howoNC9MLKQAcNj8AuRCaVcy
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2020 10:23:47 -0800
IronPort-SDR: lBLV0u3lRdUgtXjg3Qi1/qvmOkxXTlVelU4Gq8I73zE/UtfovI1k6+LJqiZUNgDAStIwBPtyHP
 oN5VgWp/VzoBWUJKhui7jmygM+EytYDYXflXVr4+iu7yguXK75ps2yxtQlZrDSxAQLXgECZFd9
 eBF0htFu3uWcx99pJUF4a9McDOFYuWC5IXJj7mUnkJIU/V7dQMUouEEbg0MW1tgXbP66X0t8ju
 cMeGTWq5wyHWczlAR5Qzv5VblCFUqYeWv9e8/xXYi5eTv6PI2IyhnPIy8PIN8Ln+kC4ETaoVOU
 ws4=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 06 Mar 2020 10:31:37 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, aleksandar.m.mail@gmail.com,
 laurent@vivier.eu
Subject: [PATCH v6 0/4]  linux-user: generate syscall_nr.sh for RISC-V
Date: Fri,  6 Mar 2020 10:24:19 -0800
Message-Id: <cover.1583518447.git.alistair.francis@wdc.com>
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
 linux-user/syscall.c            | 199 +++++++++++++++++++--
 5 files changed, 783 insertions(+), 308 deletions(-)
 create mode 100644 linux-user/riscv/syscall32_nr.h
 create mode 100644 linux-user/riscv/syscall64_nr.h

-- 
2.25.1


