Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53946C31E49
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 23:04:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DADBC212CC
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 23:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NijK9EKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DADBC212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIK0B-0001td-PV
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 19:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIJdm-0007bx-Fl
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 18:41:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIJdk-0002ie-KQ
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 18:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600209691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/XQOZX3YlzB8uPAvQhr5pSb6yHYAjMkNZEf2C0oaaOY=;
 b=NijK9EKM1msOaVqMjuGfTF72A+fr5oC9pBMuLFPK1w0S3iFLiEpjhmlnx5OHc4zg5UQ3bo
 xKtjIiMYCRzNIWSBaYp//JDTq/tl7ZHWXdOEZ0meCo3h7Hculp595El8ewb8i1d9zRi/We
 07UMml6ocbGNhTBxYTte6lBm/aHXnYc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-4uqy7edVNZWgGMkL2Py_CA-1; Tue, 15 Sep 2020 18:41:28 -0400
X-MC-Unique: 4uqy7edVNZWgGMkL2Py_CA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 022AA190A403;
 Tue, 15 Sep 2020 22:41:27 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE78A60BE5;
 Tue, 15 Sep 2020 22:41:25 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 36/37] qapi/visit.py: remove unused parameters from
 gen_visit_object
Date: Tue, 15 Sep 2020 18:40:26 -0400
Message-Id: <20200915224027.2529813-37-jsnow@redhat.com>
In-Reply-To: <20200915224027.2529813-1-jsnow@redhat.com>
References: <20200915224027.2529813-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:10:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
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
index 9ca6b60caf..9d7a1d285f 100644
--- a/scripts/qapi/pylintrc
+++ b/scripts/qapi/pylintrc
@@ -7,7 +7,6 @@ ignore-patterns=doc.py,
                 expr.py,
                 parser.py,
                 schema.py,
-                visit.py,
 
 
 [MESSAGES CONTROL]
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 66ce3dc52e..ce71659a03 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -247,7 +247,7 @@ def gen_visit_alternate(name, variants):
     return ret
 
 
-def gen_visit_object(name, base, members, variants):
+def gen_visit_object(name):
     return mcgen('''
 
 bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj,
@@ -340,7 +340,7 @@ def visit_object_type(self, name, info, ifcond, features,
             if not name.startswith('q_'):
                 # only explicit types need an allocating visit
                 self._genh.add(gen_visit_decl(name))
-                self._genc.add(gen_visit_object(name, base, members, variants))
+                self._genc.add(gen_visit_object(name))
 
     def visit_alternate_type(self, name, info, ifcond, features, variants):
         with ifcontext(ifcond, self._genh, self._genc):
-- 
2.26.2


