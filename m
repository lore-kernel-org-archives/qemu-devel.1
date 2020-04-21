Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB54C54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:26:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 807EA2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRKiQrMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807EA2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQrys-00039m-LJ
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpX-0005Gg-OA
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpX-0006HN-3d
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:16:47 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54841)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpW-0006DY-MC; Tue, 21 Apr 2020 08:16:46 -0400
Received: by mail-wm1-x343.google.com with SMTP id h2so3289007wmb.4;
 Tue, 21 Apr 2020 05:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vcBPhZxwd+4vvuNFMjpVIGG8AsZi9zdExeOhoYV7tu4=;
 b=MRKiQrMRjgF15Z5ST3R4ycE1fKYuE1z0PoxMQYHXYmcNIi9JtZ3GdS/Ztw94805CeU
 gOyiifBLeLMskzOcbqAOBjaJmeP0T5fnkaO6NwvZN2vM5We2ZpW6FdaqQ5erHdViSSqt
 i8awh+/TkBDHEY/HQLwsmSGOmI3PJa3PXDlsiSNfQ9jMQFA9SIX1iMz6EznWXTM0uWlY
 Csou5J2ClG5qH7eRZlKgvHTbqForst7yHH4/A4ilURBdsJW7mnFZ+YWkQgLFNeq/nbqe
 GfqNt9S2dLBkyvBF24L9RDsnz0sdX0w5LffLdYaZ0F8jgQhtFH/gbgMCjO2CsHaNB7n9
 DMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=vcBPhZxwd+4vvuNFMjpVIGG8AsZi9zdExeOhoYV7tu4=;
 b=YoGTOq2/mTgBVhHwQEucRGhL5kp8Zzvwa0GI91qpKdjJ7finfpQHSyr/4a3sBkFxOM
 L36RIIP6CeHGg/yEMDipDr5Q3qwexVTUSB6quOf2G71S48l0IRQTH1m3AmhPy/T8LrW0
 oYKu2XjxR8FKcOsV1q78Sn8qR0f4VKRZmAWsbOAJtWAIbWcDIXejKV5wqH9Ioz5nw//r
 moVByoSh9k8QGZiORduM+p3y/XRHUBXKNOsqZ1v/fJiRF4ElabNlWe88qgtph3so2QJA
 4de9Le3NwoiSCXnGEq9oLsSQa1GzzH9XCT1TMo9Y5uao55HJYbgFV2cklXg39/bwoV4x
 zS0w==
X-Gm-Message-State: AGi0PuYmaOYwhrYgdqPzRVTem8PBP0SCgy/fFvrLOjYibzQl8dxorG1B
 e0XtUM+7tex/e6Wum454a5cXJavhsrQ=
X-Google-Smtp-Source: APiQypKJqU8Ykv5xmIWbbrw/HrMyoeq+McjLKCOM+hTjvKZgIn/a4W6oM+n+x/NWqkkT6lVMQ2E7XA==
X-Received: by 2002:a1c:9cc6:: with SMTP id f189mr4486493wme.75.1587471404227; 
 Tue, 21 Apr 2020 05:16:44 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id z76sm3761140wmc.9.2020.04.21.05.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 05:16:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 08/17] hw/misc/tmp421: Extract set_temp_mC() helper
Date: Tue, 21 Apr 2020 14:16:17 +0200
Message-Id: <20200421121626.23791-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200421121626.23791-1-f4bug@amsat.org>
References: <20200421121626.23791-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::343
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, John Snow <jsnow@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we are going to reuse this code, extract it first.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/tmp421.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/hw/misc/tmp421.c b/hw/misc/tmp421.c
index 8003356307..270e7d5510 100644
--- a/hw/misc/tmp421.c
+++ b/hw/misc/tmp421.c
@@ -122,6 +122,22 @@ static int64_t get_temp_mC(TMP421State *s, unsigned int id)
     return ((s->temperature[id] - offset) * 1000 + 128) / 256;
 }
 
+static void set_temp_mC(TMP421State *s, unsigned int id,
+                        int64_t temp, Error **errp)
+{
+    bool ext_range = (s->config[0] & TMP421_CONFIG_RANGE);
+    int offset = ext_range * 64 * 256;
+
+    assert(id < SENSORS_COUNT);
+    if (temp >= maxs[ext_range] || temp < mins[ext_range]) {
+        error_setg(errp, "value %" PRId64 ".%03" PRIu64 " C is out of range",
+                   temp / 1000, temp % 1000);
+        return;
+    }
+
+    s->temperature[id] = (int16_t) ((temp * 256 - 128) / 1000) + offset;
+}
+
 static void tmp421_get_temperature(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
@@ -149,11 +165,8 @@ static void tmp421_get_temperature(Object *obj, Visitor *v, const char *name,
 static void tmp421_set_temperature(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
-    TMP421State *s = TMP421(obj);
     Error *local_err = NULL;
     int64_t temp;
-    bool ext_range = (s->config[0] & TMP421_CONFIG_RANGE);
-    int offset = ext_range * 64 * 256;
     int tempid;
 
     visit_type_int(v, name, &temp, &local_err);
@@ -162,12 +175,6 @@ static void tmp421_set_temperature(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (temp >= maxs[ext_range] || temp < mins[ext_range]) {
-        error_setg(errp, "value %" PRId64 ".%03" PRIu64 " C is out of range",
-                   temp / 1000, temp % 1000);
-        return;
-    }
-
     if (sscanf(name, "temperature%d", &tempid) != 1) {
         error_setg(errp, "error reading %s: %s", name, g_strerror(errno));
         return;
@@ -178,7 +185,7 @@ static void tmp421_set_temperature(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    s->temperature[tempid] = (int16_t) ((temp * 256 - 128) / 1000) + offset;
+    set_temp_mC(TMP421(obj), tempid, temp, errp);
 }
 
 static void tmp421_read(TMP421State *s)
-- 
2.21.1


