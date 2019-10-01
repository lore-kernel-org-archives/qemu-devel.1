Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2B2ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 19:20:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01E7D2133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 19:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E7D2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFNhT-0007Fd-S8
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 15:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iFNcJ-0004Ni-Du
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iFNcH-0003J8-Js
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:15:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40550)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iFNcH-0003IB-E5
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:15:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AEEBBC04AC50;
 Tue,  1 Oct 2019 19:15:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7926B5D9C9;
 Tue,  1 Oct 2019 19:15:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 21BC011385C7; Tue,  1 Oct 2019 21:15:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/7] qapi: Clear scripts/qapi/doc.py executable bits again
Date: Tue,  1 Oct 2019 21:15:14 +0200
Message-Id: <20191001191514.11208-8-armbru@redhat.com>
In-Reply-To: <20191001191514.11208-1-armbru@redhat.com>
References: <20191001191514.11208-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 01 Oct 2019 19:15:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit fbf09a2fa4 "qapi: add 'ifcond' to visitor methods" brought back
the executable bits.  Fix that.  Drop the #! line for good measure.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/doc.py | 1 -
 1 file changed, 1 deletion(-)
 mode change 100755 =3D> 100644 scripts/qapi/doc.py

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
old mode 100755
new mode 100644
index 1c5125249f..dc8919bab7
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -1,4 +1,3 @@
-#!/usr/bin/env python
 # QAPI texi generator
 #
 # This work is licensed under the terms of the GNU LGPL, version 2+.
--=20
2.21.0


