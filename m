Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87404C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 11:03:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59E2320671
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 11:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E2320671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfLkQ-0001ey-G0
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 07:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jfLjl-0001An-DD
 for qemu-devel@nongnu.org; Sun, 31 May 2020 07:02:41 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:59031)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jfLjk-0006Oj-9M
 for qemu-devel@nongnu.org; Sun, 31 May 2020 07:02:41 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MFL4B-1jlibL3fmD-00Fjz1; Sun, 31 May 2020 13:02:35 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/m68k: implement fmove.l #<data>,FPCR
Date: Sun, 31 May 2020 13:02:31 +0200
Message-Id: <20200531110231.620711-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gRXlPp3ur9V9PClMfEz5Kcot4hH4+G1Frpu/j6M5h4iEo7sZPPC
 4u5pwEgsK/0imq8xinGXfhR1ET4OHqvOxmB01i4EOb7fXfindYSYXnBVzQZaIGT4IAfLP7U
 OZz7I05svbNJsLu8RMUUO0IfY1Sl+bHT1lT77wyqSqWH7Zg0IikIqyVvypTDYddlhaH8DM8
 pXDbmP3L8SSNXEiS5d4sg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7VIazFhr6/o=:6wy0/jbWo6ISJoPF8+A4wS
 PJIo0BqNNizhrYdri/7V+gY1X9evt8gvdBPuQJx93DjqP+wwQMez0A/FqRIF743HY1A2Dv0UZ
 46rUYq/ds8+UJRy6bxDS9Z4OTvtIBa4Tz94kmwNK9sjoEEJd9yLePgDWXNWi/x66m3k81z9sn
 ToMZ3PCG9q/XZhL8uY0KG3MCUPMezthMu7xAmexXcNYbwDyRHl7Uzyw0be3YKaCAHVZf8FFrI
 iEF/pr5YuZjC9Ojv5642jZPXXlWZMyuW02MP8hQVrU4Yb/YQxG29SUj2WNQ1NqKMXYBASQyD8
 N2deWU64tF0wCliZcRWWobUyM65fXU7UC+gpab6tY9iN3JVUiUZukd9pTQS9cGg+Fw3oZwP7F
 s4x41a4XS/mUMiYLX8LLirFQsLXMbT2yUYcQFVwT3ByM0zS13Vqjv1ZkOlRmt39H8wfw4nnPN
 angb8GC3XZnDwWZv2NAoaccfY7l6G+2YlM68L+oxGiFE8WMQANcSSwA8LBuk3pJMKVE43GY4D
 /q96yPf/sd948boDo5rLFKIxFVRZPIgTqlwLjNN3Er2YEY+Oi39j3w6oJYqy+K+9WAIQiUWr6
 k2IZMoe9lzhw0m6TuYSBcZIqhzBl1aNOxVZrnP77c0fvgkV6dL+nKxbT8wpurKEFUNCxQT/2O
 6F0LE/Et+w/jboiwS4r784aC97NFgtrj+e215eDr8npCqfVBUMCzAhESRHNh4qxEc4Z+BBNdA
 PCELz9wneTrBkUNg62E0CLm4/oKiQedw7CXapKFEANCm7wbUdKjkRNWJBxeJ47pfguh8vdMNW
 yXDaQ6OcDMyk4mRP9RMCp+UjI9VLsgckHFGBfEyZUckhF1iyUvI3W2wYa6w20rdZ1OKbCPf
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 07:02:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <laurent@vivier.eu>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The immediate value mode was ignored and instruction execution
ends to an invalid access mode.

This was found running 'R' that set FPSR to 0 at startup with
a 'fmove.l #0,FPSR' in qemu-system-m68k emulation and triggers a
kernel crash:

[   56.640000] *** ADDRESS ERROR ***   FORMAT=2
[   56.640000] Current process id is 728
[   56.640000] BAD KERNEL TRAP: 00000000
[   56.640000] Modules linked in: sg evdev mac_hid ip_tables x_tables sha1_generic hmac ipv6 nf_defrag_ipv6 autofs4 ext4 crc16 mbcache jbd2 crc32c_generic sd_mod t10_pi crc_t10dif crct10dif_generic crct10dif_common sr_mod cdrom mac_esp macsonic esp_scsi
[   56.640000] PC: [<00016a2c>] X_UNSUPP+0x2c/0x3c
[   56.640000] SR: 2004  SP: 3eb5e68c  a2: c02e239a
[   56.640000] d0: 00000040    d1: 00000002    d2: 8002adec    d3: 8002ad50
[   56.640000] d4: 8002c768    d5: 0000000d    a0: ffffffc2    a1: ffffffc1
[   56.640000] Process R (pid: 728, task=a3dfda5d)
[   56.640000] Frame format=2 instr addr=00000000
[   56.650000] Stack from 3a4d9f30:
[   56.650000]         41000000 00000002 00000002 ffffffc2 ffffffc1 1fff0000 80000000 00000000
[   56.650000]         3fbf0000 80000000 00000000 00000000 20000000 00000000 7fff0000 ffffffff
[   56.650000]         ffffffff 00000000 00050008 00000000 8000067c c02c2000 efffee20 000002d8
[   56.650000]         00002a28 3a4d9f98 00000002 00000014 fffffffe 8002c768 00000002 00000041
[   56.650000]         00000002 c041fc58 c0743758 ffffffff 00000000 0008c075 00002b24 00000012
[   56.650000]         000007d0 00000024 00000002 c05bef04 c05bef04 0000005e 00000077 c28aca70
[   56.650000] Call Trace: [<00050008>] copy_overflow+0x10/0x28
[   56.650000]  [<00002a28>] buserr+0x20/0x28
[   56.650000]  [<0008c075>] bpf_check+0x57f/0x1cfa
[   56.650000]  [<00002b24>] syscall+0x8/0xc
[   56.650000]  [<0000c019>] dn_sched_init+0x75/0x88
[   56.650000] Code: 1017 0200 00f0 0c00 0040 66ff 0000 05ac <f23c> 8800 0000 0000 f23c 9000 0000 0000 222e ff84 082e 0005 ff1c 6600 000a 0281
[   56.650000] Disabling lock debugging due to kernel taint
...

Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/translate.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 0f80888203d3..c093f6c683e8 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4936,6 +4936,20 @@ static void gen_op_fmove_fcr(CPUM68KState *env, DisasContext *s,
             gen_store_fcr(s, AREG(insn, 0), mask);
         }
         return;
+    case 7: /* Immediate */
+        if (REG(insn, 0) == 4) {
+            if (is_write ||
+                (mask != M68K_FPIAR && mask != M68K_FPSR &&
+                 mask != M68K_FPCR)) {
+                gen_exception(s, s->base.pc_next, EXCP_ILLEGAL);
+                return;
+            }
+            tmp = tcg_const_i32(read_im32(env, s));
+            gen_store_fcr(s, tmp, mask);
+            tcg_temp_free(tmp);
+            return;
+        }
+        break;
     default:
         break;
     }
-- 
2.26.2


