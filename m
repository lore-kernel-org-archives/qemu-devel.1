Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4C9C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:11:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 391492070B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391492070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFSER-0002n4-Kq
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 20:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRrr-0001Gr-Sx
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRrm-0001XH-LJ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:47:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36370
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRrl-0001TH-So; Tue, 01 Oct 2019 19:47:38 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlPGa179294; Tue, 1 Oct 2019 19:47:35 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcdgpnctk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:35 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NlP6c179311;
 Tue, 1 Oct 2019 19:47:35 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcdgpnct1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:35 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjlYk029380;
 Tue, 1 Oct 2019 23:47:34 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma01dal.us.ibm.com with ESMTP id 2v9y59fahk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:34 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NlXXT11928134
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:33 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 428122805A;
 Tue,  1 Oct 2019 23:47:33 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 26E152805C;
 Tue,  1 Oct 2019 23:47:33 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:33 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 40/97] sphinx: add qmp_lexer
Date: Tue,  1 Oct 2019 18:45:19 -0500
Message-Id: <20191001234616.7825-41-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010203
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: John Snow <jsnow@redhat.com>, qemu-stable@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Sphinx, through Pygments, does not like annotated json examples very
much. In some versions of Sphinx (1.7), it will render the non-json
portions of code blocks in red, but in newer versions (2.0) it will
throw an exception and not highlight the block at all. Though we can
suppress this warning, it doesn't bring back highlighting on non-strict
json blocks.

We can alleviate this by creating a custom lexer for QMP examples that
allows us to properly highlight these examples in a robust way, keeping
our directionality and elision notations.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Reported-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190603214653.29369-3-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
(cherry picked from commit cd231e13bdcb8d686b014bef940c7d19c6f1e769)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 docs/conf.py             |  4 ++--
 docs/sphinx/qmp_lexer.py | 43 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 2 deletions(-)
 create mode 100644 docs/sphinx/qmp_lexer.py

diff --git a/docs/conf.py b/docs/conf.py
index befbcc6c3e..e46b299b71 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -41,7 +41,7 @@ except NameError:
 # add these directories to sys.path here. If the directory is relative to the
 # documentation root, use an absolute path starting from qemu_docdir.
 #
-# sys.path.insert(0, os.path.join(qemu_docdir, "my_subdir"))
+sys.path.insert(0, os.path.join(qemu_docdir, "sphinx"))
 
 
 # -- General configuration ------------------------------------------------
@@ -54,7 +54,7 @@ needs_sphinx = '1.3'
 # Add any Sphinx extension module names here, as strings. They can be
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
 # ones.
-extensions = []
+extensions = ['qmp_lexer']
 
 # Add any paths that contain templates here, relative to this directory.
 templates_path = ['_templates']
diff --git a/docs/sphinx/qmp_lexer.py b/docs/sphinx/qmp_lexer.py
new file mode 100644
index 0000000000..f7e4c0e198
--- /dev/null
+++ b/docs/sphinx/qmp_lexer.py
@@ -0,0 +1,43 @@
+# QEMU Monitor Protocol Lexer Extension
+#
+# Copyright (C) 2019, Red Hat Inc.
+#
+# Authors:
+#  Eduardo Habkost <ehabkost@redhat.com>
+#  John Snow <jsnow@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPLv2 or later.
+# See the COPYING file in the top-level directory.
+"""qmp_lexer is a Sphinx extension that provides a QMP lexer for code blocks."""
+
+from pygments.lexer import RegexLexer, DelegatingLexer
+from pygments.lexers.data import JsonLexer
+from pygments import token
+from sphinx import errors
+
+class QMPExampleMarkersLexer(RegexLexer):
+    """
+    QMPExampleMarkersLexer lexes QMP example annotations.
+    This lexer adds support for directionality flow and elision indicators.
+    """
+    tokens = {
+        'root': [
+            (r'-> ', token.Generic.Prompt),
+            (r'<- ', token.Generic.Prompt),
+            (r' ?\.{3} ?', token.Generic.Prompt),
+        ]
+    }
+
+class QMPExampleLexer(DelegatingLexer):
+    """QMPExampleLexer lexes annotated QMP examples."""
+    def __init__(self, **options):
+        super(QMPExampleLexer, self).__init__(JsonLexer, QMPExampleMarkersLexer,
+                                              token.Error, **options)
+
+def setup(sphinx):
+    """For use by the Sphinx extensions API."""
+    try:
+        sphinx.require_sphinx('2.1')
+        sphinx.add_lexer('QMP', QMPExampleLexer)
+    except errors.VersionRequirementError:
+        sphinx.add_lexer('QMP', QMPExampleLexer())
-- 
2.17.1


