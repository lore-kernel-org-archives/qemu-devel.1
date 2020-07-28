Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0299AC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:35:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D008B2070B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D008B2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0OpW-00062i-3j
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 08:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k0Oob-0004f9-Uv
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 08:34:41 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:35975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k0Ooa-0001sk-08
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 08:34:41 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MsZeX-1kuPoN0yOB-00txhg; Tue, 28 Jul 2020 14:34:36 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] linux-user: Ensure mmap_min_addr is non-zero
Date: Tue, 28 Jul 2020 14:34:30 +0200
Message-Id: <20200728123432.501354-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200728123432.501354-1-laurent@vivier.eu>
References: <20200728123432.501354-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Y2ExmyX9KMXPBHInR9cJgIGGafjMGPxin0bASUuAkr8/70Pz4Em
 raz9/VAxgZJXZJxjlStLDW9ANTbxeoxFfzJspUeSzfgrBqJ99NpX9h1jhb3M65hW6vF+u4B
 3nPGO8g6EqAMgShCaDBXcUj9zAeycj5OfwIe4oaDES89alsWNvKoO2G0sabytEEW10hgtki
 aD/IcpIf2mu/qAJMMP93w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b1BCzJtxbZE=:PD6/Q5pEJLLVllme/haQCH
 UH/eLgAww0XTykMUKveg7nJsC7TuJg7zBYiL+ji0BZpDNgFxLSxYvFVpki/r4sjNk+tIPdzPD
 zdG3mOBNwOF/6QIlm+qO6Ql6Q73xZuws2ejPTTWgJ/bejvtVA0lp63TZdJgQtR2E9pVW6+Laj
 6ZfS7Q0VMokFlWRqCp44+SY+cWrtyRQ4axmM6OcI0GNgQWHy36jtJGHIjFrznZWv7V5Dajnyu
 Oii7ntwZtjsTCxv3EdnGHFzwL+XbOmdDxo8czPIBol8eqZ7DhfICWefje9ivhFjEH7F93n7nB
 TXwApsRXrRINYvT28BQ/1vy3VE7LJE/qCOEOUUKL18T0+A+fSxkZc7YxcelbZaw+tKrSMD1uH
 MkEa4Uk9M6Bw5eWty+IhvKIy8hh/+Oz3Mkm2CDjQy9u1YI52LXIkidBDMzYoE39/5OEG8+xEo
 vqBpJVrg+OGm/9wDMfMC8bbuC4LBh4Rin6LTHqq9IJomBWoUjtxAV5rNrkIr9pMkRTiaJMJPW
 mxTyivnrlabLRwnu9mIUtjmukH7MprHpazaomNkEsH1buKbXJ13DRsKqBbz2SoMMqsnTxE8Y1
 2+ZyUwoHKkaANDYNFeNVDS04gJ/2shG0tmuGhACt7QtKYsqfBWfUxz2lgbR39MN9kPPIP3/zZ
 Df5aDRV077tKhe5a1j2bzrbP5gc2bKgNgxgdc2iMeX6uNkE+Y7nL3szg91xa3cBxRWvAw7Tkh
 BD3a8RHNmu5DdkKwOUsO0kNxhOwNQUi3I4RMIqgadX0eP1Roq/b0xuNc04gN8pNeHYrwU3VtT
 Met0NlwlqgUMdDU5/9YNYZVV8sdr/t3k8zVDpcRL7pWogEwUKUBQijQ/H3xguxtv5lacyCj
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 08:34:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

When the chroot does not have /proc mounted, we can read neither
/proc/sys/vm/mmap_min_addr nor /proc/sys/maps.

The enforcement of mmap_min_addr in the host kernel is done by
the security module, and so does not apply to processes owned
by root.  Which leads pgd_find_hole_fallback to succeed in probing
a reservation at address 0.  Which confuses pgb_reserved_va to
believe that guest_base has not actually been initialized.

We don't actually want NULL addresses to become accessible, so
make sure that mmap_min_addr is initialized with a non-zero value.

Buglink: https://bugs.launchpad.net/qemu/+bug/1888728
Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Acked-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200724212314.545877-1-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/main.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 3597e99bb10a..75c97851579e 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -758,14 +758,26 @@ int main(int argc, char **argv, char **envp)
 
         if ((fp = fopen("/proc/sys/vm/mmap_min_addr", "r")) != NULL) {
             unsigned long tmp;
-            if (fscanf(fp, "%lu", &tmp) == 1) {
+            if (fscanf(fp, "%lu", &tmp) == 1 && tmp != 0) {
                 mmap_min_addr = tmp;
-                qemu_log_mask(CPU_LOG_PAGE, "host mmap_min_addr=0x%lx\n", mmap_min_addr);
+                qemu_log_mask(CPU_LOG_PAGE, "host mmap_min_addr=0x%lx\n",
+                              mmap_min_addr);
             }
             fclose(fp);
         }
     }
 
+    /*
+     * We prefer to not make NULL pointers accessible to QEMU.
+     * If we're in a chroot with no /proc, fall back to 1 page.
+     */
+    if (mmap_min_addr == 0) {
+        mmap_min_addr = qemu_host_page_size;
+        qemu_log_mask(CPU_LOG_PAGE,
+                      "host mmap_min_addr=0x%lx (fallback)\n",
+                      mmap_min_addr);
+    }
+
     /*
      * Prepare copy of argv vector for target.
      */
-- 
2.26.2


