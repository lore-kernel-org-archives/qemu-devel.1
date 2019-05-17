Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EE3C04E84
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:50:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C415420848
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zsG5MhDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C415420848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40265 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRSxT-0005zL-3c
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 22:50:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSma-0005Tv-Pb
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmZ-00026L-R5
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:40 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRSmZ-00025p-Ao
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:39 -0400
Received: by mail-pg1-x544.google.com with SMTP id t1so1101179pgc.2
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 19:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=DHS+azgDjOz9872pwx2wjM+spw3T8bEncaHuHvbQJSc=;
	b=zsG5MhDPy3Peh4KyxlyG0aJPng5JxmauuCZUD4qfQDNewiIZ/j1Xga6OU/4DcKkXi6
	Lxi4V3EeO/vTN5p8uJlgm3giu2QEIR+mUGqiqU4qk4Vx32pUMhi6XtkTB4gSlS0tyZkI
	kTK0cIoohtsV85a0DUh1WwKM7V6kj00Sdzl4Xripy/yTO+EzZtPbAgv1ArMImd0F/lr5
	kE+FDgHKJMLzxrizQ2E4+7E11WfgBqty5uz0TsmsX8fcU37+2byouRWksabOAtFMxixt
	gSvVrUibeEyn/32tuC2j+3Iym4/2U40CT65H5PvCcHrfUaq8m+RadHbsTcKM+aEVhS/Y
	Bt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=DHS+azgDjOz9872pwx2wjM+spw3T8bEncaHuHvbQJSc=;
	b=pAK/7nFvdzeTPSqAMPVfiBBp9kf+B+HErBu+5vVDUT1K9+iK2oGE6xxcrTNNQf3tXo
	wc/qTgSmTqtk3J7gUI+yMCJOX+pAcWQnPFRj+iJ2werYfiRTuWvVUOKntVCtucaehmgf
	XVmVx344zj1l0I1CJRV4+F9Stm3sHUNS+GKhPf5IGNE6fWF25Pj6qfdoU25+8QPqJIdB
	/jBPyYXnY8P685Tk3+GSJ/k4MMC8+/Bq6FoZhJKT5oX/5aUtGa6M61qqnwX+7RGs14h0
	xLdLg9MB6dvn3afYF+KohAzytquB3/KGC6hNUEB6Vfpko9Pv6GsmGPEttt4Cr2u0ilsu
	Z9xg==
X-Gm-Message-State: APjAAAU1p4PlZZJzUfWdFHGHnaxc+y7UxLZZPOwvC5WXp7lSfw6u/Iyn
	1Oo/l2+JdpWhgYPJrKlJhcNc6148uSs=
X-Google-Smtp-Source: APXvYqyxMOp9taj7eZxTTFO5x5r7UevnXPJf+KUTYFE1TCAjx1PzQItXKw3NpZNP4Mh2D0fUJokVbg==
X-Received: by 2002:aa7:808d:: with SMTP id v13mr26719080pff.198.1558060778076;
	Thu, 16 May 2019 19:39:38 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id w6sm6984152pge.30.2019.05.16.19.39.37
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 19:39:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 19:39:08 -0700
Message-Id: <20190517023924.1686-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517023924.1686-1-richard.henderson@linaro.org>
References: <20190517023924.1686-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v8 09/25] ui/vnc: Use gcrypto_random_bytes for
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


