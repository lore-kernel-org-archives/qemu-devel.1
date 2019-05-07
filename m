Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA00C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:27:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ED2120989
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED2120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42149 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNvRN-00078h-D7
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 04:27:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hNvKS-0000id-AS
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:20:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hNvKR-0008EL-CI
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:20:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>)
	id 1hNvKN-0008BS-UE; Tue, 07 May 2019 04:19:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31900C007344;
	Tue,  7 May 2019 08:19:55 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-45.ams2.redhat.com
	[10.36.116.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C0B945B097;
	Tue,  7 May 2019 08:19:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id A145AA1E4; Tue,  7 May 2019 10:19:46 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 10:19:43 +0200
Message-Id: <20190507081946.19264-6-kraxel@redhat.com>
In-Reply-To: <20190507081946.19264-1-kraxel@redhat.com>
References: <20190507081946.19264-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Tue, 07 May 2019 08:19:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 5/8] vl: add -vga help support
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Alistair Francis <alistair@alistair23.me>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Provide help output similar to other argument help handling:

$ qemu-system-x86_64 -vga help
none
std                  standard VGA (default)
cirrus               Cirrus VGA
vmware               VMWare SVGA
xenfb
qxl                  QXL VGA
virtio               Virtio VG

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20190412152713.16018-3-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 vl.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/vl.c b/vl.c
index 6b2820483c43..b6709514c1bb 100644
--- a/vl.c
+++ b/vl.c
@@ -2069,11 +2069,39 @@ static bool vga_interface_available(VGAInterfaceT=
ype t)
            object_class_by_name(ti->class_names[1]);
 }
=20
-static void select_vgahw(const char *p)
+static const char *
+get_default_vga_model(const MachineClass *machine_class)
+{
+    if (machine_class->default_display) {
+        return machine_class->default_display;
+    } else if (vga_interface_available(VGA_CIRRUS)) {
+        return "cirrus";
+    } else if (vga_interface_available(VGA_STD)) {
+        return "std";
+    }
+
+    return NULL;
+}
+
+static void select_vgahw(const MachineClass *machine_class, const char *=
p)
 {
     const char *opts;
     int t;
=20
+    if (g_str_equal(p, "help")) {
+        const char *def =3D get_default_vga_model(machine_class);
+
+        for (t =3D 0; t < VGA_TYPE_MAX; t++) {
+            const VGAInterfaceInfo *ti =3D &vga_interfaces[t];
+
+            if (vga_interface_available(t) && ti->opt_name) {
+                printf("%-20s %s%s\n", ti->opt_name, ti->name ?: "",
+                       g_str_equal(ti->opt_name, def) ? " (default)" : "=
");
+            }
+        }
+        exit(0);
+    }
+
     assert(vga_interface_type =3D=3D VGA_NONE);
     for (t =3D 0; t < VGA_TYPE_MAX; t++) {
         const VGAInterfaceInfo *ti =3D &vga_interfaces[t];
@@ -4424,16 +4452,10 @@ int main(int argc, char **argv, char **envp)
=20
     /* If no default VGA is requested, the default is "none".  */
     if (default_vga) {
-        if (machine_class->default_display) {
-            vga_model =3D machine_class->default_display;
-        } else if (vga_interface_available(VGA_CIRRUS)) {
-            vga_model =3D "cirrus";
-        } else if (vga_interface_available(VGA_STD)) {
-            vga_model =3D "std";
-        }
+        vga_model =3D get_default_vga_model(machine_class);
     }
     if (vga_model) {
-        select_vgahw(vga_model);
+        select_vgahw(machine_class, vga_model);
     }
=20
     if (watchdog) {
--=20
2.18.1


