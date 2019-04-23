Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94BCC10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 21:24:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B40E20652
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 21:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B40E20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59690 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ2tu-0005BZ-Se
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 17:24:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJ2sR-0004IB-EL
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJ2sQ-0007eR-0I
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:22:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJ2sP-0007c4-J6
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:22:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7B7343199372;
	Tue, 23 Apr 2019 21:22:51 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EF5F7600C2;
	Tue, 23 Apr 2019 21:22:50 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 18:22:44 -0300
Message-Id: <20190423212246.3542-2-ehabkost@redhat.com>
In-Reply-To: <20190423212246.3542-1-ehabkost@redhat.com>
References: <20190423212246.3542-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Tue, 23 Apr 2019 21:22:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/3] qapi: SupportStatusInfo struct
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
Cc: mprivozn@redhat.com, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190423212244.UM-DsgYq86UZyeRb-OPcNlUPchCbobSemRjzVYr0pdk@z>

This struct will be used to represent support and deprecation
status of QEMU features.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qapi/common.json | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/qapi/common.json b/qapi/common.json
index 99d313ef3b..b59d0dc66b 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -193,3 +193,27 @@
              'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
              'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
              'x86_64', 'xtensa', 'xtensaeb' ] }
+
+##
+# @SupportStatusInfo:
+#
+# Information on support status of a given feature
+# (e.g. machine type)
+#
+# @deprecated: if true, the given feature is deprecated and may be removed
+#              in future versions of QEMU according to the QEMU deprecation
+#              policy.
+#
+# @status-message: Human readable message describing support status
+#                  of the feature.
+#
+# @suggested-alternative: Optional.  Suggested alternative for a deprecated
+#                         feature.  For machine types, this should be the name
+#                         of an available machine-type.
+#
+# Since: 4.1
+##
+{ 'struct': 'SupportStatusInfo',
+  'data': { 'deprecated': 'bool',
+            '*status-message': 'str',
+            '*suggested-alternative': 'str' } }
-- 
2.18.0.rc1.1.g3f1ff2140


