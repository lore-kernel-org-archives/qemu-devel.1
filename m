Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AFCC47423
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:21:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A88E2080A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A88E2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMpLc-00018G-MC
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 05:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kMpGi-0003t3-KK; Mon, 28 Sep 2020 05:16:24 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:46023)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kMpGZ-0002XL-T6; Mon, 28 Sep 2020 05:16:24 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MxHLs-1kcADc1asy-00xXMi; Mon, 28 Sep 2020 11:16:12 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 7/8] migration/multifd: Remove superfluous semicolons
Date: Mon, 28 Sep 2020 11:16:01 +0200
Message-Id: <20200928091602.383870-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928091602.383870-1-laurent@vivier.eu>
References: <20200928091602.383870-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TDv8xBk1ThJ7knLw+EZGmeA0WjIMds6uExppLuBUybg5NiLUPul
 BZ3GoLl8ROIvSO34Dxz15rlVBT2NMUY1kSKD8oFp1FGiuZrI6HXWWSs1KxKG2lVkqhfqkmZ
 YwYonHlWXMV0P9pneRyETtcnjdRxinPDOGQdXnQv4wnM3lEZulSNBcevOEoAjkjsCIRrUbS
 vC+6Ysws2MSAxnWIZdYyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JAWtdgVEnlU=:ZSLNwbrpxEAI6B3TkxQkV5
 As1vfzDuYkdAS94JZQehSzuX86k46IBz7KDavzMxlrUFC4EcpXMeQI+0BCwO85QO/DnwyABkr
 zktP/oJe2dRrCdaNEyJqQ7EM/JCGmh2SfqYquuQ02Hq6oEkqTwn+MNJoJapUkxA+qGybtMVaD
 Nz5tddzYC9/3oWq/NWcE2YrF90xI+l7uTba3ZcZb4TL1bSh+kED3XEkdGbevVFKDvaR7QwXbU
 Lt4NG9F7nf3tzkxfUZN61y4Rx7ScYNAQOTWDb3uCnJWLslpRcu406lpOKJhypi2CZAzsGg03L
 Ncqb/GMxz0scJN7hJmb0suFi5r2h5McvOEx8Rgh1nw6faWASSofBZ1WXpHaKPqXpaCMtGNe6u
 wocEsyALefKA/Gg9lKzaz2u7ncCD9E0iby3U+exNgropy80wAZvYikObd2zq6h9PgyBfmfTm8
 huLTTLWsRwhtjyGDIY8zbl176Ocye30OfI2xOV9nS+LI7Z6wAWpEMfImh2eSR8GLb0X9/7vU4
 Ese1CAhu8EX/Kkd9FMb03HeS3AZkMR/E4EQlqmbf2cIC43z4VTqD0ZmV1hvlGxHNAoe3JcR2a
 lvOXpR2ONvVKZ+BuVQ/YCAXIVqIp/GPQSIxZoexYFfbtr8275DlMBWxwJb78bl/MERghM7me0
 6e2WWoOKAzQISjMZIT58C90eJkZgZQu6I64j0La9n5lxNPu1V29QVVso6290UtLbrvR8Oe/x0
 R5S54nnL7Q6mo7+cCqnOOOJiEslOvf6hnKPGuEfg563It8fC9IgEdZd7Ela1stNjg1SZKUBIX
 1Qyca7SCL4grxa1rz8K2PmrRswKXnKO9SZI7bLKpZR7liHfkNmIvOJednSMhsgxROLqvjxn
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 05:16:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.462, SPF_HELO_NONE=0.001,
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
Cc: qemu-trivial@nongnu.org, Li Qiang <liq3ea@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

checkpatch.pl report superfluous semicolons since commit
ee0f3c09e01, but this one was missed:

  scripts/checkpatch.pl d32ca5ad798~..d32ca5ad798
  ERROR: superfluous trailing semicolon
  #498: FILE: migration/multifd.c:308:
  +    ram_counters.transferred += transferred;;
  total: 1 errors, 1 warnings, 2073 lines checked

Fixes: d32ca5ad798 ("multifd: Split multifd code into its own file")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Message-Id: <20200921040231.437653-1-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 migration/multifd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index ac84a61797f3..2de5263c3263 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -447,7 +447,7 @@ static int multifd_send_pages(QEMUFile *f)
                 + p->packet_len;
     qemu_file_update_transfer(f, transferred);
     ram_counters.multifd_bytes += transferred;
-    ram_counters.transferred += transferred;;
+    ram_counters.transferred += transferred;
     qemu_mutex_unlock(&p->mutex);
     qemu_sem_post(&p->sem);
 
-- 
2.26.2


