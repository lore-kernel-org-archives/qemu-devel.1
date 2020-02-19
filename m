Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72831C3404D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:24:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB902464E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB902464E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4MWh-0001Ub-G4
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 05:24:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4MPn-0003e2-8P
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:17:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4MPl-0005I5-Vj
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:17:10 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:51497)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j4MPl-0005Db-HH; Wed, 19 Feb 2020 05:17:09 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N9d91-1jY2sr2w4b-015aL4; Wed, 19 Feb 2020 11:16:36 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 09/17] ui/input-barrier: Remove superfluous semicolon
Date: Wed, 19 Feb 2020 11:16:04 +0100
Message-Id: <20200219101612.1033925-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219101612.1033925-1-laurent@vivier.eu>
References: <20200219101612.1033925-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dCKqb1vUoCcOnVsEoFGgPBNlgZjVP79jxRfrS4mjxXL8SqMpwsI
 xWH2CzHFJQI6TATjV2J9uuYb9DdLUKoroR/PRigg65uVjxB0cJSaGRbypHneZZA/TJ2pYAf
 vZShdwYCffI27wnIZlrCx4u2+YDWgbBzfDLZMxhScfvb//RMH2Wv8HMumhCEsoEMqcn8yko
 wg5P2CAofkgcrmsCVc3Xw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KmzcAQTGE2k=:DKepF76/00oaWArlojOmNU
 2mIgrgJrQZSaCDaFoNR8PDhyXXHgDahlgFrx34k5tt//WHFQYkHbbqiU2j+MQpPWMD4QSNwDx
 LPXFm3f2h4FTzIX2O8bKNyhQG1y+2eIleY/qocx7SYN4uctXAQXPRXLBBjJHQzLadpK5z5imd
 REarmrPP3SFwbCrwL0YNO/MloEY7K7fuvEBispu4Nm+CuieGu/p4Y/gVnjWnjP+zA4PxD23ba
 M2T0dJMOutyfunu7ZqCyPfTUHhdhgZSh6ZuXO5gE73xyyRCPLoy9duyv0L17m2IUL+Z65uLo6
 kEgeuwiyfSu3tJGx3HGrQ49pofLhK7ktgDQPBYpLowY9v3LPpq345dB8pz3twxTF8/iFr3Bfg
 XVC2LDRnsx2Sa3B+MBIyxJXmZHEJFPf4llGBB4xoP88N0pG8Zt4F/1RqnBO81YABFxXdtXfTt
 0nJlzgrxKaMAzQZQbHvcsziPfZHyNVnamkKgzXvrEFUzfuuDcz2PobfY1owaatVwmTjWj7kKP
 V/pm+Qmoc5K3OZiYdrqZPS2TSItfCemdgA8L9i/5czkUQxA78aneLTZr5QsrihVYYQ55IfyVH
 fX35Sb831XqPYgRZA6z/10q627ILrs4Aikai2IDnj4395v8r2lwMY/Op+bWKHNBYQ5qdNZ7it
 Wb19erUBBquQNHfphDU9Zbz5AQUM6zaQTARtMpfO78gd4D2/HHTxV1xnn/+grn0GIfPxxl7mr
 +kLUvGMfYayQYmNS0Ku2c++5T7XhnbEZ75WlqvB+7nR41szzCE3uG2H2fArDxJow+8PY2yqdz
 afDc+1mp3BNAQ4h9RfjFF6H9YqMT30PTZ+LdoKgjWQ7daMTmBIjnsZZAOwbBVskDY2IvWTm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Chris Wulff <crwulff@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Fixes: 6105683da35
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20200218094402.26625-11-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 ui/input-barrier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/input-barrier.c b/ui/input-barrier.c
index fe35049b83a2..527c75e130ee 100644
--- a/ui/input-barrier.c
+++ b/ui/input-barrier.c
@@ -455,7 +455,7 @@ static gboolean writecmd(InputBarrier *ib, struct barrierMsg *msg)
         break;
     default:
         write_cmd(p, barrierCmdEUnknown, avail);
-        break;;
+        break;
     }
 
     len = MAX_HELLO_LENGTH - avail - sizeof(int);
-- 
2.24.1


