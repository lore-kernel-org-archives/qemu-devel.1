Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87CCC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 07:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A7F62080D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 07:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7F62080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaZPJ-000204-7r
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 02:10:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kaZO9-0000IZ-TK
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 02:08:53 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:33015)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kaZO2-0007Xg-8j
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 02:08:53 -0500
Received: from localhost.localdomain ([82.252.154.198]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MmDVA-1jsOrb0f8C-00iFFw; Thu, 05 Nov 2020 08:08:43 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 2/4] linux-user: Use "!= 0" when checking if
 MAP_FIXED_NOREPLACE is non-zero
Date: Thu,  5 Nov 2020 08:08:35 +0100
Message-Id: <20201105070837.558332-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201105070837.558332-1-laurent@vivier.eu>
References: <20201105070837.558332-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xp3EU+evYL7WeGagg5hHecSr5tQF2Vv/mnqq4smCZOuZhmFJ3Ct
 oiR3KDfFZFNukgEwTaUNXooykdLU7bWSs3PXotrpvWWSew7/d1Jktn0sQZRARv5i/6Pe5tU
 RSAKHN/KqfbAFsUoxJ5/KzZYA9KOC3pMb85DyJVPZGp/aaKm/iMItdwDC2UM44Nb3NiSw3G
 JEQYLrcupIYqiqSxSRogA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AS40tPH6BGM=:0gePM1PvTBvvlM293FzAoJ
 kEg86ofm0zyF1rZIlUYNBsGbM3XqLSf0LceOYHbddvR7K+qK63ZFVGJ9BNAjkvkYwzC4xYcgL
 EOoewIo7hQ/BeDbDlqFI1mShiXXA4h6tc4HQm8pKzIELMYYw/hT2IAkE3Vb2VR4RbLa3wT1aC
 J9Gz5ApidMbHqdnFgoNCpmysjB5+sVFkX/c5qhQ9VSkyFQ9B3T8lQ/XQvbT2ewR8Vue8SXIwi
 F4xWaj8JWp44xjuF1GwrWHY5D8rBAuMgnl1YWjhOWsF9vfGKLsKEGd5hhX6PbIMuPsD0fjSi3
 YmhMo06ayTyQxFfvagnghRNDyajbYqNi8uBl6M3YeZRS4poP8ESkD3xrcqSOtKkxmWHc+rlfl
 qrjxzDSq/8Oyme4CpNiShvZnTzYrh0zCvc8R5HrL2rdNcTEyl30a/RO/ezl4u
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 02:08:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

In pgd_find_hole_fallback(), Coverity doesn't like the use
of "if (MAP_FIXED_NOREPLACE || ...)" because it's using a
logical operator on a constant other than 0 or 1 and its
heuristic thinks we might have intended a bitwise operator
instead.

The logic is correct (we are checking whether the host really
has a MAP_FIXED_NOREPLACE or whether we fell back to the
"#define as 0 to ignore" from osdep.h); make Coverity
happier by explicitly writing out the comparison with zero.

Fixes: Coverity CID 1431059
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20201103142636.21125-1-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index bf8c1bd25330..cae41d504d36 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2188,7 +2188,8 @@ static uintptr_t pgd_find_hole_fallback(uintptr_t guest_size, uintptr_t brk,
                                      PROT_NONE, flags, -1, 0);
             if (mmap_start != MAP_FAILED) {
                 munmap((void *) align_start, guest_size);
-                if (MAP_FIXED_NOREPLACE || mmap_start == (void *) align_start) {
+                if (MAP_FIXED_NOREPLACE != 0 ||
+                    mmap_start == (void *) align_start) {
                     return (uintptr_t) mmap_start + offset;
                 }
             }
-- 
2.28.0


