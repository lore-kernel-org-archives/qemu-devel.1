Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD03EC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:50:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A34E20658
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YN7/Dl94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A34E20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpNo-0005nw-OR
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpKF-0000Zy-Bu
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpKE-0006Ao-9Z
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37470
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpKE-00069v-5S
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584125185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4iGVZuF4Qb5AYL8uwIXnWmSt3UwwMw6MN0vCl+3WZX8=;
 b=YN7/Dl94Bv89OENtr0bmzNtDwmaZSy8ZzLPNb0vXE9LI8Uy8QoAwVUQe+7Gce2jP98z0E9
 td9CCC87+y/KokChPOXsgyskyRX7hJiWsZJAVON/jgnSQJBC7EmaexjFEGooTwtcEQXyyw
 t0TL/8T0JcGS5T85Jon3bIF7xs7kbSw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-5qsKRMjMOcaTrWIWRIT83Q-1; Fri, 13 Mar 2020 14:46:20 -0400
X-MC-Unique: 5qsKRMjMOcaTrWIWRIT83Q-1
Received: by mail-wr1-f70.google.com with SMTP id b11so4712311wru.21
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zCp7V6dmvI6Oe1etj78MAk0xW8iGI9/bbSjLeaMKlUw=;
 b=J4dndvc+9Cdg+uwchcgCkJ3e65Kb3EPGVxRvQH5DsiCvF2Z9kuU2sAc/lTzguVE2Ea
 m/aNgr6zcmiJeulTWcyY6IH/87ybwlnJuJDx/c9u2MArkeZmQL6QsfcVhHRHaLJZk5Fv
 h+BbkNWsx5/RhBE8tFSxxNZP0pBmJqRzWvY+Ubl2h8cmE5y9K48m+aANfS6kLzrJsDbZ
 y9apVXZdJnObv7qjkugvkR3PNGYy1qZIADzwr7LZK2wKOEzwRy8UHkQWijIZLgg4gQP7
 NtEWp1FkdL3Lduk94sk7D04L3Zom/d8dTmGUR909fzOr/lQrtaUMczucfpLPXQ4UqqWf
 gw2A==
X-Gm-Message-State: ANhLgQ1g4XIDVYNgElz53xfwQfzpbKZqAMt/UOPQfKVqJPzb153x/kVH
 sz3APPxdgwjWBx/XkmHN+L2PnVli9VPAckrSU0u1bCI1l0QxPv8EaK7UbTobojeHqJYMvJskuVK
 njcP8HOSXwFXWASI=
X-Received: by 2002:a1c:491:: with SMTP id 139mr4867677wme.21.1584125178774;
 Fri, 13 Mar 2020 11:46:18 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuaYIMh40A0NCuonushmZMvLIz51qi9sJGqlGelMgK3L3fXcRVsxiUGuEBrw15kAGNEnJPq4w==
X-Received: by 2002:a1c:491:: with SMTP id 139mr4867658wme.21.1584125178571;
 Fri, 13 Mar 2020 11:46:18 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id i1sm63986354wrs.18.2020.03.13.11.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:46:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/9] hw/core/qdev-properties: Use qemu_strtoul() in
 set_pci_host_devaddr()
Date: Fri, 13 Mar 2020 19:46:00 +0100
Message-Id: <20200313184607.11792-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200313184607.11792-1-philmd@redhat.com>
References: <20200313184607.11792-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace strtoul() by qemu_strtoul() so checkpatch.pl won't complain
if we move this code later.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/core/qdev-properties.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 48e4c98cf0..e1cefcaa61 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -820,7 +820,7 @@ static void set_pci_host_devaddr(Object *obj, Visitor *=
v, const char *name,
     PCIHostDeviceAddress *addr =3D qdev_get_prop_ptr(dev, prop);
     Error *local_err =3D NULL;
     char *str, *p;
-    char *e;
+    const char *e;
     unsigned long val;
     unsigned long dom =3D 0, bus =3D 0;
     unsigned int slot =3D 0, func =3D 0;
@@ -837,23 +837,23 @@ static void set_pci_host_devaddr(Object *obj, Visitor=
 *v, const char *name,
     }
=20
     p =3D str;
-    val =3D strtoul(p, &e, 16);
-    if (e =3D=3D p || *e !=3D ':') {
+    if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0xffff || e =3D=3D p) {
+        goto inval;
+    }
+    if (*e !=3D ':') {
         goto inval;
     }
     bus =3D val;
=20
-    p =3D e + 1;
-    val =3D strtoul(p, &e, 16);
-    if (e =3D=3D p) {
+    p =3D (char *)e + 1;
+    if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0x1f || e =3D=3D p) {
         goto inval;
     }
     if (*e =3D=3D ':') {
         dom =3D bus;
         bus =3D val;
-        p =3D e + 1;
-        val =3D strtoul(p, &e, 16);
-        if (e =3D=3D p) {
+        p =3D (char *)e + 1;
+        if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0x1f || e =3D=3D p)=
 {
             goto inval;
         }
     }
@@ -862,14 +862,13 @@ static void set_pci_host_devaddr(Object *obj, Visitor=
 *v, const char *name,
     if (*e !=3D '.') {
         goto inval;
     }
-    p =3D e + 1;
-    val =3D strtoul(p, &e, 10);
-    if (e =3D=3D p) {
+    p =3D (char *)e + 1;
+    if (qemu_strtoul(p, &e, 10, &val) < 0 || val > 7 || e =3D=3D p) {
         goto inval;
     }
     func =3D val;
=20
-    if (dom > 0xffff || bus > 0xff || slot > 0x1f || func > 7) {
+    if (bus > 0xff) {
         goto inval;
     }
=20
--=20
2.21.1


