Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4492AC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:31:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1BD920757
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ez09atZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1BD920757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKpt0-00073i-Sg
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 17:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpQK-0002Xk-AP
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:02:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50813
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpQH-0004em-6B
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600808519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5faI8ElcYvnxKPiHc83uD5yKXb0k2Hk/EbySAFimiQk=;
 b=ez09atZWKXYlGazAz49QsV/bvYWMisDtCITZqMcAlh7JgkWvm/ARV4X3+miZWHQZbqMfU7
 s1snnBi5GllkMaeWN3vEzkcfsMUlwYmiLxP5sIa02L8duvUh0j/4ljrpCNTfdWI5zw27lR
 HiDiJMHNITCPq8Bx0jiNP9B3KW+3RrQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-ifGqNRatOQ6biSVpmdow9w-1; Tue, 22 Sep 2020 17:01:57 -0400
X-MC-Unique: ifGqNRatOQ6biSVpmdow9w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2D85186841A;
 Tue, 22 Sep 2020 21:01:56 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C28DA5577A;
 Tue, 22 Sep 2020 21:01:55 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 37/38] qapi/visit.py: remove unused parameters from
 gen_visit_object
Date: Tue, 22 Sep 2020 17:01:00 -0400
Message-Id: <20200922210101.4081073-38-jsnow@redhat.com>
In-Reply-To: <20200922210101.4081073-1-jsnow@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 17:00:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

And this fixes the pylint report for this file, so make sure we check
this in the future, too.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/pylintrc | 1 -
 scripts/qapi/visit.py | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/pylintrc b/scripts/qapi/pylintrc
index cebaf600f9..581755351b 100644
--- a/scripts/qapi/pylintrc
+++ b/scripts/qapi/pylintrc
@@ -7,7 +7,6 @@ ignore-patterns=doc.py,
                 expr.py,
                 parser.py,
                 schema.py,
-                visit.py,
 
 
 [MESSAGES CONTROL]
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 180c140180..ec9d36e72f 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -253,7 +253,7 @@ def gen_visit_alternate(name, variants):
     return ret
 
 
-def gen_visit_object(name, base, members, variants):
+def gen_visit_object(name):
     return mcgen('''
 
 bool visit_type_%(c_name)s
@@ -346,7 +346,7 @@ def visit_object_type(self, name, info, ifcond, features,
             if not name.startswith('q_'):
                 # only explicit types need an allocating visit
                 self._genh.add(gen_visit_decl(name))
-                self._genc.add(gen_visit_object(name, base, members, variants))
+                self._genc.add(gen_visit_object(name))
 
     def visit_alternate_type(self, name, info, ifcond, features, variants):
         with ifcontext(ifcond, self._genh, self._genc):
-- 
2.26.2


