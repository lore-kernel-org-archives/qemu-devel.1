Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E98CC4742C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 07:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FA1820936
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 07:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA1820936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaZPJ-000213-7e
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 02:10:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kaZO9-0000Ie-Tm
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 02:08:53 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:34953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kaZO7-0007Xk-BP
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 02:08:53 -0500
Received: from localhost.localdomain ([82.252.154.198]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mz9pT-1kMUqF2vrf-00wBEB; Thu, 05 Nov 2020 08:08:44 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] linux-user: Check copy_from_user() return value in
 vma_dump_size()
Date: Thu,  5 Nov 2020 08:08:37 +0100
Message-Id: <20201105070837.558332-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201105070837.558332-1-laurent@vivier.eu>
References: <20201105070837.558332-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bZ+KkmCsEIgTB9FZ1lkIDWS00V/RUxqzWUf6ODm/h1q1u30Y9PT
 oQmQ3ltPSlpGxGAMwOJlaVfzGMqSxVD96kgrBExqbkP93ULLPnR9+DsCXGWqcTCSbltowqe
 vO5FM6Cg/scuTrVjx69IexTuBzJrtWbRQ28RQVxGRpxTPy4T9RzGFOD5/WjY07Hx/w0+IAQ
 2nkoa5APVr66eYMZ8MtCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fjro3wryRXU=:fPlXULmZYus/gFt9r7G+e7
 XcYmXZvo7iQ8GYLF3+3D+RMbYn5PaTYZKRWWDJYhsysU4AoL2oarDiOLX6Mj0FFyraz3URK9G
 abMunJ5+Ejxw2MLCQwTeuUyD3B4+xmxT4k2F0PVy2ghpEtC+ysQAQpE3HIAsc+iGu7I84Vkns
 cAJkNuuXoo1ORZ0C3Hs5z6zn9HBtW4A4/BhsOQl2iIf4jPzw3JXphnHfOWjONroOkjkOom27b
 1PeQmBXtR6vlJ2zXnBdmLfL5hPQTF2ookI1aqUZr5Ok4yoNVuuB22xQiRuW4zxbPPbJE9Xxr/
 /SMGCUQxSpwAf5V+De73EG3d7Of2p61OIdJvewB9S32tuKHgjW/zBkmErn6/jYsX9xDu+NNP7
 56lRxjXj7a/DslmhlzKB1PIlQxVjyGY8MAlyg0C4hu6GicNN3kZJay51G2fxlTM1XNPgoJhl9
 b0Daa0268w==
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 02:08:41
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
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

Coverity points out that we don't check the return value from
copy_from_user() in vma_dump_size(). This is to some extent
a "can't happen" error since we've already checked the page
with an access_ok() call earlier, but it's simple enough to
handle the error anyway.

Fixes: Coverity CID 1432362
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20201103141532.19912-1-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index cae41d504d36..0b02a926025e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3485,7 +3485,9 @@ static abi_ulong vma_dump_size(const struct vm_area_struct *vma)
     if (vma->vma_flags & PROT_EXEC) {
         char page[TARGET_PAGE_SIZE];
 
-        copy_from_user(page, vma->vma_start, sizeof (page));
+        if (copy_from_user(page, vma->vma_start, sizeof (page))) {
+            return 0;
+        }
         if ((page[EI_MAG0] == ELFMAG0) &&
             (page[EI_MAG1] == ELFMAG1) &&
             (page[EI_MAG2] == ELFMAG2) &&
-- 
2.28.0


