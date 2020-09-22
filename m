Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A8BC4727E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D668206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhstZodi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D668206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKr7j-00017a-7C
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqt1-0004Zo-T0
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:35:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22280)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqt0-0007fS-0L
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600814145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZaO4qj/yTu41gKQZ04f3gMKYh6PkBbR6GMOvXDRhB7k=;
 b=FhstZodiiuaxDmIX2N/N10ITdhj5f3QUa0yBS14GeH5uZbLcE3a/vKFxwM4L81rUa+M7L7
 QqUBJyEF7YsHXohcIfo2n84toRRCAG5MUFqrCRCE9mZgWipr+Yl5840uCoX03rPoCndR+7
 BfAXNTZIQ469gqAO/3dh427ZjJw3vq8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-WSV9awEwPGCz8mjvddRMmQ-1; Tue, 22 Sep 2020 18:35:43 -0400
X-MC-Unique: WSV9awEwPGCz8mjvddRMmQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70D92107465D;
 Tue, 22 Sep 2020 22:35:42 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8CC2860CCC;
 Tue, 22 Sep 2020 22:35:41 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 14/26] qapi/parser.py: add docstrings
Date: Tue, 22 Sep 2020 18:35:13 -0400
Message-Id: <20200922223525.4085762-15-jsnow@redhat.com>
In-Reply-To: <20200922223525.4085762-1-jsnow@redhat.com>
References: <20200922223525.4085762-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index d9aae4ddb7..490436b48a 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -61,7 +61,15 @@ class QAPIDocError(QAPIError):
 
 
 class QAPISchemaParser:
+    """
+    Performs parsing of a QAPI schema source file.
 
+    :param fname: Path to the source file
+    :param previously_included: Set of absolute paths of previously included
+                                source files; these will not be parsed again.
+    :param incl_info: QAPISourceInfo for the parent document;
+                      Can be None for the parent document.
+    """
     def __init__(self,
                  fname: str,
                  previously_included: Optional[Set[str]] = None,
@@ -97,6 +105,10 @@ def __init__(self,
         self._parse()
 
     def _parse(self) -> None:
+        """
+        Parse the QAPI Schema Document.
+        Build self.exprs, self.docs
+        """
         cur_doc = None
 
         # Prime the lexer:
@@ -216,6 +228,32 @@ def _pragma(cls,
             raise QAPISemError(info, "unknown pragma '%s'" % name)
 
     def accept(self, skip_comment: bool = True) -> None:
+        """
+        Read the next lexeme.
+
+        - `tok` is the current lexeme/token type.
+          It will always be a single char in `"[]{},:'tf#"`.
+        - `pos` is the position of the first character in the lexeme.
+        - `cursor` is the position of the next character.
+        - `val` is the value of the lexeme.
+
+        Single-char lexemes:
+          LBRACE, RBRACE, COLON, COMMA, LSQB, RSQB:
+            `tok` holds the single-char value of the lexeme.
+
+        Multi-char lexemes:
+          COMMENT - `tok` is `'#'`.
+                    `val` is a string including all chars until end-of-line.
+                          (The '#' is excluded.)
+          STRING  - `tok` is `"'"`.
+                    `val` is the string, excluding the quotes.
+          TRUE    - `tok` is `"t"`. `val` is `True`.
+          FALSE   - `tok` is `"f"`. `val` is `False`.
+
+        NEWLINE and SPACE lexemes are consumed by the lexer directly.
+        `line_pos` and `info` are advanced when NEWLINE is encountered.
+        `tok` is set to `None` upon reaching EOF.
+        """
         while True:
             self.tok = self.src[self.cursor]
             self.pos = self.cursor
-- 
2.26.2


