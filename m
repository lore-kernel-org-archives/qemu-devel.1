Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2678EC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:40:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EABE72075E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABE72075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38659 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMWXv-0002Rb-6f
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 07:40:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWLp-0007uK-GC
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWLo-0003Ww-I9
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:27:37 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:40459)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMWLo-0003Vz-AA; Fri, 03 May 2019 07:27:36 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1MHEPI-1hZhdZ17PE-00DIJE; Fri, 03 May 2019 13:27:05 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 13:26:47 +0200
Message-Id: <20190503112654.4393-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503112654.4393-1-laurent@vivier.eu>
References: <20190503112654.4393-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9mJ0MGscqZRGBssB4WUsQFl3MyEohYKw0+nYDypOHB4kljMeWOr
	KTiOz0xelByBCjut1qimUyzh6sXudAvBob1yQWVckkkrw19qTk9bhb5WR5LlrfCRs/JQVB1
	1o1Uch6d5qRKmpDRcqEe0qrOCr5NuKZUfkEviGQ2310xahDE8xPNHw0dfcsaHREWU4MqWJ2
	zabRRwLY0JJZ+M6nI69Ug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mYlqkDd0v18=:VbHbjz+SXh//p930qlIPaE
	b461DT1hqvMJ6lWXroidtbye3ZdnfVKNkdYq3sbgFD8N9PEsbcW67NwopU3w+o1RkW2XLiJiw
	nOCLmT7JGsUmbdHOZDx5KMu2hG8i7QMPKtphdf6t9EpK6ipuYMneBfxViNW182lbo6idKOBq/
	DYIwhmf8rTGKMM0PTVZ5WVtiG2KM6xOwU0+b+ibZGY/FWiTRmGm0dMLtYEWkLQTi4IiHyvJyB
	ozL4+ZJfi/USWSdOqMinDSDWwULQX2j5juwqNOKNPUssVWuGzV+jDBixVpcV7u+eRLgXaDLIL
	jN8ZIHyD4Wi8BgdFU595Tl2G7VThb+CFWoRy65QEgWiO7YGyUCAl52n9qehABrbWOx/RurABP
	B+P9xxLN3KhDhC/alidAgjp2vSffotWCk+04STjixAETaEwzSWBceT4KM2RK8sbbdIHUYCyQ1
	WhL/0bWuCqWFVpsvoBvWbO4S5hTxlZX7AA41HlkvtzNEMoqXBUo5QIwO3Bxtbc+MQwhVDSaSC
	kfBRMG4HjwUsQr31qsoLryHV3rQXwbuEcV4qKv7Kos6y1Aee2+T1Ex7MMBjB62l2Xs3Ah+zLH
	lZd7oSU4hofN21Uq3CHU4MvP+wcFscifUmiS7SGJt8HZsGUCFLs7RNUCNhm/3Zro53ERvsY2/
	0hNrjuUONttR3jQuBSjU3l8jPKd6h/WRk6oebPi+nuwVi7uDxHSi7oQSuPvGxFhliRJyJd040
	ke4ICX5ZkecedWV02FBW1iy0S2IvGGjt1vtP5wGOeBU4gwF5YwpQ3MC++4A=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: [Qemu-devel] [PULL v2 05/12] qom: use object_new_with_type in
 object_new_with_propv
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Laurent Vivier <laurent@vivier.eu>, Fabien Chouteau <chouteau@adacore.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503112647.OsDVMu6TDYPWpGcC3Z8yQzX4hMSzdVmWQ463QMA4wHI@z>

From: Wei Yang <richardw.yang@linux.intel.com>

Function object_new_with_propv already get the Type of the object, so we
could leverage object_new_with_type here.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20190311083234.20841-1-richardw.yang@linux.intel.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 qom/object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qom/object.c b/qom/object.c
index e3206d6799ee..d3412e7fdca6 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -679,7 +679,7 @@ Object *object_new_with_propv(const char *typename,
         error_setg(errp, "object type '%s' is abstract", typename);
         return NULL;
     }
-    obj = object_new(typename);
+    obj = object_new_with_type(klass->type);
 
     if (object_set_propv(obj, &local_err, vargs) < 0) {
         goto error;
-- 
2.20.1


