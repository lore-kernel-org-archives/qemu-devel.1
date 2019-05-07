Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC139C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:26:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E16C920989
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16C920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42133 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNvQL-00060n-4V
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 04:26:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hNvKO-0000gX-9K
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hNvKN-0008BG-BT
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:19:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>)
	id 1hNvKL-00088e-03; Tue, 07 May 2019 04:19:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D8B8308338F;
	Tue,  7 May 2019 08:19:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-45.ams2.redhat.com
	[10.36.116.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9369261B6C;
	Tue,  7 May 2019 08:19:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 98EACA1E3; Tue,  7 May 2019 10:19:46 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 10:19:42 +0200
Message-Id: <20190507081946.19264-5-kraxel@redhat.com>
In-Reply-To: <20190507081946.19264-1-kraxel@redhat.com>
References: <20190507081946.19264-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Tue, 07 May 2019 08:19:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 4/8] vl: constify VGAInterfaceInfo
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20190412152713.16018-2-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 vl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/vl.c b/vl.c
index d9fea0a11966..6b2820483c43 100644
--- a/vl.c
+++ b/vl.c
@@ -2015,7 +2015,7 @@ typedef struct VGAInterfaceInfo {
     const char *class_names[2];
 } VGAInterfaceInfo;
=20
-static VGAInterfaceInfo vga_interfaces[VGA_TYPE_MAX] =3D {
+static const VGAInterfaceInfo vga_interfaces[VGA_TYPE_MAX] =3D {
     [VGA_NONE] =3D {
         .opt_name =3D "none",
     },
@@ -2061,7 +2061,7 @@ static VGAInterfaceInfo vga_interfaces[VGA_TYPE_MAX=
] =3D {
=20
 static bool vga_interface_available(VGAInterfaceType t)
 {
-    VGAInterfaceInfo *ti =3D &vga_interfaces[t];
+    const VGAInterfaceInfo *ti =3D &vga_interfaces[t];
=20
     assert(t < VGA_TYPE_MAX);
     return !ti->class_names[0] ||
@@ -2076,7 +2076,7 @@ static void select_vgahw(const char *p)
=20
     assert(vga_interface_type =3D=3D VGA_NONE);
     for (t =3D 0; t < VGA_TYPE_MAX; t++) {
-        VGAInterfaceInfo *ti =3D &vga_interfaces[t];
+        const VGAInterfaceInfo *ti =3D &vga_interfaces[t];
         if (ti->opt_name && strstart(p, ti->opt_name, &opts)) {
             if (!vga_interface_available(t)) {
                 error_report("%s not available", ti->name);
--=20
2.18.1


