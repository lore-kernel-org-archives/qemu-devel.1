Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B488EC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 13:22:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CA9E20851
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 13:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA9E20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54575 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUA9I-0005t9-TF
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 09:22:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hUA18-0007aL-T1
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:13:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hU9yQ-0001bG-30
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:11:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hU9yP-0001ax-Tj
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:11:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3133E59450
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 13:10:56 +0000 (UTC)
Received: from localhost (ovpn-112-23.ams2.redhat.com [10.36.112.23])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AC9C07848B;
	Fri, 24 May 2019 13:10:55 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 15:09:43 +0200
Message-Id: <20190524130946.31736-7-marcandre.lureau@redhat.com>
In-Reply-To: <20190524130946.31736-1-marcandre.lureau@redhat.com>
References: <20190524130946.31736-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Fri, 24 May 2019 13:10:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v9 6/9] spice-app: fix running when
 !CONFIG_OPENGL
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not set 'gl' parameter, fixes:
qemu-system-x86_64: Invalid parameter 'gl'

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 ui/spice-app.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/spice-app.c b/ui/spice-app.c
index 925b27b708..30541b1022 100644
--- a/ui/spice-app.c
+++ b/ui/spice-app.c
@@ -157,9 +157,10 @@ static void spice_app_display_early_init(DisplayOpti=
ons *opts)
     qemu_opt_set(qopts, "addr", sock_path, &error_abort);
     qemu_opt_set(qopts, "image-compression", "off", &error_abort);
     qemu_opt_set(qopts, "streaming-video", "off", &error_abort);
+#ifdef CONFIG_OPENGL
     qemu_opt_set(qopts, "gl", opts->has_gl ? "on" : "off", &error_abort)=
;
     display_opengl =3D opts->has_gl;
-
+#endif
     be->u.spiceport.data->fqdn =3D g_strdup("org.qemu.monitor.qmp.0");
     qemu_chardev_new("org.qemu.monitor.qmp", TYPE_CHARDEV_SPICEPORT,
                      be, NULL, &error_abort);
--=20
2.22.0.rc1.1.g079e7d2849.dirty


