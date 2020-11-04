Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9963AC388F7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 01:18:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0665C22404
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 01:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUTT3F3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0665C22404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka7Ro-0005XK-4y
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 20:18:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nz-0007Y6-I5
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nx-0004yX-JV
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r5RN8S6BJ12v6o3a7OQWEM4M5IcdBBkgErIERMbrEj8=;
 b=MUTT3F3Ce/7rLHG4QsLiP7by3qfIFlH4MGnCMakRDkAIjPT9twQ04ieWeo89GsS+NlRrxk
 915QNDpXF6Cc3Ob8A95nKvm8rsA6LBD5OW58EopZwuCPWx9qoEjRMLgRr/pB1dx2w6WTYj
 Q/RWgmV3KviyPrKnqKgZNqidjk3VLCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-Yxo1hrUCMii8rjTm09aNfQ-1; Tue, 03 Nov 2020 19:37:35 -0500
X-MC-Unique: Yxo1hrUCMii8rjTm09aNfQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 463BC108E1A6
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:37:34 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71ADE55766;
 Wed,  4 Nov 2020 00:37:33 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 66/72] scripts/qmp-shell: convert usage comment to docstring
Date: Tue,  3 Nov 2020 19:35:56 -0500
Message-Id: <20201104003602.1293560-67-jsnow@redhat.com>
In-Reply-To: <20201104003602.1293560-1-jsnow@redhat.com>
References: <20201104003602.1293560-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qmp/qmp-shell | 128 ++++++++++++++++++++++++------------------
 1 file changed, 72 insertions(+), 56 deletions(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 8d5845ab4815..82fe16cff820 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -1,7 +1,5 @@
 #!/usr/bin/env python3
 #
-# Low-level QEMU shell on top of QMP.
-#
 # Copyright (C) 2009, 2010 Red Hat Inc.
 #
 # Authors:
@@ -10,60 +8,78 @@
 # This work is licensed under the terms of the GNU GPL, version 2.  See
 # the COPYING file in the top-level directory.
 #
-# Usage:
-#
-# Start QEMU with:
-#
-# # qemu [...] -qmp unix:./qmp-sock,server
-#
-# Run the shell:
-#
-# $ qmp-shell ./qmp-sock
-#
-# Commands have the following format:
-#
-#    < command-name > [ arg-name1=arg1 ] ... [ arg-nameN=argN ]
-#
-# For example:
-#
-# (QEMU) device_add driver=e1000 id=net1
-# {u'return': {}}
-# (QEMU)
-#
-# key=value pairs also support Python or JSON object literal subset notations,
-# without spaces. Dictionaries/objects {} are supported as are arrays [].
-#
-#    example-command arg-name1={'key':'value','obj'={'prop':"value"}}
-#
-# Both JSON and Python formatting should work, including both styles of
-# string literal quotes. Both paradigms of literal values should work,
-# including null/true/false for JSON and None/True/False for Python.
-#
-#
-# Transactions have the following multi-line format:
-#
-#    transaction(
-#    action-name1 [ arg-name1=arg1 ] ... [arg-nameN=argN ]
-#    ...
-#    action-nameN [ arg-name1=arg1 ] ... [arg-nameN=argN ]
-#    )
-#
-# One line transactions are also supported:
-#
-#    transaction( action-name1 ... )
-#
-# For example:
-#
-#     (QEMU) transaction(
-#     TRANS> block-dirty-bitmap-add node=drive0 name=bitmap1
-#     TRANS> block-dirty-bitmap-clear node=drive0 name=bitmap0
-#     TRANS> )
-#     {"return": {}}
-#     (QEMU)
-#
-# Use the -v and -p options to activate the verbose and pretty-print options,
-# which will echo back the properly formatted JSON-compliant QMP that is being
-# sent to QEMU, which is useful for debugging and documentation generation.
+
+"""
+Low-level QEMU shell on top of QMP.
+
+usage: qmp-shell [-h] [-H] [-N] [-v] [-p] qmp_server
+
+positional arguments:
+  qmp_server            < UNIX socket path | TCP address:port >
+
+optional arguments:
+  -h, --help            show this help message and exit
+  -H, --hmp             Use HMP interface
+  -N, --skip-negotiation
+                        Skip negotiate (for qemu-ga)
+  -v, --verbose         Verbose (echo commands sent and received)
+  -p, --pretty          Pretty-print JSON
+
+
+Start QEMU with:
+
+# qemu [...] -qmp unix:./qmp-sock,server
+
+Run the shell:
+
+$ qmp-shell ./qmp-sock
+
+Commands have the following format:
+
+   < command-name > [ arg-name1=arg1 ] ... [ arg-nameN=argN ]
+
+For example:
+
+(QEMU) device_add driver=e1000 id=net1
+{'return': {}}
+(QEMU)
+
+key=value pairs also support Python or JSON object literal subset notations,
+without spaces. Dictionaries/objects {} are supported as are arrays [].
+
+   example-command arg-name1={'key':'value','obj'={'prop':"value"}}
+
+Both JSON and Python formatting should work, including both styles of
+string literal quotes. Both paradigms of literal values should work,
+including null/true/false for JSON and None/True/False for Python.
+
+
+Transactions have the following multi-line format:
+
+   transaction(
+   action-name1 [ arg-name1=arg1 ] ... [arg-nameN=argN ]
+   ...
+   action-nameN [ arg-name1=arg1 ] ... [arg-nameN=argN ]
+   )
+
+One line transactions are also supported:
+
+   transaction( action-name1 ... )
+
+For example:
+
+    (QEMU) transaction(
+    TRANS> block-dirty-bitmap-add node=drive0 name=bitmap1
+    TRANS> block-dirty-bitmap-clear node=drive0 name=bitmap0
+    TRANS> )
+    {"return": {}}
+    (QEMU)
+
+Use the -v and -p options to activate the verbose and pretty-print options,
+which will echo back the properly formatted JSON-compliant QMP that is being
+sent to QEMU, which is useful for debugging and documentation generation.
+"""
+
 import argparse
 import ast
 import json
-- 
2.26.2


