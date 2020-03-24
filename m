Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCFAC4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:10:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 239E920775
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239E920775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGgVu-0006hQ-7a
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 06:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jGgP8-00062m-6J
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jGgP6-0000cl-VJ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:03:26 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:49247)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jGgP6-0000c6-MO
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:03:24 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MvbO4-1jZj7a1vao-00sdVw; Tue, 24 Mar 2020 11:03:16 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 4/5] linux-user: Add x86_64 vsyscall page to /proc/self/maps
Date: Tue, 24 Mar 2020 11:03:10 +0100
Message-Id: <20200324100311.588288-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324100311.588288-1-laurent@vivier.eu>
References: <20200324100311.588288-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ojp0y9ce1pIflhkVnGrS0924Kx1UvotZXiVdnzyaYLXbC7DHsby
 UTlu88LeDlEWaTFQAi6LmWeryTRiCczMUzFrsJwRPFcAo2WNu4ElLf7S2Pc/xJ7qm5Q4uAn
 QUTlAzn0xtXioZmfQEw6zpz8gTzTWkVq2X1yDUkJBEIL5lBUeRVza0Ou7HY585tb1sAabAL
 Ofr9gV6gVTUYOX74ZVLpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wSua/9F1wzQ=:WNk5zu5Td8bhxYDdNTzI48
 l8rAmHPd9s1fvIiM6mB/jpovAvbD+ah367nupiBYKrIK5Kr9ctSyn55Xzw4AM1B0VI1RzbIkK
 WE5dNuHc2MXrDkpfhnFVoHlD8q8zgU7y/RQLgy18nGfp8VDbyTegcmheAxNj1HkVk3864zzC+
 fneEFTkjxfVVbkIubWOFBR/YWywGgh90yv0A357ikWO33OIdyyrqSfcG+m3NppDzGd4XUrLhf
 Hhxex2rMTiOjMSe27Mk85n+uBY/B4hEr6TFK9RgbnEOYppFETS3w7nibD48bQoz2og4vEByAs
 PBdEUQFVygztI/D2wLFXeepMBC14RN8lEbjcXapyWBWqM4jIUZ1/QUQQy1KFNex5ldxV7NU0+
 ZkLlVjEZUJ+DpnM3xQMJ0lBpEJwVa3hkILMNkZG3C5d8qZ/D2wDOrsPYvv9ZLNtYtzvNDKGjJ
 NmLXEOwWT+RMxT//LYoDIqzbEYH7zbn5cjw+K2NUNa/M68SlApho4RwcnEdnfeKIjVRq1ffm/
 0cQoFzewMMFvyw2amasScdImuET3d45yVc9kSt1H99jeytqxCFir3nXUB5maxHrWmXLqixy8J
 yl46aW0vrV+2PerYnoZQ3AvPN56JWbFgpTpRzXq0TZFQX+rQ9TJ5a8hmCIYjD3XENhd06dHwt
 LjMlmltgI4envmSrbpED5PhWAIox1y5jQWxxyOe/dDjD1c9bSPNirk9tcAe29mPrlAbEJM3Ma
 xLYopaAd3ap/oOo3pol4Y37/3O4SX4yM5OnaG/EoTwWTU+kmN1uJJ3bft7sMG5akQKJ8K2Nya
 ion9N7Edgv4QfZsoJj5F1f2ar3F9xBPUCSB06wet6S2GVHzPdmjmWRyIbtor4L2GblpdMu4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The page isn't (necessarily) present in the host /proc/self/maps,
and even if it might be it isn't present in page_flags, and even
if it was it might not have the same set of page permissions.

The easiest thing to do, particularly when it comes to the
"[vsyscall]" note at the end of line, is to special case it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200213032223.14643-5-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 35f414666243..5675eca962d7 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7144,6 +7144,16 @@ static int open_self_maps(void *cpu_env, int fd)
         }
     }
 
+#ifdef TARGET_VSYSCALL_PAGE
+    /*
+     * We only support execution from the vsyscall page.
+     * This is as if CONFIG_LEGACY_VSYSCALL_XONLY=y from v5.3.
+     */
+    dprintf(fd, TARGET_FMT_lx "-" TARGET_FMT_lx 
+            " --xp 00000000 00:00 0 [vsyscall]\n",
+            TARGET_VSYSCALL_PAGE, TARGET_VSYSCALL_PAGE + TARGET_PAGE_SIZE);
+#endif
+
     free(line);
     fclose(fp);
 
-- 
2.25.1


