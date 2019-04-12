Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3025EC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:18:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 014122077C
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 014122077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35478 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEv8w-00045s-PS
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 08:18:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEv6s-0002o6-Eg
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEv6r-0004bs-Hv
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:16:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hEv6r-0004bU-BG
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:16:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F6B2308CFB5;
	Fri, 12 Apr 2019 12:16:44 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-27.ams2.redhat.com
	[10.36.112.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 668CE5D9CC;
	Fri, 12 Apr 2019 12:16:41 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 12 Apr 2019 13:16:25 +0100
Message-Id: <20190412121626.19829-5-berrange@redhat.com>
In-Reply-To: <20190412121626.19829-1-berrange@redhat.com>
References: <20190412121626.19829-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Fri, 12 Apr 2019 12:16:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 4/5] hw/usb: avoid format truncation warning
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412121625.o9gvgVgthgzOkT-W2H1oXRswXh6IjfUkc5Da-B0lUoo@z>

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
---
 hw/usb/hcd-xhci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index ec28bee319..7222f9b1af 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
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
2.20.1


