Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DAFC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 19:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE9FD20675
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 19:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE9FD20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57472 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMH3S-0002Bl-2P
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 15:07:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMGvu-0003tu-Tu
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMGvt-0003AL-Sm
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:59:50 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:58473)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMGvn-000369-Vm; Thu, 02 May 2019 14:59:44 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MNcYX-1h65kT2sN1-00P2Q2; Thu, 02 May 2019 20:58:54 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 20:58:28 +0200
Message-Id: <20190502185835.15185-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502185835.15185-1-laurent@vivier.eu>
References: <20190502185835.15185-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ur/Wju8uHKEhby/1Bd7kRz2oP+WPX2g2aOyNZSbku383Jx7XDj/
	2gQN9Bgozg3RGKscB8lIGhiWqY0Wz56RIHJkHCqd7709G70D1H1b03cS4Cx6AUMfcLBk/K8
	/7mdtp5ZRF6KyP2UKCLoryDWmaFCMr8ukZWOcLCC24aEVF9a8dXTeXTnbaM/XDk9fZKNlzA
	lcLQz3X7a59XdpN/LMRog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rc3vUDtaI6Q=:3NtnypnZDcRZWrct7S1Ek2
	sbrvRdWLr6jVKAgIt9LI+WgXJ7fZ/+cR4hsvqhS+ZiUEFkLKaFtsS3hWn0BnsZXnuapykTWWQ
	O0KOqrCQjBYoIjogYG7d/hF009G8/zzNYYyvNNvIuVtXn/HQo6DjrS9KOrkg23glEhHi00I1W
	ftTLh8NhbnMEpzKP6auQmkf0PydnpovTK8VHDNxltY7vAIulDFaQVRZB54dwXsjG9rw8isHEI
	DVfHZGDmwKoNJ0Fs0n2sh1dUFjyl2gRIE6G5Q1+K6ca9Xlxzon2bTuANpMVGQY28amTS2fNBy
	dB2V/g/jl4xADMv7mK7zBjfeIio7ovBngNCFMYZaGhZl6lQ71qVRmcE7WFkfkGbIkGapxmLm4
	kuEW/kpa1wiLdBl8cSCNWv+GS3bX/G7eOJXxlZzPhWYjKjvKLdebju8Or8RvE+0sHRWFO4zUA
	KomQa1Xp390Z+Riy1GmM+IGwwIWb3lRr4g+5KTuRHB6SchWLhVFQewOniMMayovD84FfeaUca
	TXG7pazDNUdZJ8HUyM5sVgfMQg9iJK+aj/I1BDw3VmqnwJRxoSW8huBnQMCPGmBi2RVAZsk2e
	cWoV90pao3oGw0lZGbc/sal2HIII+fKz52URt0kD56IvbmvZW263PSdnBRxoXcVcf1kxpxffP
	7MXbcJCqjCr2a7MU83IUnmM9lgXFzIKaYegS5L+Mmo4/vOnx1uHCRReFIJMYs0C4ObRQbBy8F
	hA1zEhIYKCzZDWGYZEtJwnxTy0/v6x2ymCM4qq5FbZ+fFZjUTDS47bLxWJo=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: [Qemu-devel] [PULL 06/13] qom: use object_new_with_type in
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	Gerd Hoffmann <kraxel@redhat.com>, qemu-trivial@nongnu.org,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Fabien Chouteau <chouteau@adacore.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <rth@twiddle.net>,
	Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
	Laurent Vivier <laurent@vivier.eu>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502185828.YhJfs3uZoBmIGIaN0IrUI9AUX8Ge7T0rqv4yPZnpWc8@z>

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


