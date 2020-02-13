Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C3CC3B188
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A7520848
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JraAPUPP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A7520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2AT1-00043C-A9
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 04:07:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j2ASE-00035q-8m
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:06:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j2ASC-0005pY-VZ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:06:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58022
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j2ASC-0005pG-SH
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581584796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+rt7Xl3jEurk4ZQ9sMEq4EQTKRM96ZQEe0rqy6JbgUM=;
 b=JraAPUPPWAdJP7l+fRICeliPh5/+R3uu2UGwbeJddTOAhsDuKWN7SfhNU9ohqvgPe1PiP5
 BK+jWy/EXBcE5qiYbsexE5bN3Cf98RkOAv8jwlMwSkHPPyXW0Vf6zGHPGk4gvk/EXscO6U
 rD5dqakQHNjgbzIckaYLkbg4lzAMpOA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-PCFi9ytaOdqNpOII3pEgTA-1; Thu, 13 Feb 2020 04:06:32 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CCA6477;
 Thu, 13 Feb 2020 09:06:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-39.ams2.redhat.com
 [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B8135C13E;
 Thu, 13 Feb 2020 09:06:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D49429AE0; Thu, 13 Feb 2020 10:06:27 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] qxl: introduce hardware revision 5
Date: Thu, 13 Feb 2020 10:06:27 +0100
Message-Id: <20200213090627.2181-2-kraxel@redhat.com>
In-Reply-To: <20200213090627.2181-1-kraxel@redhat.com>
References: <20200213090627.2181-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: PCFi9ytaOdqNpOII3pEgTA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The only difference to hardware revision 4 is that the device doesn't
switch to VGA mode in case someone happens to touch a VGA register,
which should make things more robust in configurations with multiple
vga devices.

Swtiching back to VGA mode happens on reset, either full machine
reset or qxl device reset (QXL_IO_RESET ioport command).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Message-id: 20200206074358.4274-1-kraxel@redhat.com
---
 hw/display/qxl.h  | 2 +-
 hw/core/machine.c | 2 ++
 hw/display/qxl.c  | 7 ++++++-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/display/qxl.h b/hw/display/qxl.h
index 80eb0d267269..707631a1f573 100644
--- a/hw/display/qxl.h
+++ b/hw/display/qxl.h
@@ -144,7 +144,7 @@ typedef struct PCIQXLDevice {
         }                                                               \
     } while (0)
=20
-#define QXL_DEFAULT_REVISION QXL_REVISION_STABLE_V12
+#define QXL_DEFAULT_REVISION (QXL_REVISION_STABLE_V12 + 1)
=20
 /* qxl.c */
 void *qxl_phys2virt(PCIQXLDevice *qxl, QXLPHYSICAL phys, int group_id);
diff --git a/hw/core/machine.c b/hw/core/machine.c
index d8e30e4895d8..84812a1d1cc1 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -34,6 +34,8 @@ GlobalProperty hw_compat_4_2[] =3D {
     { "vhost-blk-device", "seg_max_adjust", "off"},
     { "usb-host", "suppress-remote-wake", "off" },
     { "usb-redir", "suppress-remote-wake", "off" },
+    { "qxl", "revision", "4" },
+    { "qxl-vga", "revision", "4" },
 };
 const size_t hw_compat_4_2_len =3D G_N_ELEMENTS(hw_compat_4_2);
=20
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index c33b1915a52c..64884da70857 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1309,7 +1309,8 @@ static void qxl_vga_ioport_write(void *opaque, uint32=
_t addr, uint32_t val)
     PCIQXLDevice *qxl =3D container_of(vga, PCIQXLDevice, vga);
=20
     trace_qxl_io_write_vga(qxl->id, qxl_mode_to_string(qxl->mode), addr, v=
al);
-    if (qxl->mode !=3D QXL_MODE_VGA) {
+    if (qxl->mode !=3D QXL_MODE_VGA &&
+        qxl->revision <=3D QXL_REVISION_STABLE_V12) {
         qxl_destroy_primary(qxl, QXL_SYNC);
         qxl_soft_reset(qxl);
     }
@@ -2121,6 +2122,10 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Er=
ror **errp)
         pci_device_rev =3D QXL_REVISION_STABLE_V12;
         io_size =3D pow2ceil(QXL_IO_RANGE_SIZE);
         break;
+    case 5: /* qxl-5 */
+        pci_device_rev =3D QXL_REVISION_STABLE_V12 + 1;
+        io_size =3D pow2ceil(QXL_IO_RANGE_SIZE);
+        break;
     default:
         error_setg(errp, "Invalid revision %d for qxl device (max %d)",
                    qxl->revision, QXL_DEFAULT_REVISION);
--=20
2.18.2


