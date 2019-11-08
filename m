Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2B1FC6196
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 20:40:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3562520674
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 20:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3562520674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTB3H-0005aW-7X
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 15:40:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iTB25-0004ae-1v
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 15:39:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iTB22-00030u-73
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 15:39:00 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:55867)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iTB20-0002qz-6m
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 15:38:57 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MWjQU-1iQvxZ2zdY-00X8Id; Fri, 08 Nov 2019 21:38:49 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] dp8393x: fix dp8393x_receive()
Date: Fri,  8 Nov 2019 21:38:46 +0100
Message-Id: <20191108203846.8837-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191108203846.8837-1-laurent@vivier.eu>
References: <20191108203846.8837-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DepvcJcesC1ySjR1qILdISoUcOoALj8D8qzYfTGOJYYZnMcmZaK
 w+Ku1vhvAtVlK1X21Gr7Bnpis4BUDlNzKRDc8WrzNepMgawS02G8kPjn+4mUDBGZ7zMLX2R
 Q8vgZq6zUrtDLOc64Kt62+JcCFBbBmzSk4cETfHucgJ28QLdFUOyoJm33vlAVVuPoLrVHY6
 N/cF78HgwJk7KjVscCoqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WeWGax1OJQk=:WG7Y+oYnZHrODKT+xHWz6w
 CMzKvKwUiv0YNbA90WeapgWEB+fbaluHX9zbN685cP0MBTk8Bd3l/36l9DbCbmfjcTlpUfA2U
 82qN/aw4bXBcaTD3RytJR7jfXAw3DdOrtA3TW2uI5hYody4rI0k3feXn8aTRAYufnOEYOVFlm
 z8zbEkIggC0KufpjngC+J8fGkxmSSj1+ntdXbqcVbGrPxYMQHJpKB9M6uxZ75G9gxjT109Vj7
 UuxYJSjsxDs/BCtdZPhSPmz1vC2pO7rnilxtNRkn5tijZAj+ausjaMR8cZ10CuNCGpBGC4lVw
 TK7ZX2wEz7YzrwWBlJQx6Z9Zt72kC4CXVd+eceA/+8/4JLkFw8SQgFXhbBOTt2WHtE9BYw0ny
 6Eakrl3lAF3AByOqeDGT+29uCQncc/ev+cF4YhVevjJpZsTgyFcnifq3CroE2rQDdlaEcwzQF
 hbSQQ1P/YrmjH/hPiuYzaVrTvcqBVMg69YlECID514Z8P4ale9t0xLyGiEtEcHKb/viGM9YtQ
 OLUBhRvvu1LkT7uWkSZvaG2ghvKsepeXcmzYQ1D7UIweZ3kS/C9Nv+XyHqkVewoagUYX4gakg
 1WHUtng5PEp9PvrUG062WRFZmHwFgOwELSzUwPH2O9TbYJTF/kIyzrvQil53L6mGDB9AGDv2u
 yM8+1sTVtOXJ+bwaxkmzVeJQMOlRnw289nj4b8F5HGhFNosO7vVHazJMYKQlRaSVIEUxNOBTo
 xrQPZlnMfzar8kiEIqK8us4ZpFbsminJov4Zzd2tRvIUjcos7dE7San7pTSnJO8KS3dD2fg8A
 aa+WOXYdlzuGRJTZrIfI07hMRKZ4Mo07aiR1QWIkgNOaR1qEyFUwdgtih2Gpku2q2+UqHuZvL
 Iisyf6jHpbKN8WOXnjZcsHV8BlUn6nQO9ZaFf9z9w=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.73
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

RXpkt.in_use is always 16 bit wide, but when the bus access mode is 32bit
and the endianness is big, we must access the second word and not the
first. This patch adjusts the offset according to the size and endianness.

This fixes DHCP for Q800 guest.

Fixes: be9208419865 ("dp8393x: manage big endian bus")
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Hervé Poussineau <hpoussin@reactos.org>
Message-Id: <20191106112341.23735-3-laurent@vivier.eu>
---
 hw/net/dp8393x.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 85d3f3788e..3d991af163 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -831,9 +831,15 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         /* EOL detected */
         s->regs[SONIC_ISR] |= SONIC_ISR_RDE;
     } else {
-        dp8393x_put(s, width, 0, 0); /* in_use */
-        address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 6 * width,
-            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, sizeof(uint16_t), 1);
+        /* Clear in_use, but it is always 16bit wide */
+        int offset = dp8393x_crda(s) + sizeof(uint16_t) * 6 * width;
+        if (s->big_endian && width == 2) {
+            /* we need to adjust the offset of the 16bit field */
+            offset += sizeof(uint16_t);
+        }
+        s->data[0] = 0;
+        address_space_rw(&s->as, offset, MEMTXATTRS_UNSPECIFIED,
+                         (uint8_t *)s->data, sizeof(uint16_t), 1);
         s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
         s->regs[SONIC_ISR] |= SONIC_ISR_PKTRX;
         s->regs[SONIC_RSC] = (s->regs[SONIC_RSC] & 0xff00) | (((s->regs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
-- 
2.21.0


