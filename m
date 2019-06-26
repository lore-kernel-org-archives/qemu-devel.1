Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C66AC48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:13:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3685120663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3685120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg6oH-0007PJ-B8
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 08:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49901)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hg6mU-0005au-9z
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hg6mT-0000nh-2z
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:12:06 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:46299)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hg6mR-0000eK-Fd
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:12:03 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MCsLu-1hosDd3hVA-008qO4; Wed, 26 Jun 2019 14:11:50 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 14:11:39 +0200
Message-Id: <20190626121139.19114-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626121139.19114-1-laurent@vivier.eu>
References: <20190626121139.19114-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Lxe9LVwcW5n3k+00I+6eF7McLrcLyYRterrhAxEULvbIEohd+kr
 sc+bU5Fapiz/o9Ypi4aCgv5ndVd0+MDisv+pZUjB5gz2VYn5PHJ7WslEy4HDVMHS+NS1iV5
 tcfSLzipB1WzA5MG6990F1QgZ/Q+eg9ockFWJ7wFCypBKdN4VZYs9CEAucTTykm8fDm1dPj
 QAc4mg9V68s3fNJpW269Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Pfqx+sg7EPI=:IXteKgPB94kC/rLvpeSli0
 HhE6SAbC83feD9rsLDacg1RPS//F7xPf7XMeyGqwk5zLWEA/GLDHKog5fKP0u/I+FiSFhKHFx
 vPBVMDxRqftOLatVOu9L9R9dvBSwNmT8ncAiJ0TJdU7lL1+VhHyvuiRC4+8lHyr2cDTaJXsSr
 vA8fYL4Wn63hbpNVueLHhxxAo/yv5XZ8VWDxW1/WO7FUESyAGuzVNd0EYnNkci2Bnztusgg4e
 NcAKMtMdR+UrycRb3LLZVxTyKjMw+9fLbm01MtHUkvqyQhxKTRu/PHChpCtdMT5s7xYSjZ2RM
 Xn/A9utdB3XS2WsnrPZr7mOZlzUvUAmSyae7oi7+ELq//7oYjcI6RPnaLfsQdGTpbBxKIxfhV
 ++lkIW/pUVWW49EbPFssjjN/R+5AjAk6QWzhEI8zE7Qg2Qqwy4kgnwkWJcv3gpxYHYVp8teb2
 zIYEzfJXg4Fg3HvblaYuSMaKtnZky8Vl059n4lMLUXgcfphdffRM/HTRTTBzdBHJF62Mpe1PD
 hN8tH4bIweaLh4BA42IlOyQjq8bVNBJtSsm9XGIRFYWIVyHjC3Zh90TEoLOo8CJlQJo5dkG75
 fa5aiAeZgCEKDNG2YJZhCH2qVBAiqkZJ+L1t8EqAStPwZg9lEYlutAz0RhRJCx7QSk4nYaBZe
 ATBqoD6z1T4WZphRmZ6ZbzV2l5TdjnXdJfLuuSfyBO1oKGIGWlc+PESiJVPyTX1strRPkjHzV
 MDHawE0LLOL7jpOwEUld0d2gpdgWiXl3Alqslg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PULL 6/6] linux-user: set default PPC64 CPU
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The default CPU for pseries has been set to POWER9 by default.
We can use the same default for linux-user

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20190609143521.19374-2-laurent@vivier.eu>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ppc/target_elf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/ppc/target_elf.h b/linux-user/ppc/target_elf.h
index 576a5b9959f4..061661885423 100644
--- a/linux-user/ppc/target_elf.h
+++ b/linux-user/ppc/target_elf.h
@@ -10,7 +10,7 @@
 static inline const char *cpu_get_model(uint32_t eflags)
 {
 #ifdef TARGET_PPC64
-    return "POWER8";
+    return "POWER9";
 #else
     return "750";
 #endif
-- 
2.21.0


