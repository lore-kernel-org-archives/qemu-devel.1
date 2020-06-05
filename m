Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E370C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:42:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 243C6206E6
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243C6206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhAk2-0003Kl-Cl
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 07:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAj6-0002A5-At
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:41:32 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:38477)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAj5-0005el-B4
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:41:32 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MIbzB-1jmvLe0kpZ-00EdE4; Fri, 05 Jun 2020 13:41:27 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 03/19] linux-user: Add support for /proc/cpuinfo on hppa
 platform
Date: Fri,  5 Jun 2020 13:41:04 +0200
Message-Id: <20200605114120.1051236-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605114120.1051236-1-laurent@vivier.eu>
References: <20200605114120.1051236-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ktzu7gJSUVZNNv1Qs1OpSvAJ4zNi8z02hVt7F4Jc4dhN1rmHGdZ
 YVvTzQUYJFcIIjGC14EYvrx5G72GMSv+ZGbBZvNmEkKxLc6BytHZK1OwynbbWs/LR7xvRMY
 hXRTwMc295nO57mh4m4i29Q8JgQH6pG8g03aC5Mxo29c0GtYP4/ZxEA/CKl8IB2/FcQUgf9
 UQjqwVILCXEXo5JY2n+Kg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gEqkqLsGtoE=:expfnda4zky+58R/lDPl4m
 M1QLyF/Z7W41fMi3IXro730mu9mGTI7cRo3tkfIDHeIO58/TK0OBY+32b0cV9T9aRvPLrD7pi
 UnHxJqL6Zz9Mk1r5xQYo7ZiLF6T+Y2XzsPbvmTUv89e8EgUrn6phOSR7y/kjcPuobYzbrRtNr
 +vCbZC9s7eQxGJOhjkIMAyw08LkKn9ldbNfgtiFV0Pm3t3PmJHcHh62913MqSezkNGkCVHdyp
 U7TULXobSS+jPVa+ND47lq2V7sj/5b+dVvdYwIfV+Fjyf/Ir8boq/ikQnTt71zg3n/jzWwG+Y
 A/KEMylysSbn9a/SQCitsSMcS2x1It3F6Vwvz4+CWcic3UlTG9jQQlrYQWlNiAcnmA5D5uvK/
 WV7fmsW4SKlQlcXrdaS6VWjP0iYH1t6h6A7zxoXh7HUSn+nRbCrQQqQE360vJ7zvruK/+YZ1E
 R0qntUIbv3pDF3nu/XjANYPwJXmRn1HyhUa0JsuUqGG6DuyjYxBBJUM4GEGpYt0tssn3CCZpk
 eDxJ1v3/P1fMKp+S5VbLeyk7rRq8Fc2lC1ux0uUR53iIC8V6K4ZGaqGnbTl4jW8M/Dz7kYVsM
 X9/7TqBlPX/8QuP1JlQstOWMZgKtnbrLnxA/R93T4VPlEEp0qZXpe1VEZAAGTxPMVu5/Pb86I
 1eecFZr5DH5EcCW2i63S/6esK/GOS6aksWft1v2qKm9sjho5bYHM1/DF/V82jeTprk0L0Tlbo
 Wg1XDNQBTuO+LbY61J2He9EAQdNzlVRDPgmQgn6uM11aSpc+dZ3mEhN3kbGUvQHPiIfGbSF+9
 SeZG0D+siYyBESoit0h8OmM+jFYOTKgz2vHbUkMoZ5zV+tEYKRVW2FRgv19ctebHS5HxVxd
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 07:41:29
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
[lv: s/an/our/]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fd5c4f1d73e6..63c40c48e31f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
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


