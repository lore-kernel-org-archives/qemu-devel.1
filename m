Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACA2C4332B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 22:56:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 232DC20767
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 22:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WYQY7s6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232DC20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEhcA-0002Ac-8N
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 18:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=339f800bd=alistair.francis@wdc.com>)
 id 1jEha2-0007MZ-H3
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:54:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=339f800bd=alistair.francis@wdc.com>)
 id 1jEha1-0003TD-6b
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:54:30 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:54476)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=339f800bd=alistair.francis@wdc.com>)
 id 1jEha0-0003JK-Ea; Wed, 18 Mar 2020 18:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1584572068; x=1616108068;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=IzQEovp1wQy5hOtiVouEqP3RQ3LG6kZ+Qog7GBwA0CM=;
 b=WYQY7s6AdQRguEbJMy3VKS186ZiW7rBUplXgTuGAszRYrqL8OwRYmT8/
 LMsmyRVDcsumYEs9U9tuG+YQRE6YdavxH1dzYM0cihNs3iL/PCaQhrLlG
 UtYBSLZJ6fHUixH8txN4cFwLLWq7ZnYrCIzlfbgx1el3Y8k7VHGVtqbIH
 Z/2cLh8/c4xOxfuJMjb9ll52uUR1FGTCXUQ82gubFnbZbeXUUcQ4Oxpnf
 lr9v9Z0Va59/7EIDC9O2eb0LCg0hbOWgIAUYfIFT7VavtSgdacli5Qnui
 jjfQ0AiX70ehkPr7v45h3OCCw1doal+ypedzHaPPQd+zLpFM6fsYQVZER w==;
IronPort-SDR: TpWf4Z4+bjYmrsZIUVuyhJBlUsf8ooJTNtd5O2P33d1yPKIW7v1kHtBGy4onPJ6e7Cii4NjF02
 IK5iyvQTKbieD7BZv0rKpzL3SZKi31smwZHLM4HJNw0w8UWFDpLRNmymKbrg/cs3FRseOxYItB
 wouMVB2IEo0DD/LN2Nx/t6zJjJsO4hpOojFIl+XHMw35dM/Ra0Qtb49lcdF6kfThGFzxy5YDpW
 3dttEb5n7+KurT7CoIPMLYhYweyCZ0eVXTQ6X3F4QoqseMUvuHiIxVmxRFMF3JVyO4dNFal4yx
 eX4=
X-IronPort-AV: E=Sophos;i="5.70,569,1574092800"; d="scan'208";a="134342885"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2020 06:54:22 +0800
IronPort-SDR: qnyCV5NRvmlHCyD6Vm2xj1ykGIt/egHYBJU33FpBA4YNag5AZQACpgVUGzeN8m4YLXvUDjvSFE
 Wn65jSDbL8em7OR6SvUo1b7FOxkyh+kStbeRt0Ngez3uK2JZCY9pUjLDOGBdf6X6bzp6RD9DJx
 4sdiIgUtUnrPcO+rY5yOx1GMge7U9MQleINU5yBI5DWm+RICVv1d744N9EsSiWESzb3y0+uME2
 capo4qSlzyiuXXq5A6NB0pYTT+srqVRlqls+/ZBiyq6mIbnpHxF4ZJKP7Efyyv1piASUKJvs2v
 vuiN+gS328ceKbmYRB/Oy8lf
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2020 15:45:47 -0700
IronPort-SDR: hPonT7vMrE+slb86VZDf6xFx9pUjqbZUOS1c5TwWqIA6PGH1Xm2mk3KfJtgEalI+rFnOh+ly1Z
 e20rKyYIQzdU7yO7EWQpG/kojqfuVc3HQr9QUZDwupctqRe91gh8S9AUyQSqdIFzDiS3tV9WVG
 uZm7oi5WBfKQ32AjLYE6foAPygua6L+j7ce/Dr/P+kpA91Se7ZJIwlthJ0zIFyncop+kmDj0Fk
 BbGlRFIKgYzYIKXeB2iQ/aC/rqpVvXDXRcO2IGPqkaooeSteNMOiWvcYi5AQLDo892GDFoBaVK
 tp0=
WDCIronportException: Internal
Received: from usa005961.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.54.167])
 by uls-op-cesaip01.wdc.com with ESMTP; 18 Mar 2020 15:54:22 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org,
	laurent@vivier.eu
Subject: [PATCH v9 0/4]  linux-user: generate syscall_nr.sh for RISC-V
Date: Wed, 18 Mar 2020 15:46:53 -0700
Message-Id: <cover.1584571250.git.alistair.francis@wdc.com>
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

v9:
 - Fix futex patch compile error
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


