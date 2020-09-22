Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A84C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 23:10:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B6C221EF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 23:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUdXw3G7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B6C221EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKrQx-0005MV-QH
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 19:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKr2o-0002Qx-3I
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:45:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59207)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKr2j-0000Wf-Iv
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600814737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TwMRv6UsLnWab9ol/6LyGADZOnqiP4elsl9NHdIBn7Q=;
 b=dUdXw3G7gHZ0bhdj5BIR9sI9NkbNDL5xB41iVRP4s/ccvYVl0uw1VQIkWDFqwn6HwrUDu6
 tfuJ9W27KqfDZtDvpzGW8xIBqnN8Mgm/JUNm4YUlV3V1Ni78QDOPwC5dZbXCCGw7/8OUFQ
 GwcOzSxHqvhWTEt+Hi8OionyQwd/lnk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-MZnOQA9PNtKdhSQ2b5JJNQ-1; Tue, 22 Sep 2020 18:45:36 -0400
X-MC-Unique: MZnOQA9PNtKdhSQ2b5JJNQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CFF0186DD27;
 Tue, 22 Sep 2020 22:45:35 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3BF425C1A3;
 Tue, 22 Sep 2020 22:45:34 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 24/25] qapi/schema.py: Add module docstring
Date: Tue, 22 Sep 2020 18:45:00 -0400
Message-Id: <20200922224501.4087749-25-jsnow@redhat.com>
In-Reply-To: <20200922224501.4087749-1-jsnow@redhat.com>
References: <20200922224501.4087749-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add some microdocumentation that gives a nice file-level overview of
this 1300+ line file.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 6ecbc2aa6b..baafe3babf 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -1,7 +1,37 @@
 # -*- coding: utf-8 -*-
-#
-# QAPI schema internal representation
-#
+"""
+QAPI Schema internal representation.
+
+The `QAPISchema` represents the fully realized QAPI schema. It builds a
+listing of `QAPISchemaEntity` objects that are each associated with a
+`QAPISchemaModule`.
+
+`QAPISchemaMember` represents a single member of a collection of
+members, see the subclasses thereof for users. `QAPISchemaVariants` is a
+simple collection of `QAPISchemaVariant`.
+
+The `QAPISchemaVisitor` can be extended and passed to QAPISchema.visit
+to iterate over a schema and perform code generation tasks.
+
+The Python class hierarchy at a glance:
+
+`QAPISchemaEntity`
+  `QAPISchemaInclude`
+  `QAPISchemaCommand`
+  `QAPISchemaEvent`
+  `QAPISchemaType`
+    `QAPISchemaBuiltinType`
+    `QAPISchemaEnumType`
+    `QAPISchemaArrayType`
+    `QAPISchemaObjectType`
+    `QAPISchemaAlternateType`
+
+`QAPISchemaMember`
+  `QAPISchemaEnumMember`
+  `QAPISchemaFeature`
+  `QAPISchemaObjectTypeMember`
+    `QAPISchemaVariant`
+"""
 # Copyright (c) 2015-2019 Red Hat Inc.
 #
 # Authors:
-- 
2.26.2


