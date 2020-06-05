Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDB5C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:50:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A73DE2063A
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73DE2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhArr-0005GA-Tk
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 07:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAoh-0008EO-AC
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:19 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:47031)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAoc-0006hs-6t
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:16 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N9M1q-1iw2E70Wd2-015Mnb; Fri, 05 Jun 2020 13:47:03 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 03/19] linux-user: Add support for /proc/cpuinfo on hppa
 platform
Date: Fri,  5 Jun 2020 13:46:44 +0200
Message-Id: <20200605114700.1052050-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605114700.1052050-1-laurent@vivier.eu>
References: <20200605114700.1052050-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6FKR7BFmLWvONieLKooI/cFR3vSkQZjLovPt6wp+OvviqGHwlwg
 mxipksbbzyxPoxGkJ9oJV3UZ3xOgh1K+GhlJdSbho2Id4JZr9bcCzGvMN+NK+WfF7qA1Dkq
 rQJ6XEWPJUtQfb0HvF1SCGfVrbCNrJvLmHgJs4m5zjhzteevdSKVPKEizlHlcQEm3vOC0JM
 ZfipMMOtIAdRpj5ibDs1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yYrgXEeJ9NI=:9tMpixFJ2/l3b+fM3lay8L
 JOovTyrm+c0HbhiVAv4/nzGO8jnH0UMmd+pMCC3liovQqrig/OrLYbMlSshYKbq/80Mtw8fHm
 3N4iZCM2SngmpOmTm+l9IpaiA4qvK2oQ4H8pM2RwIG7xV/7yCQUwCuqEjfqKsjkK2NaLXUjMH
 Q2mVxbnCAc2hItcVHBenxm5AZpmrmCjPrf81NovZeU0J93H2tUr4gzpe4bZRpoCkHhXUNK/FV
 Iv2A/khK2LiRIxLq426qWSmjTikrUJkQpkV5cJJG5ThAZHQzBD/VxSmdrSNgPzQyZS3LlxSt+
 to+RVJq9WNtWwZ77jS4pOiQ/4W1DPVWzZ4FDX1UYJTu4waW+PJnI4UjP1NvSa2jt+FU+MyjDg
 JkH8DbOy6sAMj/DcLY9veL4uxNRul6QTpx6IUbnL/TiWxItU/ivotuXKIJSGsgSH7rUN/3wlU
 GADgG20/CbW8rAU++PwsO1KCxXUg2fOhJmJCmD9SEoThRfNVvu5OBdXb/CPAa0iAawVLb5j2n
 kbTVhFLOavko9k+TL0ovUckEa3IMQAHs2Uy4+5TZ8XxkAcBJCqmOQykyVyRgHOSwXykhm5klB
 SHOfMiYFKut7soDDO93RKpHDd0C6V/4XCVCPScbotGmYdYwkbPs/PwS5XCwbk8T1NfaDFkEXC
 Ys6r0ePcjm/QplPMQR6fPcVE1++hUD3bOV7sIxPbF4sv9O1IYI7b37hNV38ujr2V/eDDRQWh2
 F1wOtDIB5UDsHm5N/MxLXeUZxWioiHcXobDDlTUcfv36CzbaSJBAvUeyhQhChYdbCnbekEQ3o
 ioMeZqZrW2eo4cQ8Hbv0HiqM8McyaItEkFWeDzfz+0b4CRHXsEKh5rZ4rRBvexZuZG39V8s
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 07:47:11
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


