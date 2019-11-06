Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB42C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:24:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D439206A3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D439206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJQW-0000Mu-JP
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iSJPm-0007z1-Jr
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:23:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iSJPl-0000b2-Gb
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:23:54 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:39461)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iSJPl-0000WI-6F
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:23:53 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mxm7U-1hibSJ1LyA-00zIjP; Wed, 06 Nov 2019 12:23:45 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] dp8393x: fix problems detected with Quadra 800 machine
Date: Wed,  6 Nov 2019 12:23:39 +0100
Message-Id: <20191106112341.23735-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lVdVaXoaUb+tP2grl5zvmMVYWpjlERCygCfvJkeE6DS6kzrbyPX
 GaC4YOGc+p+CzyKn5T2yzN/cD9mUuQxr+i1/vRq8mT5BgMl1Ly2SVM7/0hAU6JMH7d60l3B
 rMTtdvxUHX9Q9mWGux5yk/vqVjmwISv9o24DYsCADq6M9ToLhwcR8gFy7Geyc0bM7iU077A
 qkYjQ6s2I7rWWzWkzhfkA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FJkfl0aSMMA=:gXfJbFK9GIkfQ8/7j69AT7
 Lgc+E3LGx0D0Zx+Eq1LYbYYO2dJlZGMoB+YjP3J9U/p2dMQILdIk6fAXUA5fgjQVuCTmfZekD
 Ew6QTgTqRoTTZemkJBxPeCnn4CTuKV07jxReI5B4/bDIY1vnBHWJoCXmDStOWceKlAxlCwr2Y
 x/shJUbWKXHSinyXk5kBoh0C1VbMhVrMCPPRtaiapMC7O/rEnnGg9nIR155mpUyGIxkuPGoEG
 u/zBq5wX6knH1tCCDu/nFubU5uBuqapfP1j5a1LbyQuyPusOvFui+qFEyDrWlIB3I5mROTp5t
 gpFmrv7XRWpNQPeLuaac6CD+tyl4ZVxJy2UmP8Q8DJIom3Zhm77SSSI3gMvUpAvOhYOe2cLp5
 ltI1hyxtFMj+zRY/5YpJuDPZ+slLgjR5pjBYMOIcDSPUMONZdkTP9be4ymWvxiX4YOkX6OfCr
 ztywQsAt2228vPTZTDBHK3nG6U9KTIrzuFt07N1OHyFixeEyJbJznvBQJgYm6Rjl4013whk1x
 1wHLUJhi5WMmBG22Kxqu5ekaQc1qGOPloJUPj1MhGY84zMH2IwFcqA4tiHwjmv0xh4Wi+Fhm6
 DmWtCQBLzZTiecSNeSg9pqI4KEcRqzI5LwX9Uy1co9qOwdfM99mloAZ+1KFWRNOk7lk0td9oA
 S3eOp/k3K1hQXr8EstKCTba4h8WTCGBWZrjE4p7OoJTGsrfLOuQGgvAXj261CgH12ed7KLIdP
 S6tmqOmgvvEMu0Cf1oUxSnd8hoi/uHJRWwpZD9JUjKIf46IdcvUOfu16Ee3LAjt17Ix0ZZa9w
 miP2tGyO1Vz/PFuDgtFqd62djt24JeO1LTEEu26zf0BwstCcz2ZyAKQe3r3AeJDW1DOr6eugc
 GRP7Te3uNBOsCd1LByvgzeaR7R2lS0mRV2rHQBzeY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.74
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
Cc: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series starts with a cleanup of the DMA buffer, moving
it from the stack to the state structure.

The following patch allows to negociate the IP address with
the DHCP server.

v2: remove PATCH 3 (will be reworked later)
    modifies PATCH 2 to adjust the offset of the field,
    not the size, added R-b, T-b from Hervé

Laurent Vivier (2):
  dp8393x: put the DMA buffer in the state structure
  dp8393x: fix dp8393x_receive()

 hw/net/dp8393x.c | 113 ++++++++++++++++++++++++-----------------------
 1 file changed, 57 insertions(+), 56 deletions(-)

-- 
2.21.0


