Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DC9C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 16:16:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F50420868
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 16:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F50420868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47368 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTTug-0000S8-BP
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 12:16:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTTn8-0002NZ-7O
	for qemu-devel@nongnu.org; Wed, 22 May 2019 12:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTTn6-0004R6-95
	for qemu-devel@nongnu.org; Wed, 22 May 2019 12:08:33 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:44495)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hTTn5-0004MV-W7; Wed, 22 May 2019 12:08:32 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MvJwN-1gcTU43eTp-00rGba; Wed, 22 May 2019 18:07:42 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 18:07:22 +0200
Message-Id: <20190522160723.31484-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522160723.31484-1-laurent@vivier.eu>
References: <20190522160723.31484-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+ZChZFfv+eCwtpcDNMLO86V5TAbr9pktjbX2aXPLYuF3TJoCCZe
	ALr0kcPcWykJ5tQM2eoNiWbZtJB/5Hu1u9fdM4+f+SdnocSHi1HgNcNegzL+6fwjkY5WE39
	ZzNDQDmFlzd5CHwqOQUqOBwjcmxQua70HuWmk+rQG0DpIfjRmEkBfxloi7fze7NnPGxGeWr
	BX5mKa6l+pZVpDkXI6R0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VOaKk3DyyEU=:EwbnMNB9XruZpw5CFtMOm8
	QUdGs7/vbOpeGF1Y5Hx4oZ28B4BO5mnqmo6+P0YjgZVTeNnOZzYkNcEFrXYpbV5oxb7StiM5b
	NK/azhBBOS551b6kk0Evb7a0kwPZcnXPvGzupf4eEqxDBBfA8CO4VyxR/41CdQw0ThJ4zF4sl
	43La3HQdWgNO1h8yxqPCnQ/qSFDonOmJe30QsdLawvEKizYFiaZA+GSaBB0vt1Y5oimg16EOh
	q+ygPXz7DqGxLKqsVmaoM3KbqSyXCRousNAGFNuqrGs+0p3N8xv3uh9TevtnVTcxboeTqpea6
	Vcd65AZrPxua0tBLOlnwcxb3UmaPNz8Tmn4Mgw6oiIcatv5WDxWm72ohII9dPrMbJ+09pixyb
	GZhdeKV/EZ6wnbyvXkOEHrUOAdjc1SQsAS+AscX4TnvGbebkGa5TtUNyEspF6ppBo+MNre6gP
	10Z5NEuo7o/EtRflX2rP19rRidVZM5HFW8MhVTFAdasiHZwSvhO61IJIKLr8J8MDbkxmtiIZO
	9jM3S40/6CUH6qGfYM088TKXa+Mk61i+tzdD8M1lCRhVV7FhnAlxa06JeUXVCQT6eCV7p3wdo
	qUH0ef3mr6cXY60QeYN9Y5tzf/vUTAUbkFDqhWyANYajhvGea1mgW7gRv6VwrKdXQlslBzMfU
	spVmMMsx8TtIQzXL3AcIU0nab7H4d8RqbxK/Fdhm+sJcJHqHAFHsKj58ELElcRwRjtJz6FXeD
	P91cpyg/bxDyyosPgDcA7FR4DLtnmK4eUDhVStGRBpP7cM/+bTMFaGMjfUQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: [Qemu-devel] [PULL 8/9] vfio: platform: fix a typo
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
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
	Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
	Li Qiang <liq3ea@163.com>, Cornelia Huck <cohuck@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	Alex Williamson <alex.williamson@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Qiang <liq3ea@163.com>

'eventd' should be 'eventfd'.

CC: qemu-trivial@nongnu.org
Signed-off-by: Li Qiang <liq3ea@163.com>
Message-Id: <20190521151543.92274-4-liq3ea@163.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/vfio/platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index e59a0234dd87..d52d6552e089 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -72,7 +72,7 @@ static VFIOINTp *vfio_init_intp(VFIODevice *vbasedev,
         g_free(intp->interrupt);
         g_free(intp);
         error_setg_errno(errp, -ret,
-                         "failed to initialize trigger eventd notifier");
+                         "failed to initialize trigger eventfd notifier");
         return NULL;
     }
     if (vfio_irq_is_automasked(intp)) {
@@ -84,7 +84,7 @@ static VFIOINTp *vfio_init_intp(VFIODevice *vbasedev,
             g_free(intp->unmask);
             g_free(intp);
             error_setg_errno(errp, -ret,
-                             "failed to initialize resample eventd notifier");
+                             "failed to initialize resample eventfd notifier");
             return NULL;
         }
     }
-- 
2.20.1


