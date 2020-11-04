Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0E9C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 19:32:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B1DD2065D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 19:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QP/k2ZIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1DD2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaOVk-0004Hh-2e
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 14:32:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kaOUU-0003PL-FQ
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 14:30:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45386)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kaOUS-0008G4-QC
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 14:30:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604518239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=90caXRKGbBJKSi+u08Pj/8dqx+zmWzZSLLu3gdIMp+I=;
 b=QP/k2ZIf87hNDszx3wTj3zQvv48LM1nyRIQgpwwnXK59ZieBYCZqu3G+TcBz2ySSL1qT8u
 ZuzuZWUyY0OerrjyTEAsT8PEtn2HHHnQazprbHnQemT77N6AHP1w19mw5trY64qvK6oUfI
 B6oLWlg7ErSGQ/Tnnb91QoR0tWk7lDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482--HWCQAkCODiy97hVFcRwYQ-1; Wed, 04 Nov 2020 14:30:35 -0500
X-MC-Unique: -HWCQAkCODiy97hVFcRwYQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23AC1107AFA9;
 Wed,  4 Nov 2020 19:30:34 +0000 (UTC)
Received: from scv.redhat.com (ovpn-113-61.rdu2.redhat.com [10.10.113.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 874CD5C5DE;
 Wed,  4 Nov 2020 19:30:33 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] README: Add Documentation blurb
Date: Wed,  4 Nov 2020 14:30:32 -0500
Message-Id: <20201104193032.1319248-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add it in a prominent place: Right after figuring out what QEMU is,
users may wish to know how to use it more than they want to know how to
build their own version of it.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 README.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/README.rst b/README.rst
index 58b9f2dc15c4..758ea8fd2ff0 100644
--- a/README.rst
+++ b/README.rst
@@ -31,6 +31,17 @@ QEMU as a whole is released under the GNU General Public License,
 version 2. For full licensing details, consult the LICENSE file.
 
 
+Documentation
+=============
+
+Documentation can be found hosted online at
+`<https://www.qemu.org/documentation/>`_. The documentation for the
+current development version that is available at
+`<https://www.qemu.org/docs/master/>`_ is generated from the ``docs/``
+folder in the source tree, and is built by `Sphinx
+<https://www.sphinx-doc.org/en/master/>_`.
+
+
 Building
 ========
 
-- 
2.26.2


