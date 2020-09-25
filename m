Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB93FC4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 00:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B800E238D6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 00:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvgrTjcb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B800E238D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLbjB-0006Qd-DD
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 20:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbbw-0000m5-6Q
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:29:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbbo-00008Q-SH
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:29:15 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600993747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IEYyTsPP9nkDV/uKK/aUX06wihmga88s0g6fn1fxzRY=;
 b=SvgrTjcbC12ddT1+41Ai0xuFbpNDcOQlcJXmU0Map8QSaDVQy1JvqMMK+qkU+6uepxYrnH
 MIUuOluDlsqVgZg68O4oJ+eJ+heakwf8HSW/nvHjdqrURwsHg+iXE0X+PdS8usSBXNmMqF
 vpEMZ+XGwjg3m4pNXCUWAoTVAvDgJeg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-3615KZsoPcmAMVhmjkznKA-1; Thu, 24 Sep 2020 20:29:05 -0400
X-MC-Unique: 3615KZsoPcmAMVhmjkznKA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7F961091066
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 00:29:04 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1EFAE5D9F1;
 Fri, 25 Sep 2020 00:29:04 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/47] qapi: modify docstrings to be sphinx-compatible
Date: Thu, 24 Sep 2020 20:28:17 -0400
Message-Id: <20200925002900.465855-5-jsnow@redhat.com>
In-Reply-To: <20200925002900.465855-1-jsnow@redhat.com>
References: <20200925002900.465855-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I did not say "sphinx beautiful", just "sphinx compatible". They will
not throw errors when parsed and interpreted as ReST.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/doc.py    | 10 +++++-----
 scripts/qapi/gen.py    |  6 ++++--
 scripts/qapi/parser.py |  9 +++++----
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 92f584edcf..c41e9d29f5 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -65,11 +65,11 @@ def texi_format(doc):
     Format documentation
 
     Lines starting with:
-    - |: generates an @example
-    - =: generates @section
-    - ==: generates @subsection
-    - 1. or 1): generates an @enumerate @item
-    - */-: generates an @itemize list
+    - ``|:`` generates an @example
+    - ``=:`` generates @section
+    - ``==:`` generates @subsection
+    - ``1.`` or ``1):`` generates an @enumerate @item
+    - ``*/-:`` generates an @itemize list
     """
     ret = ''
     doc = subst_braces(doc)
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index bf5552a4e7..3d25a8cff4 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -154,9 +154,11 @@ def _bottom(self):
 
 @contextmanager
 def ifcontext(ifcond, *args):
-    """A 'with' statement context manager to wrap with start_if()/end_if()
+    """
+    A 'with' statement context manager to wrap with start_if()/end_if()
 
-    *args: any number of QAPIGenCCode
+    :param ifcond: List of conditionals
+    :param args: any number of QAPIGenCCode
 
     Example::
 
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 165925ca72..00738cea8c 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -366,10 +366,11 @@ def append(self, line):
 
         The way that the line is dealt with depends on which part of
         the documentation we're parsing right now:
-        * The body section: ._append_line is ._append_body_line
-        * An argument section: ._append_line is ._append_args_line
-        * A features section: ._append_line is ._append_features_line
-        * An additional section: ._append_line is ._append_various_line
+
+         * The body section: ._append_line is ._append_body_line
+         * An argument section: ._append_line is ._append_args_line
+         * A features section: ._append_line is ._append_features_line
+         * An additional section: ._append_line is ._append_various_line
         """
         line = line[1:]
         if not line:
-- 
2.26.2


