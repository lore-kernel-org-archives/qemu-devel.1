Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C84FFA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 16:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ABB92168B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 16:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rfmyUaMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABB92168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKmUN-0002Sb-As
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 12:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36253)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3cEinXQYKCpEDv7z3y19916z.x97Bz7F-yzGz689818F.9C1@flex--sameid.bounces.google.com>)
 id 1iKmNW-0004NI-Jh
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:42:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3cEinXQYKCpEDv7z3y19916z.x97Bz7F-yzGz689818F.9C1@flex--sameid.bounces.google.com>)
 id 1iKmNV-0006Ig-Aw
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:42:26 -0400
Received: from mail-vs1-xe49.google.com ([2607:f8b0:4864:20::e49]:36390)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3cEinXQYKCpEDv7z3y19916z.x97Bz7F-yzGz689818F.9C1@flex--sameid.bounces.google.com>)
 id 1iKmNV-0006IC-7g
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:42:25 -0400
Received: by mail-vs1-xe49.google.com with SMTP id z7so3192103vsz.3
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 09:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc:content-transfer-encoding;
 bh=JE4TuYAH1H5117bvmxHFP4bvJ+F5rdpnNADeRT4SBDM=;
 b=rfmyUaMpv486XNrl+3+sf6XxsQlYuCyCyo8UD4552g9PMtcopqqh9iFis5oy+Il0gx
 kv8EXMY1GT1QrrAUbFc0DDR/6EBB4YW+thRmQSfkFTQ+3cg1mADpjUTkMCTF/1DN/WL0
 0hjQgzOkbwnz3DrI7M9USmzR4kNCREdG1oo05XdyJo2pnYMbWfxELaZr9Pyf/rr7jyBk
 c4fsZO7BMNZtjoGygBnPt38Wh/3BxufpLRubsINQH+bE/Mnk7sZM4lCA9hkKJ1/bsKHz
 VoULjrjfZx1Pip0SIVGWnp+mOmSn9WDtICeGz/LQrVIuA5RDtpoD7KkjyK2V+XkYqNNh
 zSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc:content-transfer-encoding;
 bh=JE4TuYAH1H5117bvmxHFP4bvJ+F5rdpnNADeRT4SBDM=;
 b=q20OKRoeQIyZQMxy1Hy5xfrgXbxZ/Y14OtkWdITV1y0ukfaM25TrcSzCEHj4oFS8ML
 faDm6yAcddo9obNMjfzBpYJMQyMmtlTxYmUkTYkiDpdRCNb7F1FwxrN3Qm3HEM/gG286
 TiGjSHD3zv0qgKnrK30MGveaIgiih8qZqOek7SUhdj71rC0YPRQsFji5dif5KS6Nxblh
 96QQ+9wwvrYpCisLBNqE1d7beKmflf27z17Ak9UkHkGw5VCVnYbx3HDoJTpNxSEG134N
 6q0p6NPUSrSuNJjCa3gW44bvPPD1B7T2cPG3jxtDYnrjcLYbkk3dkVp/2tOV8i6Banil
 d5cA==
X-Gm-Message-State: APjAAAVZrjShYFL5UiJAJdxh6r2IIElF2Lmz6aEBJZHFqqJled+DyP1C
 U6i6xV816ti2AhlH4hPAjusOmnuEN9I/INFOkDV69992QXuxBDK/yaAg0Kc6aaCCPFY4grpOMC5
 3FGt/IaqZ3b6r3dAZKmVKJv1ODjyq6HrBFYCNoiCpVvHh0ZypJ4C0Qyo5lYxI
X-Google-Smtp-Source: APXvYqxWIJLOcgIpQjIyxeX6oyPPuJFlbQeIzcvA19EOw9sPnG83Dzx2lalfrneox6KN2fRKlXZqSthdOFM=
X-Received: by 2002:a67:fa99:: with SMTP id f25mr1288594vsq.141.1571244144307; 
 Wed, 16 Oct 2019 09:42:24 -0700 (PDT)
Date: Wed, 16 Oct 2019 19:41:43 +0300
In-Reply-To: <20191016164145.115898-1-sameid@google.com>
Message-Id: <20191016164145.115898-8-sameid@google.com>
Mime-Version: 1.0
References: <20191016164145.115898-1-sameid@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH v8 6/8] bootdevice: Refactor get_boot_devices_list
From: Sam Eiderman <sameid@google.com>
To: qemu-devel@nongnu.org
Cc: arbel.moshe@oracle.com, karl.heubaum@oracle.com, kevin@koconnor.net, 
 kraxel@redhat.com, kwolf@redhat.com, liran.alon@oracle.com, 
 qemu-block@nongnu.org, sameid@google.com, seabios@seabios.org, 
 lersek@redhat.com, philmd@redhat.com, jsnow@redhat.com, 
 Sam Eiderman <shmuel.eiderman@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e49
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

From: Sam Eiderman <shmuel.eiderman@oracle.com>

Move device name construction to a separate function.

We will reuse this function in the following commit to pass logical CHS
parameters through fw_cfg much like we currently pass bootindex.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
Signed-off-by: Sam Eiderman <sameid@google.com>
---
 bootdevice.c | 61 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/bootdevice.c b/bootdevice.c
index bc5e1c2de4..2cf6b37c57 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -202,6 +202,39 @@ DeviceState *get_boot_device(uint32_t position)
     return res;
 }
=20
+static char *get_boot_device_path(DeviceState *dev, bool ignore_suffixes,
+                                  const char *suffix)
+{
+    char *devpath =3D NULL, *s =3D NULL, *d, *bootpath;
+
+    if (dev) {
+        devpath =3D qdev_get_fw_dev_path(dev);
+        assert(devpath);
+    }
+
+    if (!ignore_suffixes) {
+        if (dev) {
+            d =3D qdev_get_own_fw_dev_path_from_handler(dev->parent_bus, d=
ev);
+            if (d) {
+                assert(!suffix);
+                s =3D d;
+            } else {
+                s =3D g_strdup(suffix);
+            }
+        } else {
+            s =3D g_strdup(suffix);
+        }
+    }
+
+    bootpath =3D g_strdup_printf("%s%s",
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
     bool ignore_suffixes =3D mc->ignore_boot_device_suffixes;
=20
     QTAILQ_FOREACH(i, &fw_boot_order, link) {
-        char *devpath =3D NULL,  *suffix =3D NULL;
         char *bootpath;
-        char *d;
         size_t len;
=20
-        if (i->dev) {
-            devpath =3D qdev_get_fw_dev_path(i->dev);
-            assert(devpath);
-        }
-
-        if (!ignore_suffixes) {
-            if (i->dev) {
-                d =3D qdev_get_own_fw_dev_path_from_handler(i->dev->parent=
_bus,
-                                                          i->dev);
-                if (d) {
-                    assert(!i->suffix);
-                    suffix =3D d;
-                } else {
-                    suffix =3D g_strdup(i->suffix);
-                }
-            } else {
-                suffix =3D g_strdup(i->suffix);
-            }
-        }
-
-        bootpath =3D g_strdup_printf("%s%s",
-                                   devpath ? devpath : "",
-                                   suffix ? suffix : "");
-        g_free(devpath);
-        g_free(suffix);
+        bootpath =3D get_boot_device_path(i->dev, ignore_suffixes, i->suff=
ix);
=20
         if (total) {
             list[total-1] =3D '\n';
--=20
2.23.0.700.g56cf767bdb-goog


