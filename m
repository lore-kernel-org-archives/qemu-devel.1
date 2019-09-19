Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C19C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:00:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E0512196F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E0512196F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAwzG-0001JK-Qx
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 10:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iAwwz-00078M-HM
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iAwti-0003ni-EF
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:55:03 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:50151)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iAwth-0003me-5G; Thu, 19 Sep 2019 09:55:01 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MfqGN-1hhwns0vNZ-00gGbg; Thu, 19 Sep 2019 15:54:53 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu, 19 Sep 2019 15:54:43 +0200
Message-Id: <20190919135443.15164-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190919135443.15164-1-laurent@vivier.eu>
References: <20190919135443.15164-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:f+6zjxTbKi06c4tDhzzvg9koiK38E/wSTMmp6zkUdD6cg0MOIHA
 xnG+2TBfmoYe3oNcP0VTXUPBplYRXxiGpbwzz2W7Wgrux/2lS5efTH0qGT9HOgF7iKz0I/S
 OUiB3HYM4fIaBPDrCy1E8ZTL090aIG5e30PkIG6dll0wqPRoBg+3jt2XRBQ00QXoj5GWdFv
 hmw9qRWwxA+Ahxn3C6UfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zxUz0HElFP4=:odiie1ryMABIwcTj2eaOXM
 cgWVvlq/2FLpSdChEYD0nxvFOSAo8suACDHFziAdSmfMrjXgjNvDQ3Vdtc4zBLfWVgjMIzhWO
 i9JO7IdflhwbQ1p7TnkmNq7wuJWfWLtUVDJ/znwBWXXPQI5nIIPV9A82NeY8vJPKbJOpwOhJs
 4uVg1s72byEkA1StZ4BkkjAAkpS4qyFKofm2RJFg7Cuff40ZpdpR3zmJKLlDKD41u4zzycumx
 Jvnk/WHEPRfpptogvsU27uB9iP4eN75Dv7mxAHjcwoWVH/1HmPsTZrDfZ/+V+5/ixa1zem8Yq
 oWvRU6vLHAQhbClHB2hHbK3eLQiODAp9jEMr3wbl2h3M0KVQ67r04RaB85/RQnZ/Nc6QmGmlQ
 h+sdYgDrmVr4ITp35b75J5Vy4/mMv3JzESEdJC4y72KafT/X7ZW6ZWBYEjXMdLxWE7UtItWah
 QA8w2NYMNiO5H5BoFfelqu5lWC44BeMaU2FdDi3pGkJUN3B7kGQM0rjni3aGGEx87AToMNRkd
 0k7ZILyoJMYEl4SB2+7H9yWciVlWSpXE18Dp4XnU4+nVVDQRqpiczvZkA2QGGlqEm2+OXUM9B
 O1u0anT038KB2rdIMnXjfT7nynrs0GYw0iEtSJ4PNZY1ZaeTzYCg+Gfb/pofhRxwHbvyOQ570
 /ihAUlYGxImsZ+dLoJAtw7mpGbYJgt52GLwh+gQozERi5jen6X5slrQjpEgBg7VANLCDvX5MC
 PM1Rt+NoB26N41R3MXQFOAy2vLd9JV+p6RVNZQlkj26/1CTry2Dyn/95Q+bp+XE/Ozn9ulcDO
 +2Ky0zW63FbQMk2Q8fkva5juGEQ8VPSuh8wpr97UfOtwNHSmGQgQgXmxzWAyK8Uzw9uafK2u4
 PCPmUA+/0QUY4pqoAwZ8CCxQIO5jzXiw5rYjESFhI=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: [Qemu-devel] [PULL 8/8] configure: Add xkbcommon configure options
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
Cc: James Le Cuirot <chewi@gentoo.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: James Le Cuirot <chewi@gentoo.org>

This dependency is currently "automagic", which is bad for distributions.

Signed-off-by: James Le Cuirot <chewi@gentoo.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20190914145155.19360-1-chewi@gentoo.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configure b/configure
index 30aad233d17c..30544f52e630 100755
--- a/configure
+++ b/configure
@@ -1521,6 +1521,10 @@ for opt do
   ;;
   --disable-libpmem) libpmem=no
   ;;
+  --enable-xkbcommon) xkbcommon=yes
+  ;;
+  --disable-xkbcommon) xkbcommon=no
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1804,6 +1808,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   capstone        capstone disassembler support
   debug-mutex     mutex debugging support
   libpmem         libpmem support
+  xkbcommon       xkbcommon support
 
 NOTE: The object files are built at the place where configure is launched
 EOF
-- 
2.21.0


