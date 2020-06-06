Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0608BC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:21:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E30206DC
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E30206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhYlH-0006KU-0f
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 09:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgQ-00070J-6t
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:22 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:48845)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgP-0007eU-62
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:21 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MfHUx-1j0mrw23lz-00gsdJ; Sat, 06 Jun 2020 15:16:11 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 03/19] linux-user: Add support for /proc/cpuinfo on hppa
 platform
Date: Sat,  6 Jun 2020 15:15:51 +0200
Message-Id: <20200606131607.1250819-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200606131607.1250819-1-laurent@vivier.eu>
References: <20200606131607.1250819-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:THmXRfsdvAcLBP+SJvjaIxid7FGcXSr0p2Uioo8O0+LTnWtXtvR
 +PVpOh46cLnhT92dMtSzSrBrldXsbvfSFk7/SRV1GUSOYzotxVHW69HtEV6MinsYBu7oacG
 DBUqMgnQFcQgSE12DL16kmH/TkmDbd4P7MqjKpWEiCV7fqV6GH9cYGVZy1KOcPd+L/1mR1E
 gqIytfY0ipIWb+G/6Wyow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KTNSjse3MWc=:tZvT6K5ehiDUlfiy/Q4P+c
 X1YUAzEonyAZmLMC2US0foWrdd6dQTZPfkAHv/3yBJuZ4vukHAc5rQMLxVW/IwRSVb4v6acDT
 uqDOLG4DfA2Uo2Igdplaig1kd5mwYQoB0sj208LRlOgaWvp35OfzE7QaxLPWrbWKdoV8jZry0
 BmUmkHo/FZP89oMiwfcd3//BUK2Ywo8n5NMakytS09+71Khg2a+A27qaIC075t+o9nuNhDIMI
 xuugcknkpSeACIeH5YBaiNd4eYiDPVV8FhhLz5adYDCXGkzLpvUZ2JQ8p1NqkPmR1FYcg2pfT
 YQBUZicPafDNOYGL1huV8+8aU9tBFlmErZuc4Wm6PRwlZER7b1Zcck0G2Ww/NAJSMv6zF+56i
 eMyidArlm6RA0r1wMcE8/y1DQ5QgMonbNR79tTuUnp54CfBHWI3I2qIrz3ijz5pb1JwZlCt2V
 yySaJQ+4zC1yG5Mk8+y+HSo+moWPHGhw5PyprjE1CQ5J+OMk4IlmjUTlRjz0avCpoiBBTzKMo
 DA+/cJK7dU/tSWFACoFWcuJ+Y1I5RBmjxCOvcH/qZSULdnWNUZbP05Zys6nnpCVn5BH4bKmuo
 O0/zT+8encLMJkXSWEIcifPFlK08r77G3F3Dxvkt+Hb7TH7feBQFgVmlM2KShWcq2in9ggdri
 wuS5+1IR88/IMhTTmJ7oABHvJm93geQuhqQb8QYIFR3pOZZN6Q+YptReuhYi+5R/IieZxgzk8
 xef0jGIKnZciSPRTqNzqdtHOuYNFTFo4W30xku8fo6D6pEoZLWx+ehrxSDP2gTvYGr0BxpHwf
 X3sONpiaiGCau0Ti+UibV/tfEj8cnkeS7wOI5f1r3bDewNcZfk2R6eUXHYicSWqTD3ZCZnN
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 09:16:19
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


