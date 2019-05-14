Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BE8C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:25:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40B3220873
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HQN+QVb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B3220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53002 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQd36-0000U7-As
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 15:25:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvD-0002Tp-Ha
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvC-0006nN-H2
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:07 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQcvC-0006mI-Av
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:06 -0400
Received: by mail-pf1-x443.google.com with SMTP id b76so5252pfb.5
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 12:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=zQEKMjfpCTDyJlIECnLYp610ugeuDB8/XWCLVFEbpkI=;
	b=HQN+QVb73V3XfZ4T2T+jb1TZWUUTrJtTo3AsjOiBVKA23D71o/rGF4bDpSh9FGB1+X
	HpEKtIoyEqAcW2rLhJ744tUEAI/6dQGNyUHOSIS8UEUMrXapw4HfdBYld8ohrXI5+NDX
	uOzLLswjmuGbciMRtFebR9PQRhG+cTPjyGCNjgmJFi+7DudOlSCO+UEIIGsLO0/aT3rZ
	mwxLXZl7ipPbmh0xy+iwgCRvkwrjLqLgQ193cIbJsE5If8+vV18G1M8zIQzVtkwG5NTH
	zBj08pw+qPAmE3Z/Z1yKforLWnlTmtvQXkN8tFhEFr6cNC2/AWEVk+eTBoytadFeB8BZ
	OU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=zQEKMjfpCTDyJlIECnLYp610ugeuDB8/XWCLVFEbpkI=;
	b=sWft/Gn+FmuvpMxEMzzzqhw3TVuAybXwXBMqPr7wwJ1ac5qIHmQcPKblvX25rBR2pN
	jmYy0G9vu9MWMtpYIh+mhOuyvfIiAotjs/JbyWSNkXbEkUnz80JCgVL0mGIT0koEU6X9
	L3BkZwu+2H2JDKMAwuFv1kuUBme+g42hHFMX+l7f8jMAU/DpGUZjCJXfZQlVshPTEl87
	WFF5PvTc8WwJ7RARoj3HDxkTdfA75MHYbum0AqSAoe6XxbUFY9NKKxdg3j9kre/WRhj4
	GOnBiyU64zzfQ6P+2oUvknFQ7yMDL/clyBlunrl9EAKq4QlNTJGySg+jY3GbsAEkRYXk
	ym6g==
X-Gm-Message-State: APjAAAVMN8E//5OAbseF7ifSKIipq40/XqCYCLzlRdSdLClupZX9l4S9
	9ewM4CRWcwf93AhVU1Spn4QReVuUJzc=
X-Google-Smtp-Source: APXvYqyNJINyC3CswyAdFg1BUS7nq5hIqD5TfIESPjVXE/kEesWC0OD5xyBq9RlzME/eHXjv9S+/cQ==
X-Received: by 2002:a63:fa16:: with SMTP id y22mr17448pgh.15.1557861425083;
	Tue, 14 May 2019 12:17:05 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	o6sm18682982pfa.88.2019.05.14.12.17.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 12:17:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 12:16:36 -0700
Message-Id: <20190514191653.31488-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514191653.31488-1-richard.henderson@linaro.org>
References: <20190514191653.31488-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v7 07/24] ui/vnc: Split out
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


