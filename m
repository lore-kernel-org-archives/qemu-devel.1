Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4478C742BD
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:40:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7870320863
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7870320863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlvmo-0006hR-Cs
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 09:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57541)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hlvmL-00054m-TT
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:40:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hlvmK-0006b9-Qd
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:40:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37876)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hlvmI-0006YV-E7; Fri, 12 Jul 2019 09:39:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BBFED81DE8;
 Fri, 12 Jul 2019 13:39:57 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-150.brq.redhat.com [10.40.204.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E8B6719C58;
 Fri, 12 Jul 2019 13:39:49 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 12 Jul 2019 15:39:25 +0200
Message-Id: <20190712133928.21394-5-philmd@redhat.com>
In-Reply-To: <20190712133928.21394-1-philmd@redhat.com>
References: <20190712133928.21394-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 12 Jul 2019 13:39:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.1? 4/7] vl: Fix 'braces' coding style
 issues
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Miroslav Rezanina <mrezanin@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we'll move this code around, fix its style first:

  ERROR: braces {} are necessary for all arms of this statement style

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 vl.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/vl.c b/vl.c
index 5089fce6c5..96de4f74b9 100644
--- a/vl.c
+++ b/vl.c
@@ -920,8 +920,9 @@ static struct HCIInfo *hci_table[MAX_NICS];
=20
 struct HCIInfo *qemu_next_hci(void)
 {
-    if (cur_hci =3D=3D nb_hcis)
+    if (cur_hci =3D=3D nb_hcis) {
         return &null_hci;
+    }
=20
     return hci_table[cur_hci++];
 }
@@ -937,8 +938,9 @@ static int bt_hci_parse(const char *str)
     }
=20
     hci =3D hci_init(str);
-    if (!hci)
+    if (!hci) {
         return -1;
+    }
=20
     bdaddr.b[0] =3D 0x52;
     bdaddr.b[1] =3D 0x54;
@@ -957,9 +959,10 @@ static void bt_vhci_add(int vlan_id)
 {
     struct bt_scatternet_s *vlan =3D qemu_find_bt_vlan(vlan_id);
=20
-    if (!vlan->slave)
+    if (!vlan->slave) {
         warn_report("adding a VHCI to an empty scatternet %i",
                     vlan_id);
+    }
=20
     bt_vhci_init(bt_new_hci(vlan));
 }
@@ -984,12 +987,14 @@ static struct bt_device_s *bt_device_add(const char=
 *opt)
=20
     vlan =3D qemu_find_bt_vlan(vlan_id);
=20
-    if (!vlan->slave)
+    if (!vlan->slave) {
         warn_report("adding a slave device to an empty scatternet %i",
                     vlan_id);
+    }
=20
-    if (!strcmp(devname, "keyboard"))
+    if (!strcmp(devname, "keyboard")) {
         return bt_keyboard_init(vlan);
+    }
=20
     error_report("unsupported bluetooth device '%s'", devname);
     return 0;
@@ -1002,9 +1007,11 @@ static int bt_parse(const char *opt)
=20
     if (strstart(opt, "hci", &endp)) {
         if (!*endp || *endp =3D=3D ',') {
-            if (*endp)
-                if (!strstart(endp, ",vlan=3D", 0))
+            if (*endp) {
+                if (!strstart(endp, ",vlan=3D", 0)) {
                     opt =3D endp + 1;
+                }
+            }
=20
             return bt_hci_parse(opt);
        }
@@ -1021,14 +1028,16 @@ static int bt_parse(const char *opt)
                     error_report("bad parameter '%s'", endp + 1);
                     return 1;
                 }
-            } else
+            } else {
                 vlan =3D 0;
+            }
=20
             bt_vhci_add(vlan);
             return 0;
         }
-    } else if (strstart(opt, "device:", &endp))
+    } else if (strstart(opt, "device:", &endp)) {
         return !bt_device_add(endp);
+    }
=20
     error_report("bad bluetooth parameter '%s'", opt);
     return 1;
--=20
2.20.1


