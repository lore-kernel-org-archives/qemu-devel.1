Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2875CC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:18:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E537A2072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2wp3UbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E537A2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYHN-0001Ee-KW
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:18:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2u-0006Bs-34
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2s-0000DN-O8
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:15 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:33697)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY2s-00009f-Df
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:14 -0500
Received: by mail-wm1-x335.google.com with SMTP id d139so4490226wmd.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=gdbUgW5i1U+9qsmIX6EVDvxzwkOri5LRfbM8A+wcoPs=;
 b=b2wp3UbJ5cnbTIsThkdPiRKex1/NJPNu63ZCs7TeN/VBer/Ayo77q0sodk8UHLPQUw
 5sFtHXNCT/MZRjDencqWcEDdsWsra1K5YM14IKaMGOJemPlgzJ4dinqV6gFMmi72DcQn
 JWy+4J3C5UFWLV6am3R176J7DB9ekgEc7IrjCWccO5E6nW5m7xOy1QpGAeBkG63cmnXO
 Dxz5n/cSyE4dKZ1JHQQ8Mu/8143NCfH1STXRh0m20YuA1P0x/556CkDjLv4zR8QiLquQ
 QHuq9YkzZUlZZaFrhrp13ahjQStpIHzJc4+HWXOaWZ9d3f7zjPvvmKfKTK42h0m7I593
 ldJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=gdbUgW5i1U+9qsmIX6EVDvxzwkOri5LRfbM8A+wcoPs=;
 b=p1jeCKdhLO32He2qx01EerZpvwH1QoO2Ip2C21k/hDwQ9Ug+/q+TpIWMdyfGHGVWJQ
 plhcAptx9iLIMgqSSkHi1efG1SVrw0ir2QvT97VXraFwtCY8x5POIckRhrhHNMMO6Uz6
 Yu3HM5773xpfCL3HBjkChQ6E2+0PjkkisnQVWcqiiSbHvw2XO1L1D0F/Yr2qZ1wM4owf
 hZ+lkXyuAne0gKUskDtDGHLWcb1I5CiURZHEje7lP8Ts4UpJbGImDlMrpPAtkODnwCnm
 TdW/hQH/cY3Kw13vCw3DY0kuf9pLTbOTUMOckU8RQ3oqovWwYGco//WsrvVasuez1giH
 ojEQ==
X-Gm-Message-State: APjAAAX71NduldyjIetF297BJhvnROtb2NNy5N8OpTSOABxLGDeFW6l/
 pjYFmPiE6b6DFq/lI12amROIDQN5
X-Google-Smtp-Source: APXvYqyxXsayKAogwSYxpGBTfQtejSiAOBGIth24CBtsbz6UrUv+QfasVK38PlC6jCcxn6ETEQJLwQ==
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr2636417wmc.145.1576670593124; 
 Wed, 18 Dec 2019 04:03:13 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/87] vl: introduce object_parse_property_opt
Date: Wed, 18 Dec 2019 13:01:44 +0100
Message-Id: <1576670573-48048-19-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will reuse the parsing loop of machine_set_property soon for "-accel",
but we do not want the "_" -> "-" conversion since "-accel" can just
standardize on dashes.  We will also add a bunch of legacy option handling
to keep the QOM machine object clean.  Extract the loop into a separate
function, and keep the legacy handling in machine_set_property.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/vl.c b/vl.c
index 28adf38..efd3b11 100644
--- a/vl.c
+++ b/vl.c
@@ -2490,27 +2490,17 @@ static MachineClass *select_machine(void)
     return machine_class;
 }
 
-static int machine_set_property(void *opaque,
-                                const char *name, const char *value,
-                                Error **errp)
+static int object_parse_property_opt(Object *obj,
+                                     const char *name, const char *value,
+                                     const char *skip, Error **errp)
 {
-    Object *obj = OBJECT(opaque);
     Error *local_err = NULL;
-    char *p, *qom_name;
 
-    if (strcmp(name, "type") == 0) {
+    if (g_str_equal(name, skip)) {
         return 0;
     }
 
-    qom_name = g_strdup(name);
-    for (p = qom_name; *p; p++) {
-        if (*p == '_') {
-            *p = '-';
-        }
-    }
-
-    object_property_parse(obj, value, qom_name, &local_err);
-    g_free(qom_name);
+    object_property_parse(obj, value, name, &local_err);
 
     if (local_err) {
         error_propagate(errp, local_err);
@@ -2520,6 +2510,21 @@ static int machine_set_property(void *opaque,
     return 0;
 }
 
+static int machine_set_property(void *opaque,
+                                const char *name, const char *value,
+                                Error **errp)
+{
+    g_autofree char *qom_name = g_strdup(name);
+    char *p;
+
+    for (p = qom_name; *p; p++) {
+        if (*p == '_') {
+            *p = '-';
+        }
+    }
+
+    return object_parse_property_opt(opaque, name, value, "type", errp);
+}
 
 /*
  * Initial object creation happens before all other
-- 
1.8.3.1



