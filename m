Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259C5C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2552072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2552072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj0hw-0001nH-5I
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Uv-0007tu-2H; Wed, 10 Jun 2020 09:10:29 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:43593)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Uq-0003fA-SH; Wed, 10 Jun 2020 09:10:28 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MNbtD-1jYjdW08gF-00P9u5; Wed, 10 Jun 2020 15:10:21 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 11/16] target/i386/cpu: Use the IEC binary prefix definitions
Date: Wed, 10 Jun 2020 15:10:06 +0200
Message-Id: <20200610131011.1941209-12-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610131011.1941209-1-laurent@vivier.eu>
References: <20200610131011.1941209-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:e6pNGKrZWZ3XWvCcug3ufm/XcEAN3JxTE4YulSlBdjBGInHKD7P
 8RG2mFa7x7rkNi32v3TUmQwZQAh8kuBq0LTxlOSZU+D7BqYUg72Q2/Q15glmrQgkRvsu20B
 8SNFU/QjZALKw32gkVISRkLI+fUEkRPTF5EEiKxG3F8YfMKaIROARMYRYYT8MuBZDfKNv7r
 W/SihU0Jfqb9WtAx4jVDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S5j0pdZnetU=:efiwghLxEfLhyUpTEtenyG
 os4RZcDi+sKn04oiYBBEY5IfBp4fOGxiN5hOLXl5nIoibKkhZq+BV2BZQTC+iZgknuNH8gkLq
 wbRfwv16MF7bTFOJ932oj9kwp3prj+q6qG2DDYkoTK7+kzq4U6NmFTcDM0s60tB/huYOlFtGG
 XD6Ah9ekk8jFvJHeinDyWfCLbmAQsGbbmyssim/yOiw9hj7WHC/zZ5Ow1LXJcZ0LmuVFBDCR3
 3/vfLuC7OcgBF5IG1nummaboCPOMpj7t9yiMUADuqWkImS1hRmS9y9fbVTqf8tJ6oB7kyPfBF
 VqgG34Ew9iv1879ELILblaYMxUg3UDONcH8PK4PwEtF42YGum+d8C90HzbfPIZTXdoMs+n6TM
 CWJfX4Ecx4UESeY51DdbDmzkw2s0WXntE5X43wvvEfe680/YwoJ5i3J6JUod1DoHzUsQu8TcS
 wCwHVS4LdijbRfqoDs37EM6ZbGWCNq9Zx0iKMTA/1Z7zIb/LzpZw3ToY4UuauZ4Hw14dNP07V
 XTUWrm5huYSQV7mklcBB3jYv2EfXhdklbftF145H2sW421KCs8Bk2ors7VRFyZxyxrvTpSirX
 WGttVNXlXCh/WyfDctM/2LxggNPQxjYzwh0ggajZoLv1pa1R8fvbx4kU/rkTzm9oXzDfI5tlL
 E9QSptVL+bn/PafWmVgruA1Czo99TUYwhySrglo3089XKplU4dbOYoAS9ziw1hIAq5ARzFL2W
 ex+eaguJYsvO57OvNwkHrHNOLL8ZpafD8m+o+VZ9LBAkWkXCzFacGhywQmWSGVUOs9GDeOK9w
 99+HEOpvOC6h6//Coq5KMwrUJ+cmyPWS6UjCyibIVlF83LcNy92EJGGcuFh2haZT8uJu7EO
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 09:10:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

IEC binary prefixes ease code review: the unit is explicit.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200601142930.29408-9-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ba05da3f2e7f..02065e35d435 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6159,7 +6159,7 @@ static void x86_cpu_machine_done(Notifier *n, void *unused)
     if (smram) {
         cpu->smram = g_new(MemoryRegion, 1);
         memory_region_init_alias(cpu->smram, OBJECT(cpu), "smram",
-                                 smram, 0, 1ull << 32);
+                                 smram, 0, 4 * GiB);
         memory_region_set_enabled(cpu->smram, true);
         memory_region_add_subregion_overlap(cpu->cpu_as_root, 0, cpu->smram, 1);
     }
-- 
2.26.2


