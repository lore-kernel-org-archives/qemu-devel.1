Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF35C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 20:59:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C95972070B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 20:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KzqV+QPh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C95972070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHwZd-0002Bj-SI
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 16:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHwWu-0008AA-6F
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 16:56:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHwWt-0002Gt-1J
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 16:56:23 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:46680)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHwWs-0002Fv-CL; Tue, 08 Oct 2019 16:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1570568182; x=1602104182;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1hkoa5mX33V/oINXuGAuGFK486Bmay+v1fFSCozhO8o=;
 b=KzqV+QPhgRTIXpPFrBJl0G0lmPXTOs+JcNJSQ8MM3cjhdtMj6DJGOSLv
 qxZ2nkHdJFwYaNb8dvGUweh5wm9la8TfNAFhNTvL2ode4uKplN98isFQC
 vI4n/ZOzTJ09UZJP82ZgofQDv4LkstBK21rG/rAfPSJaxgtbAvURpvvt0
 9op3ASgBfqoG3ptb5lBnSn9LIVgBdsCbUQRZU7rjYneYf7wJVmYbdVKm3
 SqpursfUu7RXl3a2u7onrtZzXq3zEfaXeH2j5EGv9YnDr84r7fOeuBwSu
 CU27aqTZA3NQb24cRW65Ea5Q1A7wU8Z9PRMWsGVjT+SRRBCgBbCLY7t7E w==;
IronPort-SDR: WlAvKP+RgEdQVBTSskq3ALJMHPYIPbX5ArYlemWbdqUzwyGXL45yedUNkSpnTHtEtZEwagxeZv
 cyRljjzbFBLBW+cYBr9NbbbamcjKI2vhx34xQANpGbD6Hzlma38+D/QJd1hil2F5EF7SHMR2fd
 6Qz6mFqOwnnJR5qnO0zt1xgIjZP0mrEwiTMoHZNoz8HPgPIezbtNhWsx/NuRSUPuXjoASe+KNh
 eYKSCwTawJGnCmUld9Dl6m7jGmupaJL+XEopi9yrKukUWcg3hmtagd5uWQhDE7sct0V5M81ffw
 xrE=
X-IronPort-AV: E=Sophos;i="5.67,272,1566835200"; d="scan'208";a="227047822"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 09 Oct 2019 04:56:17 +0800
IronPort-SDR: 9qsJ4Kw88xVDeBVnwYpP0OVrZVXc7cnZa3M61pnnrGAUVV7v0CgIUnoiuzfD8NesjUeaNKIN5Q
 t0BKzETnTHX6crbIv93emz7WoJjv60aM88edNQkSOMq3Qu9ClCDpqNyFcA7bXjQGN+aJ/iWQH7
 IDKpjq60df97jWDvX3jTwm24xdE2Xqz8OOqYq4/TLmxG9EC+uBN/OIZdirjabdZlGjNu/Uj+5K
 uee/yKeJDEiAMR3j1N3+9ao22DW7OwHzOmKr7rAOh6E3BdNm5oK1j2qt2/N7LhToNh5U/ra7TF
 pTLjFy0wUL6EhxhFQos0SsZe
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2019 13:52:17 -0700
IronPort-SDR: dJ7yUkgHUg0RcGryOx0a8oHCU3IbkA128u1+YAfnrpnS6y17dbAh6z73JW7KnObuUL26sqOgsk
 WTjR1bP5l2ijTf2bZsuU3bg16rxm8OvHsOIjuFz7HPMfbOOdrniry1PcvevArdJZUG/JTam84D
 8qxt0VuZVAuJNXY4Kv0Swf1z5fDZaHKASvZK1ZEBeyeqGUgpcw1w2SqeCEJVVm6aL0Evlvp3if
 KQUbA5MeODYvezfYD51iHCPMxlWerNtcbENiQgjBLXR3XpLurtyp2JjU8Hwp5EbHSouekcH06D
 zgg=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 08 Oct 2019 13:56:18 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 0/2]  RISC-V: Convert to do_transaction_failed hook
Date: Tue,  8 Oct 2019 13:51:46 -0700
Message-Id: <cover.1570567870.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.245
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


The do_unassigned_access hook has been deprecated and RISC-V is the last
user of it. Let's instead update the RISC-V implementation to use
do_transaction_failed instead.

After this series I used the 'git grep' regexes in
docs/devel/loads-stores.rst and these are the memory accesses inside
target/riscv:

monitor.c:102:        cpu_physical_memory_read(pte_addr, &pte, ptesize);

cpu_helper.c:262:        target_ulong pte = address_space_ldl(cs->as, pte_addr, attrs, &res);
cpu_helper.c:264:        target_ulong pte = address_space_ldq(cs->as, pte_addr, attrs, &res);

translate.c:782:    ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);

gdbstub.c:328:        env->fpr[n] = ldq_p(mem_buf); /* always 64-bit */

All of these look safe to me.

v2:
 - Rebase on master


Palmer Dabbelt (2):
  RISC-V: Handle bus errors in the page table walker
  RISC-V: Implement cpu_do_transaction_failed

 target/riscv/cpu.c        |  2 +-
 target/riscv/cpu.h        |  7 +++++--
 target/riscv/cpu_helper.c | 23 ++++++++++++++++-------
 3 files changed, 22 insertions(+), 10 deletions(-)

-- 
2.23.0


