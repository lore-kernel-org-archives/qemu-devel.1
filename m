Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E71C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:35:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A188D2075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A188D2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38605 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMWTm-0006Kq-Ro
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 07:35:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWFF-0000pM-EN
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWFE-0002iz-I4
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:20:49 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:59437)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMWFB-0002d6-8m; Fri, 03 May 2019 07:20:46 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MuUrM-1gWTXz0yJu-00rXFY; Fri, 03 May 2019 13:20:13 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 13:19:51 +0200
Message-Id: <20190503111958.30825-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503111958.30825-1-laurent@vivier.eu>
References: <20190503111958.30825-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZeB29zT0oOs3OsLRmJuQ1prcSE/VXnf7d0USHLaAjAFvb1KYcPZ
	nmiOwO7zs4KanW6YP8AKgXM0xXJIRzPiLiDNtar0jb8HFx9QzwFgW4UwwXiXQ6qpWnKftZZ
	yYWD7BsxJU+slapMO8RMXG+zfKaYSw6SKS+uUotm0ruxC0T4BSNHrMCyb/t6I7ABPi8kWZV
	1IGRR1vJmcE9Yu2GzLBNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GXTuGl2qoO8=:iza5ngT5lN6sUaPqF28whd
	JjpqrF1jnaEMKUjoiOwTxTxZ6eT5z3FU7gs8tTC07ug8f1ND0BME9tvcFU9lV3gJnmrav3XPm
	/sT8ZUkAdsAA8/sbGqUngjGFsyXO2B5g2geMEQMwn0TZSygsJnhG2shgjdOkiFGmXvBzGH73W
	RzTz37703MZU/sD1QMdAIRpLYq2dUvYHdPRtPJpQOMsENDPydGvdukkIUFlE8zE1F9aZfsj7m
	ghoMPFsgp0xUO3z8ngCEYfP5EU6Ar3bCGMDMv1pNcjAWPQrAbS3Qq5JMPmxuZtsztz3QiV8Ph
	0EXkh5aqNyLhAWlORrxc2+pc1zV/kRk/LAaGRlXTN/6tlhQJenfE+XRmlFkwFMsCnAW6r7Bhe
	Wq9lPlnmgfcGKiRO4rXYt+jJ/Ks80HnKEhM75QwrofALxV49biOvyq69wN9b82vGseOF7HL2B
	ApGu01oAKbdpfiZxv3G8oXhTz7lzR42OBqkD/wB6DZRkCdquBo+QWGpghZmcpb2p908vVCMd9
	ynEbRGgAnEoswOzkfLeI5h4IS9sR98bhfPW9HLb8YvK6Od1u0a4q5AP/dttuH7n+FES1wzH4O
	oJ+7AQh2xUIGcGY6qYZy0Wj5k45xvoG1sR6Ej93y2XopZDexhtkH2eD4XDgMAHU9ex2harg4i
	LDrfyGfd0ejS7wJboRqaO7nxzJuxG60a08nHvsBO8t26jUPykAsJJj6trt3LTURZ6WUPnMwpb
	YzCDpi87CIEMA+gd04soVaCTDSyJKFMQepUblGxdBwh+HX/IfEuUwC+3bdY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
Message-ID: <20190503111951.3DOljlTeTIoZ2fbfqPL74YvjDgdpToJlyxZa9824KP4@z>

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


