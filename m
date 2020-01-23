Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB90AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A914721569
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGvKaRyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A914721569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugLR-0007MV-Bb
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:32:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iudMS-0004us-C5
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:21:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iudMR-0003KL-CF
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:21:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45809
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iudMR-0003KA-8C
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:21:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579789290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aawRGz1XJLzcOhERvs/O0IrY3DsPdDnK/U0cdLxG+AA=;
 b=JGvKaRykdYRYO3HSg8Ne+RE/tzFyg5jxK+u4Dk1eVn3gTS6s7537Q8kmSIU/IuN0WSmbgS
 f7vrek+ainSz49rTFpVDZ7uS8dPdE4cVuJxSmzklPwV+NVZKGaiVVY+7MUWJ5zc3DOzKT8
 OiwpLtMbAgAVoTnLBMSj6xAMrAFlYB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-PNK7Vc-PPsO5YYstv7B4cg-1; Thu, 23 Jan 2020 09:21:28 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E69468010C5
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 14:21:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-106.ams2.redhat.com
 [10.36.116.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C5361001925;
 Thu, 23 Jan 2020 14:21:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7FF049B13; Thu, 23 Jan 2020 15:21:22 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] ui/console: Display the 'none' backend in '-display help'
Date: Thu, 23 Jan 2020 15:21:22 +0100
Message-Id: <20200123142122.13839-4-kraxel@redhat.com>
In-Reply-To: <20200123142122.13839-1-kraxel@redhat.com>
References: <20200123142122.13839-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: PNK7Vc-PPsO5YYstv7B4cg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Commit c388f408b5 added the possibility to list the display
backends using '-display help'. Since the 'none' backend is
is not implemented as a DisplayChangeListenerOps, it is not
registered to the dpys[] array with qemu_display_register(),
and is not listed in the help output.

This might be confusing, as we list it in the man page:

  -display type
      Select type of display to use. This option is a replacement for
      the old style -sdl/-curses/... options. Valid values for type are

      none
          Do not display video output. The guest will still see an
          emulated graphics card, but its output will not be displayed
          to the QEMU user. This option differs from the -nographic
          option in that it only affects what is done with video
          output; -nographic also changes the destination of the serial
          and parallel port data.

Fix by manually listing the special 'none' backend in the help.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20200120192947.31613-1-philmd@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/console.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/console.c b/ui/console.c
index 69339b028bb2..179901c35e0d 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -2338,6 +2338,7 @@ void qemu_display_help(void)
     int idx;
=20
     printf("Available display backend types:\n");
+    printf("none\n");
     for (idx =3D DISPLAY_TYPE_NONE; idx < DISPLAY_TYPE__MAX; idx++) {
         if (!dpys[idx]) {
             ui_module_load_one(DisplayType_str(idx));
--=20
2.18.1


