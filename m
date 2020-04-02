Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B87C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DECD120737
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCgGNY6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECD120737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK5C9-00049v-Gq
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 15:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jK5At-0002OU-GM
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jK5As-00009n-8e
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56451
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jK5As-00008e-4l
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585854405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WLTKvMaeXidLHOB5oKca6XdBHm1iUVOIo6D0v329Ekk=;
 b=QCgGNY6giayxrcgkkLOiOQ3FcNLAIMTtbYFWi4qaqmgxWcDZFklckbt6QU9Sj0TqI0uzqJ
 5aV+pHFWkGXkc/erjJVSE+whJrFs3mNTbnWIJpnVDpMnYEXEcdcT52AMQFF+0UaIciqyDS
 idgiUF7tob9YN/Q/JYWrYoGgSlR6jCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-iYaiJ-9SOM2IJ4iX3p3JIQ-1; Thu, 02 Apr 2020 15:06:43 -0400
X-MC-Unique: iYaiJ-9SOM2IJ4iX3p3JIQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBE78800D50
 for <qemu-devel@nongnu.org>; Thu,  2 Apr 2020 19:06:42 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7FB48DA0F2;
 Thu,  2 Apr 2020 19:06:42 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/15] hw/isa/superio: Correct the license text
Date: Thu,  2 Apr 2020 15:06:27 -0400
Message-Id: <20200402190640.1693-3-pbonzini@redhat.com>
In-Reply-To: <20200402190640.1693-1-pbonzini@redhat.com>
References: <20200402190640.1693-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

The license is the 'GNU General Public License v2.0 or later',
not 'and':

  This program is free software; you can redistribute it and/ori
  modify it under the terms of the GNU General Public License as
  published by the Free Software Foundation; either version 2 of
  the License, or (at your option) any later version.

Fix the license comment.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200312213712.16671-1-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/isa-superio.c       | 2 +-
 hw/isa/smc37c669-superio.c | 2 +-
 include/hw/isa/superio.h   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index c4e391916c..180a8b9625 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -5,7 +5,7 @@
  * Copyright (c) 2011-2012 Andreas F=C3=A4rber
  * Copyright (c) 2018 Philippe Mathieu-Daud=C3=A9
  *
- * This code is licensed under the GNU GPLv2 and later.
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
  * See the COPYING file in the top-level directory.
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
diff --git a/hw/isa/smc37c669-superio.c b/hw/isa/smc37c669-superio.c
index 901a9f8e65..18287741cb 100644
--- a/hw/isa/smc37c669-superio.c
+++ b/hw/isa/smc37c669-superio.c
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2018 Philippe Mathieu-Daud=C3=A9
  *
- * This code is licensed under the GNU GPLv2 and later.
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
  * See the COPYING file in the top-level directory.
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
diff --git a/include/hw/isa/superio.h b/include/hw/isa/superio.h
index b151dcd753..147cc0a7b7 100644
--- a/include/hw/isa/superio.h
+++ b/include/hw/isa/superio.h
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2018 Philippe Mathieu-Daud=C3=A9
  *
- * This code is licensed under the GNU GPLv2 and later.
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
  * See the COPYING file in the top-level directory.
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
--=20
2.18.2



