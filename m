Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3A1C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:58:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8966720818
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8966720818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42427 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR0yU-0003sn-NW
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 16:58:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hR0rP-0005qU-TC
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hR0rO-0001Bu-1l
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:50:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hR0rN-0001AT-Qt
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:50:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29CB23001561
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 20:50:44 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-17.ams2.redhat.com
	[10.36.112.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 13C1E5C5B0;
	Wed, 15 May 2019 20:50:40 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 15 May 2019 22:50:16 +0200
Message-Id: <1557953433-19663-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
References: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Wed, 15 May 2019 20:50:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 04/21] vl: Add missing descriptions to the VGA
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

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
Based-on: <20190412152713.16018-1-marcandre.lureau@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Paul Durrant <paul.durrant@citrix.com>
Message-Id: <20190412163706.3878-1-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/vl.c b/vl.c
index 2e44f7d..f49b119 100644
--- a/vl.c
+++ b/vl.c
@@ -2018,6 +2018,7 @@ typedef struct VGAInterfaceInfo {
 static const VGAInterfaceInfo vga_interfaces[VGA_TYPE_MAX] =3D {
     [VGA_NONE] =3D {
         .opt_name =3D "none",
+        .name =3D "no graphic card",
     },
     [VGA_STD] =3D {
         .opt_name =3D "std",
@@ -2056,6 +2057,7 @@ static const VGAInterfaceInfo vga_interfaces[VGA_TY=
PE_MAX] =3D {
     },
     [VGA_XENFB] =3D {
         .opt_name =3D "xenfb",
+        .name =3D "Xen paravirtualized framebuffer",
     },
 };
=20
--=20
1.8.3.1



