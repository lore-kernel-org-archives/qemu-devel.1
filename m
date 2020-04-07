Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F16C2BABC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:37:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C6A20644
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3K8Y4IP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C6A20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLkfV-0005KR-Af
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 05:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jLkem-0004t0-MD
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jLkel-0006PT-PU
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:36:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25749
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jLkel-0006P1-M7
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586252191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cPGyaQEkTVX74IWsa7XTlZWvRIPuGSRL59sHbAo4Tks=;
 b=V3K8Y4IPFCsJ+KlapNISwurIM8GDSabPNYgQJ4Nd+nP1fECxgbWfELxFhM/KwpS7BxhutV
 d4WZbimzHQypMZiGIRuZ2mP8dbCSviFFVtWpxcLlmvWIjRDHVyClf7AJper4PSbcQJEDZP
 cRhpRucDl5/WBDPwY4fSHehKyDVz2cs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-43pKa1Z_Pj6z9-91TdhzMQ-1; Tue, 07 Apr 2020 05:36:23 -0400
X-MC-Unique: 43pKa1Z_Pj6z9-91TdhzMQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C34951085926;
 Tue,  7 Apr 2020 09:36:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-60.ams2.redhat.com
 [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D7F8A10002D0;
 Tue,  7 Apr 2020 09:36:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B1F6416E2C; Tue,  7 Apr 2020 11:36:17 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4] ui: improve -show-cursor deprecation message
Date: Tue,  7 Apr 2020 11:36:17 +0200
Message-Id: <20200407093617.10058-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: peter.maydell@linaro.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Specifically explain what users should do in case they don't use
-display yet and depend on the qemu picking the ui for them.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 softmmu/vl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 58a40bcfc19c..0640d481df06 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -3531,8 +3531,10 @@ void qemu_init(int argc, char **argv, char **envp)
                 no_shutdown =3D 1;
                 break;
             case QEMU_OPTION_show_cursor:
-                warn_report("The -show-cursor option is deprecated, "
-                            "use -display {sdl,gtk},show-cursor=3Don inste=
ad");
+                warn_report("The -show-cursor option is deprecated. Please=
 "
+                            "add show-cursor=3Don to your -display options=
.");
+                warn_report("When using the default display you can use "
+                            "-display default,show-cursor=3Don");
                 dpy.has_show_cursor =3D true;
                 dpy.show_cursor =3D true;
                 break;
--=20
2.18.2


