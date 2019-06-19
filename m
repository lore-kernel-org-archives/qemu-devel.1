Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C09C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 12:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C044A206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 12:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C044A206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37954 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdZmN-0000kt-Oo
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 08:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55901)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kpouget@redhat.com>) id 1hdZkL-0008Qb-Iq
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 08:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kpouget@redhat.com>) id 1hdZkH-0004DH-Sh
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 08:31:25 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:40798)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <kpouget@redhat.com>) id 1hdZk9-0003cY-IX
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 08:31:14 -0400
Received: by mail-wm1-f50.google.com with SMTP id v19so1639424wmj.5
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 05:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jozFB0ctGaUjtpKGna3OuU7qYSP25GTS+AoCKSW0SxA=;
 b=SV3EpZfOVc8w14yPunppjX0d6IL2WvQJ6DHIiH9zs9Aq08dh0UkVVmF65KzOBjvOQ5
 I281DxTyLg78ZjClh6kqdgBHj4vWJcmUfNsnoZ2etnJd6RnW+QANgwGs8/P0svkyTGZE
 S3ZpH2Yk2He2++g96lADCqMawpjZ+TtbbdrYw+76XHW1j5qWTfJadIhBL0XPdLbTi0Oy
 Nm1AxhTXvNfmRvPycsbcUrRBqn74p47crJTuElfjLECxQdqoXd/j4FnDntPcfiVrtHXI
 j6W1b2UKu71Mqy4aohxbNu1zFdwjIst/blPWRL0X6ANTYbsOcyr3Q+sv3rehCCpQadsD
 DXYg==
X-Gm-Message-State: APjAAAX4H+2dVUzbGRidzf17KNT9r9wBvs5Qlg/mRAI9LxdiGdSiyzbx
 KOaPpkfJU8PZqyyFDshBfGtNiduVCAI=
X-Google-Smtp-Source: APXvYqwJj4fFllL9TgYoq0bJcAbpw9ONOVt2ctWHFuhgABgL/bTlgki/Q4tEiLBVVFWCXAXeYOi36w==
X-Received: by 2002:a05:600c:2199:: with SMTP id
 e25mr3494786wme.72.1560947444528; 
 Wed, 19 Jun 2019 05:30:44 -0700 (PDT)
Received: from pinea.redhat.com ([2001:861:3440:6a0:71b6:dd5f:657d:58e3])
 by smtp.gmail.com with ESMTPSA id f24sm829265wmb.16.2019.06.19.05.30.43
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 19 Jun 2019 05:30:43 -0700 (PDT)
From: Kevin Pouget <kpouget@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 14:30:42 +0200
Message-Id: <20190619123042.4822-1-kpouget@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.50
Subject: [Qemu-devel] [RFC] spice-core: allow setting properties from QMP
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
Cc: Marc-Andre Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

we're investigating the possibility to set some spice properties at
runtime, through the QMP interface, but we're not sure what's the best
way to proceed.
I've prepared the patch below, that adds a new QMP
command, but is there another way like with a QOM object, that could
reuse an existing command? I searched but couldn't find an easy/not
hacky way to create such objects ...

thanks,

Kevin

---

This patch allows setting spice properties from the QMP interface.

At the moment, only the 'video-codecs' property is supported.

Signed-off-by: Kevin Pouget <kpouget@redhat.com>
---
 qapi/ui.json    | 19 +++++++++++++++++++
 ui/spice-core.c | 13 +++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/qapi/ui.json b/qapi/ui.json
index 59e412139a..5483a9c003 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -265,6 +265,25 @@
 { 'command': 'query-spice', 'returns': 'SpiceInfo',
   'if': 'defined(CONFIG_SPICE)' }

+##
+# @set-spice:
+#
+# Set Spice properties.
+# @property: the SPICE property to modify
+# @value: the new value to affect to this property
+#
+# Since: ...
+#
+# Example:
+#
+# -> { "execute": "set-spice", "arguments": { "property": "video-codecs",
+#                                             "value": "spice:mjpeg;gst:mjpeg;" } }
+# <- { "returns": {} }
+##
+{ 'command': 'set-spice',
+  'data': {'property': 'str', 'value': 'str'},
+  'if': 'defined(CONFIG_SPICE)' }
+
 ##
 # @SPICE_CONNECTED:
 #
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 2ffc3335f0..5408b16684 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -503,6 +503,19 @@ static QemuOptsList qemu_spice_opts = {
     },
 };

+void qmp_set_spice(const char *property, const char *value, Error **errp) {
+    if (strcmp(property, "video-codecs") == 0) {
+        int invalid_codecs = spice_server_set_video_codecs(spice_server, value);
+
+        if (invalid_codecs) {
+            error_setg(errp, "Found %d invalic codecs while setting "
+                       "the property %s=%s\n", invalid_codecs, property, value);
+        }
+    } else {
+        error_setg(errp, "Setting an unknown spice property (%s=%s)\n", property, value);
+    }
+}
+
 SpiceInfo *qmp_query_spice(Error **errp)
 {
     QemuOpts *opts = QTAILQ_FIRST(&qemu_spice_opts.head);
--
2.21.0

