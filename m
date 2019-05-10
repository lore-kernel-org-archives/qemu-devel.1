Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689A3C04AB2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:27:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 337C12183F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y+F5NpWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 337C12183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35020 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOuJh-0007yn-DY
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 21:27:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHk-0006Iu-EY
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHj-00014F-61
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:16 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOuHi-00011w-VV
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:15 -0400
Received: by mail-pg1-x542.google.com with SMTP id z16so2114604pgv.11
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 18:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=/ZYAcflQLE8QxLnv1PzgjeCpnaQ2OAMJAHbK0JDJ8Y8=;
	b=Y+F5NpWSy54b0g/wbhbxsHPDmCfYJqWRX6IM6C4VBvXuB4apYAabzsMZnZhbWdy8n9
	jGWOJ+uKDDk0UZMadgtD940JWfNqC+Jcn/oUjAyYJif0YLFarhMza857k9KdlUBBXHNJ
	3jswznxCkEdcsnVLqP2dwHHiabZ7ljI7z3D061mO9xL2Uy55VduIqOTSwEJrN2Q/guEE
	WGz0ih1/Or6TH98/iTGNzN0dj6Z0p/Lw9bLoOKWb4d7yBB1ghG6AMPG21ab4HlDiqwjx
	2cq6Nst2HxZ7tfCNpevOAJb8ht9VOqIuJgygpwCR3ZCKWggxbH28+frtv71gYILf15jp
	708w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=/ZYAcflQLE8QxLnv1PzgjeCpnaQ2OAMJAHbK0JDJ8Y8=;
	b=aMVmAGPedm0DyjoaQJg1cSvweQijFC9OsZXnegNK6uAyJ+zCt7JC6RFH9ir8NsLOr6
	8YexdSGU2VjGj79yhuAsdzsAU7cbomcgNhqBog7Dk4lr/bsqJJsfazWQWrcAax2VDv3L
	PeK1Wr4xcU/6aCsl7YM+dTbbHQ1gqCwf/98CjsG3/K0hnISjnICOOA6VAiJATsau082h
	J0gknB2mOPUy6ZzxduZpx8Va/XCH0n9jghvOS9VEucSM7qd/h6mVMWP6Bpjk9FicNId3
	VPBFadTd7fmCdl2gkb37pT6r4nBJguuzAK4M82lgzoSk93MKfzMfCjg0W6RdDT212c4B
	CDBA==
X-Gm-Message-State: APjAAAXLbgLDn71d6od4AB07MXCMy1+YtPHG9dvVnz4gbk/MOQ4e1fxh
	/3eYJYMj5+L1OTR6sOP0Z1CF5XKcIh0=
X-Google-Smtp-Source: APXvYqytMcNnLj7SwI62curoq7ASo+errrLw4KqBb7fCNXxNNl+1RnUyl8oGV2vRTVoF7MlbgU0reQ==
X-Received: by 2002:aa7:9116:: with SMTP id 22mr9828663pfh.165.1557451511450; 
	Thu, 09 May 2019 18:25:11 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	n18sm8252700pfi.48.2019.05.09.18.25.10 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 18:25:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 18:24:43 -0700
Message-Id: <20190510012458.22706-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510012458.22706-1-richard.henderson@linaro.org>
References: <20190510012458.22706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v5 09/24] ui/vnc: Use gcrypto_random_bytes for
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


