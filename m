Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E4FC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 06:55:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3616208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 06:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3616208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvyoW-0006tK-8f
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 02:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48393)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hvygC-0000vN-RP
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hvyg8-0001qC-Ka
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59994)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hvyg8-0001nv-DA
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A0117315C00D
 for <qemu-devel@nongnu.org>; Fri,  9 Aug 2019 06:47:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B6B15D9CC;
 Fri,  9 Aug 2019 06:47:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ADDF71136429; Fri,  9 Aug 2019 08:46:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 08:46:33 +0200
Message-Id: <20190809064645.22656-18-armbru@redhat.com>
In-Reply-To: <20190809064645.22656-1-armbru@redhat.com>
References: <20190809064645.22656-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 09 Aug 2019 06:47:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 17/29] Include qom/object.h slightly less
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

hw/hw.h used to include headers hardware emulation "usually" needs.
The previous commits removed all but one of them, to good effect.
Only qom/object.h is left.  Remove that one, too.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/display/edid.h | 2 +-
 include/hw/hw.h           | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/hw/display/edid.h b/include/hw/display/edid.h
index 7948bd2c40..ff99dc0a05 100644
--- a/include/hw/display/edid.h
+++ b/include/hw/display/edid.h
@@ -1,7 +1,7 @@
 #ifndef EDID_H
 #define EDID_H
=20
-#include "hw/hw.h"
+#include "qom/object.h"
=20
 typedef struct qemu_edid_info {
     const char *vendor; /* http://www.uefi.org/pnp_id_list */
diff --git a/include/hw/hw.h b/include/hw/hw.h
index 8e18358e6a..8079b911fa 100644
--- a/include/hw/hw.h
+++ b/include/hw/hw.h
@@ -6,8 +6,6 @@
 #error Cannot include hw/hw.h from user emulation
 #endif
=20
-#include "qom/object.h"
-
 void QEMU_NORETURN hw_error(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
=20
 #endif
--=20
2.21.0


