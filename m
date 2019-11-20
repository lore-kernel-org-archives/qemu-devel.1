Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A546C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 19:01:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 464B22068D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 19:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EAZxOCsM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 464B22068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXVEf-0000H1-5h
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 14:01:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iXVC2-0006hW-7l
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:59:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iXVBz-0002OW-5z
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:59:10 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47919
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iXVBv-0002NV-C0
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:59:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574276342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s7Dn6ysPT3UhQYqSStW1/9KhDEFomQbpGWosePoxc6s=;
 b=EAZxOCsM6DpgBYz+eN03tfqwUItNPbCAVLfyn+wAyKAm6TNOk8WlEiu7PVossql0vN5ff8
 brgkZc2n50XEMeVLEXAFPLk8iA2Yg9Gagh1T4dTZcL08pqzsJGywoCxefiTYTCCnwJasyT
 FytszambaCCZgVmn2vV9g9i67iC3xiU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-fWhitb7vOlSopqglEa_AWw-1; Wed, 20 Nov 2019 13:58:59 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFCFF800054;
 Wed, 20 Nov 2019 18:58:58 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAB7A1838A;
 Wed, 20 Nov 2019 18:58:56 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/9] monitor: rename device-hotplug.c to blockdev-hmp-cmds.c
Date: Wed, 20 Nov 2019 20:58:43 +0200
Message-Id: <20191120185850.18986-3-mlevitsk@redhat.com>
In-Reply-To: <20191120185850.18986-1-mlevitsk@redhat.com>
References: <20191120185850.18986-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: fWhitb7vOlSopqglEa_AWw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
 MAINTAINERS                             | 1 +
 Makefile.objs                           | 4 ++--
 device-hotplug.c =3D> blockdev-hmp-cmds.c | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)
 rename device-hotplug.c =3D> blockdev-hmp-cmds.c (98%)

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
index 11ba1a36bd..cb33c1873c 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -43,13 +43,13 @@ io-obj-y =3D io/
 # single QEMU executable should support all CPUs and machines.
=20
 ifeq ($(CONFIG_SOFTMMU),y)
-common-obj-y =3D blockdev.o blockdev-nbd.o block/
+common-obj-y =3D blockdev.o blockdev-nbd.o blockdev-hmp-cmds.o block/
 common-obj-y +=3D bootdevice.o iothread.o
 common-obj-y +=3D dump/
 common-obj-y +=3D job-qmp.o
 common-obj-y +=3D monitor/
 common-obj-y +=3D net/
-common-obj-y +=3D qdev-monitor.o device-hotplug.o
+common-obj-y +=3D qdev-monitor.o
 common-obj-$(CONFIG_WIN32) +=3D os-win32.o
 common-obj-$(CONFIG_POSIX) +=3D os-posix.o
=20
diff --git a/device-hotplug.c b/blockdev-hmp-cmds.c
similarity index 98%
rename from device-hotplug.c
rename to blockdev-hmp-cmds.c
index 5ce73f0cff..21ff6fa9a9 100644
--- a/device-hotplug.c
+++ b/blockdev-hmp-cmds.c
@@ -1,5 +1,5 @@
 /*
- * QEMU device hotplug helpers
+ * Blockdev HMP commands
  *
  * Copyright (c) 2004 Fabrice Bellard
  *
--=20
2.17.2


