Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8272EC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56EF42082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mLk6dAg1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56EF42082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60003 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhce-00082b-DO
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:41:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhVB-00012t-5m
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhVA-0001Jj-3J
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:09 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNhV9-0001Hu-C3
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:07 -0400
Received: by mail-pf1-x444.google.com with SMTP id z28so7145546pfk.0
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 10:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=jYAIQMfujH1Yj8GqMNdb9ZgzR2B+8AW7wjG3BA673NY=;
	b=mLk6dAg1QsjNbOm4DQ60Gu/71PfAo5s0UVcwGKOTIgmRy1yEjAWDGZj+ixu4KPy0LV
	wyk29yKHH9c2inXYUpr1O/VdFBEKgC3fNmFRchbiYAGm2sxwRkUWW7IyoJqfHObtjbxr
	pXTa4TmOykFdfDb8tU/evt1Bx3m3YiddcZu2uKeZTj2HMRCR8FADxOEq4p4fsdeewNS1
	2T5Fx+hnst+1TYvyT5NNBFUpqu/QcXRCPmtnNw8tbmvLaK5Ennp2Xs5xxMTMyW3TeotE
	xOrjEW55mv+bAQaw4Ar93r+DmotWmAQwULfyizrE4YQIWz5TQXQuk4pUcmCcc5SD7cx9
	etcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=jYAIQMfujH1Yj8GqMNdb9ZgzR2B+8AW7wjG3BA673NY=;
	b=bNgl0Egww3oOTKM/KhzhxYObZi5FGTRmrcmmIS4wsfje/x4GJRB05IlyBNXsbCxLCn
	kVHQcNHtdvFsFGoKB4U6rRPIDF1V0HlXw4Kl/H1M93QDEVnlHOXVLsYi7NCcSKlcekHg
	dkQ0rAbQstf8TJKrQVWnWHzSO9grD5W/wbeM/ojKMId+eqyDt8N2POjzBPYlYx4plyQA
	jcTOLtsv+WGSY1EeoAMY0zlw8tJ0Phe5nn7DKcIGJKgfmkROz9FSooXUgrF/VXZSTKXx
	vryyw4BjdBdq2t9aV4g7umXYizUb53VX92bnlHFRJcQi6Em262iqtSBrNzLVTsD8hHgA
	skzw==
X-Gm-Message-State: APjAAAVZKlSfzClSECsQcK6krDrweLvZQpFNPrR5v9a73l3h9QVJCp3k
	6HlpYPNxei3rz0lgwdwmhN1tPgufPiQ=
X-Google-Smtp-Source: APXvYqxQZ1IKaxZBuHkfybCA3CqzzRwMM4OX0wz2Xxms7FspnjE8O0L0/u6U2QmaxmypXmzAVBKQFQ==
X-Received: by 2002:a62:1b8a:: with SMTP id b132mr34709412pfb.19.1557164045886;
	Mon, 06 May 2019 10:34:05 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	k9sm2268839pfa.180.2019.05.06.10.34.04 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 10:34:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 10:33:37 -0700
Message-Id: <20190506173353.32206-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506173353.32206-1-richard.henderson@linaro.org>
References: <20190506173353.32206-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v4 08/24] ui/vnc: Split out
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There were 3 copies of this code, one of which used the wrong
data size for the failure indicator.

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


