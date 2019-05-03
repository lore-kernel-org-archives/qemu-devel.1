Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8024C04AAA
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 07:02:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0AE62087F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 07:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0AE62087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35639 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMSD0-0005la-Vr
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 03:02:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hMSAt-0003nt-2H
	for qemu-devel@nongnu.org; Fri, 03 May 2019 03:00:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hMSAs-0006Gb-0C
	for qemu-devel@nongnu.org; Fri, 03 May 2019 03:00:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hMSAr-0006FL-Qh
	for qemu-devel@nongnu.org; Fri, 03 May 2019 03:00:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 21D0F30B4874;
	Fri,  3 May 2019 07:00:01 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-45.ams2.redhat.com
	[10.36.116.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7FB8B60BF7;
	Fri,  3 May 2019 06:59:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 5C25C1753B; Fri,  3 May 2019 08:59:54 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 08:59:54 +0200
Message-Id: <20190503065954.17069-8-kraxel@redhat.com>
In-Reply-To: <20190503065954.17069-1-kraxel@redhat.com>
References: <20190503065954.17069-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Fri, 03 May 2019 07:00:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 7/7] hw/usb: avoid format truncation warning
 when formatting port name
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503065954.KN51muxy_-hkyVFMW_DOcV9AhrjScauZ3Ptj8HK6wdQ@z>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

hw/usb/hcd-xhci.c: In function =E2=80=98usb_xhci_realize=E2=80=99:
hw/usb/hcd-xhci.c:3339:66: warning: =E2=80=98%d=E2=80=99 directive output=
 may be truncated writing between 1 and 10 bytes into a region of size 5 =
[-Wformat-trunca\
tion=3D]
 3339 |             snprintf(port->name, sizeof(port->name), "usb2 port #=
%d", i+1);
      |                                                                  =
^~
hw/usb/hcd-xhci.c:3339:54: note: directive argument in the range [1, 2147=
483647]
 3339 |             snprintf(port->name, sizeof(port->name), "usb2 port #=
%d", i+1);
      |                                                      ^~~~~~~~~~~~=
~~~

The xhci code formats the port name into a fixed length
buffer which is only large enough to hold port numbers
upto 5 digits in decimal representation. We're never
going to have a port number that large, so aserting the
port number is sensible is sufficient to tell GCC the
formatted string won't be truncated.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20190412121626.19829-5-berrange@redhat.com>

[ kraxel: also s/int/unsigned int/ to tell gcc they can't
          go negative. ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-xhci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index d8472b4fea7f..2e9a839f2bf9 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3306,7 +3306,7 @@ static void usb_xhci_init(XHCIState *xhci)
 {
     DeviceState *dev =3D DEVICE(xhci);
     XHCIPort *port;
-    int i, usbports, speedmask;
+    unsigned int i, usbports, speedmask;
=20
     xhci->usbsts =3D USBSTS_HCH;
=20
@@ -3336,6 +3336,7 @@ static void usb_xhci_init(XHCIState *xhci)
                 USB_SPEED_MASK_LOW  |
                 USB_SPEED_MASK_FULL |
                 USB_SPEED_MASK_HIGH;
+            assert(i < MAXPORTS);
             snprintf(port->name, sizeof(port->name), "usb2 port #%d", i+=
1);
             speedmask |=3D port->speedmask;
         }
@@ -3349,6 +3350,7 @@ static void usb_xhci_init(XHCIState *xhci)
             }
             port->uport =3D &xhci->uports[i];
             port->speedmask =3D USB_SPEED_MASK_SUPER;
+            assert(i < MAXPORTS);
             snprintf(port->name, sizeof(port->name), "usb3 port #%d", i+=
1);
             speedmask |=3D port->speedmask;
         }
--=20
2.18.1


