Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A08C33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 05:44:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B6022522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 05:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="axnazXxb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B6022522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itmLP-0000CB-En
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 00:44:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2824d4cde=alistair.francis@wdc.com>)
 id 1itmKF-0007n7-G3
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 00:43:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2824d4cde=alistair.francis@wdc.com>)
 id 1itmKE-0000FJ-3P
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 00:43:43 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:8430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2824d4cde=alistair.francis@wdc.com>)
 id 1itmKD-0000Dz-17; Tue, 21 Jan 2020 00:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1579585422; x=1611121422;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=FMdWdt/Z43YWUxuzhWdNT2m+FqenMICqOXGj1pOq2Lg=;
 b=axnazXxbRnkt37uTWwvSngn4ZQumYZF+NDzwZ2rvm3s2mg9v4ipU9O6k
 WtG3jiTqYpt7MjLIpt6Cag39qqbpVdDWLgll9k24h0Q506CsReabWh/ru
 WqIPhi/p0r0WdHHN6Cj3e3CvjxcHIJbWqPQGI6WRJslbthL1E3QaovBD0
 1skpcvi2pToz5cZ/cZQLstRqFgE55XjwIZm361oDRkGXVMZwWXIDS23g3
 6YrJMGXuaeX58x8+RR7Bs6mQ6Qwiq7cucFdfQfihAItFZR5ZOK8l25fUJ
 vt/p1tZI9VaMB+DBTVISaq5+OvrB4/fyisASwZp6hO8LraOOLgb0aBP3R g==;
IronPort-SDR: 4VOcymynlmdcPSsjKwRxnxi08wzEV5E3l/ba2Ap0cSyp2Hfaq+hqZF5dHSLz/qOMxK6xHdz2F+
 ZESrc4k8pBS+8fZlbwr/0eEW4OvdnqLLa3rr3/NECZB5x5nqWHUhrc+pg2HN+QI7hitjTeufKc
 dg4MgM9AvkfZf3F1ZJHZoAP99uf/bwYbntGyo4Mw1BFEfVhl5xbTww3ikYtb4/S0ApliW1En7J
 X8hCLVgLZLeupXrrHjkxhZRoXi7CwLnH7LgYyLS6Gn2IJdFnaDG8BNsTE1k3br1d5N7BuBtiq3
 nmk=
X-IronPort-AV: E=Sophos;i="5.70,344,1574092800"; d="scan'208";a="128661668"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 21 Jan 2020 13:43:38 +0800
IronPort-SDR: Db/JG4eSK859bhXNKSl4/AHkl5JJ8uOGXZBQ+BthxzrvsJbqZO86vc22My8t+QtkoWO2yYYBYl
 VBwQhIjEPuKwCKaU1pPhKo0acrouXB5mbkWduaR+ZLnuzGGa02nIia89DbQqU7vNinHRoWf/tI
 OkXRqV+nKboXdojyB9uBYlUFzNsFJel5iAcXPuXgVPEpWrNwbbZUcZRJZjc8ZOSkg7PESNXG35
 panr6py7Yk65i86JiLlAEnjXgI/bjm6GoZfbW7UU86RoJTVLop9z1+YcAWEh9c6sGWKfcoKkdg
 1cdbGG9EEcu+yuv/X/GoCA9P
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2020 21:37:04 -0800
IronPort-SDR: exNu54BcSpl0NYhcPJIRR0Mi8PJs7ladHxmDqrjivEp12sfX104CeHIGf3LAKqzYAkpDDju/Ko
 EncOac9eygkopobwJlm3buSZRj9mXl+yUUjdbQM/wRtU3he7aCxnpqLtbnz7KMwOO5A4eA8No+
 +ZjSaz4D16XxDrzx8Q6JQTnY/icEiRrLAY+WJ0nG9WoBArQwhMEexrRYLbHR9iqwWwT1e9gjuo
 sYSqz/CysEqYTyLfHDsEyHmyKfDnexnovIrCMD8spalRACwB7rHnShl1Khi4kFEMXY0Ox0OeSv
 jio=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 20 Jan 2020 21:43:37 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 1/1] target/riscv: Correctly implement TSR trap
Date: Mon, 20 Jan 2020 21:36:57 -0800
Message-Id: <62fcfe747245cf8edcabcbe8f1f0b59be035fad6.1579584948.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.24.1
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

As reported in: https://bugs.launchpad.net/qemu/+bug/1851939 we weren't
correctly handling illegal instructions based on the value of MSTATUS_TSR
and the current privledge level.

This patch fixes the issue raised in the bug by raising an illegal
instruction if TSR is set and we are in S-Mode.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 331cc36232..eed8eea6f2 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -83,7 +83,7 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
     }
 
     if (env->priv_ver >= PRIV_VERSION_1_10_0 &&
-        get_field(env->mstatus, MSTATUS_TSR)) {
+        get_field(env->mstatus, MSTATUS_TSR) && !(env->priv >= PRV_M)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
 
-- 
2.24.1


