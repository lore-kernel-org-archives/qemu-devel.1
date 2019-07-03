Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B9CC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 18:58:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3468C2189E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 18:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3468C2189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hikSj-00038e-HG
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 14:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56812)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hijgY-0004u9-2b
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:08:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hijgV-0000s6-EL
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:08:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37808)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hijgS-0000oS-NO
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:08:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B624D85A04;
 Wed,  3 Jul 2019 18:08:42 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4586D18248;
 Wed,  3 Jul 2019 18:08:42 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Date: Wed,  3 Jul 2019 15:07:15 -0300
Message-Id: <20190703180726.31267-33-ehabkost@redhat.com>
In-Reply-To: <20190703180726.31267-1-ehabkost@redhat.com>
References: <20190703180726.31267-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 03 Jul 2019 18:08:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v4 32/43] qmp: Add "alias-of" field to
 query-cpu-definitions
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Management software will be expected to resolve CPU model name
aliases using the new field.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190628002844.24894-2-ehabkost@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qapi/target.json | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/qapi/target.json b/qapi/target.json
index 1d4d54b600..0197c7962c 100644
--- a/qapi/target.json
+++ b/qapi/target.json
@@ -475,6 +475,12 @@
 #            to introspect properties configurable using -cpu or -global=
.
 #            (since 2.9)
 #
+# @alias-of: Name of CPU model this model is an alias for.  The target o=
f the
+#            CPU model alias may change depending on the machine type.
+#            Management software is supposed to translate CPU model alia=
ses
+#            in the VM configuration, because aliases may stop being
+#            migration-safe in the future (since 4.1)
+#
 # @unavailable-features is a list of QOM property names that
 # represent CPU model attributes that prevent the CPU from running.
 # If the QOM property is read-only, that means there's no known
@@ -498,7 +504,8 @@
             '*migration-safe': 'bool',
             'static': 'bool',
             '*unavailable-features': [ 'str' ],
-            'typename': 'str' },
+            'typename': 'str',
+            '*alias-of' : 'str' },
   'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I3=
86) || defined(TARGET_S390X) || defined(TARGET_MIPS)' }
=20
 ##
--=20
2.18.0.rc1.1.g3f1ff2140


