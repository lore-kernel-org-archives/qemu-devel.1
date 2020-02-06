Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B5BC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:54:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F77C217BA
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F77C217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgg6-00019z-It
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:54:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56871)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1izgco-0001hz-5P
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1izgcn-0006oQ-3Y
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:18 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:50523)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1izgcm-0006lG-Po; Thu, 06 Feb 2020 07:51:17 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MC2o9-1intIs39fp-00CPsw; Thu, 06 Feb 2020 13:50:51 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 11/12] aspeed/i2c: Prevent uninitialized warning
Date: Thu,  6 Feb 2020 13:50:26 +0100
Message-Id: <20200206125027.1926263-12-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200206125027.1926263-1-laurent@vivier.eu>
References: <20200206125027.1926263-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hsG0MoAZNDkAr6/dAbHU0b2Sd1vXTc5zUe651VUJg4XcNzZ/noC
 GyERr62exowH3kYsMpw9MdqVw7KaD1QQWEsvZcYMoDNAyxKlNrchzjPhnrV9ReKbkreXy8C
 cWvgwNp/Qq6946Q4EnrbtStnxh5bQkjSTfTYMcFz59IKpRMQXa1BrPI5YPKPXjd+swOlff8
 vVvwuO/qtFDx64Iz1eihQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fO6ol714BUI=:5/cYrGjiGI+7F/ekb3wmpR
 cryvZx6TRLRy7w3sjFNJDR40r9HuvwueWXLh5nCybya6LIjwj1aMXghCI5huPdqy9ZbJBZOCf
 KHlHcnaNw2IvAJ/EwbxOk4xUIW2z3aTNHZB2XR8+KXv32ExCDy2Ed56Rz/7DVUG6QcXhefjxF
 7mWLVLyBSjtYLqE+vx36em7JcDp4PMuCOnjtAXyT9IYgB4XAT94g2dddTrTrc5is7PxDoXJV9
 BP4ww0jYNyW8vYXB+Z5C/deWFZLk/WuNf/ueYxh9aAMmTtfYs99Xx11Uku8ayEkcEjXb8/oy0
 qOLZUi4nFv35zej+g0U/OzkXPawMUSeHaR0Y+WHmrF46+ZAL76oGKrLkiI0RQ6icxcckBQNTt
 T8mlhE/13BMzi7UTIWcoAoQ9+n3CkM/cL9HsEM9XpNc6ZQhHXU1j6J0YdUqrZCkMLNfv+dS2H
 RfupBT8Rp7JY6OOf20aLVAa0fNjIfKN6QPonxosGr/m0wcjmMmB1vRq1fQqEWk88ClFE8myUY
 d3ftJn6S85ct57UhTiFlQvem/CN0u4cPA0cS+sHlvIOr1G2QIzS/eMemHzdzvSijnr2r0yW7E
 8DGWrt5SFYB+zFefueSSzxR+/oGh7TCSajVoNjHijoHhgW2OdWKAAhlFTqTRY0JESC+ZKdhLm
 Y/71hT5TllPxWlpAKjekiyJmPR98d/WI+HyZW8GZVzCpYR1MfVR4OoyjXZOMndAKfkT3bLasc
 dpUbjxQjuMQBK66G1jx5GxBja5arIA9sR1Ylrd3DrQobJEafLSbMgX4yGQSEAnkg1+5SZ80Bv
 8YXJOtYXsBQ79kw7f/R5jHCGq0pHhKx9TuxA5MYxrpEObdH0+ncAUM5rqyeJxN+4D2nS1hy
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@aj.id.au>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-trivial@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Miroslav Rezanina <mrezanin@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Miroslav Rezanina <mrezanin@redhat.com>

Compiler reports uninitialized warning for cmd_flags variable.

Adding NULL initialization to prevent this warning.

Signed-off-by: Miroslav Rezanina <mrezanin@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <07957dcab31f65de3dd30efa91e6b9152ac79879.1579598240.git.mrezanin@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/i2c/aspeed_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 9cda9685016c..fb973a983dcd 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -400,7 +400,7 @@ static bool aspeed_i2c_check_sram(AspeedI2CBus *bus)
 
 static void aspeed_i2c_bus_cmd_dump(AspeedI2CBus *bus)
 {
-    g_autofree char *cmd_flags;
+    g_autofree char *cmd_flags = NULL;
     uint32_t count;
 
     if (bus->cmd & (I2CD_RX_BUFF_ENABLE | I2CD_RX_BUFF_ENABLE)) {
-- 
2.24.1


