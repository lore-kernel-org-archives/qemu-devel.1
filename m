Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEEFC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:17:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B1D5206A2
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1D5206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhYh7-0007Yg-Dw
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 09:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYfb-00061d-It
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:15:31 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:34983)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYfZ-0007ZX-UU
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:15:31 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Macay-1j5Tl204lO-00c8rI; Sat, 06 Jun 2020 15:15:22 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 03/19] linux-user: Add support for /proc/cpuinfo on hppa
 platform
Date: Sat,  6 Jun 2020 15:15:01 +0200
Message-Id: <20200606131517.1250346-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200606131517.1250346-1-laurent@vivier.eu>
References: <20200606131517.1250346-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:o+dKIZbsRKlufLowFdEydXySFCUi5viJJfmZ+W6DMnk+ETn8pdh
 c7mZ+ASSBOAQlGHtkSWBJgxqFOw4OUA7+553TrM88KBFJZJDTDbY+OqT3fnbsKWAvbO8Z8m
 1PO/2tLnGOLx+iABnMHhAewxejrky+7KBLAzPtmsQitIwGveQv9l6cmCIfRGq76NTktAkd2
 lYQbAQB9hFaUKqcttnilQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pxMZuhs9OTE=:Mjik3BBGlrR93nCLhQxxHu
 J/op1KDqyUgZIreIl+P2H7Ya41DNH0CgovRHCDlVBnf3criuxg+WcJVrk+ql/yhP7sib+tDU8
 T0iV6Ad2x637K6NIxHtYrtP9Ze/PWnLpgOudY+TDAjPMoEyic3WgDQ9NS4EFlNwWtrkHUZ26m
 ZLMk1L/LXWX8cT7xy4pdHaJDG+jTE5ts7GLONr+VZmMxO/MCgwSe69ZVanF9G56HiDm8COnqE
 E4sCDJHNNZRv2/mK4AjEly1q1IxQhtgijZGnhf5r5oDu2VFuhIirmnPL5u8Xe4qeHj+qUZsRs
 j8ODt5b2qZvnIxVBKjyCu3eL2yNsHHpkpeYU5lD7GdjMAZW27g66Js4AFs/25D/tl4h6WDVbI
 I5ckNX4qRWWgB2/1uo9o+OiBw+LXuN5IYeCXsqqNMtve6BPXjSPypTcev+uqKs3eo85oEB9Y4
 nghNxsS5tpqQ2oX8ZEtjlWHeHesG2X15PppLTblxW1FBegdlXO7MSTQelxFVr+2sbPCEGKqfX
 xxo/4pOnb/KZFLOXjRw5IfAUQYQNQ4AI72dBTzFxwhmOK/YJz8wf7aNNzGki7lpyid62gHIRQ
 c5sdJjyuhXtBSNq5s1X65draMLSyrzEPwTmYqw5vV2a7D9sFYCOStr/TVw/JZJJTuu/Qc7AgA
 RDXQPJ6pFpfVjuv+zMlyAN0mqbBepQXyUw3pXz6d8SfI+SBTWbcQrX6cefasMKOYSVNpeNbhU
 ZwLpnQdSQg3zLd1tOKTOuAENrOBsSlTGdjpBftf+izrsZHSr9CuHexqeVxQQ9sh1Ko5iFpuk8
 SPAA7nf94S1yKmcBDHipD1Lel4j14apzXnRtFuhyrHGJNSwqngw6rUNt+eu1RJEdgSyG+JZ
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 09:15:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Helge Deller <deller@gmx.de>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Helge Deller <deller@gmx.de>

Provide our own /proc/cpuinfo file for the hppa (parisc) platform.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200424210648.GA26715@ls3530.fritz.box>
[lv: s/an/our/ and add TARGET_HPPA to guard is_proc()]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fd5c4f1d73e6..9ac3af20c176 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7378,7 +7378,7 @@ static int is_proc_myself(const char *filename, const char *entry)
 }
 
 #if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN) || \
-    defined(TARGET_SPARC) || defined(TARGET_M68K)
+    defined(TARGET_SPARC) || defined(TARGET_M68K) || defined(TARGET_HPPA)
 static int is_proc(const char *filename, const char *entry)
 {
     return strcmp(filename, entry) == 0;
@@ -7438,6 +7438,18 @@ static int open_cpuinfo(void *cpu_env, int fd)
 }
 #endif
 
+#if defined(TARGET_HPPA)
+static int open_cpuinfo(void *cpu_env, int fd)
+{
+    dprintf(fd, "cpu family\t: PA-RISC 1.1e\n");
+    dprintf(fd, "cpu\t\t: PA7300LC (PCX-L2)\n");
+    dprintf(fd, "capabilities\t: os32\n");
+    dprintf(fd, "model\t\t: 9000/778/B160L\n");
+    dprintf(fd, "model name\t: Merlin L2 160 QEMU (9000/778/B160L)\n");
+    return 0;
+}
+#endif
+
 #if defined(TARGET_M68K)
 static int open_hardware(void *cpu_env, int fd)
 {
@@ -7462,7 +7474,7 @@ static int do_openat(void *cpu_env, int dirfd, const char *pathname, int flags,
 #if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
         { "/proc/net/route", open_net_route, is_proc },
 #endif
-#if defined(TARGET_SPARC)
+#if defined(TARGET_SPARC) || defined(TARGET_HPPA)
         { "/proc/cpuinfo", open_cpuinfo, is_proc },
 #endif
 #if defined(TARGET_M68K)
-- 
2.26.2


