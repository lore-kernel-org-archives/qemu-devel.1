Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F700C46470
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 04:45:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFB7F21734
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 04:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB7F21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47027 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVqSV-0000EN-66
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 00:45:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hVqOC-0005Da-Nl
	for qemu-devel@nongnu.org; Wed, 29 May 2019 00:40:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hVqOB-00069j-Pp
	for qemu-devel@nongnu.org; Wed, 29 May 2019 00:40:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hVqOB-00069W-KL
	for qemu-devel@nongnu.org; Wed, 29 May 2019 00:40:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D890A7FDCA
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 04:40:34 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-59.ams2.redhat.com
	[10.36.116.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 613B760BE0;
	Wed, 29 May 2019 04:40:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id E301817532; Wed, 29 May 2019 06:40:20 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 06:40:17 +0200
Message-Id: <20190529044020.27003-7-kraxel@redhat.com>
In-Reply-To: <20190529044020.27003-1-kraxel@redhat.com>
References: <20190529044020.27003-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Wed, 29 May 2019 04:40:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 6/9] spice-app: fix running when !CONFIG_OPENGL
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Do not set 'gl' parameter, fixes:
qemu-system-x86_64: Invalid parameter 'gl'

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20190524130946.31736-7-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/spice-app.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/spice-app.c b/ui/spice-app.c
index 925b27b708bb..30541b10224a 100644
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
2.18.1


