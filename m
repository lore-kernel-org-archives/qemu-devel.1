Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4443BC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:27:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A7592077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GULrf7TS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7592077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNkJ-0004ZB-4e
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:26:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNbF-0007xn-Mh
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNbE-0007hv-8J
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:37 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7454)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNbC-0007g0-FF; Mon, 09 Dec 2019 13:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915476; x=1607451476;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jH6mftcYVsmiZzVUefmvMW8CKVg0CbGP6k/6wNXTbNA=;
 b=GULrf7TSDHqitHNXg8EWzH1kGg7X5JYKHSRGqNGSwQXHQbR1uMELDJZq
 sFL453JIVvbr5fHqASCZmI4NjtDFStsrSoKTtxPUTwgCtNozzNhnzkm+j
 ufBtBdv9+m/+GTRQhO5GvmJd8PnLV1Rrzr0Mlk8a2Az2uE8H5kPMbyMnc
 q50ypdoy9VOv/vkbZ0bBBIfRzqw+XfLQ0ZDp6UHzRvYTAuMDZ+hoJr/15
 ZiuZ8wL5HsqRz0oSPtUwcuBaYiZqLJrXe9T0FOTMCBvwDP+80HvgyghkA
 BXz3oNCEAQPBg7RjISyazURe5pCTRfwQKm7LSc5GYnQyd8Ght22P5Ry+b A==;
IronPort-SDR: 9jYuiDGFKATtWVRqBKFf1vbuUjr5U4FOuBTxmMdyPE7wb5csadrykuzoCWqyfQhBGdchJlhW9W
 5TdSy0Bz5IpK+4Xh1cBD+BTkLeMi0HDlpc5ozCtKx3CTJ4lsDyi3y2MDDQTfAXX2YaJ2J8/wcy
 nkjLUmViEK3mX1HCB8rg6rYyNpI/KFjZufDlfPq3EjFeqgmM5Fnhu6QNIF5K9B4FUr2CcSsj+f
 CeArLfr22YC6Cff2UOag+Xi8ocQn35emK1xI+Q8lk/PHCL2ISrAZcpCO9PhMJ0WZDIbXw9xv6D
 Qpo=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="226412019"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:17:54 +0800
IronPort-SDR: x4kQtJ9HoPGZdYhKi2pnBVcyHEcWSAoPApw8VAgWmNuxEZJdpW9uE8ID67HjIEPtNn7PFhVI2u
 Wam0pXCGZ0Se8aL51VO5EWC60OrqRjaJZC3OBDIe3Gu8S5n/6zn3TR7KyXGn3DttWA5eGQcsx0
 Gt0f8lwL255ybq5515cU44nqT8jENYUdTez3+OfEZdBq1FdcRmvEaMfjfE8KES+JGRjjEXXq6H
 ZCv4u0CGXW/ww3GZQiKFe6dvvxjjN6PJ9WmSGAo6PYMX2N+wo+0eY1qnX3qoj7RqU4oEmm4gYC
 MexfeXbJP5qJCU3Bzf9VrBau
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:12:10 -0800
IronPort-SDR: aL7kAptcZcvWVkaa/9g2BdXh9RKfJBJYNsk+ImJV8tvp016vLdZDmi9rYGdB9de0s0kZr8kNZt
 yp0ik3a2+n5YDEMdKQZ+T/o0/sUUXpAP26P/rkr5iVPK+wfmYS2j9R/I77kPFiO5pfIr19LxpR
 6URJzMDBG0z5JvCG+gr0Gf8LLAaDx0LY6F5B8Zhy906ZTdzWBZk26+JM8ORBGZWljagWJUfxUg
 bgQREh5v/xVpRFgalXghlDjtWegOvV+EpEtnfvTzPNQzSMeDTr6YmBkZXXjT8Ag5skvJA1WTiw
 u+I=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Dec 2019 10:17:33 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 27/36] target/riscv: Disable guest FP support based on
 virtual status
Date: Mon,  9 Dec 2019 10:11:51 -0800
Message-Id: <36e8fafd2d2e16a50820c6a27850a413a89d941b.1575914822.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575914822.git.alistair.francis@wdc.com>
References: <cover.1575914822.git.alistair.francis@wdc.com>
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

When the Hypervisor extension is in use we only enable floating point
support when both status and vsstatus have enabled floating point
support.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 2c6d2bc3a3..2040fc0208 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -99,6 +99,9 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 bool riscv_cpu_fp_enabled(CPURISCVState *env)
 {
     if (*env->mstatus & MSTATUS_FS) {
+        if (riscv_cpu_virt_enabled(env) && !(env->vsstatus & MSTATUS_FS)) {
+            return false;
+        }
         return true;
     }
 
-- 
2.24.0


