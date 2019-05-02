Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B212C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:48:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B4F920873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B4F920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46793 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6S6-00051m-Fd
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 03:48:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hM6GK-00026N-60
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hM6GI-000136-3I
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:36:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hM6GG-0000gx-6H
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:36:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 15F88C1306E4;
	Thu,  2 May 2019 07:35:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-45.ams2.redhat.com
	[10.36.116.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AFF5998A8;
	Thu,  2 May 2019 07:35:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 889001752B; Thu,  2 May 2019 09:35:43 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 09:35:38 +0200
Message-Id: <20190502073543.4391-3-kraxel@redhat.com>
In-Reply-To: <20190502073543.4391-1-kraxel@redhat.com>
References: <20190502073543.4391-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Thu, 02 May 2019 07:35:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/7] usb-mtp: fix alignment of access of
 ObjectInfo filename field
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
Message-ID: <20190502073538.AKw6UOPDlAm-nYnNnugagCXqFKolet0xqzzlX6kka78@z>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

The ObjectInfo struct's "filename" field is following a uint8_t
field in a packed struct and thus has bad alignment for a 16-bit
field. Switch the field to to uint8_t and use the helper function
for accessing unaligned 16-bit data.

Note that although the MTP spec specifies big endian, when transported
over the USB protocol, data is little endian.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 20190415154503.6758-4-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-mtp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 6b7d1296e430..963449ec7de8 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -226,7 +226,7 @@ typedef struct {
     uint32_t assoc_desc;
     uint32_t seq_no; /*unused*/
     uint8_t length; /*part of filename field*/
-    uint16_t filename[0];
+    uint8_t filename[0]; /* UTF-16 encoded */
     char date_created[0]; /*unused*/
     char date_modified[0]; /*unused*/
     char keywords[0]; /*unused*/
@@ -1551,7 +1551,7 @@ static void usb_mtp_cancel_packet(USBDevice *dev, U=
SBPacket *p)
     fprintf(stderr, "%s\n", __func__);
 }
=20
-static char *utf16_to_str(uint8_t len, uint16_t *arr)
+static char *utf16_to_str(uint8_t len, uint8_t *str16)
 {
     wchar_t *wstr =3D g_new0(wchar_t, len + 1);
     int count, dlen;
@@ -1559,7 +1559,7 @@ static char *utf16_to_str(uint8_t len, uint16_t *ar=
r)
=20
     for (count =3D 0; count < len; count++) {
         /* FIXME: not working for surrogate pairs */
-        wstr[count] =3D (wchar_t)arr[count];
+        wstr[count] =3D lduw_le_p(str16 + (count * 2));
     }
     wstr[count] =3D 0;
=20
--=20
2.18.1


