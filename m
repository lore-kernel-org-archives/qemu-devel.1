Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6BFC04AAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:42:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D76B620815
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LNPYJC1W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76B620815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40128 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRSpa-00084O-6O
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 22:42:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmZ-0005St-QZ
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmY-00025N-CW
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:39 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRSmX-00024V-Ud
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:38 -0400
Received: by mail-pf1-x442.google.com with SMTP id y11so2853220pfm.13
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 19:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=zQEKMjfpCTDyJlIECnLYp610ugeuDB8/XWCLVFEbpkI=;
	b=LNPYJC1WFR6MQja4ezKyO4owmXx5YniGlxytJ//9rjheof42E2cpxfWTIESjIU3eJS
	GaSPBNYpduTenfusO+TS2lBPEogA+CQPKBhivr7e1MDWYpto7CvGQZGK2dy9mhuQPhCa
	eH42l0++hbocTw3sJ0HrAx4KVDpZyYE742mThefm0QJ88nxq1kUXnBYDmTxFgDT5At79
	FSCklWeEvnFHRPV7LwZ6z2sR0R9+cG5KpS2pWueaqhQUGzOHXzQP7Bq0XTK9/GCuzecG
	4RvJMcjrjU8dsBpFwaigX/V8vXokcH0SotoUNVlq4Lad6zCsyy8EFXV/AsPqFj1S5CzE
	+IPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=zQEKMjfpCTDyJlIECnLYp610ugeuDB8/XWCLVFEbpkI=;
	b=BVnqaHc1E3WsRK5875AwUd7BTFx6+zU1PneAKPjIYkMNSYM7zaIf/l3QWk9haEriTG
	5050WPqYAQT/oE3bRCIbg0xjSMWA3T7vHNBZecZmYY8pv/6QiiiFFiOiBIzZ3YvjfulJ
	vaCm7hErizP+gNfZrFrZxktpofsvaXr4n4MILT+sbc/dX04d6suPdAdtQ2cTypZ0Pd0j
	p0LalFY3jQDYnO88avoMexSEGEmYSfBgABFuwj+85iOCQweq1bJIuXczp5abOdDh2KL/
	Z9kZsLsYvgPNNXFDMN1O79F8lOGAV6yTtvzt0QNA+LBMsT2B5yocl2Cp40ehDtU042V7
	y3MA==
X-Gm-Message-State: APjAAAVRXRENFByvOi0qG/jZR62Vx4Ne8Q5K20Byfl0F2EADZVaeAD27
	tLaGvKsf7zRu/NZfr54mlQIPLqjJJl4=
X-Google-Smtp-Source: APXvYqyjjuVaOo6NqePRLBKKtkI32w9ApBjAFCSVUQozyuvts4nksFq7lU+4OteAq5HX65HZI86tAg==
X-Received: by 2002:a63:7d18:: with SMTP id y24mr39575186pgc.101.1558060776811;
	Thu, 16 May 2019 19:39:36 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id w6sm6984152pge.30.2019.05.16.19.39.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 19:39:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 19:39:07 -0700
Message-Id: <20190517023924.1686-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517023924.1686-1-richard.henderson@linaro.org>
References: <20190517023924.1686-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v8 08/25] ui/vnc: Split out
 authentication_failed
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

There were 3 copies of this code, one of which used the wrong
data size for the failure indicator.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 ui/vnc.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 1871422e1d..785edf3af1 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2535,6 +2535,18 @@ void start_client_init(VncState *vs)
     vnc_read_when(vs, protocol_client_init, 1);
 }
 
+static void authentication_failed(VncState *vs)
+{
+    vnc_write_u32(vs, 1); /* Reject auth */
+    if (vs->minor >= 8) {
+        static const char err[] = "Authentication failed";
+        vnc_write_u32(vs, sizeof(err));
+        vnc_write(vs, err, sizeof(err));
+    }
+    vnc_flush(vs);
+    vnc_client_error(vs);
+}
+
 static void make_challenge(VncState *vs)
 {
     int i;
@@ -2609,14 +2621,7 @@ static int protocol_client_auth_vnc(VncState *vs, uint8_t *data, size_t len)
     return 0;
 
 reject:
-    vnc_write_u32(vs, 1); /* Reject auth */
-    if (vs->minor >= 8) {
-        static const char err[] = "Authentication failed";
-        vnc_write_u32(vs, sizeof(err));
-        vnc_write(vs, err, sizeof(err));
-    }
-    vnc_flush(vs);
-    vnc_client_error(vs);
+    authentication_failed(vs);
     qcrypto_cipher_free(cipher);
     return 0;
 }
@@ -2638,13 +2643,7 @@ static int protocol_client_auth(VncState *vs, uint8_t *data, size_t len)
      * must pick the one we sent. Verify this */
     if (data[0] != vs->auth) { /* Reject auth */
        trace_vnc_auth_reject(vs, vs->auth, (int)data[0]);
-       vnc_write_u32(vs, 1);
-       if (vs->minor >= 8) {
-           static const char err[] = "Authentication failed";
-           vnc_write_u32(vs, sizeof(err));
-           vnc_write(vs, err, sizeof(err));
-       }
-       vnc_client_error(vs);
+       authentication_failed(vs);
     } else { /* Accept requested auth */
        trace_vnc_auth_start(vs, vs->auth);
        switch (vs->auth) {
@@ -2673,13 +2672,7 @@ static int protocol_client_auth(VncState *vs, uint8_t *data, size_t len)
 
        default: /* Should not be possible, but just in case */
            trace_vnc_auth_fail(vs, vs->auth, "Unhandled auth method", "");
-           vnc_write_u8(vs, 1);
-           if (vs->minor >= 8) {
-               static const char err[] = "Authentication failed";
-               vnc_write_u32(vs, sizeof(err));
-               vnc_write(vs, err, sizeof(err));
-           }
-           vnc_client_error(vs);
+           authentication_failed(vs);
        }
     }
     return 0;
-- 
2.17.1


