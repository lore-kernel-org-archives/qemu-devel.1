Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E02C33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61346206F0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ci+5Hvek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61346206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixhTR-0003fL-JT
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 20:21:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhHd-0002Jd-1v
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhHb-0006OI-U4
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:09:12 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhHa-00069K-Lj; Fri, 31 Jan 2020 20:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580519350; x=1612055350;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ljs168UZUBbo6dIZ8/dJdfkn8W0XiTlZFPUCVAmDteA=;
 b=Ci+5HvekCRGb3m5Bo9jKQKtshR4IHHu1wstCYx8iep/euHn5fNkIB2p1
 bqjxRP2i4Yw5Gg8bHuiOFyheS9BxbvVaxmhQEsWRg3VM3mEo+HkZNsxA0
 EJUdkJWg06kxigwm0Av9YLcWSQ8WyNE+Nzvjf8Wod+eBMEoQzuvh2SjUb
 /fmIkjTKaOVEuB5XYS33jJ5E8X549Sa5Alv7mjVQG1doulhCrevxDdMYy
 YQnjP4w0M2qvc0Z/00X1ySQ4tElxSLp5HRYnHqAlcFZtAI2zlCDRSJL5Y
 br/za+fgEyzDigJ1jQgn8qnVdyVsOvhm+WTV1i2naOgfJafPcDiPqb7JD g==;
IronPort-SDR: 3WNXANfKrM+n6JSPvVC2Uq+bddaXQWebHlwi5FkWbux14TWq3UqH1ORuer+GbDcnr+tGeb6Qux
 wE/K4Rq8LthMb05J/8ffsykmZz407a+Yp4CFzOLYqzgfO1ON1eX912hh/6Joe9M7AkNtzaEFUz
 RU5+kTT9iSG/Lx0S3IjVn3t+MIKIVm/V2vMj9FiCBbAqSlr+k2ug/JmG/XZjCbuVG+GyNQTyhX
 NUTpDGk2AoZQ9FbeacpCKgALqcEZG/pcxACQgipzArg7BL/ylD2pccXL2W1kR3bEYZhtfZBiEs
 WCs=
X-IronPort-AV: E=Sophos;i="5.70,388,1574092800"; d="scan'208";a="128872467"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2020 09:08:57 +0800
IronPort-SDR: L5dOPhmSK2EpcWFqR04x3vBxpo2zJsV5liMMnhwdGlgCeWF8lBl/C8lJwX1p+eZfM1UZemxxJE
 B6k9H/VVnPYdOb4eYdOFUsPk0rrwA+Tmq4iLCv8wh93S9z1t5fW4EgfE8uMvpvb+yJVqtkJ/zL
 vISBrqK9NHB4GBzzzns8J7dFnxIiKJ8D/RBNgva/qyDwyGwPIoGnBvDB+wZcjg0O62NP/usmBo
 2T6+XAOO3pEZ4+5wFcNdnYgNwTWH791hbLuzX5AvafC9ZZYOrbd0ODFwUT4Fr4th9TcumbOPCt
 Osn38WZtxa2uDL2cV2POIROQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 17:02:05 -0800
IronPort-SDR: arEM/C97mZQZQWiCh3DZCE9iMG5UO787EIFCJ96BijLGwG4FrEB9vf0mye8+2VejRRbQd4BBbR
 rfb7nkWVFuaIAorTFCsRtrpsdk+Gqt7suhbYxy6zaaF+bfCl9feNVdyAxC5CFv4zsfDKvz9cvb
 SvT2S+QjmwTwr8YssnFXRuT5mmTkRk3SjtwgVDY4Lta+qhRWoNYu6x/hyz1apb1P0PhD01TlyS
 qeGj8EeIgV5ie0zGq0gpjJwOci6CJ7TDAi+IAfNJ9c5kUXz5xmiZiauLzaBpIG+9JVuqyR6BZQ
 VVA=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Jan 2020 17:08:57 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 17/35] target/riscv: Extend the SIP CSR to support
 virtulisation
Date: Fri, 31 Jan 2020 17:02:20 -0800
Message-Id: <39eac165cde84450279a4cbb887437fefe75fa04.1580518859.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580518859.git.alistair.francis@wdc.com>
References: <cover.1580518859.git.alistair.francis@wdc.com>
MIME-Version: 1.0
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/csr.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 918678789a..2e6700bbeb 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -743,8 +743,19 @@ static int write_sbadaddr(CPURISCVState *env, int csrno, target_ulong val)
 static int rmw_sip(CPURISCVState *env, int csrno, target_ulong *ret_value,
                    target_ulong new_value, target_ulong write_mask)
 {
-    int ret = rmw_mip(env, CSR_MSTATUS, ret_value, new_value,
+    int ret;
+
+    if (riscv_cpu_virt_enabled(env)) {
+        /* Shift the new values to line up with the VS bits */
+        ret = rmw_mip(env, CSR_MSTATUS, ret_value, new_value << 1,
+                      (write_mask & sip_writable_mask) << 1 & env->mideleg);
+        ret &= vsip_writable_mask;
+        ret >>= 1;
+    } else {
+        ret = rmw_mip(env, CSR_MSTATUS, ret_value, new_value,
                       write_mask & env->mideleg & sip_writable_mask);
+    }
+
     *ret_value &= env->mideleg;
     return ret;
 }
-- 
2.25.0


