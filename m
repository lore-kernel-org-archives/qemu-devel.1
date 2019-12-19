Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B2BC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 20:17:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0377C2465E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 20:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0377C2465E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii2F7-00042o-2M
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 15:17:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ii2C9-0001Gx-Ns
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 15:14:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ii2C8-0004Nq-ES
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 15:14:49 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:58695)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ii2C6-0004JM-SE
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 15:14:47 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MyK9U-1hlVkq40CK-00yfS6; Thu, 19 Dec 2019 21:14:41 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] q800: fix and improve RTC/PRAM interface
Date: Thu, 19 Dec 2019 21:14:37 +0100
Message-Id: <20191219201439.84804-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:aMnSku0BHCml24LY5J9dw5NnZnIY7CauNBmCynwHDa0FODmLeuO
 AuULyTEaswv+uDXZpwvOWToPrJruHHhP486HCmJDwHajwwXcNVPbpTqjvVDRkxBXxx4RIMI
 CyUoGbnfRRGHLSBwn9qOFRFSy47yCiJ064jCyAyv1vdrGziVdx+16/V8997k+COaDNAHLjP
 MQW6jTjC37DT9Qfv+3EyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7mCXIl8yAQk=:Ahm9SP+NUVHJ/cpzlu6oGe
 VhLOjWKUiEfQ+gPfXDy54JwWcwRO7o7XEZk5k/6k5frdN9Fek8tndm+yF26B9Oyax+l2F3cN0
 3BPawEHB22xfsLtGSDXdU1kbyMBnlFizbBoCQIPYuV8S+jELjJZbRGunDTwZSprYbty31Cdd0
 nqIbCiDCr89h8cXF6nLhmUnAW5X2itGnY6RXTYBHL+/yGaJrehCMTFXs/7kHxmwuGQ02dg7As
 ZUlvFHWYBLa0U8pyZZcwlQ5l0//M/+dcvLcXPz1MeJjMqVA/vDlSXbyIctk0cFxXcLe3O3M12
 01ci/6LwwUsIWiZLlSb588JOunxQI3NNCLO4cYiDFDND1VvupuHtjf0MKDZ7Z/GpAw8mFbShO
 y3hkZynXvDzoAVwJX4So0pLjINKHV1mrKIhQ6d9kBj6fdjldqKAp5BUnrYnKOLmeSl129zn7M
 w51zKeM3pML/HXZhBTsIdoiAAPY4OP4uUsCp8WXmk2WdxBAMP/YoXlztwub8i3lKGcfalAyEo
 NWRqSh7FwW92FCO1XHNi1r+RpFdf2sVliMiE5XVc4LffX9zWliOYZ2DjVQKElC+7Cz1WsvFFR
 VGbISvc3YRTfJK8rZdQ+M5cmeRyQVxezuxcHmXtk7Nr7qgPCNUB9+tRsfOufXiqvYzeQAFKMY
 SjYLeVz3XImYgvBnZT9LL3KZwAegWfU+AS4wOjgslZ1xeKrj5KQuKkIGkoXEVSFiI3qYcGqRb
 7iqvnklnuEiEyD7rRgSOpapY3NqgRV6Iocsod8ycZDuCsk8AwC8307QtSPLcuuRGwMoEglomZ
 jsHLjIRLLXaXgqcRI5sig4G7RJoCUtjTBsIRsOuHIdZ4BxVGte65iienMREAc5774+96fjwSi
 oY+ZY1jST70YARv5JWdw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.187
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A bug has been reported on launchpad about an error
reported by cc:

  qemu-4.2.0/hw/misc/mac_via.c:467:27: style: Expression is
  always false because 'else if' condition matches previous
  condition at line 463. [multiCondition]

  https://bugs.launchpad.net/qemu/+bug/1856549

In fact, the PRAM interface has not really been tested and
has several problems that needed to be fixed.

This series makes a cleanup in this part of code and
fix existing problems.

It also adds some trace-events that helped to debug the
numerous issues and a backend file to allow to save and
restore the content of the PRAM.

This has been tested by playing with the /dev/nvram interface
in the guest, checking we can read what we have written, and
we can read and write in the file on host and read and write
the same data in the guest /dev/nvram.

Laurent Vivier (2):
  q800: fix mac_via RTC PRAM commands
  q800: add a block backend to the PRAM

 hw/m68k/q800.c            |   6 +
 hw/misc/mac_via.c         | 339 ++++++++++++++++++++++++++++----------
 hw/misc/trace-events      |  19 +++
 include/hw/misc/mac_via.h |   3 +
 4 files changed, 284 insertions(+), 83 deletions(-)

-- 
2.24.1


