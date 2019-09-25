Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30266C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:13:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE96A21D7A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="sXBrOHw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE96A21D7A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD5Eh-0006I3-OZ
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 07:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44913)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3XEqLXQYKChE9r3vzux55x2v.t537v3B-uvCv2454x4B.58x@flex--sameid.bounces.google.com>)
 id 1iD58d-0008Pu-Ng
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3XEqLXQYKChE9r3vzux55x2v.t537v3B-uvCv2454x4B.58x@flex--sameid.bounces.google.com>)
 id 1iD58Y-0004dg-KF
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:07:12 -0400
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a]:40526)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3XEqLXQYKChE9r3vzux55x2v.t537v3B-uvCv2454x4B.58x@flex--sameid.bounces.google.com>)
 id 1iD58Y-0004bR-DG
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:07:10 -0400
Received: by mail-wm1-x34a.google.com with SMTP id o188so1930292wmo.5
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 04:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=h+cRgKLkCqTFM58KGRf0r71ieDf+K2XSFGxiiABhRqM=;
 b=sXBrOHw1PryXcsFrWUn6ZfAPoKJn/f+HCRNukLCAbqLVa9TPa6QWfKODNh0EB6gkja
 nIfWI2bPP5peuQuHZuJLHrihLLJSvHXXC5Ly5H8x6NAoaPJNj8xyiz3qIS9nnfMlKV13
 a0L536sPYjmxSB1MzVORXjk1qQJVkeNIufCwksN8X5S77X4i6eMTI7cAM43cq9ZqX4pq
 aPnxjVbFQ49DGKY0WZOOw5CRVaK4kv+PF54V2r4TPyKv6RRqNW/ty5IVP2sn4ahKyGtc
 YXXsuYBE0zI27Wzs2Q3QztpXy7gvyU07jVhj0GrQEEyg8JsXMs6I9bkN/7GENTZwSEfR
 Esig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=h+cRgKLkCqTFM58KGRf0r71ieDf+K2XSFGxiiABhRqM=;
 b=VQ3NKzO1vRIljdtl4T7MiMEil/EfRjolYdvqZTJeKGMdOmzbeDRDrAgZHxSTVpt5H7
 OPcymA5p/b+Z8V7ztWv/nJFXrSzIPvpgdUGBXLWhyh2EKRSAVEVCfgWUXpdEPkBkRBxb
 bW+Ii/3NGvs59Jx3o0kBkSyIwLDEgPBQsCYGHrNgiApl2s9wVWPcwP4flAW3sCOy6c7M
 dU0n/IOPk1ZZUxglv4mWQGrG5ilfTP+UiQ/fwMGV/0dXXVu21UUt+OtcMBa95TmwcDsf
 jczTJOg8PGjvx5Rg9e4Ie//8daHELqIGuUSQdRsFjIvFiC4/vJdTluGfTmgOOaGugqgL
 9nBw==
X-Gm-Message-State: APjAAAVsWwSGm2ryJpWuzsAqAf9T28gHJUQFIrjn4EgaxXiG7Qp3BLUY
 YzFHXAWMLhh9UnyJbplLoEpKhcYBg/4A4rBqme6OdeAryjzTJiQ8vICUpyqwo/JOR7jnZF0joB0
 VKC2V7CscxJ3WpkO0CU5IiBTjJ3O2Za6wFzMKjBzAFXK++qvwfbBqK7Sp8bKF
X-Google-Smtp-Source: APXvYqzDFfJYzGJTaE8CpmUSweSt5xnhDOIaD0TC6fugzWxHfnMzQdl/FZciG8WWkd4OIR2nR9Nv1dASbXI=
X-Received: by 2002:a05:6000:1281:: with SMTP id
 f1mr176199wrx.247.1569409628619; 
 Wed, 25 Sep 2019 04:07:08 -0700 (PDT)
Date: Wed, 25 Sep 2019 14:06:37 +0300
In-Reply-To: <20190925110639.100699-1-sameid@google.com>
Message-Id: <20190925110639.100699-7-sameid@google.com>
Mime-Version: 1.0
References: <20190925110639.100699-1-sameid@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v7 6/8] bootdevice: Refactor get_boot_devices_list
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::34a
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, kevin@koconnor.net, liran.alon@oracle.com,
 kraxel@redhat.com, Sam Eiderman <shmuel.eiderman@oracle.com>,
 sameid@google.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Sam Eiderman <sameid@google.com>
From: Sam Eiderman via <qemu-devel@nongnu.org>

From: Sam Eiderman <shmuel.eiderman@oracle.com>

Move device name construction to a separate function.

We will reuse this function in the following commit to pass logical CHS
parameters through fw_cfg much like we currently pass bootindex.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 bootdevice.c | 61 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/bootdevice.c b/bootdevice.c
index bc5e1c2de4..2b12fb85a4 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -202,6 +202,39 @@ DeviceState *get_boot_device(uint32_t position)
     return res;
 }
 
+static char *get_boot_device_path(DeviceState *dev, bool ignore_suffixes,
+                                  char *suffix)
+{
+    char *devpath = NULL, *s = NULL, *d, *bootpath;
+
+    if (dev) {
+        devpath = qdev_get_fw_dev_path(dev);
+        assert(devpath);
+    }
+
+    if (!ignore_suffixes) {
+        if (dev) {
+            d = qdev_get_own_fw_dev_path_from_handler(dev->parent_bus, dev);
+            if (d) {
+                assert(!suffix);
+                s = d;
+            } else {
+                s = g_strdup(suffix);
+            }
+        } else {
+            s = g_strdup(suffix);
+        }
+    }
+
+    bootpath = g_strdup_printf("%s%s",
+                               devpath ? devpath : "",
+                               s ? s : "");
+    g_free(devpath);
+    g_free(s);
+
+    return bootpath;
+}
+
 /*
  * This function returns null terminated string that consist of new line
  * separated device paths.
@@ -218,36 +251,10 @@ char *get_boot_devices_list(size_t *size)
     bool ignore_suffixes = mc->ignore_boot_device_suffixes;
 
     QTAILQ_FOREACH(i, &fw_boot_order, link) {
-        char *devpath = NULL,  *suffix = NULL;
         char *bootpath;
-        char *d;
         size_t len;
 
-        if (i->dev) {
-            devpath = qdev_get_fw_dev_path(i->dev);
-            assert(devpath);
-        }
-
-        if (!ignore_suffixes) {
-            if (i->dev) {
-                d = qdev_get_own_fw_dev_path_from_handler(i->dev->parent_bus,
-                                                          i->dev);
-                if (d) {
-                    assert(!i->suffix);
-                    suffix = d;
-                } else {
-                    suffix = g_strdup(i->suffix);
-                }
-            } else {
-                suffix = g_strdup(i->suffix);
-            }
-        }
-
-        bootpath = g_strdup_printf("%s%s",
-                                   devpath ? devpath : "",
-                                   suffix ? suffix : "");
-        g_free(devpath);
-        g_free(suffix);
+        bootpath = get_boot_device_path(i->dev, ignore_suffixes, i->suffix);
 
         if (total) {
             list[total-1] = '\n';
-- 
2.23.0.351.gc4317032e6-goog


