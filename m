Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCF1C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:19:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1344320881
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vw6Ht19C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1344320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52924 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQcxb-0003lL-8R
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 15:19:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvE-0002Tq-L9
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvD-0006oQ-M5
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:08 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQcvD-0006nl-Gn
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:07 -0400
Received: by mail-pf1-x441.google.com with SMTP id s11so9612709pfm.12
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 12:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=DHS+azgDjOz9872pwx2wjM+spw3T8bEncaHuHvbQJSc=;
	b=Vw6Ht19Cc2d0O99O4y9E/m6n5DH1o3Gac4gmuvKoHF6mzIIIqJX0fcbmXRNwQSku5V
	nw3E/OYtCeUDzGZQGlauJfh3ObBRa5XThIIkw7XVaCifv6N6CLNJKu6Mp+h2goGyNinl
	lZMEeFM8jSPfw8c8iIyG3lXULeRpIi87TMKS2oGeJfjjPslGhwlRygEM14LuD1kY9PN7
	9jp0fdmo0SX7RFvapzFktNuGurDrTowL15YtjQYGg2i8R/LVPycYvHlw9AC0guZf1co/
	COc6R+1D8W6c9ksEa/i2VOsoUqO1VmFalq2O4PBP4oHdqEpGlpT2IYsbRh/O3KK7H/nS
	1lWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=DHS+azgDjOz9872pwx2wjM+spw3T8bEncaHuHvbQJSc=;
	b=uHcjQidl/Hh4sHhbFiYqnjeCGjtf6NVnQAKbDerakY4ULqDPS8QGqpc/fX60ORlo6S
	yL7IVU6UjL6te7PVIjiDPEI1NoNoSRrExRf6eyy+cb0n1V//djbNXeu+6qyWlUXHwnzG
	eMyC/+HMsuXp64Df7KODnJzkHL3I3j9kkTYLleTa4zBgetgS+jteoJPyJd1iksqe9Xes
	ZZJ4xiRGl8qZKy6PQ//K9z3noK9PpO1ElRMOHn4KeTeX58zSGUqnwHMd/7wpGfCacclO
	Mew8cG4Ta4vrIRJQDYjBzXYGo+GDsJeZBuFxAGj8l7fXMMkvxZMueUJig7004YLnrfZ5
	r+aw==
X-Gm-Message-State: APjAAAWh/UZ7tRdAdv4uQfGoabGfnDamCqvZpmYW0aWqxljZAn+6PC6v
	zS/uf8VdiInbYPfvgY/5bxAvi+5o8q8=
X-Google-Smtp-Source: APXvYqw8lbv3t8oCBHlpsI7gngLu6sinxqi1bc98GTxIhwPbcqZCXhym6mynVdBVRzG7kcuHyuOqIw==
X-Received: by 2002:a63:690:: with SMTP id 138mr39216636pgg.415.1557861426286; 
	Tue, 14 May 2019 12:17:06 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	o6sm18682982pfa.88.2019.05.14.12.17.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 12:17:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 12:16:37 -0700
Message-Id: <20190514191653.31488-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514191653.31488-1-richard.henderson@linaro.org>
References: <20190514191653.31488-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v7 08/24] ui/vnc: Use gcrypto_random_bytes for
 start_auth_vnc
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
Cc: lvivier@redhat.com, berrange@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use a better interface for random numbers than rand().
Fail gracefully if for some reason we cannot use the crypto system.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 ui/vnc.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 785edf3af1..d83f4a6ff9 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -43,6 +43,7 @@
 #include "crypto/hash.h"
 #include "crypto/tlscredsanon.h"
 #include "crypto/tlscredsx509.h"
+#include "crypto/random.h"
 #include "qom/object_interfaces.h"
 #include "qemu/cutils.h"
 #include "io/dns-resolver.h"
@@ -2547,16 +2548,6 @@ static void authentication_failed(VncState *vs)
     vnc_client_error(vs);
 }
 
-static void make_challenge(VncState *vs)
-{
-    int i;
-
-    srand(time(NULL)+getpid()+getpid()*987654+rand());
-
-    for (i = 0 ; i < sizeof(vs->challenge) ; i++)
-        vs->challenge[i] = (int) (256.0*rand()/(RAND_MAX+1.0));
-}
-
 static int protocol_client_auth_vnc(VncState *vs, uint8_t *data, size_t len)
 {
     unsigned char response[VNC_AUTH_CHALLENGE_SIZE];
@@ -2628,7 +2619,16 @@ reject:
 
 void start_auth_vnc(VncState *vs)
 {
-    make_challenge(vs);
+    Error *err = NULL;
+
+    if (qcrypto_random_bytes(vs->challenge, sizeof(vs->challenge), &err)) {
+        trace_vnc_auth_fail(vs, vs->auth, "cannot get random bytes",
+                            error_get_pretty(err));
+        error_free(err);
+        authentication_failed(vs);
+        return;
+    }
+
     /* Send client a 'random' challenge */
     vnc_write(vs, vs->challenge, sizeof(vs->challenge));
     vnc_flush(vs);
-- 
2.17.1


