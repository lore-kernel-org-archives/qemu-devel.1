Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEEBC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 23:43:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67896205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 23:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CyAbk/ax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67896205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsbmE-0002q8-Mi
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 19:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58857)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=10717eeaa=alistair.francis@wdc.com>)
 id 1hsbhg-0005hr-80
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 19:38:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=10717eeaa=alistair.francis@wdc.com>)
 id 1hsbhf-0002Fi-6T
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 19:38:48 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:64657)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=10717eeaa=alistair.francis@wdc.com>)
 id 1hsbhe-0002B2-Ra; Tue, 30 Jul 2019 19:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1564529945; x=1596065945;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XNjBwmh1LFBChEJ+quD7Z2691WqYMlE30zxPXnx8bn8=;
 b=CyAbk/axey1QbaIOldH46SVWARgCLC20Xt1V2BSgZRR32q47ri7q9Vy7
 Aq+7LGOLo8tl3ExLKcLOqOie5o8e03HdBqsrNl9zeR7d3ecYC5OqpOYnJ
 y44sb80m9djyjHkPPeMLvdwNIlaFQo1Rk6vHliy3YQdxWIFUYIHQqRMDd
 UPBQ1eoEnL3c+6Ei3VnkZIOSFtDeJ5vSYyOOFkT3e4OeFeNnxp6Y5owvS
 D6ZeYE/qpd0qgMtuxTqmALXEseebnKuuolGvi46Fk7n4YuxsAZaHZXOQA
 wfZ0mkakXlBFq1nvaMTDnts71ZDniyJ3+K9dLGubP+pweBz9sewIzkXFq A==;
IronPort-SDR: Q13MU3nhyexKrVTtwcvZPj4z7VuNPVQVN3j/P3JT0V4qZj8wUDpjtf0SeEyRsJ/bfRnRLxroP2
 /Xv1UGTty6m1gv89OsQX7NVPwq6OIkAL0n8nDZXm9aGglR750bjZMvekMsRysH/DQ+rjTzBo6q
 LazEOqKpYUkGrb6XADiNa6y8JMgeEJPAhtGFu9YKHqelUl6U/slv/gX90Z0L5w7pC3S+uMBrPh
 KmySrqGoioo8NvFmtYA4ZK8ItX9Nnw7tAKLF1r2dpGOpxFYD0ujLdMP4ATn4LjvWexjfee+Amc
 C6Q=
X-IronPort-AV: E=Sophos;i="5.64,327,1559491200"; d="scan'208";a="214723427"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 31 Jul 2019 07:38:59 +0800
IronPort-SDR: VI4HQYTTcvSUUL94Y4jRXLB8epwRlyS+NUbTUamkGz7Wf79sfZPWsHmr0WWlcNQcJGI9yxKwB6
 oURqNdk1/gDx2lxxaL0zZR09G3JRmlnVtDmfCvfXtLbK73hsFcGmanoV9UKha6bF6tBl7wQZxC
 q5gvEe/rWdgmu3bFcpUqgGeOW70xVL1GctT8uKbmkvGkI+xyo13ZNAVo16sERicYu01fIAAbD6
 q68oOIayMaBX96td5QesVagayZ+rrCaUEtqqDL7VXGqoELnsfO425tsPLzT8gjvuaqsCXZWbtx
 iOJLv+vvXlnVk7TrfBg4r1Bj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 30 Jul 2019 16:36:44 -0700
IronPort-SDR: NNOTdrK/BhUqnANVC2MqXAOr/9tzAEDbHAgTFwo5R7+5+xP2ZGPlib/e7JTUffn4t+OCN7pYwt
 GRP0KLt9kUbytvvfhPXYqZAB+SI+ssu84JG0kxm7nVqoOSKUtMqfWPFOqGBjZ0zK0gmFKRKLLr
 QIPO3QX8rdTZCN4iEUJHmyPfqXkKk0Z1yiudZJgKX8lQvPL7CAzEANmHCqgl4NJOxmrtbmsaaK
 jHn7vzijPKjkBTOttGFTuYE+HcUSh03Q2fj7Wm2tjafdLTuCsZAFRjD5rIjdUu8Huafma6NK9R
 Eg4=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 30 Jul 2019 16:38:42 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Tue, 30 Jul 2019 16:35:34 -0700
Message-Id: <4dad98dcc3b6a3f3a5097922494b0521c60570c7.1564529681.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564529681.git.alistair.francis@wdc.com>
References: <cover.1564529681.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH-4.2 v2 5/5] target/riscv: Fix Floating Point
 register names
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

From: Atish Patra <atish.patra@wdc.com>

As per the RISC-V spec, Floating Point registers are named as f0..f31
so lets fix the register names accordingly.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f8d07bd20a..af1e9b7690 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -40,10 +40,10 @@ const char * const riscv_int_regnames[] = {
 };
 
 const char * const riscv_fpr_regnames[] = {
-  "ft0", "ft1", "ft2",  "ft3",  "ft4", "ft5", "ft6",  "ft7",
-  "fs0", "fs1", "fa0",  "fa1",  "fa2", "fa3", "fa4",  "fa5",
-  "fa6", "fa7", "fs2",  "fs3",  "fs4", "fs5", "fs6",  "fs7",
-  "fs8", "fs9", "fs10", "fs11", "ft8", "ft9", "ft10", "ft11"
+  "f0", "f1", "f2",  "f3",  "f4", "f5", "f6", "f7",
+  "f8", "f9", "f10",  "f11",  "f12", "f13", "f14", "f15",
+  "f16", "f17", "f18",  "f19",  "f20", "f21", "f22", "f23",
+  "f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31"
 };
 
 const char * const riscv_excp_names[] = {
-- 
2.22.0


