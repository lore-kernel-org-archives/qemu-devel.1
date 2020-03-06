Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093C4C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:20:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8C8220848
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmzI0BAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C8220848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGeB-0002ko-U9
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:20:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jAGZN-0004mD-BI
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jAGZM-0007YM-1d
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:29 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25704
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jAGZE-0007MZ-RI
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583514919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W2NlQibGUpAy4sY1Uz1u4QMdM8N02pQOxaDoSrXr2IU=;
 b=dmzI0BAucNjdHrl5KyQ3OyYo8nTtdlFl/aZYZP2uFtdBw/Uwoo9at5gEb7+SaXbzOE0YoE
 KhKsL3OAGctJn7XFNqbdKs5F6gA6hZzKZZ09WHuu9umcIb5V2+Yl+wfbv0tExMpm20C6VJ
 tI+w/XnQmgUAmEKuLQLfKErcLjznwWY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-9JzkQ3BZPZGEvD4W19qjEQ-1; Fri, 06 Mar 2020 12:15:17 -0500
X-MC-Unique: 9JzkQ3BZPZGEvD4W19qjEQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D3BB184C801;
 Fri,  6 Mar 2020 17:15:16 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2000873873;
 Fri,  6 Mar 2020 17:15:14 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 08/29] stubs: Add arch_type
Date: Fri,  6 Mar 2020 18:14:37 +0100
Message-Id: <20200306171458.1848-9-kwolf@redhat.com>
In-Reply-To: <20200306171458.1848-1-kwolf@redhat.com>
References: <20200306171458.1848-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

blockdev.c uses the arch_type constant, so before we can use the file in
tools (i.e. outside of the system emulator), we need to add a stub for
it. A new QEMU_ARCH_NONE is introduced for this case.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200224143008.13362-3-kwolf@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/sysemu/arch_init.h | 2 ++
 stubs/arch_type.c          | 4 ++++
 stubs/Makefile.objs        | 1 +
 3 files changed, 7 insertions(+)
 create mode 100644 stubs/arch_type.c

diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 62c6fe4cf1..01392dc945 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -24,6 +24,8 @@ enum {
     QEMU_ARCH_NIOS2 =3D (1 << 17),
     QEMU_ARCH_HPPA =3D (1 << 18),
     QEMU_ARCH_RISCV =3D (1 << 19),
+
+    QEMU_ARCH_NONE =3D (1 << 31),
 };
=20
 extern const uint32_t arch_type;
diff --git a/stubs/arch_type.c b/stubs/arch_type.c
new file mode 100644
index 0000000000..fc5423bc98
--- /dev/null
+++ b/stubs/arch_type.c
@@ -0,0 +1,4 @@
+#include "qemu/osdep.h"
+#include "sysemu/arch_init.h"
+
+const uint32_t arch_type =3D QEMU_ARCH_NONE;
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 7afbe5fb61..24062ce7d9 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -1,3 +1,4 @@
+stub-obj-y +=3D arch_type.o
 stub-obj-y +=3D bdrv-next-monitor-owned.o
 stub-obj-y +=3D blk-commit-all.o
 stub-obj-y +=3D blockdev-close-all-bdrv-states.o
--=20
2.20.1


