Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669DCC282E5
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B0221848
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JJjCXtJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B0221848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33612 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUKHi-0001Hk-B9
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 20:11:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUK42-0005au-AX
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJuw-0004Ub-Bp
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:48:07 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:5520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJuv-0004TN-W8; Fri, 24 May 2019 19:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1558741686; x=1590277686;
	h=from:to:cc:subject:date:message-id:in-reply-to:
	references:mime-version:content-transfer-encoding;
	bh=gGFuqft3Gy+jQsmp9J8ov+i4/Ieho2R14R8oFQ3Co8Y=;
	b=JJjCXtJUdllU8tQwR/u5zZcFDk0sZaERhGLKxtVyPDf3RiPBuGjXJqdv
	wAwf2oISyk7fl2yF9l4SwQKFPC4B6lsFDxYFyZKHlPdjwE1CNuV3ogdvd
	fSVvEY0lDCbSifbNRQNq9tPkYGKYDKsIHG61k/FMRfBcqBmLrPcz/veUM
	mMOznYVly02mO6CyEDdtDurEd5LsrnFkNMMXgUlCh5cweJ2pkU3AiQMJM
	zF+T7hx9/Rjhn4SZyiO1fhIn8ZrFMOGepKUrdL7qAAbX2JB50oxI8ydks
	4VcWWEKCtN0A03/JjPEiwVOq5EhYdSvX9ysmsWsZYDDkho2AHVUkbvd+A A==;
X-IronPort-AV: E=Sophos;i="5.60,508,1549900800"; d="scan'208";a="215265016"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
	([199.255.45.15])
	by ob1.hgst.iphmx.com with ESMTP; 25 May 2019 07:48:04 +0800
IronPort-SDR: FIZK7D33MqSuWYJOMmcc+Gf+Fx4B8kzn0tVrJgzNN6cxfGxG9+MBEezQtBC/aCraz+y+fxK8kG
	Zjb2dx7d0HXrJH4ooclj8pqfjh4awdTQBuh0v/O2NO4cN9wZ16eJifowUEruFI7/1E9V0cgc/z
	3EXMBN2I0fAGhKko00TE/qIoHlP2Q34I7bo7ivIzSllLkI52gncGgQgILd2W/+p0eD346+ORU6
	RvxS8obFhnpuVrsHuIns2taM3Pt/DfGDHHnGhEYvbw4/2j70NrvEdIoD+831og9eCPC0l4Zm8i
	qWsRz2jVeRoP+WC/iPV013MV
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
	by uls-op-cesaep02.wdc.com with ESMTP; 24 May 2019 16:25:43 -0700
IronPort-SDR: 81Ph2PkovrGGzJ2Clj407IS1Bz6ZXeQ2fLQaR+kVh5zLkoLS3jKeCstSI40Nhrp6mS1qw4fAku
	Po/qH1LwowgMelUcVonZ25TA07UChdRdDuJv9C7HMLFyWoUVIblehMRoGem2OTvjdGPYUP/rVU
	1pdnpp1W6OL75Zr4UPtRUWLRntSPZs4utxpI1WVxZGEuOm9wFkTn584g/JkTnE+pwH/29dKR78
	OKJ7alIKzIfvZQQAefs5bcv2pC4wP5+LcCreb+hgdrlAS0FtUNLkaSutK3c94UGeakB6IviqDi
	Esk=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
	risc6-mainframe.int.fusionio.com) ([10.196.157.140])
	by uls-op-cesaip01.wdc.com with ESMTP; 24 May 2019 16:48:04 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 24 May 2019 16:46:09 -0700
Message-Id: <e5110fbea0b6b10f0a8b2f165eb5d95b47fd2536.1558741334.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558741334.git.alistair.francis@wdc.com>
References: <cover.1558741334.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [RFC v1 13/23] target/riscv: Generate illegal
 instruction on WFI when V=1
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/op_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 644d0fb35f..e08bb8dd5a 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -130,9 +130,10 @@ void helper_wfi(CPURISCVState *env)
 {
     CPUState *cs = CPU(riscv_env_get_cpu(env));
 
-    if (env->priv == PRV_S &&
+    if ((env->priv == PRV_S &&
         env->priv_ver >= PRIV_VERSION_1_10_0 &&
-        get_field(env->mstatus, MSTATUS_TW)) {
+        get_field(env->mstatus, MSTATUS_TW)) ||
+        riscv_cpu_virt_enabled(env)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     } else {
         cs->halted = 1;
-- 
2.21.0


