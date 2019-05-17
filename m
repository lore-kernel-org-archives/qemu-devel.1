Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47131C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:14:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12D7B2087E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OvaFUob+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D7B2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54323 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRl7r-0000cz-52
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 18:14:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=033a92d29=alistair.francis@wdc.com>)
	id 1hRl5z-0007tX-LH
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:12:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=033a92d29=alistair.francis@wdc.com>)
	id 1hRl5w-0007IJ-NX
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:12:54 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:41010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=033a92d29=alistair.francis@wdc.com>)
	id 1hRl5u-0007Ep-U8; Fri, 17 May 2019 18:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1558131171; x=1589667171;
	h=from:to:cc:subject:date:message-id:in-reply-to:
	references:mime-version:content-transfer-encoding;
	bh=1P5qQVKzrpTrWYHCy5Y+UMpW1pxkR7dCHPH3WsXz+P8=;
	b=OvaFUob+wZt67Yv/mblaaxSjuUoe4miSuwRkVHHZCDKRlUPSW52TTuwr
	QKKwbLm6moWJyIfr4TbF2UY4eyvFfsBVTdyn4r7zXvX/J4CRMT3opdSCW
	VHGTiITNUk4qqh4BSrHP5/kH7FlspVRFcIED7GoZgVpi6tg+0RvIAhaa1
	iiGtxy/d1i66/NoYEMRhM8rfLFcqegbM2rswBurHxcPUlxxKGlNHQeOUr
	vWdZXq/HKB2MN8JCL+QxPs5QJpDogKCNmgM0Wa5gWrUSUUTkEGkyr9yYg
	MaFYF2GY6P4XvCicBiZD/1IN95dQlB2SPNPXr1gKdKM/L+M+ZJsdbaCRP A==;
X-IronPort-AV: E=Sophos;i="5.60,481,1549900800"; d="scan'208";a="110242474"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
	([199.255.45.14])
	by ob1.hgst.iphmx.com with ESMTP; 18 May 2019 06:12:46 +0800
IronPort-SDR: o3M2jrXjyaPSCri3UE3ELuMYg7Kqs5Iuh9xPGJFDy/WnMbQ4ZPakLSg3jTqLy8DIVcDvcukT/K
	E7+CH+q2oKRyxj8mfo6qChu0jX4UIrUEkYrWeUSiHUf3lmx6Rx+pnMeVjBUXaFHXoFsaFDvOPs
	kb5JTBWutv7LH2vLTpRa0+MhR21C8MLQjV+sxBBR8zbRmycmQoYEcKauMIcYQ/K5w34VxjGFlz
	ArJE7tX+M6znBeLRxa3rht/XC7Hz4i50YnLykG/Xy3rRZ7YDGUA22JUx1fvQtF6UtvEJ2VR+z1
	UcYNyo/OXZah1Wb+GJJAhHJi
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
	by uls-op-cesaep01.wdc.com with ESMTP; 17 May 2019 14:48:15 -0700
IronPort-SDR: iO/Mcn4Z0aOYIqHXKCpsljROJ4JsxDQNKRw4JTLJAkeNoSdzWk7g7n/PITcgsHDFI24DBlX2Gz
	vMbJy4n+Efy3FRKEN71Xw0cQmz9Hh49SjrRJktPIDYuDqJN72iRsz36Axt66tuXHns6fXUpCvt
	ZVyAGoiyZaG1kPvAYZmFOKQu3jRaVAU1tlclhc5XTMRXw/4QVv62wiRvAEznIUG20K+FxudiZ0
	JD7HGjD/Q4XpfC4f+Fgz5ClpvzZ9JGUUpVJH/qFO4RLItuwZzmhHzAcKltDlH1JUFpY9yzApuK
	7WY=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
	risc6-mainframe.int.fusionio.com) ([10.196.157.140])
	by uls-op-cesaip01.wdc.com with ESMTP; 17 May 2019 15:12:45 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 17 May 2019 15:10:58 -0700
Message-Id: <bf4b3ebaaf429e6df494b0b6c06834910ae727f7.1558131003.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558131003.git.alistair.francis@wdc.com>
References: <cover.1558131003.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.154.45
Subject: [Qemu-devel] [PATCH v1 1/4] target/riscv: Fix PMP range boundary
 address bug
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dayeol Lee <dayeol@berkeley.edu>

A wrong address is passed to `pmp_is_in_range` while checking if a
memory access is within a PMP range.
Since the ending address of the pmp range (i.e., pmp_state.addr[i].ea)
is set to the last address in the range (i.e., pmp base + pmp size - 1),
memory accesses containg the last address in the range will always fail.

For example, assume that a PMP range is 4KB from 0x87654000 such that
the last address within the range is 0x87654fff.
1-byte access to 0x87654fff should be considered to be fully inside the
PMP range.
However the access now fails and complains partial inclusion because
pmp_is_in_range(env, i, addr + size) returns 0 whereas
pmp_is_in_range(env, i, addr) returns 1.

Signed-off-by: Dayeol Lee <dayeol@berkeley.edu>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index b11c4ae22f..a2fcc90d73 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -246,7 +246,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
          from low to high */
     for (i = 0; i < MAX_RISCV_PMPS; i++) {
         s = pmp_is_in_range(env, i, addr);
-        e = pmp_is_in_range(env, i, addr + size);
+        e = pmp_is_in_range(env, i, addr + size - 1);
 
         /* partially inside */
         if ((s + e) == 1) {
-- 
2.21.0


