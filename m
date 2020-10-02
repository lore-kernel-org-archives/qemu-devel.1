Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8317BC4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:41:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A87320795
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SY/NXHRb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A87320795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kONBU-0002xt-5Q
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 11:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=537b2d3de=alistair.francis@wdc.com>)
 id 1kON5f-0003Rv-Qq; Fri, 02 Oct 2020 11:35:25 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:19124)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=537b2d3de=alistair.francis@wdc.com>)
 id 1kON5b-00037J-Bi; Fri, 02 Oct 2020 11:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601652919; x=1633188919;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nXky0hiYQL7unFY+phKwUBeEu45GGUWKv+isyp58oyU=;
 b=SY/NXHRbdS3ySvKXh17rBf+K99eSTtI5w3KpS98EBiw9m5OgKP7CXniV
 gXmbpzVeuu/GU7CVJOPhM2Xw/2qHWl67q/NQDyfA9s/GEW5IFuaaUuCw+
 CazyG9E2qyYJrNO+j2n6pxKH059yuYAUI6iN+vi6ApeRaC++L+u4laovL
 E+xe1WuIfI6l87UjBvM/yQE4uPkZ5BsfJkQTWmLGRX0zYpkzFvr37/XUP
 7QgGsXtRwx+byfmGeziXzb5EKXk5uDMZCo8Xh5Q0Usv7gYl5ba6OpxuhD
 59AkRhxMFxUUxiMjNyton3Kj33YUdJTeQOrgjPwD9fuRlDW0OHOj79EWq A==;
IronPort-SDR: trE8bIZRI36N4K8rcUvcVDvrvnrovqGyW+HwuYUEirvj/2wBsTJ25UMJ/sWXgBQbSjGNZ7Ckca
 Y2IMEFLbrhvdmLmsaPkTiOFrkeZG37aJzHJlRJ1hcnIDUjg0RIrtrWTFl5ubN6EaR6MjNC8iM0
 uP+9gzWgjQ+woxFN031YqBPsItceQED5VoURwlUJf6mH/JShta/HWFz+guXhOLHT8RJF8A8dOn
 O5XADg2dL4kZOWIcinluAQpqXWm1mHUDaVF59kkHtr2UtzJmehcvVClAmlFUmv7pnN702KbFlo
 g1Y=
X-IronPort-AV: E=Sophos;i="5.77,328,1596470400"; d="scan'208";a="148830306"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 23:35:14 +0800
IronPort-SDR: 1VPL5GCtSXyVNkHb9KHixifoT7Iioi2QJbAeks52hq7xGhWRhCich9Te1NGk2W6j00mMH295ox
 x5J1C9xKUg8Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2020 08:21:10 -0700
IronPort-SDR: LmSpcdF9ZN4T9IsuShKObBGsUNUW3Do3wONzvDoIXNQXwVabeCKxXRIOnv9Aq3TegCYyzNmaLZ
 LbsbQzSX1Vtg==
WDCIronportException: Internal
Received: from dbzljc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.174])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Oct 2020 08:35:15 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 1/1] riscv: Convert interrupt logs to use qemu_log_mask()
Date: Fri,  2 Oct 2020 08:24:14 -0700
Message-Id: <29a8c766c7c4748d0f2711c3a0abb81208138c5e.1601652179.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=537b2d3de=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 11:35:14
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Currently we log interrupts and exceptions using the trace backend in
riscv_cpu_do_interrupt(). We also log exceptions using the interrupt log
mask (-d int) in riscv_raise_exception().

This patch converts riscv_cpu_do_interrupt() to log both interrupts and
exceptions with the interrupt log mask, so that both are printed when a
user runs QEMU with -d int.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/riscv/cpu_helper.c | 8 +++++++-
 target/riscv/op_helper.c  | 1 -
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 904899054d..6c68239a46 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -895,7 +895,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     }
 
     trace_riscv_trap(env->mhartid, async, cause, env->pc, tval,
-        riscv_cpu_get_trap_name(cause, async));
+                     riscv_cpu_get_trap_name(cause, async));
+
+    qemu_log_mask(CPU_LOG_INT,
+                  "%s: hart:"TARGET_FMT_ld", async:%d, cause:"TARGET_FMT_lx", "
+                  "epc:0x"TARGET_FMT_lx", tval:0x"TARGET_FMT_lx", desc=%s\n",
+                  __func__, env->mhartid, async, cause, env->pc, tval,
+                  riscv_cpu_get_trap_name(cause, async));
 
     if (env->priv <= PRV_S &&
             cause < TARGET_LONG_BITS && ((deleg >> cause) & 1)) {
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 9b9ada45a9..e987bd262f 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -29,7 +29,6 @@ void QEMU_NORETURN riscv_raise_exception(CPURISCVState *env,
                                           uint32_t exception, uintptr_t pc)
 {
     CPUState *cs = env_cpu(env);
-    qemu_log_mask(CPU_LOG_INT, "%s: %d\n", __func__, exception);
     cs->exception_index = exception;
     cpu_loop_exit_restore(cs, pc);
 }
-- 
2.28.0


