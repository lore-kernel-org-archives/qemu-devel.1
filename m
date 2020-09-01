Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A8FC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E945F206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E945F206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7GA-0000Lb-TE
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zY-00065l-HK; Tue, 01 Sep 2020 10:10:32 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:60195)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zW-0003zh-Fd; Tue, 01 Sep 2020 10:10:32 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M3UhO-1kCYl63QFG-000bfz; Tue, 01 Sep 2020 16:10:27 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 43/44] main-loop: Fix comment
Date: Tue,  1 Sep 2020 16:09:53 +0200
Message-Id: <20200901140954.889743-44-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4o6sYvUCQ0ApSDMYsDaRZRjFjlLFBTF4rHH7ZGvjZc662nk7M2a
 b+xdzOQSlA7jZQiQ3VIa+yCMvGUaOdUbjLfTggHDvafoxgbSZDHCvY8eJLDemdYmvcCaDXC
 dOfJ5wwr/1RylQo+NclfulfGIUG/WOftxvTgOvKzTBGQPkvzHaP6En0km2rwiIjburVJWHV
 WvWHk3gznKqx3ll3x6WSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H9mzzYJ0XsI=:QeAI3orvbdrQ0iw8nzXxEF
 JHq40zQEB/oC+x5FT92VAkchIsxqCpIxN7tCPVupCvSsMrhmgCCJGAL8Wwvfuar4MzK5kYsY9
 0ckiKIpQqyYVpzUdUyz2KAR/hov7xmv+32Q4Sp1EDZeYkSZ6HpzZ2XKVTkz8NjKbuqXyovbq6
 oxDODCNjvvjnzzyW7WcZxBoslv2EK5tr6M52eRoNLdPeoaOhoJmE1WSgHgE+w5P1eRmaUF/lk
 3c0klglQxSGlSb5K33Bp7UAWX0gbZEGBUvBfiWpzBXZlmH5ChN5hoVQZAmSkJeY3dQpW1LG78
 d6xxsLhfpNY5xMQ7xYnTCD/PGj3TVvFfMe7EDclBPs2TfC2btMr26kGo0YjwlouVslDPf/xH3
 fjCVayRkFlDLp0PByC5P6gYJUUOx9oILEFwoRUfZhlsuPGwEoRZSEduWi8oRnV5bM/7h754j/
 njshmXl1O7Q4U6U0/WhCDbLty4+ZLS1KWzidix76sDRnhpjcJjzMG6IcpO4a3AUd1rzutL9J/
 L+VoefHGXcoepJH7XUfj2cPMgjIHkn/EGc5b+aCopX5pmdiTpEL7LZPxZjxWAQjD7wu8GMOcI
 6Ms/keBAdW7ZrHVe1XEJJqy0NHusff0i0QOQGdjXWX6TTm7huzoa3jWvGPVI1WE62UcfUiKSP
 RwFGThlCmuWG4ptg5sK8LBU120dbSbTYpES3AdcoaVRulGrtTTnvjrvPukuZmo8GjwopCF7qj
 KRck312NPaFzBMO7pjPILwergGlTm2oo8q6GkU1UJ7va3rChLjuNIrRimMRzZzMblVnCmJu8H
 S+IGxkZh9mT9ZbxzVpxE3mUWew8ZCER4KI3vKJ6TXlDnJdOmduETZgUKitsyWLoLbzBLEzJ
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:09:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Weil <sw@weilnetz.de>

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200827175520.32355-1-sw@weilnetz.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/qemu/main-loop.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index 8e98613656ff..d6892fd2081a 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -52,7 +52,7 @@ int qemu_init_main_loop(Error **errp);
  * repeatedly calls main_loop_wait(false).
  *
  * Main loop services include file descriptor callbacks, bottom halves
- * and timers (defined in qemu-timer.h).  Bottom halves are similar to timers
+ * and timers (defined in qemu/timer.h).  Bottom halves are similar to timers
  * that execute immediately, but have a lower overhead and scheduling them
  * is wait-free, thread-safe and signal-safe.
  *
-- 
2.26.2


