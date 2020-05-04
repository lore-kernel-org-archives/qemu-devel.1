Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC5EC4724C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:17:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34CE220721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34CE220721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdm8-0004eA-7P
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 12:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdW4-0001Xj-6g; Mon, 04 May 2020 12:00:32 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:41617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdW2-0005vM-UT; Mon, 04 May 2020 12:00:23 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M89bP-1jS30z2dMp-005MI8; Mon, 04 May 2020 18:00:11 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 11/19] block: Avoid dead assignment
Date: Mon,  4 May 2020 17:59:48 +0200
Message-Id: <20200504155956.380695-12-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504155956.380695-1-laurent@vivier.eu>
References: <20200504155956.380695-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wjbZekFVd4AkavH5+JmTqVCPmGJX0WgY9p/LrSaZFwnmTM1VvtI
 5gut4ghCyk5HKRwG8JoJ2vXgwNOrvB9T93E5yYMDNrE0z2Z7/FD/sd0iqUZIFoF120g80xL
 OyA4efYpyN1muvywIAWyLE/KCPZczGYwDmgs8wnlKwFNUcJ3j8B47ifai7VpOXfo09H5cgt
 Iq54vC0d0+ssIMrvLxTqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QAy3hNWbORI=:WJsPiZTOctC0R0fb9aSIIA
 3OOLthmg8m4kDP+sLN5zIcgk/2HARA0zsC7n1VCh3e8QAtOuPaOSpHqWScTnXhkzp54k0H1NM
 9KTk4wdqket3n0cwhZeYysSLRN1cfDwOWRMFGEefKKKQTqF/zeAgW6wnKiEHV/e/y+Mheb/hF
 03E3BAN10p/FvunyZmU55cJDEEc3zP1hohuxLrf9yrDavpc9EIbt4gR20ZXjw4wUoq2jeczYr
 bISQdfFBwSb9VPbBTG+L5N3tGgSif8ld5SEtYD+Y2trNBk41H0K9fsz47bzZKkMfX/ozEnVda
 fvZBWky4+XZimVwUQO1LiyBLoom1GAnoFtCL8XYuljbRrGi2auYyEIqGMi4ryXwGFt94sFuAJ
 MgHW+h9mOhOcys4zjfoBuLv86BBMCZ9q+6aqKim/WI/LenLKrI/a1llmWxady/051Cyx16bPv
 XktY4DhCzW8iOSNH6mUEcQ+YJWw12zgfenPcpQ+/0XK18oZxR5zuZME/i6Q/6cn55tzfu+GIO
 vAnv6VGuCFbtDLO9VQeX41RdCV1VMb9ulWErTIaFT24fwD87991LFOmWPtiDxQ/LjnvQJ5U2M
 4rMoPjytuQffwrnsTtszb27WV/foZBjS6CtZzgu/YjcsT89wcCEH8d8QQwFbDomeHjZd/S2PR
 4vqcn1ilHdTgvbwd9Bh0bpKl9Agx5gvngHBxdKgjUxE4pI1ZjRMQzfeqQqPc4BTwiWfaa05Xo
 8yH81H5lpbcBj575WLxpLqIm/eopGSnUCEHYoKRvG78gIicir1LTJ2rG3O8WX958kyAKHchO+
 +JsUwpp0jLzkD+C/n//uOJn0JWQCEtFYsURXjkxUN5AgD0jEnZgP4sdfbHYi1PLc6IQvYEx
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 12:00:18
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Fix warning reported by Clang static code analyzer:

  block.c:3167:5: warning: Value stored to 'ret' is never read
      ret = bdrv_fill_options(&options, filename, &flags, &local_err);
      ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 462f5bcf6
Reported-by: Clang Static Analyzer
Suggested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200422133152.16770-2-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 301ec588bda2..cf5c19b1db49 100644
--- a/block.c
+++ b/block.c
@@ -3165,7 +3165,7 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
     }
 
     ret = bdrv_fill_options(&options, filename, &flags, &local_err);
-    if (local_err) {
+    if (ret < 0) {
         goto fail;
     }
 
-- 
2.26.2


