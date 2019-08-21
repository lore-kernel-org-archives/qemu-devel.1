Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697FBC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39AFC22CE3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39AFC22CE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0OsQ-0003Y7-77
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 07:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i0OfB-0004iK-T0
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i0OfA-0006Tk-PO
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:20:25 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:33997)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1i0OfA-0006Sm-GC; Wed, 21 Aug 2019 07:20:24 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mgw7n-1iRlrP1GE1-00hPWR; Wed, 21 Aug 2019 13:20:14 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:19:46 +0200
Message-Id: <20190821111947.26580-14-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821111947.26580-1-laurent@vivier.eu>
References: <20190821111947.26580-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2/y0RZimKS2QqEOdr6rtgUM5CISmSCnCXkpUKfp06kwghkw65uO
 +sdap4Mi/6IvHrpD4ZpS37Mu6sfonvd1tVbyCj0Zp0kRG5TW+Z5DOv0oeDyF7BvZyosU1ZA
 VN+3zb8BNrVlQ+H/7037YZvZMy6sE2LNsyDtUAn8FUc6+i9qXNai3GRq8gNdWyOTcyVGmTp
 tgnC4ZG82q7V/7ksClrFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rWnds0iQH3A=:RCdOgpsm5csAK/OyCYy1Zi
 hTNpgerpd4pgrgF1Ibwc8aAN6CuJWexIaEFkHvx28JGaV7b/avPHvur/VGbgCeKB0R3XvNB60
 Yi4TcQDY00bhqnI8lfV1JAEwMr3wZGKZSrkjvZiI/9zfMcxY3L7dseY54o6vKD9PDnysix62w
 l8HEF3Hoy4pWssPA/YEIx4RJfxvCugcgHa5fcMAJNHPCDPfxFKuEbbc2p3RCC+criG3ujbImS
 OAazKJE62+gsEI54XiiH7mRlC4nbVVHrLqd3y6qxTPLAKPw/LyaHMWfre05PwQczb4qXaOOij
 wb8QHuXwCsF1Mkfsw7A9hQIGRM+dN4GPRgzOwzGJ91Dj01SVFCzgcD+hWayVAV4xbJYZD3iu2
 9cmoYjLcrwGOSbMM7nlQ789eusPg+R0OEIaK5SbJl16A3cXuWzhBbCPDIyXOGaM3DHK12n93O
 fNv8ITHtEeB5CeR9Z3fSDO0QewO8z2lrMbNtMTt5WRWreFiAj+GJAzqFhICN9U4lY3XVNeai4
 9MpKb/vZ/rrOS9LRmcEMq1C4zMQ8/qKTdm30JWJklNE0g6bHMvyEERAw7J6eLajfNMhLZZe/h
 MdSMR8V7ZUO2mpI/0qPKHfHMVpnl+oo4f4m5AKMIttelEYdfxvfugvLyCjWQztAHE9ued42Wo
 HH2BMFwbF5OWqM5g5LZV1LMIjfHbEFfYWFHBnwHDsXOn55KACX/J35XUbOb2ZDmV6HbV4Ain/
 E3kCbGNdojif0toyP8lKo9vMthStH6gIX8d+3+00tTKS5m991IxcoGjhN+o=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: [Qemu-devel] [PULL 13/14] hw/display/sm501: Remove unused include
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>,
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The "cpu.h" include makes devices target-specific. Since it
is not used, remove it, so the device become generic (we can
now compile it once for all targets).

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190812113739.16587-2-philmd@redhat.com>
[lv: fix conflict with 650d103d3ea9
     ("Include hw/hw.h exactly where needed")]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/display/sm501.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index d9e5762e367a..1f33c87e654e 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -28,7 +28,6 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "cpu.h"
 #include "hw/char/serial.h"
 #include "ui/console.h"
 #include "hw/sysbus.h"
-- 
2.21.0


