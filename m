Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591B8CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 10:19:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7E52064B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 10:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7E52064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLPLw-0007ID-4p
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 06:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iLPJt-0005N6-4C
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:17:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iLPJs-0002Vt-3g
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:17:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58922)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iLPJr-0002V4-UI
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:17:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 19357307C656;
 Fri, 18 Oct 2019 10:17:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com
 [10.36.116.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4EBE81001B03;
 Fri, 18 Oct 2019 10:17:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3CA449D26; Fri, 18 Oct 2019 12:17:11 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/4] curses: use the bit mask constants provided by curses
Date: Fri, 18 Oct 2019 12:17:09 +0200
Message-Id: <20191018101711.24105-3-kraxel@redhat.com>
In-Reply-To: <20191018101711.24105-1-kraxel@redhat.com>
References: <20191018101711.24105-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 18 Oct 2019 10:17:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Matthew Kilgore <mattkilgore12@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Matthew Kilgore <mattkilgore12@gmail.com>

The curses API provides the A_ATTRIBUTES and A_CHARTEXT bit masks for
getting the attributes and character parts of a chtype, respectively. We
should use provided constants instead of using 0xff.

Signed-off-by: Matthew Kilgore <mattkilgore12@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Tested-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Message-id: 20191004035338.25601-2-mattkilgore12@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/curses.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/curses.c b/ui/curses.c
index ec281125acbd..84003f56a323 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -75,8 +75,8 @@ static void curses_update(DisplayChangeListener *dcl,
     line =3D screen + y * width;
     for (h +=3D y; y < h; y ++, line +=3D width) {
         for (x =3D 0; x < width; x++) {
-            chtype ch =3D line[x] & 0xff;
-            chtype at =3D line[x] & ~0xff;
+            chtype ch =3D line[x] & A_CHARTEXT;
+            chtype at =3D line[x] & A_ATTRIBUTES;
             ret =3D getcchar(&vga_to_curses[ch], wch, &attrs, &colors, N=
ULL);
             if (ret =3D=3D ERR || wch[0] =3D=3D 0) {
                 wch[0] =3D ch;
--=20
2.18.1


