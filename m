Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D93C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:18:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5315320786
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5315320786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGhZn-0003P8-Fk
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 07:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jGhYd-0002G8-Ky
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jGhYb-0007LP-QE
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:17:19 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:41005)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jGhYb-0007Kc-BN
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:17:17 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mw9Dg-1jZBsV1QUW-00s4Yd; Tue, 24 Mar 2020 12:17:07 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 4/5] linux-user: Add x86_64 vsyscall page to /proc/self/maps
Date: Tue, 24 Mar 2020 12:16:59 +0100
Message-Id: <20200324111700.595531-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324111700.595531-1-laurent@vivier.eu>
References: <20200324111700.595531-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:U6JARm6Ix8awta0eIImuBEUlY9n4vZEjhbE9pGunEfXSgs883wI
 qZXU2uF5r3u5Pt+d5ru6xic8PbYdT3XI/ku97J+ptCqiSG7QWEMC72+ca8Bhe/mjoB713rA
 qKB3mwMMK9CR4IzOr9BYqfH7lLcaaeYJWlauvw6BHubsTAk4eaYWGFMmZcm2+59qr/eyNCT
 awX0PjBFM68ZQXLJ41e1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pcOySjJuoMU=:VT52kz82ERI8Ua8SYi6uY+
 cdSO94GLycR+sJgwHxnXWmZ/xLXKaIhK4eJOt7PW3feFcFueGjC0iLq7QFQebqBm0W5flNUp8
 cnf3r6Lp6MD5C2DlzqLNSc42qrRbkzEw54q0QwVLQE9DCO2bGIMzjCNnk0zgd3a/VXLYVjS6a
 bcHr1AoRr5HHfA5tfpYyOb93/UPz1mNVzoxLUxO06X3Pr7fxGMX7w6RnLegiSkUEYSv0+03w0
 NihHTXkeYA8DoGCW0A9w3U74mCylNzg6YfNlcG9M1Tmnt7BStuq8Itk6iOhUHxx4WZ33nfQfE
 6yoKxWHw7kQ6uniQQdwh/CbPMMHS9qoZdCtxTqRZ/g0BydkhblkHvyRcZTnrb3iCVo9kvDVon
 pYUIZZ7BWKEXOVncDbU5n65kFxD9pUofZOCqzidGUD6apWm6FL/EgXJ3q5nVWCK0IKtbkoniU
 tNrElbSddKN6VaD/M16XVdisKCggm9EnMzjadmCm5IlVDPtDqutSIXIb2ZtARtNKzwEHKUk08
 J5er4F7vXRtUMEzpmpNPnirwE4s7pExbatb0xZab8nbNZNbkf/DhKZZ/Ti4fGYh5CGQOP9c8D
 f6+BXUXmoGdzCZ1RVgJIHOrCYVtlLuj3MDyZNy0dvsr6KhzUC3el1G5cj1Zd+CcJzkmnPFLvL
 2OpuvFvJvagKdVOnd+6agn5Ac7xllD1w6ednghRZm7+SUUx0MzxoO01YieWZqYfYlFTQIMV2O
 k7CVw4Ilts1QgAEc1YFYN47jTnUcEfweQBKACSslsYsIm3lE+viSKW3acOEudJMQlSsB3rQH1
 TC6YjwMbES+gjuq4cW30HdzUiPcilDUcl3cXymvtuNw3PRkj9meHuzD+sXIJzVSN+qwND5l
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
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
[lv: remove trailing space]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 35f414666243..dbdd56e42077 100644
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


