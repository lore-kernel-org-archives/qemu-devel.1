Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0950C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:42:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB6FF20721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sg1k4ON9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6FF20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyb3y-0003Sg-Tr
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 07:42:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iyazx-0004hF-LN
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:38:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iyazw-00063k-CE
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:38:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33262
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iyazw-00063c-8F
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:38:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580733519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7khwH6SQQON5PqxU6RXbZYXMnlSBvMPO+olzTuJGAZ0=;
 b=Sg1k4ON9r37qaBRMf+SWZR2NbIYBV1ZgCXkWhJw+vFQO8OKjITo5LIrNsQUA+gmw97BeTY
 oND63DMoiOX9S3wrrmwutmfyxPP03QMXTBr1uD82PMwtx9GdTk+Zmxq80tHIwKxY2LKywT
 CVI5yrtOkqRRJPGsUNcoixTgibl2Lfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-nuXGm4XsMNiQtGoV38rXDQ-1; Mon, 03 Feb 2020 07:38:37 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79C3B107ACCC;
 Mon,  3 Feb 2020 12:38:36 +0000 (UTC)
Received: from thuth.com (ovpn-116-129.ams2.redhat.com [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F25061070;
 Mon,  3 Feb 2020 12:38:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 13/13] trivial: Remove xenfb_enabled from sysemu.h
Date: Mon,  3 Feb 2020 13:38:11 +0100
Message-Id: <20200203123811.8651-14-thuth@redhat.com>
In-Reply-To: <20200203123811.8651-1-thuth@redhat.com>
References: <20200203123811.8651-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: nuXGm4XsMNiQtGoV38rXDQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The define is only used in one other place. Move the code there
instead of keeping this xen-specific define in sysemu.h.

Message-Id: <20200121161747.10569-1-thuth@redhat.com>
Acked-by: Paul Durrant <paul@xen.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/xenpv/xen_machine_pv.c | 2 +-
 include/sysemu/sysemu.h   | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index 3a8af1a1e0..8df575a457 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -60,7 +60,7 @@ static void xen_init_pv(MachineState *machine)
     xen_be_register("qnic", &xen_netdev_ops);
=20
     /* configure framebuffer */
-    if (xenfb_enabled) {
+    if (vga_interface_type =3D=3D VGA_XENFB) {
         xen_config_dev_vfb(0, "vnc");
         xen_config_dev_vkbd(0);
     }
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 686f4217a6..6358a324a7 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -32,7 +32,6 @@ typedef enum {
 } VGAInterfaceType;
=20
 extern int vga_interface_type;
-#define xenfb_enabled (vga_interface_type =3D=3D VGA_XENFB)
=20
 extern int graphic_width;
 extern int graphic_height;
--=20
2.18.1


