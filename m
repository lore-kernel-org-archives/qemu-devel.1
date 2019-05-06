Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431E2C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10234206A3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n8q6IHGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10234206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59928 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhX4-0002cm-8w
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:36:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhVB-00013I-KB
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhVA-0001KR-H5
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:09 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNhVA-0001JI-91
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:08 -0400
Received: by mail-pg1-x543.google.com with SMTP id i21so6781675pgi.12
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 10:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=/ZYAcflQLE8QxLnv1PzgjeCpnaQ2OAMJAHbK0JDJ8Y8=;
	b=n8q6IHGmbXLkHiw8TrdDI1Qnr0lkZsTs2wkjYQ3BIKve8qI7/ZptgDyrOOpXbZqimF
	bg8lDUZih+BLgc6jPoUEZ4Wvh0OVv4yCrIw576Y77P1avSmPj+EaZE+oZrvX4ZpBFVIW
	HLSOIwoVVV73ExFEhfBmtvfHRDu7wto23KWyqk+9mKAPkbwMkEMZ3jNr9qdfGoMjZWYH
	YgY8I7PkCuldJjHS0beqsCh+b0mzwAbtvYxuRzv4nx7g5uAwUztMKEcoB7uFHXSfMahe
	x20bh5Yksyy4z36/l6gqCgYj7jF3B38aO7nPlF+PAcr8/uSLqLdhhjZ9md6o1fK9IN+7
	S/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=/ZYAcflQLE8QxLnv1PzgjeCpnaQ2OAMJAHbK0JDJ8Y8=;
	b=iTXkZfSg9fLlKzQvr/xozElndTn1EJVKGLW/JnmSe0Be6oUsQVH5RoHnnaLCcD1lqU
	A02hMfEQK99+rHdCNa7I3pZrgiZrydzrkHYVrHXZi/DGP6BUwyodIViBOuzdwwpHEazB
	nmmN7jSRw4MQCLpIF3svO1njvfotVF1jYnFYWKd+lLsnQdmhrE9k5dUENK+2nBw72nG2
	QF7TE6Tr2v7gQ0PymtmFbJcehIhA9W0ilk+OsjU7T3HNALQM3bwKNxg1vtAVZAR4Zudc
	cHIzageKMdPM9AIldP7GQNo8otGhAZqEySyV3LwhtEKYtopEpJeQxYPFiyHw9PHANgju
	LV+w==
X-Gm-Message-State: APjAAAXyJkCOGo42RV9/15DRfldhxV+ZuONqUt2OfME9tMt1JP6jQSOO
	536CxmA7uYWAYEhySBUfeipqKq4Fxgc=
X-Google-Smtp-Source: APXvYqwW0BSLyL38Gb8oOdJIlLZkSaG9WDUw8vYV3mkxgX16KAH4xczs268OROz4KLY1pQv8NmpT+Q==
X-Received: by 2002:a65:5241:: with SMTP id q1mr12586526pgp.298.1557164047018; 
	Mon, 06 May 2019 10:34:07 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	k9sm2268839pfa.180.2019.05.06.10.34.05 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 10:34:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 10:33:38 -0700
Message-Id: <20190506173353.32206-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506173353.32206-1-richard.henderson@linaro.org>
References: <20190506173353.32206-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v4 09/24] ui/vnc: Use gcrypto_random_bytes for
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
v2: Use qcrypto_random_bytes, not qemu_getrandom, as there is
    no need for deterministic results for this interface.
v3: Fail gracefully in the event qcrypto_random_bytes fails.
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


