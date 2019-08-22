Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EED5C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 17:44:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E6A20856
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 17:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E6A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0r8A-00066W-NV
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 13:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0r6L-0003pD-0w
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:42:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0r6K-0004jJ-5z
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:42:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15356)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0r6K-0004iy-0p
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:42:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 563243175288;
 Thu, 22 Aug 2019 17:42:19 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28EA96092D;
 Thu, 22 Aug 2019 17:42:17 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 19:42:14 +0200
Message-Id: <1566495734-23297-2-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 22 Aug 2019 17:42:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] modules-test: ui-spice-app is not built as
 module
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
Cc: marcandre.lureau@redhat.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

$(call land, $(CONFIG_SPICE), $(CONFIG_GIO)) will never return "m" so
ui-spice-app is always linked into QEMU.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/modules-test.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tests/modules-test.c b/tests/modules-test.c
index a8118e9..f9de3af 100644
--- a/tests/modules-test.c
+++ b/tests/modules-test.c
@@ -53,9 +53,6 @@ int main(int argc, char *argv[])
 #ifdef CONFIG_SDL
         "ui-", "sdl",
 #endif
-#if defined(CONFIG_SPICE) && defined(CONFIG_GIO)
-        "ui-", "spice-app",
-#endif
     };
     int i;
 
-- 
1.8.3.1


