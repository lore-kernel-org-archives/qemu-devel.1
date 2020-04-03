Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21001C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE9472073B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bADDR/ds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9472073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKNXF-00069t-2r
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 10:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jKNWF-0005Aw-CD
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:42:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jKNWD-00056x-60
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:42:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40199
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jKNWD-00055g-2Z
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585924920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZzwgN2rWU4/RfENARbQYAxOHiEJTGraF7fcMVlmV9Zo=;
 b=bADDR/ds+YS4sQJxPODx9X8OWVgi3h3zQ6KNfJSelk8AQS9y8/b8TxP1SKY2Nun5erZuRp
 0Sf7Z4qmw/tGVyzyFJ9C7Kt0M+DTGUv5tc3ZnvAGv4bTJCalyaC8QrtEtHu7v86fub1Ruc
 1GXOGLDCH2gEO/C36QnINAO0Nd9+zpw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-fu1vxOrNPraovwjpxbJ4GQ-1; Fri, 03 Apr 2020 10:41:56 -0400
X-MC-Unique: fu1vxOrNPraovwjpxbJ4GQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8A8D10CE783;
 Fri,  3 Apr 2020 14:41:54 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E61350BEE;
 Fri,  3 Apr 2020 14:41:52 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] nvdimm-utils: clean up headers and add license comment
Date: Fri,  3 Apr 2020 10:41:49 -0400
Message-Id: <20200403144149.14068-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, sbhat@linux.ibm.com,
 aik@ozlabs.ru, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes: 3f350f6bb36233be50fc2bc18dc78b6a948a5dbe
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v2:
  - add license blob to header as well
  - trim comment a litle bit to remove unrelated NFIT/PMEM sentences
---
 include/qemu/nvdimm-utils.h | 23 +++++++++++++++++++++--
 util/nvdimm-utils.c         | 23 +++++++++++++++++++++++
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/include/qemu/nvdimm-utils.h b/include/qemu/nvdimm-utils.h
index 4b8b198ba7..2d8cde085c 100644
--- a/include/qemu/nvdimm-utils.h
+++ b/include/qemu/nvdimm-utils.h
@@ -1,7 +1,26 @@
 #ifndef NVDIMM_UTILS_H
 #define NVDIMM_UTILS_H
-
-#include "qemu/osdep.h"
+/*
+ * NVDIMM utilities
+ *
+ * Copyright(C) 2015 Intel Corporation.
+ *
+ * Author:
+ *  Xiao Guangrong <guangrong.xiao@linux.intel.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licens=
es/>
+ */
=20
 GSList *nvdimm_get_device_list(void);
 #endif
diff --git a/util/nvdimm-utils.c b/util/nvdimm-utils.c
index 5cc768ca47..3d570c3c3e 100644
--- a/util/nvdimm-utils.c
+++ b/util/nvdimm-utils.c
@@ -1,3 +1,26 @@
+/*
+ * NVDIMM utilities
+ *
+ * Copyright(C) 2015 Intel Corporation.
+ *
+ * Author:
+ *  Xiao Guangrong <guangrong.xiao@linux.intel.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licens=
es/>
+ */
+
+#include "qemu/osdep.h"
 #include "qemu/nvdimm-utils.h"
 #include "hw/mem/nvdimm.h"
=20
--=20
2.18.1


