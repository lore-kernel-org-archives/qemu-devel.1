Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A127C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 16:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E58D2077C
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 16:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E58D2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39833 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEzBv-0000xL-Cl
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 12:38:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEzB6-0000ZP-8j
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:37:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEzB5-0001Ol-EW
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:37:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEzB5-0001Ny-6X
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:37:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CE5C131028D9;
	Fri, 12 Apr 2019 16:37:19 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-66.brq.redhat.com [10.40.204.66])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 633945D9CD;
	Fri, 12 Apr 2019 16:37:08 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	qemu-devel@nongnu.org
Date: Fri, 12 Apr 2019 18:37:06 +0200
Message-Id: <20190412163706.3878-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 12 Apr 2019 16:37:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] vl: Add missing descriptions to the VGA
 adapters list
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
	Markus Armbruster <armbru@redhat.com>,
	Paul Durrant <paul.durrant@citrix.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Anthony Perard <anthony.perard@citrix.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412163706.LZjILFBCxIfTClNiMrRFXDdgTPiIOPgnyY_29VZzHdA@z>

Some VGA adapters do not contain an helpful description,
this can be confusing:

  $ qemu-system-arm -M virt -vga help
  none
  std                  standard VGA
  cirrus               Cirrus VGA (default)
  vmware               VMWare SVGA
  xenfb

Add a description to the missing adapters:

  $ qemu-system-arm -M virt -vga help
  none                 no graphic card
  std                  standard VGA
  cirrus               Cirrus VGA (default)
  vmware               VMWare SVGA
  xenfb                Xen paravirtualized framebuffer

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Based-on: <20190412152713.16018-1-marcandre.lureau@redhat.com>
---
 vl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/vl.c b/vl.c
index 840c45c00fa..dfeda8bd7fc 100644
--- a/vl.c
+++ b/vl.c
@@ -2029,6 +2029,7 @@ typedef struct VGAInterfaceInfo {
 static const VGAInterfaceInfo vga_interfaces[VGA_TYPE_MAX] =3D {
     [VGA_NONE] =3D {
         .opt_name =3D "none",
+        .name =3D "no graphic card",
     },
     [VGA_STD] =3D {
         .opt_name =3D "std",
@@ -2067,6 +2068,7 @@ static const VGAInterfaceInfo vga_interfaces[VGA_TY=
PE_MAX] =3D {
     },
     [VGA_XENFB] =3D {
         .opt_name =3D "xenfb",
+        .name =3D "Xen paravirtualized framebuffer",
     },
 };
=20
--=20
2.20.1


