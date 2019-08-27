Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D78C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:57:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47CF2206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47CF2206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2YDj-0006Pe-6X
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 05:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i2YCT-00055m-TR
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i2YCS-0005BD-Rt
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:55:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57818)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i2YCS-0005Ax-Lu
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:55:40 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 052EA18C890F
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 09:55:40 +0000 (UTC)
Received: from localhost (ovpn-116-148.ams2.redhat.com [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E4FC7194B2;
 Tue, 27 Aug 2019 09:55:28 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: virtio-fs@redhat.com,
	qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 10:54:37 +0100
Message-Id: <20190827095437.18819-5-stefanha@redhat.com>
In-Reply-To: <20190827095437.18819-1-stefanha@redhat.com>
References: <20190827095437.18819-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Tue, 27 Aug 2019 09:55:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/4] virtiofsd: add vhost-user.json file
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Install a vhost-user.json file describing virtiofsd.  This allows
libvirt and other management tools to enumerate vhost-user backend
programs.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile                                    | 1 +
 .gitignore                                  | 1 +
 contrib/virtiofsd/50-qemu-virtiofsd.json.in | 5 +++++
 3 files changed, 7 insertions(+)
 create mode 100644 contrib/virtiofsd/50-qemu-virtiofsd.json.in

diff --git a/Makefile b/Makefile
index ef6eca07cc..c6e2f4e7a0 100644
--- a/Makefile
+++ b/Makefile
@@ -318,6 +318,7 @@ HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)=
) =3D qemu-bridge-helper$(EXE
=20
 ifdef CONFIG_LINUX
 HELPERS-y +=3D virtiofsd$(EXESUF)
+vhost-user-json-y +=3D contrib/virtiofsd/50-qemu-virtiofsd.json
=20
 ifdef CONFIG_VIRGL
 ifdef CONFIG_GBM
diff --git a/.gitignore b/.gitignore
index fd6e6c38c7..554c7abe81 100644
--- a/.gitignore
+++ b/.gitignore
@@ -6,6 +6,7 @@
 /config-target.*
 /config.status
 /config-temp
+/contrib/virtiofsd/50-qemu-virtiofsd.json
 /elf2dmp
 /trace-events-all
 /trace/generated-events.h
diff --git a/contrib/virtiofsd/50-qemu-virtiofsd.json.in b/contrib/virtio=
fsd/50-qemu-virtiofsd.json.in
new file mode 100644
index 0000000000..9bcd86f8dc
--- /dev/null
+++ b/contrib/virtiofsd/50-qemu-virtiofsd.json.in
@@ -0,0 +1,5 @@
+{
+  "description": "QEMU virtiofsd vhost-user-fs",
+  "type": "fs",
+  "binary": "@libexecdir@/virtiofsd"
+}
--=20
2.21.0


