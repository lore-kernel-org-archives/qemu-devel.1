Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC1AC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24FE522D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24FE522D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0P0S-0004gK-9a
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 07:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i0OfN-0004wA-3q
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i0OfK-0006Zh-RA
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:20:36 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:55141)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1i0Of2-0006MV-KP; Wed, 21 Aug 2019 07:20:16 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mqrjz-1idq8i1ebZ-00mvpD; Wed, 21 Aug 2019 13:20:05 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:19:40 +0200
Message-Id: <20190821111947.26580-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821111947.26580-1-laurent@vivier.eu>
References: <20190821111947.26580-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:i+3b3qlR6kyQgu6gQfu96rxZj7K07Flpi6sw/j0BgOY8QwjhaRL
 FLLPkCl5BEfqwz5dQI5OsOlUnlrfaUy4i5pPqfWeF5wrf018FvTB08mNMgnnMEnDrhWVa/J
 IYjFmHpNmRZRXJjEypFI0uSbL6vK83oYIaxMpETydGePHENw/6DYZWycUAfct4xsLPi5GyG
 P50TxSivcFVqbYY8Qy0KQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/lz0sZuo1ps=:qu6e8G22GTbs71/edVKvng
 U/Dy36pjAJMQojsfEnHkTrU0uJ3MNI0PTN/1Ph4pJjaNVf3oVDceaoOXsy0UJuR0t0rEzwqy7
 ODYKWm67rOGNUGRxh3DTl46uaIYvGDx4rBri8x1tT5xVE3BxAn58bQpm/rzRXJGAxgsCGH53w
 U3FKHIktqi9/tUNJnFHnnoWEJ7/6b42XL5uaAWDJ9LrXmyxPvFzQIe8k0NXifBOd+QFZFH2rk
 GmFOubWF584hkrayFPlAc6D6hR3+jInQ0/Mc3uimC3Sv1N0wU45z3CFU/F8jru4JoWFRH0Ihp
 E0cpzdNitUwTtLCi6QUqxhI5NzS2UrvDnYD93qS5YUKubmpBphg9n94gMv82pwpkxOMpfFd02
 4DFbcI87G4JGHhpVaXRdMZ+GMgC15lJCi5EWSpoTVYke3qsgvkUo5vLcd0uMJrKSZN7ErT4Zc
 GTBGpEMxFqhucRwpbCy8U6qVQVoKcKPeu85MS2NTO8+ZksoJWTpUhGA5ULiQ3Jf4Bnt9r+laT
 XsQ1XTv+VLA47zXgDEYtCZBS8fc8lMLszuGmEFEwOuW4Kwqt7aMgk1jU0XIBt+QZ7KEm19vzE
 ea/AMVOtThxx2GF0d5QrXCnpzFD2Gc661yw4OlDEMonLTES3Gn+Rv6E9s+Z5H090jeu0HcOZ7
 fVEzdGgvan7j2pBH16iXtlbgDJD3IkEfS3jLEbDmARq67U47Ph4NcXfCSSJKZ42ZBsbyyeq8K
 gAXYc9aiarjQVL3qWb4O0BSGT0GxhL2gLc3nOQ4KH3vMV1DUKq/wPb65nj810hiyN8+LoNI/5
 cXiuGrIcuBHDE38b2pPz3XBNh60vw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PULL 07/14] json: Move switch 'fall through' comment
 to correct place
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
 Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>,
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Reported by GCC9 when building with CFLAG -Wimplicit-fallthrough=2:

  qobject/json-parser.c: In function ‘parse_literal’:
  qobject/json-parser.c:492:24: error: this statement may fall through [-Werror=implicit-fallthrough=]
    492 |     case JSON_INTEGER: {
        |                        ^
  qobject/json-parser.c:524:5: note: here
    524 |     case JSON_FLOAT:
        |     ^~~~

Correctly place the 'fall through' comment.

Reported-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190719131425.10835-2-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 qobject/json-parser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 7d23e12e3379..d083810d3782 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -519,8 +519,8 @@ static QObject *parse_literal(JSONParserContext *ctxt)
             }
             assert(ret == -ERANGE);
         }
-        /* fall through to JSON_FLOAT */
     }
+    /* fall through to JSON_FLOAT */
     case JSON_FLOAT:
         /* FIXME dependent on locale; a pervasive issue in QEMU */
         /* FIXME our lexer matches RFC 8259 in forbidding Inf or NaN,
-- 
2.21.0


