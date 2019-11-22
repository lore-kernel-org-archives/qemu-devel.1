Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38CFC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 17:17:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A49A20658
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 17:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jkz6TRXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A49A20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYCYe-0000Lp-Fn
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 12:17:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iYC6W-0005ct-EH
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iYC6U-00045M-Sl
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44219
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iYC6U-00044l-OK
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574441298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ui9UgGzzv/pjupUTsEmw1vZ85UDhtrAqVT5HZS5Y+OM=;
 b=Jkz6TRXbYoRes8E9k1qkJ2mM/x8tGy7PYqxrGxeMo1V4PHgMpLJHSHuY8pbcvxyLNQh4oV
 CcEg165tA58Nr4zLS0YmreKZ/L32Xmu6zjNDkRnu7NMIjOQEdkEhdikBnJ4MDPVBZ7qYdu
 QGKrSSKchkELs9RuyuTL+hYUxA2sXMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-Q5eYDtHKOTiJHHRF7qszhQ-1; Fri, 22 Nov 2019 11:48:16 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE77818C35A1;
 Fri, 22 Nov 2019 16:48:15 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E5E7466094;
 Fri, 22 Nov 2019 16:48:13 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/9] monitor/hmp: rename device-hotplug.c to
 block/monitor/block-hmp-cmds.c
Date: Fri, 22 Nov 2019 18:48:00 +0200
Message-Id: <20191122164807.27938-3-mlevitsk@redhat.com>
In-Reply-To: <20191122164807.27938-1-mlevitsk@redhat.com>
References: <20191122164807.27938-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Q5eYDtHKOTiJHHRF7qszhQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These days device-hotplug.c only contains the hmp_drive_add
In the next patch, rest of hmp_drive* functions will be moved
there.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 MAINTAINERS                                        | 1 +
 Makefile.objs                                      | 2 +-
 block/Makefile.objs                                | 1 +
 block/monitor/Makefile.objs                        | 1 +
 device-hotplug.c =3D> block/monitor/block-hmp-cmds.c | 2 +-
 5 files changed, 5 insertions(+), 2 deletions(-)
 create mode 100644 block/monitor/Makefile.objs
 rename device-hotplug.c =3D> block/monitor/block-hmp-cmds.c (98%)

diff --git a/MAINTAINERS b/MAINTAINERS
index dfb7932608..658c38edf4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1855,6 +1855,7 @@ Block QAPI, monitor, command line
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
 F: blockdev.c
+F: blockdev-hmp-cmds.c
 F: block/qapi.c
 F: qapi/block*.json
 F: qapi/transaction.json
diff --git a/Makefile.objs b/Makefile.objs
index 11ba1a36bd..e83962db96 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -49,7 +49,7 @@ common-obj-y +=3D dump/
 common-obj-y +=3D job-qmp.o
 common-obj-y +=3D monitor/
 common-obj-y +=3D net/
-common-obj-y +=3D qdev-monitor.o device-hotplug.o
+common-obj-y +=3D qdev-monitor.o
 common-obj-$(CONFIG_WIN32) +=3D os-win32.o
 common-obj-$(CONFIG_POSIX) +=3D os-posix.o
=20
diff --git a/block/Makefile.objs b/block/Makefile.objs
index e394fe0b6c..c9e35ab66a 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -43,6 +43,7 @@ block-obj-y +=3D crypto.o
=20
 block-obj-y +=3D aio_task.o
 block-obj-y +=3D backup-top.o
+common-obj-y +=3D monitor/
=20
 common-obj-y +=3D stream.o
=20
diff --git a/block/monitor/Makefile.objs b/block/monitor/Makefile.objs
new file mode 100644
index 0000000000..0a74f9a8b5
--- /dev/null
+++ b/block/monitor/Makefile.objs
@@ -0,0 +1 @@
+common-obj-y +=3D block-hmp-cmds.o
diff --git a/device-hotplug.c b/block/monitor/block-hmp-cmds.c
similarity index 98%
rename from device-hotplug.c
rename to block/monitor/block-hmp-cmds.c
index 5ce73f0cff..21ff6fa9a9 100644
--- a/device-hotplug.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -1,5 +1,5 @@
 /*
- * QEMU device hotplug helpers
+ * Blockdev HMP commands
  *
  * Copyright (c) 2004 Fabrice Bellard
  *
--=20
2.17.2


