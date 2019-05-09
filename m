Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDCEC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0406F20863
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0406F20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50340 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOeOn-0001lV-7w
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 04:27:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hOeHb-0002DM-DP
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:20:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hOeHa-0000TW-3y
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:20:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hOeHZ-0000T9-Si
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:20:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3672285539;
	Thu,  9 May 2019 08:20:01 +0000 (UTC)
Received: from thuth.com (ovpn-116-115.ams2.redhat.com [10.36.116.115])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 321F25B680;
	Thu,  9 May 2019 08:19:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Thu,  9 May 2019 10:19:29 +0200
Message-Id: <20190509081930.19081-14-thuth@redhat.com>
In-Reply-To: <20190509081930.19081-1-thuth@redhat.com>
References: <20190509081930.19081-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Thu, 09 May 2019 08:20:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 13/14] target/sh4: Fix LGPL information in the
 file headers
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
Cc: ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's either "GNU *Library* General Public License version 2" or "GNU
Lesser General Public License version *2.1*", but there was no "version
2.0" of the "Lesser" license. So assume that version 2.1 is meant here.

Message-Id: <1550073530-4138-1-git-send-email-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 linux-user/sh4/target_cpu.h     | 2 +-
 linux-user/sh4/target_structs.h | 2 +-
 target/sh4/cpu.h                | 2 +-
 target/sh4/gdbstub.c            | 2 +-
 target/sh4/helper.c             | 2 +-
 target/sh4/op_helper.c          | 2 +-
 target/sh4/translate.c          | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/linux-user/sh4/target_cpu.h b/linux-user/sh4/target_cpu.h
index 1a647ddb98..b0be9a2c1b 100644
--- a/linux-user/sh4/target_cpu.h
+++ b/linux-user/sh4/target_cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/sh4/target_structs.h b/linux-user/sh4/target_stru=
cts.h
index 3e832bf69a..00ac39478b 100644
--- a/linux-user/sh4/target_structs.h
+++ b/linux-user/sh4/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 84b08ff640..1be36fe875 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sh4/gdbstub.c b/target/sh4/gdbstub.c
index 13bea00d7d..54568e96f9 100644
--- a/target/sh4/gdbstub.c
+++ b/target/sh4/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 2ff0cf4060..fa51269fb1 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 4f825bae5a..28027f9e0b 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index cdf0888490..5a7d8c4535 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
--=20
2.21.0


